VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntApoderado 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Apoderados"
   ClientHeight    =   4035
   ClientLeft      =   3315
   ClientTop       =   3360
   ClientWidth     =   7200
   Icon            =   "BacMntApoderado.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4035
   ScaleWidth      =   7200
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   6300
      Top             =   -150
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":2EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":3361
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":3857
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":3CEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":41D2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":46E5
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":4BB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":507E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":5575
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":5A6D
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":5EAF
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3495
      Left            =   0
      TabIndex        =   14
      Top             =   510
      Width           =   7185
      _Version        =   65536
      _ExtentX        =   12674
      _ExtentY        =   6165
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
         Left            =   5910
         MaxLength       =   5
         MouseIcon       =   "BacMntApoderado.frx":6274
         MultiLine       =   -1  'True
         TabIndex        =   3
         Top             =   150
         Width           =   1095
      End
      Begin Threed.SSFrame Frame 
         Height          =   870
         Index           =   0
         Left            =   60
         TabIndex        =   15
         Top             =   15
         Width           =   7065
         _Version        =   65536
         _ExtentX        =   12462
         _ExtentY        =   1535
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
            Left            =   840
            MaxLength       =   40
            TabIndex        =   4
            Top             =   465
            Width           =   6105
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
            Left            =   2130
            MaxLength       =   1
            TabIndex        =   2
            Top             =   135
            Width           =   255
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
            Left            =   840
            MaxLength       =   9
            MouseIcon       =   "BacMntApoderado.frx":657E
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   1
            Top             =   135
            Width           =   1140
         End
         Begin VB.Line Line1 
            X1              =   2025
            X2              =   2085
            Y1              =   255
            Y2              =   255
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
            TabIndex        =   18
            Top             =   510
            Width           =   660
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00FFFFFF&
            BackStyle       =   0  'Transparent
            Caption         =   "Rut"
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
            TabIndex        =   17
            Top             =   180
            Width           =   270
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00FFFFFF&
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
            Index           =   4
            Left            =   5160
            TabIndex        =   16
            Top             =   165
            Width           =   585
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   2100
         Index           =   1
         Left            =   45
         TabIndex        =   19
         Top             =   840
         Width           =   7080
         _Version        =   65536
         _ExtentX        =   12488
         _ExtentY        =   3704
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
         Begin VB.TextBox Textrut 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H00800000&
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
            Left            =   195
            MaxLength       =   9
            MultiLine       =   -1  'True
            TabIndex        =   6
            Text            =   "BacMntApoderado.frx":6888
            Top             =   795
            Width           =   500
         End
         Begin VB.TextBox Textapoderado 
            Appearance      =   0  'Flat
            BackColor       =   &H00800000&
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
            Left            =   720
            MaxLength       =   40
            MultiLine       =   -1  'True
            TabIndex        =   7
            Text            =   "BacMntApoderado.frx":688E
            Top             =   795
            Width           =   500
         End
         Begin VB.TextBox Textcargo 
            Appearance      =   0  'Flat
            BackColor       =   &H00800000&
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
            Left            =   195
            MaxLength       =   40
            MultiLine       =   -1  'True
            TabIndex        =   8
            Text            =   "BacMntApoderado.frx":6894
            Top             =   1125
            Width           =   500
         End
         Begin VB.TextBox Textfono 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H00800000&
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
            Left            =   720
            MaxLength       =   15
            MultiLine       =   -1  'True
            TabIndex        =   9
            Text            =   "BacMntApoderado.frx":689A
            Top             =   1125
            Width           =   500
         End
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   1935
            Left            =   45
            TabIndex        =   5
            Top             =   120
            Width           =   6990
            _ExtentX        =   12330
            _ExtentY        =   3413
            _Version        =   393216
            Rows            =   3
            RowHeightMin    =   315
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   12632256
            GridColor       =   0
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   450
         Left            =   120
         TabIndex        =   20
         Top             =   3000
         Width           =   6915
         _ExtentX        =   12197
         _ExtentY        =   794
         ButtonWidth     =   820
         ButtonHeight    =   794
         AllowCustomize  =   0   'False
         Style           =   1
         ImageList       =   "Img_opciones"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Limpiar"
               Object.ToolTipText     =   "Agregar Fila"
               ImageIndex      =   10
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Quitar Fila"
               ImageIndex      =   11
            EndProperty
         EndProperty
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   7200
      _ExtentX        =   12700
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
            Key             =   "Ver"
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
   Begin Threed.SSFrame Frame 
      Height          =   2160
      Index           =   3
      Left            =   9675
      TabIndex        =   0
      Top             =   1230
      Visible         =   0   'False
      Width           =   3225
      _Version        =   65536
      _ExtentX        =   5689
      _ExtentY        =   3810
      _StockProps     =   14
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   780
         Left            =   285
         ScaleHeight     =   720
         ScaleWidth      =   2100
         TabIndex        =   11
         Top             =   330
         Width           =   2160
      End
      Begin VB.Label Label 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Label(1)"
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   330
         TabIndex        =   13
         Top             =   1620
         Width           =   1860
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Index           =   0
         Left            =   330
         TabIndex        =   12
         Top             =   1275
         Width           =   1860
      End
   End
