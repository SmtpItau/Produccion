VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BacMntOma 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Códigos OMA"
   ClientHeight    =   5250
   ClientLeft      =   1845
   ClientTop       =   1425
   ClientWidth     =   5955
   FillStyle       =   0  'Solid
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Bacmntoa.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form3"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5250
   ScaleWidth      =   5955
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   4695
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   5955
      _Version        =   65536
      _ExtentX        =   10504
      _ExtentY        =   8281
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame Frame 
         Height          =   4455
         Index           =   0
         Left            =   90
         TabIndex        =   11
         Top             =   90
         Width           =   5760
         _Version        =   65536
         _ExtentX        =   10160
         _ExtentY        =   7858
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
         Begin VB.TextBox txtcodigo 
            Alignment       =   1  'Right Justify
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1680
            MaxLength       =   3
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   240
            Width           =   1140
         End
         Begin VB.TextBox TxtNombre 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1680
            MaxLength       =   45
            TabIndex        =   2
            Top             =   645
            Width           =   3975
         End
         Begin VB.ComboBox cmbOperacion 
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1680
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   1080
            Width           =   3945
         End
         Begin Threed.SSFrame fraComplementos 
            Height          =   2805
            Left            =   105
            TabIndex        =   12
            Top             =   1500
            Width           =   5535
            _Version        =   65536
            _ExtentX        =   9763
            _ExtentY        =   4948
            _StockProps     =   14
            Caption         =   " Datos a Incorporar para este Código ..."
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
            Begin Threed.SSCheck chkPantalla 
               Height          =   285
               Index           =   6
               Left            =   300
               TabIndex        =   10
               Top             =   2450
               Width           =   4800
               _Version        =   65536
               _ExtentX        =   8467
               _ExtentY        =   503
               _StockProps     =   78
               Caption         =   "Relación con Planillas ..."
               ForeColor       =   8388608
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSCheck chkPantalla 
               Height          =   285
               Index           =   5
               Left            =   300
               TabIndex        =   9
               Top             =   2100
               Width           =   4800
               _Version        =   65536
               _ExtentX        =   8467
               _ExtentY        =   503
               _StockProps     =   78
               Caption         =   "Acuerdos"
               ForeColor       =   8388608
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSCheck chkPantalla 
               Height          =   285
               Index           =   4
               Left            =   300
               TabIndex        =   8
               Top             =   1750
               Width           =   4800
               _Version        =   65536
               _ExtentX        =   8467
               _ExtentY        =   503
               _StockProps     =   78
               Caption         =   "Autorización del BCCH"
               ForeColor       =   8388608
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSCheck chkPantalla 
               Height          =   285
               Index           =   3
               Left            =   300
               TabIndex        =   7
               Top             =   1400
               Width           =   4800
               _Version        =   65536
               _ExtentX        =   8467
               _ExtentY        =   503
               _StockProps     =   78
               Caption         =   "Exportaciones"
               ForeColor       =   8388608
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSCheck chkPantalla 
               Height          =   285
               Index           =   2
               Left            =   300
               TabIndex        =   6
               Top             =   1050
               Width           =   4800
               _Version        =   65536
               _ExtentX        =   8467
               _ExtentY        =   503
               _StockProps     =   78
               Caption         =   "Cobertura de Importaciones (Detalle de Intereses)"
               ForeColor       =   8388608
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSCheck chkPantalla 
               Height          =   285
               Index           =   1
               Left            =   300
               TabIndex        =   5
               Top             =   720
               Width           =   4800
               _Version        =   65536
               _ExtentX        =   8467
               _ExtentY        =   503
               _StockProps     =   78
               Caption         =   "Derivados"
               ForeColor       =   8388608
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSCheck chkPantalla 
               Height          =   285
               Index           =   0
               Left            =   300
               TabIndex        =   4
               Top             =   350
               Width           =   4800
               _Version        =   65536
               _ExtentX        =   8467
               _ExtentY        =   503
               _StockProps     =   78
               Caption         =   "Operación con Financiamiento Internacional"
               ForeColor       =   8388608
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
         End
         Begin VB.Label Label 
            Caption         =   "Código"
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
            Index           =   0
            Left            =   120
            TabIndex        =   15
            Top             =   240
            Width           =   1500
         End
         Begin VB.Label Label 
            Caption         =   "Descripción"
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
            Index           =   2
            Left            =   120
            TabIndex        =   14
            Top             =   645
            Width           =   1500
         End
         Begin VB.Label Label 
            Caption         =   "Tipo Operación"
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
            Index           =   1
            Left            =   120
            TabIndex        =   13
            Top             =   1080
            Width           =   1500
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5220
      Top             =   0
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
            Picture         =   "Bacmntoa.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntoa.frx":11E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntoa.frx":20BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntoa.frx":2F98
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntoa.frx":32B2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
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
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMntOma"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim i                As Integer
Dim Sql              As String
Dim Datos()

Private Function FUNC_Validacion()

   Dim sCadena       As String

   FUNC_Validacion = False

   sCadena = ""

   If Trim(txtCodigo.Text) = "" Then
      sCadena = sCadena & "- Falta ingresar el Código." & vbCrLf

   End If

   If Trim$(TxtNombre.Text) = "" Then
      sCadena = sCadena & "- Falta ingresar el Descripción." & vbCrLf

   End If

   If cmbOperacion.Tag = "" Then
      sCadena = sCadena & "- Falta seleccionar el Tipo de Operación." & vbCrLf

   End If

   If sCadena <> "" Then
      sCadena = sCadena & "FALTAN INGRESAR LOS SIGUIENTES DATOS:" & vbCrLf & vbCrLf & sCadena
      MsgBox sCadena, vbExclamation

   Else
      FUNC_Validacion = True

   End If

End Function

Private Sub PROC_LIMPIAR()

   txtCodigo = ""
   TxtNombre = ""

   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False

   Call PROC_ActivaBoton(False)
   Call Carga_Listas("TipoDocumento", cmbOperacion)

   cmbOperacion_LostFocus

   For i = 0 To 6
      chkPantalla(i).Value = False

   Next i

   txtCodigo.SetFocus

End Sub

Private Sub PROC_ActivaBoton(Valor As Boolean)

   txtCodigo.Enabled = Not Valor
   TxtNombre.Enabled = Valor
   cmbOperacion.Enabled = Valor

End Sub

Private Sub chkPantalla_Click(Index As Integer, Value As Integer)

   If Index = 2 Or Index = 3 Then
      i = IIf(Index = 2, 3, 2)

      If chkPantalla(i).Value Then
         chkPantalla(i).Value = Not chkPantalla(Index).Value

      End If

   End If

End Sub

Private Sub chkPantalla_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      chkPantalla(Index).Value = Not chkPantalla(Index).Value

   End If

End Sub

Private Sub cmbOperacion_Click()

   If cmbOperacion.ListIndex >= 0 Then
      cmbOperacion.Tag = left(cmbOperacion.List(cmbOperacion.ListIndex), 1)

   Else
      cmbOperacion.Tag = ""

   End If

End Sub

Private Sub cmbOperacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      chkPantalla(0).SetFocus

   End If

End Sub

Private Sub cmbOperacion_LostFocus()

   If cmbOperacion.ListIndex >= 0 Then
      cmbOperacion.Tag = left(cmbOperacion.List(cmbOperacion.ListIndex), 1)

   Else
      cmbOperacion.Tag = ""

   End If

End Sub