End
Attribute VB_Name = "BacMntApoderado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objCliente            As Object
Private Objrutcli             As Object
Private ObjApoderado          As Object
Dim OptLocal                  As String
Dim FRM_ESTADO                As Integer
Dim iCol                      As Integer

Private Sub PROC_APHabilitarControles(Valor As Boolean)

   txtRut.Enabled = Not Valor
   txtcodcli.Enabled = Not Valor
   TxtNombre.Enabled = Valor
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor

End Sub

Private Sub PROC_APLIMIPIAR()

   txtRut.Text = ""
   txtDigito.Text = ""
   TxtNombre.Text = ""
   txtcodcli.Text = ""

   txtRut.Enabled = True
   txtcodcli.Enabled = True

   Call PROC_APHabilitarControles(False)

   txtRut.SetFocus

End Sub

Private Function FUNC_BuscarApoderados()

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
      Call PROC_APLIMIPIAR
      Call PROC_APHabilitarControles(False)
      txtRut.SetFocus
      Screen.MousePointer = 0
      Exit Function

   Else
      Call PROC_APHabilitarControles(True)
      grilla.Enabled = True

   End If

   idRut = txtRut.Text

   '-------- Carga grilla de apoderados -----------'
   If Not objCliente.CargaApoderados(grilla, Val(txtRut.Text), Val(txtcodcli.Text), 0) Then
      Toolbar1.Buttons(3).Enabled = False
      Screen.MousePointer = 0
      grilla.Rows = 2
      grilla.RowHeight(1) = 345
   Else
      Toolbar1.Buttons(3).Enabled = True
      grilla.Col = 0
      grilla.Row = 1
      grilla.Enabled = True
      grilla.SetFocus

   End If

   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   TxtNombre.Enabled = False

   Screen.MousePointer = 0

End Function

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim iOpcion        As Integer

   On Error GoTo Errores

   iOpcion = 0

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode
      Case vbKeyLimpiar
         iOpcion = 1

      Case vbKeyGrabar:
         iOpcion = 2

      Case vbKeyEliminar:
         iOpcion = 3

      Case vbKeyBuscar:
         iOpcion = 4

      Case vbKeySalir:
         If UCase(Me.ActiveControl.Name) <> "TEXTCARGO" And _
            UCase(Me.ActiveControl.Name) <> "TEXTFONO" And _
            UCase(Me.ActiveControl.Name) <> "TEXTAPODERADO" And _
            UCase(Me.ActiveControl.Name) <> "TEXTRUT" Then
            iOpcion = 5

         Else
            KeyCode = 0
            iOpcion = 0

         End If

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

   Set objCliente = New clsCliente
   Set Objrutcli = New clsCliente
   Set ObjApoderado = New clsApoderado

   Call BacIniciaGrilla(8, 7, 1, 0, False, grilla)
   Call FUNC_SeteaGrilla(grilla)
   grilla.Col = 0
   grilla.Row = grilla.FixedRows


   TxtNombre.Enabled = False

   Call PROC_LimiarTextos

   FRM_ESTADO% = False
   PROC_APHabilitarControles (False)

   grilla.Rows = 2
   grilla.RowHeight(1) = 345
   grilla.Enabled = False

   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Frame_Click(Index As Integer)

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub Grilla_DblClick()

   Grilla_KeyPress 13

End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 46 Then
      If (grilla.TextMatrix(grilla.Row, 0) = "" And grilla.TextMatrix(grilla.Row, 1) = "" And grilla.TextMatrix(grilla.Row, 2) = "") And grilla.Rows > 2 Then
         grilla.RemoveItem (grilla.Row)
         grilla.SetFocus
         Exit Sub

      End If

      If (grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows = 2 Then
         grilla.Rows = 1
         grilla.Rows = 2
         grilla.RowHeight(1) = 345
         grilla.SetFocus
         Exit Sub

      End If

      'Call PROC_ELIMINAR

   End If

   If KeyCode = vbKeyInsert Then
      If grilla.TextMatrix(grilla.Rows - 1, 0) <> "" And grilla.TextMatrix(grilla.Rows - 1, 1) <> "" And grilla.TextMatrix(grilla.Rows - 1, 2) <> "" And grilla.TextMatrix(grilla.Rows - 1, 3) <> "" Then
         grilla.Rows = grilla.Rows + 1
         grilla.RowHeight(grilla.Rows - 1) = 345
         grilla.Row = grilla.Rows - 1
         
         Bac_SendKey vbKeyHome
         grilla.SetFocus

      End If

   End If

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

   Dim iRow          As Integer

   If KeyAscii = 39 Or KeyAscii = 34 Then
      KeyAscii = 0

   End If

   With grilla
      If KeyAscii = 45 Then
         .Rows = .Rows + 1
         .RowHeight(.Rows - 1) = 345
      End If

      If .Col = 0 Then                   ' rut
         If KeyAscii = vbKeyReturn Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
            iRow = .Row

            If FUNC_ValidaIngreso() = False Then
               Exit Sub

            End If

            .Row = iRow
            .Col = 0

            Textrut.top = grilla.CellTop + grilla.top + 30
            Textrut.left = grilla.CellLeft + grilla.left + 30
            Textrut.Height = grilla.CellHeight - 15
            Textrut.Width = grilla.CellWidth - 15

            Textrut.Visible = True

            If IsNumeric(Chr(KeyAscii)) Then
               Textrut.Text = Chr(KeyAscii)
               Bac_SendKey vbKeyRight '"{RIGHT}"    'Comienzo Izquierda

            Else
               Textrut.Text = .TextMatrix(.Row, .Col)
               Bac_SendKey vbKeyEnd '"{END}"

            End If

            Textrut.SetFocus

         End If

      End If

      If .Col = 2 Or .Col = 3 Or .Col = 6 Then             ' apoderado , cargo
         If Trim(.TextMatrix(.Row, 0)) = "" Then
            MsgBox "Debe Ingresar Rut del Apoderado", vbCritical
            .Col = 0
            .SetFocus
            Exit Sub

         End If

         If .Col = 1 Then
            If KeyAscii > 0 And KeyAscii <> 27 Then
               Textapoderado.top = grilla.CellTop + grilla.top + 30
               Textapoderado.left = grilla.CellLeft + grilla.left + 20
               Textapoderado.Height = grilla.CellHeight - 15
               Textapoderado.Width = grilla.CellWidth - 15
         
               Textapoderado.Visible = True

               If KeyAscii = 13 Then
                  Textapoderado.Text = .TextMatrix(.Row, .Col)
                  Bac_SendKey vbKeyEnd ' "{END}"

               Else
                  Textapoderado.Text = IIf(.Col <> 5, UCase(Chr(KeyAscii)), Chr(KeyAscii))
                  Bac_SendKey vbKeyRight ' "{RIGHT}" 'Comienzo Izquierda

               End If

               Textapoderado.SetFocus

            End If

         Else
            If KeyAscii > 0 And KeyAscii <> 27 Then
               Textcargo.top = grilla.CellTop + grilla.top + 30
               Textcargo.left = grilla.CellLeft + grilla.left + 20
               Textcargo.Height = grilla.CellHeight - 15
               Textcargo.Width = grilla.CellWidth - 15
               Textcargo.Visible = True

               If KeyAscii = 13 Then
                  Textcargo.Text = .TextMatrix(.Row, .Col)
                  Bac_SendKey vbKeyEnd ' "{END}"     'Comienzo Derecha

               Else
                  Textcargo.Text = IIf(.Col <> 5, UCase(Chr(KeyAscii)), Chr(KeyAscii))
                 ' Bac_SendKey vbKeyRight ' "{RIGHT}" 'Comienzo Izquierda

               End If

               Textcargo.SetFocus

            End If

         End If

      End If

      If .Col = 4 Then                    ' fono
         If Trim(.TextMatrix(.Row, 0)) = "" Then
            MsgBox "Debe Ingresar Rut del Apoderado", vbCritical
            .Col = 0
            .SetFocus
            Exit Sub

         End If

         If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
            Textfono.top = grilla.CellTop + grilla.top + 30
            Textfono.left = grilla.CellLeft + grilla.left + 25
            Textfono.Height = grilla.CellHeight - 15
            Textfono.Width = grilla.CellWidth - 15
         
            Textfono.Visible = True

            If IsNumeric(Chr(KeyAscii)) Then
               Textfono.Text = Chr(KeyAscii)
               Bac_SendKey vbKeyRight ' "{RIGHT}"    'Comienzo Izquierda

            Else
               Textfono.Text = .TextMatrix(.Row, .Col)
               Bac_SendKey vbKeyEnd ' "{END}"     'Comienzo Derecha

            End If

            Textfono.SetFocus

         End If

      End If

   End With

End Sub

Private Sub Grilla_Scroll()
   
   Call Textrut_LostFocus

End Sub

Private Sub Textapoderado_KeyPress(KeyAscii As Integer)

   With grilla
      If KeyAscii = 39 Or KeyAscii = 34 Then
         KeyAscii = 0

      End If

      If .Col <> 5 Then
         Call BacToUCase(KeyAscii)

      End If

      If KeyAscii = vbKeyReturn Then
         .TextMatrix(.Row, .Col) = Textapoderado.Text
         Textapoderado.Visible = False
         .SetFocus

      End If

      If KeyAscii = vbKeyEscape Then
         Textapoderado.Text = ""
         Textapoderado.Visible = False
         .SetFocus

      End If

   End With

End Sub

Private Sub Textapoderado_LostFocus()

   Textapoderado.Visible = False
   grilla.SetFocus

End Sub

Private Sub Textcargo_KeyPress(KeyAscii As Integer)

   With grilla
      If KeyAscii = 39 Or KeyAscii = 34 Then
         KeyAscii = 0

      End If

      If .Col <> 5 Then
         Call BacToUCase(KeyAscii)

      Else
         KeyAscii = Caracter(KeyAscii)

      End If

      If KeyAscii = vbKeyReturn Then
         .TextMatrix(.Row, .Col) = Textcargo.Text
         Textcargo.Text = ""
         .Enabled = True
         Textcargo.Visible = False
         
         If Not (.Col = .Cols - 1) Then
            .Col = .Col + 1
            .LeftCol = .Col
         End If
         
         .SetFocus

      End If

      If KeyAscii = vbKeyEscape Then
         Textcargo.Text = ""
         Textcargo.Visible = False
         .Enabled = True
         .SetFocus

      End If

   End With

End Sub

Private Sub Textcargo_LostFocus()

   Textcargo.Visible = False

End Sub

Private Sub Textfono_KeyPress(KeyAscii As Integer)

   With grilla
      KeyAscii = Caracter(Asc(UCase$(Chr$(KeyAscii))))

      If KeyAscii = vbKeyReturn Then
         .TextMatrix(.Row, .Col) = Textfono.Text
         Textfono.Visible = False
         .Col = 6
         .LeftCol = .Col
         .SetFocus

      End If

      If KeyAscii = vbKeyEscape Then
         Textfono.Text = ""
         Textfono.Visible = False
         .SetFocus

      End If

   End With

End Sub

Private Sub Textfono_LostFocus()

   Textfono.Text = ""
   Textfono.Visible = False
   grilla.SetFocus

End Sub

Private Sub Textrut_KeyPress(KeyAscii As Integer)

   Dim sTemp       As String

   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> vbKeyEscape And KeyAscii <> vbKeyReturn And KeyAscii <> vbKeyDelete And KeyAscii <> 8 Then
      KeyAscii = 0
      Exit Sub
   
   End If


   With grilla
      KeyAscii = Caracter(Asc(UCase$(Chr$(KeyAscii))))
      

      If (KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 45 Or KeyAscii = 75 Or KeyAscii = 13 Or KeyAscii = 27 Or KeyAscii = 8 Then
      Else
         KeyAscii = 0

      End If

      If KeyAscii = vbKeyReturn Then
         If Trim(Textrut.Text) = "" Then
            .TextMatrix(.Row, 0) = ""
            .TextMatrix(.Row, 1) = ""
            .TextMatrix(.Row, 2) = ""
            .TextMatrix(.Row, 3) = ""
            Textrut.Visible = False
            .SetFocus
            Exit Sub

         End If


'         If FUNC_ValidaRUT(Textrut.Text) = True Then
'         Else
'            MsgBox " El Rut Esta Incorrecto  ", vbCritical
'            sTemp = Textrut.Text
'            Textrut.Text = ""
'            Textrut.Text = sTemp
'            KeyAscii = 0
'            Textrut.SetFocus
'            Bac_SendKey vbKeyEnd ' "{end}"
'            Exit Sub
'
'         End If

         If bacBuscaRepetidoGrilla(0, grilla, Trim(Textrut.Text)) = False Then
            
            .TextMatrix(.Row, 1) = FUNC_DevuelveDig(Textrut.Text)
            .TextMatrix(.Row, 0) = Trim(Textrut.Text)
            Textrut.Text = ""
            Textrut.Visible = False
            .Enabled = True
            .Col = 2
            Exit Sub

         Else
            KeyAscii = 0
            Exit Sub

         End If

      End If

      If KeyAscii = vbKeyEscape Then
         Textrut.Visible = False
         .SetFocus

      End If

   End With

End Sub

Private Sub Textrut_LostFocus()

   Textrut.Visible = False

   If grilla.Enabled Then
      grilla.SetFocus

   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim idrutcli         As String
   Dim iddigito         As String
   Dim idrutapo         As String
   Dim IdOpcion         As Integer
   Dim A                As Integer
   Dim bOk              As Boolean

   On Error GoTo Errores

   Select Case Button.Index
   Case 1
      Screen.MousePointer = 11
      grilla.Enabled = False
      Call PROC_APLIMIPIAR
      Call PROC_LimiarTextos
      grilla.Rows = 1
      grilla.Rows = 2
      grilla.Row = 1
      grilla.Col = 0
      Screen.MousePointer = 0

   Case 2
      Screen.MousePointer = 11

      Call PROC_LimiarTextos

      idrutcli = txtRut.Text
      iddigito = txtDigito.Text

      If FUNC_ValidaIngreso_graba() = False Then
         Textapoderado.Visible = False
         On Error GoTo 0
         Exit Sub

      End If

      FRM_ESTADO% = False

      Call ObjApoderado.EliminarApoderado(Val(idrutcli), Val(txtcodcli.Text))
      Call ObjApoderado.RefrescaApo(grilla)

      IdOpcion = ObjApoderado.GrabarApo(idrutcli, iddigito, Val(txtcodcli.Text))

      Screen.MousePointer = 0

      Select Case IdOpcion
      Case False
         MsgBox "No se pueden grabar datos en tabla apoderados", 16
         Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar- Rut: " + txtRut.Text + "-" + txtDigito.Text, "", "")

      Case 1
         MsgBox "No se pueden grabar datos en tabla apoderado", 16
         Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar- Rut: " + txtRut.Text + "-" + txtDigito.Text, "", "")

      Case 2
         MsgBox "No se puede PROC_Eliminar en tabla apoderado ", 16
         Call LogAuditoria("03", OptLocal, Me.Caption + " Error al PROC_Eliminar- Rut: " + txtRut.Text + "-" + txtDigito.Text, "", "")

      Case 3
         MsgBox "No se puede grabar en tabla apoderado", 16
         Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar- Rut: " + txtRut.Text + "-" + txtDigito.Text, "", "")

      Case 4
         MsgBox "No se puede grabar en tabla apoderado", 16
         Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar- Rut: " + txtRut.Text + "-" + txtDigito.Text, "", "")

      Case True
         MsgBox "Grabación se realizó con exito", 64
         Call LogAuditoria("01", OptLocal, Me.Caption, "", "Rut: " & txtRut.Text + "-" + txtDigito.Text)
         FRM_ESTADO% = True

      End Select

      If FRM_ESTADO% = True Then
         Call PROC_LIMPIAR

      End If

   Case 3
      grilla.Col = 0

      If (MsgBox("¿Seguro de Eliminar, todos los apoderados?", vbQuestion + vbYesNo)) = vbYes Then
         opecod = Val(Mid(grilla.Text, 1, 9))
         idrutcli = txtRut.Text
         Call PROC_LimiarTextos
         grilla.Enabled = True

         With grilla
            Call ObjApoderado.EliminarApoderado(Val(idrutcli), Val(txtcodcli.Text))
            Call LogAuditoria("03", OptLocal, Me.Caption, "", "")

            If .Rows > 2 Then
               If Trim$(.TextMatrix(.Row, 0)) <> "" Then
                  Call PROC_LIMPIAR
                  On Error GoTo 0
                  Exit Sub

               End If

            End If

         End With
   
         Call PROC_LIMPIAR

      End If

   Case 4
      If txtRut.Text = "" Then
         MsgBox "Falta Información Para la Busqueda", vbInformation
         On Error GoTo 0
         Exit Sub

      Else
         txtDigito.Text = FUNC_DevuelveDig(txtRut.Text)
         Call FUNC_BuscarApoderados

      End If

   Case 5
      On Error GoTo 0
      Unload Me

   End Select

   On Error GoTo 0
   Exit Sub

Errores:
   On Error GoTo 0

End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
   Case 1
        If grilla.TextMatrix(grilla.Rows - 1, 0) <> "" And grilla.TextMatrix(grilla.Rows - 1, 0) <> "" Then
            grilla.Rows = grilla.Rows + 1
            grilla.RowHeight(grilla.Rows - 1) = 345
            grilla.Row = grilla.Rows - 1
            grilla.Col = 0
            grilla.SetFocus
        End If
   Case 2
        If grilla.Rows < 3 Then
            grilla.TextMatrix(1, 0) = ""
            grilla.TextMatrix(1, 1) = ""
            Toolbar1.Buttons(3).Enabled = False
        Else
            grilla.RemoveItem (grilla.Row)
            grilla.SetFocus
        End If
   End Select

End Sub

Private Sub txtcodcli_DblClick()

   Call txtRut_DblClick

End Sub

Private Sub txtcodcli_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyAyuda Then
      Call txtRut_DblClick
   
   End If

End Sub

Private Sub txtcodcli_KeyPress(KeyAscii As Integer)

   BacSoloNumeros KeyAscii

   If KeyAscii = vbKeyReturn And Trim$(txtcodcli.Text) <> "" Then
      KeyAscii = 0
      Call FUNC_BuscarApoderados
       If grilla.Enabled Then
        grilla.SetFocus
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
      Call PROC_APHabilitarControles(False)
      txtRut.SetFocus
      Exit Sub

   End If

End Sub

Private Sub TxtNombre_DblClick()

   Call txtRut_DblClick

End Sub

Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyAyuda Then
      Call txtRut_DblClick
   
   End If

End Sub

Private Sub txtRut_DblClick()

   BacControlWindows 100

   MiTag = "MDCL_U"
   BacAyuda.Show 1

   If giAceptar% Then
      txtRut.Text = Val(gsCodigo$)
      txtDigito.Text = gsDigito$
      txtcodcli.Text = gsCodCli

      Call FUNC_BuscarApoderados

      grilla.Enabled = True
      grilla.SetFocus

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

Private Function FUNC_SeteaGrilla(Grillas As Object)

   With Grillas
      .Enabled = True
      .Row = 0
      .RowHeight(0) = 360
      
      .CellFontWidth = 4         ' TAMAÑO

      .ColWidth(0) = 1410        'RUT
      .ColWidth(1) = 400         'DV
      .ColWidth(2) = 5000        'NOMBRE
      .ColWidth(3) = 5000        'CARGO
      .ColWidth(4) = 1500        'FONO
      .ColWidth(5) = 0          'MARCA
      .ColWidth(6) = 3000        'EMAIL

      .Row = 0
      .Col = 0
      .CellFontBold = True       'RESALSE
      .FixedAlignment(0) = 4
      .Text = "     Rut    "

      .Col = 1
      .CellFontBold = True       'RESALSE
      .FixedAlignment(1) = 4
      .Text = " DV   "

      .Col = 2
      .CellFontBold = True       'RESALSE
      .FixedAlignment(2) = 4
      .Text = " Nombre Apoderado   "

      .Col = 3
      .CellFontBold = True       'RESALSE
      .FixedAlignment(3) = 4
      .Text = " Cargo Apoderado   "

      .Col = 4
      .CellFontBold = True       'RESALSE
      .FixedAlignment(4) = 4
      .Text = "   Fono     "

      .Col = 6
      .CellFontBold = True       'RESALSE
      .Text = "   E-Mail     "

   End With

End Function

Private Function FUNC_ValidaRUT(Rut_valid As String) As Boolean

   Dim Fila       As Integer
   Dim sRut       As String
   Dim sDv        As String

   FUNC_ValidaRUT = False

   If Trim$(Len(Rut_valid)) > 1 And InStr(1, Rut_valid, "-") <> 0 Then
      sRut = Mid$(Rut_valid, 1, Len(Rut_valid) - IIf(InStr(Rut_valid, "-") = 0, 1, 2))
      sDv = right$(Rut_valid, 1)

      If PROC_ControlRUT(sRut, sDv) Then
         FUNC_ValidaRUT = True
         Exit Function

      Else
         Exit Function

      End If

   End If

End Function


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

Private Sub PROC_LimiarTextos()

   Textrut.Visible = False
   Textrut.Text = ""
   Textapoderado.Visible = False
   Textapoderado.Text = ""
   Textcargo.Visible = False
   Textcargo.Text = ""
   Textfono.Visible = False
   Textfono.Text = ""

End Sub

Private Function FUNC_ValidaIngreso_graba() As Boolean

   Dim Fila       As Integer

   FUNC_ValidaIngreso_graba = True

   grilla.Enabled = True

   With grilla
      For Fila = 1 To .Rows - 1
         .Row = Fila

         If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 2)) = "" Then
            Screen.MousePointer = 0
            MsgBox "Falta Ingresar el Nombre de Un Apoderado ", vbExclamation
            FUNC_ValidaIngreso_graba = False

            .Col = 1
            .SetFocus
            Exit Function

         End If

      Next Fila

   End With

End Function

Private Function FUNC_ValidaIngreso() As Boolean

   Dim Fila       As Integer

   FUNC_ValidaIngreso = True

   grilla.Enabled = True

   With grilla
      For Fila = 1 To .Rows - 1
         .Row = Fila

         If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 1)) = "" Then
            Call PROC_POSICIONA_TEXTO(grilla, Textrut)
            .Col = 0
            Exit Function

         End If

      Next Fila

   End With

End Function

Private Sub PROC_ELIMINAR()

   Dim idrutcli      As String
   Dim A             As Integer
   Dim iok           As Integer

   On Error GoTo Errores

   grilla.Col = 0

   If (grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows = 2 Then
      grilla.Rows = 1
      grilla.Rows = 2
      grilla.SetFocus
      Exit Sub

   End If

   If grilla.Rows > 1 Then
      If grilla.Rows > 2 Then
         grilla.RemoveItem (grilla.Row)

      Else
         grilla.Rows = 1
         grilla.Rows = 2

      End If

      grilla.SetFocus
      Exit Sub

   End If

   opecod = Val(Mid(grilla.Text, 1, 9))

   idrutcli = txtRut.Text

   Call PROC_LimiarTextos

   grilla.Enabled = True

   With grilla
      Call ObjApoderado.PROC_EliminarApoderado(Val(idrutcli), Val(txtcodcli.Text))

      If .Rows > 2 Then
         If Trim$(.TextMatrix(.Row, 0)) <> "" Then
            .RemoveItem .Row
            .SetFocus
            Exit Sub

         End If

      End If

   End With

   grilla.SetFocus

   On Error GoTo 0

   Exit Sub

Errores:
   On Error GoTo 0

End Sub


Private Sub PROC_LIMPIAR()

   Set objCliente = New clsCliente
   Set Objrutcli = New clsCliente
   Set ObjApoderado = New clsApoderado


   grilla.Enabled = False

   Call PROC_APLIMIPIAR

   TxtNombre.Enabled = False

   Call PROC_LimiarTextos

   FRM_ESTADO% = False

   Call PROC_APHabilitarControles(False)

   grilla.Rows = 1
   grilla.Rows = 2

End Sub

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