Private Sub Form_Activate()
    PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_GotFocus()
    WindowState = 0
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   On Error GoTo Errores

   Dim iOpcion        As Integer

   iOpcion = 0

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
    PROC_CARGA_AYUDA Me, " "
    Me.top = 0
    Me.left = 0
    top = 1
    left = 15
    
    Me.Visible = True
    
    Call PROC_LIMPIAR
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim Valores       As String

   Select Case Button.Index
   Case 2
      Me.MousePointer = 11

      If FUNC_Validacion() Then

         Sql = "sp_Graba_OMA " & CDbl(txtCodigo.Text) & ", '" & TxtNombre.Text & "', "

         Valores = ""

         For i = 0 To 6
            Valores = Valores & IIf(chkPantalla(i).Value, "1", "0")

         Next i

         Sql = Sql & "'" & cmbOperacion.Tag & " " & Valores & "'"

         If BAC_SQL_EXECUTE(Sql) Then
            If BAC_SQL_FETCH(Datos()) Then
               If Trim(Datos(1)) <> "OK" And Trim(Datos(1)) <> "SI" Then
                  MsgBox " No se puede grabar registro ", 64

               Else
                  MsgBox " Registro Grabado Correctamente ", 64
                  Call PROC_LIMPIAR

               End If

            End If

         End If

      End If

      Me.MousePointer = 0

   Case 3

      If MsgBox("Está seguro de eliminar el registro", 36) = 6 Then
         Envia = Array()
         AddParam Envia, CDbl(txtCodigo.Text)

         If Not BAC_SQL_EXECUTE("sp_Borra_OMA ", Envia) Then
            MsgBox " No se puede eliminar registro ", 64
            Exit Sub

         Else
            
         
            If BAC_SQL_FETCH(Datos()) Then
               If Trim(Datos(1)) <> "OK" And Trim(Datos(1)) <> "SI" Then
                  MsgBox Datos(2), vbExclamation

               Else

                  MsgBox "Registro Eliminado ", vbInformation
               End If

            End If
            
         End If

         Call PROC_LIMPIAR

      Else
         txtCodigo.Enabled = True
         txtCodigo.SetFocus

      End If

   Case 1
      Call PROC_LIMPIAR

   Case 4
      Call txtCodigo_KeyPress(vbKeyReturn)

   Case 5
      Unload Me

   End Select

End Sub

Private Sub txtcodigo_Change()

   Toolbar1.Buttons(4).Enabled = (txtCodigo.Text <> "")

End Sub

Private Sub TxtCodigo_DblClick()

   BacControlWindows 100
   MiTag = "tbCodigosOMA"
   BacAyuda.Show 1

   If giAceptar% = True Then
      
       txtCodigo.Text = CDbl(gsCodigo$)
       txtCodigo_KeyPress vbKeyReturn
   
'      Call PROC_ActivaBoton(True)
'      txtcodigo.Text = CDbl(gsCodigo$)
'      TxtNombre.Text = gsGlosa$
'      bacBuscarCombo cmbOperacion, CDbl(gsDigito)
'
'      For I = 0 To 6
'         chkPantalla(I).Value = (Mid(gsValor, I + 1, 1) = "1")
'
'      Next I
'
'      TxtNombre.SetFocus

   End If

End Sub

Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then
      Call TxtCodigo_DblClick

   End If

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn And Len(Trim(txtCodigo.Text)) > 0 Then
      Call PROC_ActivaBoton(True)
      Envia = Array()
      AddParam Envia, txtCodigo.Text

      If Not BAC_SQL_EXECUTE("SP_CODIGO_OMA", Envia) Then
         Exit Sub

      End If

      If BAC_SQL_FETCH(Datos()) Then
         TxtNombre.Text = Trim(Datos(3))

         Call bacBuscarCombo(cmbOperacion, CDbl(left(Datos(2), 2)))
         cmbOperacion_LostFocus

         For i = 0 To 6
            chkPantalla(i).Value = (Mid(Datos(2), i + 3, 1) = "1")

         Next i

         Toolbar1.Buttons(2).Enabled = True
         Toolbar1.Buttons(3).Enabled = True
         Toolbar1.Buttons(4).Enabled = False

      Else
         Toolbar1.Buttons(2).Enabled = True
         Toolbar1.Buttons(3).Enabled = False
         Toolbar1.Buttons(4).Enabled = False

      End If

      TxtNombre.SetFocus

   Else
      If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
         KeyAscii = 0

      End If

   End If

End Sub

Private Sub TxtNombre_Change()

   If Trim(TxtNombre.Text) <> "" Then
      Toolbar1.Buttons(1).Enabled = True

   End If

End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

   Call BacToUCase(KeyAscii)

   If KeyAscii = vbKeyReturn And Trim(TxtNombre) <> "" Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub


