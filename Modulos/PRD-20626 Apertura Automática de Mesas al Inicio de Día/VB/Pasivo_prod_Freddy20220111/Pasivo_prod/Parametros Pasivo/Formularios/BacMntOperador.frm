VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntOperador 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Operadores"
   ClientHeight    =   4650
   ClientLeft      =   4245
   ClientTop       =   4005
   ClientWidth     =   7035
   Icon            =   "BacMntOperador.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4650
   ScaleWidth      =   7035
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   7035
      _ExtentX        =   12409
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
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6180
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   14
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":596E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":5D64
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":62A1
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":6762
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntOperador.frx":6BA4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4095
      Left            =   0
      TabIndex        =   9
      Top             =   540
      Width           =   7035
      _Version        =   65536
      _ExtentX        =   12409
      _ExtentY        =   7223
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
      Begin Threed.SSFrame Frame 
         Height          =   885
         Index           =   0
         Left            =   30
         TabIndex        =   10
         Top             =   -30
         Width           =   6930
         _Version        =   65536
         _ExtentX        =   12224
         _ExtentY        =   1561
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
            Left            =   5880
            MaxLength       =   5
            TabIndex        =   17
            Top             =   150
            Width           =   945
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
            Left            =   870
            MaxLength       =   9
            TabIndex        =   16
            Top             =   150
            Width           =   1215
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
            Left            =   870
            MaxLength       =   40
            TabIndex        =   1
            Top             =   480
            Width           =   5955
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
            Left            =   2220
            MaxLength       =   1
            TabIndex        =   0
            Top             =   150
            Width           =   255
         End
         Begin VB.Line Line1 
            X1              =   2115
            X2              =   2175
            Y1              =   285
            Y2              =   285
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
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
            Left            =   90
            TabIndex        =   13
            Top             =   525
            Width           =   660
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
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
            Left            =   90
            TabIndex        =   12
            Top             =   195
            Width           =   270
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
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
            Left            =   5175
            TabIndex        =   11
            Top             =   180
            Width           =   585
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   2715
         Index           =   1
         Left            =   60
         TabIndex        =   14
         Top             =   855
         Width           =   6915
         _Version        =   65536
         _ExtentX        =   12197
         _ExtentY        =   4789
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
         Begin VB.TextBox Txtrut_col 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H8000000D&
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000E&
            Height          =   315
            Left            =   1215
            MaxLength       =   9
            TabIndex        =   18
            Text            =   "0"
            Top             =   1665
            Width           =   1185
         End
         Begin VB.TextBox Txtglosa_col 
            BackColor       =   &H8000000D&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000E&
            Height          =   255
            Left            =   1545
            MaxLength       =   40
            MultiLine       =   -1  'True
            TabIndex        =   5
            Text            =   "BacMntOperador.frx":6F69
            Top             =   1215
            Width           =   4920
         End
         Begin VB.VScrollBar VScroll1 
            Height          =   210
            Left            =   5235
            TabIndex        =   15
            Top             =   285
            Visible         =   0   'False
            Width           =   975
         End
         Begin MSFlexGridLib.MSFlexGrid grilla 
            Height          =   2550
            Left            =   45
            TabIndex        =   2
            Top             =   120
            Width           =   6840
            _ExtentX        =   12065
            _ExtentY        =   4498
            _Version        =   393216
            FixedCols       =   0
            RowHeightMin    =   300
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorBkg    =   12632256
            GridColor       =   0
            WordWrap        =   -1  'True
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
         TabIndex        =   19
         Top             =   3600
         Width           =   6795
         _ExtentX        =   11986
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
               ImageIndex      =   13
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Quitar Fila"
               ImageIndex      =   14
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2160
      Index           =   3
      Left            =   7425
      TabIndex        =   3
      Top             =   1035
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
         TabIndex        =   6
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
         TabIndex        =   8
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
         TabIndex        =   7
         Top             =   1275
         Width           =   1860
      End
   End
End
Attribute VB_Name = "BacMntOperador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objCliente         As Object
Private Objrutcli          As Object
Dim FRM_ESTADO             As Integer
Dim OptLocal               As String

Private Function FUNC_APHabilitarControles(Valor As Boolean)

   txtRut.Enabled = Not Valor
   'txtDigito.Enabled = Not Valor
   TxtNombre.Enabled = Valor
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor

End Function

Private Sub PROC_APLimpiar()

   txtRut.Text = ""
   txtDigito.Text = ""
   TxtNombre.Text = ""
   txtcodcli.Text = ""
   Call FUNC_APHabilitarControles(False)
   txtRut.SetFocus
   txtcodcli.Enabled = True

End Sub

Private Function FUNC_Buscar_Operadores()

   Dim idRut      As String
   Dim IdDig      As String
   Dim Idcodcli   As String
   Dim lValor     As Boolean

   If Trim(txtRut.Text) <> "" Then
      idRut = txtRut.Text
      IdDig = txtDigito.Text
      Idcodcli = txtcodcli.Text
      lValor = True

      If txtRut.Text = "" Then
         Me.txtcodcli.SetFocus

      End If

      Screen.MousePointer = 11

      If Controla_RUT(txtRut, txtDigito) = True Then
         objCliente.clrut = txtRut.Text
         objCliente.cldv = txtDigito.Text
         objCliente.clcodigo = Val(txtcodcli.Text)

         If objCliente.LeerxRut(objCliente.clrut, objCliente.clcodigo) Then
            If objCliente.clrut <> 0 Then
               TxtNombre.Text = objCliente.clnombre
               TxtNombre.Tag = TxtNombre.Text
               txtcodcli.Text = objCliente.clcodigo
               Idcodcli = txtcodcli.Text

            Else
               MsgBox "Error : No existe , Rut o el Codigo del Cliente ", 16
               lValor = False

            End If

         Else
            Screen.MousePointer = 0
            MsgBox "Error : En Carga de Datos", 16
            lValor = False
            Exit Function

         End If

      Else
         Screen.MousePointer = 0
         MsgBox "Error : Rut Incorrecto", 16
         lValor = False

      End If

      If Not (lValor) Then
         txtRut.Text = ""
         txtDigito.Text = ""
         txtcodcli.Text = ""
         Call PROC_APLimpiar
         Call FUNC_APHabilitarControles(False)
         BacControlWindows 1000
   
         Screen.MousePointer = 0
         txtRut.SetFocus

         Exit Function

      Else
         Call FUNC_APHabilitarControles(True)

      End If
   
      TxtNombre.Enabled = False
    
      ' Carga Grilla de operadores
      If Not objCliente.CargaOperador(grilla, CLng(idRut), CLng(Idcodcli), 0) Then
         Toolbar1.Buttons(3).Enabled = False
         Screen.MousePointer = 0
         Exit Function

      Else
         Toolbar1.Buttons(3).Enabled = True
         grilla.Rows = grilla.Rows - 1
         If grilla.Rows = 1 Then
            Toolbar1.Buttons(3).Enabled = False
            grilla.Rows = grilla.Rows + 1
            grilla.RowHeight(grilla.Rows - 1) = 345

        End If

        grilla.Col = 0
        grilla.Row = 1
        grilla.Enabled = True
        grilla.SetFocus

      End If

      Toolbar1.Buttons(1).Enabled = True
      Toolbar1.Buttons(1).Enabled = True
      TxtNombre.Enabled = False
      txtcodcli.Enabled = False

      Screen.MousePointer = 0

   End If

End Function

Private Sub Form_Activate()
    PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim opcion        As Integer

   On Error GoTo Errores
   opcion = 0

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode
      Case vbKeyLimpiar
         opcion = 1

      Case vbKeyGrabar:
         opcion = 2

      Case vbKeyEliminar:
         opcion = 3

      Case vbKeyBuscar:
         opcion = 4

      Case vbKeySalir:
         If Me.ActiveControl.Name <> "Txtglosa_col" And Me.ActiveControl.Name <> "Txtrut_col" Then
            opcion = 5

         End If

      End Select

      If opcion <> 0 Then
         If Toolbar1.Buttons(opcion).Enabled Then
            Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))

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

   Dim iCol       As Integer

   OptLocal = Opt

   Me.top = 0
   Me.left = 0

   Set objCliente = New clsCliente
   Set Objrutcli = New clsOperador

   Call BacIniciaGrilla(8, 2, 1, 0, False, grilla)
   Call FUNC_SeteaGrilla(grilla)

   Call FUNC_APHabilitarControles(False)

   grilla.Col = 0
   grilla.Row = grilla.FixedRows

   TxtNombre.Enabled = False
   txtcodcli.Enabled = True
   Txtrut_col.Text = ""
   Txtrut_col.Visible = False
   Txtglosa_col.Text = ""
   Txtglosa_col.Visible = False

   grilla.Rows = 2
   grilla.Enabled = False

   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set objCliente = Nothing
   Set Objrutcli = Nothing

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Frame_Click(Index As Integer)

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub Grilla_DblClick()

   Grilla_KeyPress 13

End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim row_tem       As Integer

   If KeyCode = 17 Or KeyCode = 9 Then
      Exit Sub

   End If

   If KeyCode = vbKeyDelete Then
      If grilla.Rows < 3 Then
         grilla.TextMatrix(1, 0) = ""
         grilla.TextMatrix(1, 1) = ""
         Toolbar1.Buttons(3).Enabled = False

      Else
         grilla.RemoveItem (grilla.Row)
         grilla.SetFocus

      End If

      Exit Sub

   End If

   If KeyCode = vbKeyInsert Then
      If grilla.TextMatrix(grilla.Rows - 1, 0) <> "" And grilla.TextMatrix(grilla.Rows - 1, 0) <> "" Then
         grilla.Rows = grilla.Rows + 1
         grilla.RowHeight(grilla.Rows - 1) = 345
         grilla.Row = grilla.Rows - 1
         grilla.Col = 0
         Txtrut_col.top = grilla.CellTop + grilla.top + 30
         Txtrut_col.left = grilla.CellLeft + grilla.left + 30
         Txtrut_col.Height = grilla.CellHeight - 15
         Txtrut_col.Width = grilla.CellWidth - 10
         Txtrut_col.Text = ""
         Txtrut_col.Visible = True
         Txtrut_col.SetFocus

      End If

      Exit Sub

   End If

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

   With grilla
      If .Col = 0 Then
         If KeyAscii = 13 Then
            Txtrut_col.Text = .TextMatrix(.Row, .Col)

         Else
            
            If IsNumeric(Chr(KeyAscii)) Then
               Txtrut_col.Text = Chr(Caracter(Asc(UCase$(Chr$(KeyAscii)))))
               Txtrut_col.SelStart = 1
               
            End If

         End If
         
         Txtrut_col.top = grilla.CellTop + grilla.top + 30
         Txtrut_col.left = grilla.CellLeft + grilla.left + 30
         Txtrut_col.Height = grilla.CellHeight - 15
         Txtrut_col.Width = grilla.CellWidth - 10

        ' PROC_POSICIONA_TEXTO grilla, Txtrut_col
         Txtrut_col.Visible = True
         KeyAscii = 0
         Txtrut_col.SetFocus

      End If

      If .Col = 1 Then
      
         If Trim(.TextMatrix(.Row, 0)) = "" Then
            MsgBox " Debe Ingresar Codigo Del Operador ", vbExclamation
            .Col = 0
            .SetFocus
            Exit Sub

         End If

         If KeyAscii = vbKeyReturn Then
            Txtglosa_col.Text = Trim(.TextMatrix(.Row, .Col))

         Else
            Txtglosa_col.Text = Chr(Caracter(Asc(UCase$(Chr$(KeyAscii)))))

         End If

         Txtglosa_col.top = grilla.CellTop + grilla.top + 60
         Txtglosa_col.left = grilla.CellLeft + grilla.left + 40
         Txtglosa_col.Height = grilla.CellHeight - 50
         Txtglosa_col.Width = grilla.CellWidth - 10

         'PROC_POSICIONA_TEXTO grilla, Txtglosa_col
         Txtglosa_col.Visible = True
         KeyAscii = 0
         Txtglosa_col.SetFocus

      End If

   End With

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   Case 1
      grilla.Enabled = False
      txtcodcli.Enabled = True
      Txtrut_col.Text = ""
      Txtrut_col.Visible = False
      Txtglosa_col.Text = ""
      Txtglosa_col.Visible = False
      Call PROC_APLimpiar
      grilla.Rows = 1
      grilla.Rows = 2
      grilla.RowHeight(grilla.Rows - 1) = 345
   Case 2
      Call PROC_GRABAR

   Case 3
      If (grilla.TextMatrix(grilla.Row, 0) = "" Or grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows > 2 Then
         grilla.RemoveItem (grilla.Row)
         grilla.SetFocus
         Exit Sub

      End If

      Call PROC_ELIMINAR

   Case 4
      If txtRut.Text = "" Then
         MsgBox "Falta Información Para la Busqueda", vbInformation
         Exit Sub

      Else
         txtDigito.Text = FUNC_DevuelveDig(txtRut.Text)
         FUNC_Buscar_Operadores

      End If

   Case 5
      Unload Me

   End Select

End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
   Case 1
        If grilla.TextMatrix(grilla.Rows - 1, 0) <> "" And grilla.TextMatrix(grilla.Rows - 1, 0) <> "" Then
            grilla.Rows = grilla.Rows + 1
            grilla.RowHeight(grilla.Rows - 1) = 345
            grilla.Row = grilla.Rows - 1
            grilla.Col = 0
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

   If KeyCode = vbKeyF3 Then
      Call txtRut_DblClick

   End If

End Sub

Private Sub txtcodcli_KeyPress(KeyAscii As Integer)

   BacSoloNumeros KeyAscii

   If KeyAscii = 13 And Val(Trim$(txtcodcli.Text)) > 0 Then
      Call FUNC_Buscar_Operadores
      Exit Sub

   ElseIf KeyAscii% = vbKeyReturn Then
      txtcodcli.Text = ""

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

   If Controla_RUT(txtRut, txtDigito) = True Then
      objCliente.clrut = txtRut.Text
      objCliente.cldv = txtDigito.Text
      txtcodcli.Enabled = True
      txtcodcli.SetFocus

   Else
      MsgBox "Error : El Rut Esta Incorrecto", 16
      Call FUNC_APHabilitarControles(False)
      txtcodcli.Enabled = False
      txtRut.SetFocus
      Exit Sub

   End If

End Sub

Private Sub Txtglosa_col_GotFocus()

   Me.Txtglosa_col.SelStart = Len(Me.Txtglosa_col.Text)

End Sub

Private Sub Txtglosa_col_KeyDown(KeyCode As Integer, Shift As Integer)

   With grilla
      If KeyCode = vbKeyReturn Then
         .TextMatrix(.Row, .Col) = Trim(Txtglosa_col.Text)
         Txtglosa_col.Text = ""
         BacControlWindows 100
         grilla.SetFocus

      End If

      If KeyCode = vbKeyEscape Then
         Txtglosa_col.Text = ""
         Txtglosa_col.Visible = False

      End If

   End With

End Sub

Private Sub Txtglosa_col_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter(Asc(UCase$(Chr$(KeyAscii))))
   Call BacToUCase(KeyAscii)
   

End Sub

Private Sub Txtglosa_col_LostFocus()

   Txtglosa_col.Visible = False

End Sub

Private Sub Txtrut_col_GotFocus()

   Txtrut_col.SelStart = Len(Txtrut_col.Text)

End Sub

Private Sub Txtrut_col_KeyPress(KeyAscii As Integer)

   With grilla
      Call BacToUCase(KeyAscii)

      If Not ((KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 13 Or KeyAscii = 27 Or KeyAscii = 8) Then
         KeyAscii = 0

      End If

      If KeyAscii = vbKeyReturn Then
         If bacBuscaRepetidoGrilla(0, grilla, Trim(Txtrut_col.Text)) = False Then
            If Trim$(Txtrut_col.Text) = "" Then
               Txtrut_col.Visible = False
               .SetFocus

            End If

            .TextMatrix(.Row, 0) = Trim(Txtrut_col.Text)

            Txtrut_col.Visible = False
            KeyAscii = 0

            .Col = 1
            .SetFocus

            Exit Sub

         Else
            KeyAscii = 0
            Exit Sub

         End If

      End If

      If KeyAscii = vbKeyEscape Then
         Txtrut_col.Visible = False
         .SetFocus

      End If

   End With

End Sub

Private Sub Txtrut_col_LostFocus()

   Txtrut_col.Visible = False

   If grilla.Enabled Then
      grilla.SetFocus

   End If

End Sub

Private Sub txtRut_DblClick()

   MiTag = "MDCL_U"
   BacAyuda.Show 1

   If giAceptar% = True Then
      txtRut.Text = CDbl(gsCodigo$)
      txtDigito.Text = gsDigito$
      txtcodcli.Text = gsCodCli

      Call FUNC_Buscar_Operadores

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

   Call BacSoloNumeros(KeyAscii)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey vbKeyTab

   End If

End Sub

Public Function FUNC_SeteaGrilla(Grillas As Object)

   With Grillas
      .Enabled = True
      .Row = 0
      .RowHeight(0) = 400
      .RowHeight(1) = 345
      .CellFontWidth = 4         ' TAMAÑO
      .ColWidth(0) = 1330
      .ColWidth(1) = 4940

      .Row = 0

      .Col = 0
      .CellFontBold = True       'RESALSE
      .Text = "   Código "

      .Col = 1
      .CellFontBold = True       'RESALSE
      .Text = " Nombre del Operador  "
      .ColAlignment(1) = 1

   End With

End Function

Public Function FUNC_Valida_Ingreso_graba() As Boolean

   Dim Fila       As Integer

   FUNC_Valida_Ingreso_graba = False

   Me.Txtglosa_col.Visible = False
   grilla.Enabled = True


   With grilla
      For Fila = 1 To .Rows - 1
         
         If .Rows = 2 And .TextMatrix(1, 0) = "" And .TextMatrix(1, 1) = "" Then
         
            Exit For
            
         End If
         
         If Trim$(.TextMatrix(Fila, 0)) = "" Then
            Screen.MousePointer = 0
            MsgBox "Falta Ingresar el código de un Operador", vbExclamation

            .Col = 0
            .Row = Fila
            .SetFocus
            Exit Function

         ElseIf Not IsNumeric(.TextMatrix(Fila, 0)) Then
            Screen.MousePointer = 0
            MsgBox "El valor ingresar en el código de un Operador no es un valor númerico", vbExclamation

            .Col = 0
            .Row = Fila
            .SetFocus
            Exit Function

         ElseIf Trim$(.TextMatrix(Fila, 1)) = "" Then
            MsgBox "Falta Ingresar el Nombre a Un Operador", vbExclamation

            .Col = 1
            .Row = Fila
            .SetFocus
            Exit Function

         End If

      Next Fila

      .SetFocus

   End With

   FUNC_Valida_Ingreso_graba = True

End Function

Private Function FUNC_Valida_Ingreso(obj As Object) As Boolean

   Dim Fila       As Integer

   FUNC_Valida_Ingreso = True

   grilla.Enabled = True

   With grilla
      For Fila = 1 To .Rows - 1
         .Row = Fila

         If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 1)) = "" Then
            PROC_POSICIONA_TEXTO grilla, Txtrut_col
            .Col = 0
            Exit Function

         End If

      Next Fila

   End With

End Function

Private Sub PROC_ELIMINAR()

   Dim A             As Integer
   Dim bOk           As Boolean
   Dim i             As Integer

   On Error GoTo Errores

   bOk = False

   If MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo) = vbYes Then
      opecod = grilla.Text

      Call BacBeginTransaction

      bOk = True

      For i = grilla.Rows - 1 To 1 Step -1
         Envia = Array(grilla.TextMatrix(i, 0), txtRut.Text, txtcodcli.Text)
         If Not BAC_SQL_EXECUTE("Sp_Borrar_Operador", Envia) Then
            Call BacRollBackTransaction
            Exit Sub

         End If

      Next i

      Call BacCommitTransaction

      bOk = False

      Call PROC_LIMPIAR
      Call PROC_APLimpiar

      grilla.Enabled = False

   End If

   Call LogAuditoria("03", OptLocal, Me.Caption, "", "")

   On Error GoTo 0

   Exit Sub

Errores:
   Call LogAuditoria("03", OptLocal, Me.Caption + " Error al eliminar- Rut: " & txtRut.Text + "-" + txtDigito.Text, "", "")

   If bOk Then
      Call BacRollBackTransaction

   End If

   On Error GoTo 0

End Sub


Private Sub PROC_LIMPIAR()

   Set objCliente = New clsCliente
   Set Objrutcli = New clsOperador

   Call BacIniciaGrilla(2, 2, 1, 0, False, grilla)
   Call FUNC_SeteaGrilla(grilla)

   Call FUNC_APHabilitarControles(False)

   TxtNombre.Enabled = False
   Txtrut_col.Text = ""
   Txtrut_col.Visible = False
   Txtglosa_col.Text = ""
   Txtglosa_col.Visible = False

   grilla.Rows = 2
   grilla.RowHeight(grilla.Rows - 1) = 345
   grilla.TextMatrix(1, 0) = ""
   grilla.TextMatrix(1, 1) = ""

   grilla.Col = 0
   grilla.Row = 1
   
End Sub

Private Function FUNC_DevuelveDig(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

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

Private Sub PROC_GRABAR()

   Dim idrutcli      As String
   Dim iddigito      As String
   Dim idrutapo      As String
   Dim IdOpcion      As Integer

   If Me.ActiveControl.Name = Me.Txtglosa_col.Text Then
      Me.Txtglosa_col.Visible = False

   End If

   Txtrut_col.Text = ""
   Txtrut_col.Visible = False
   Txtglosa_col.Text = ""
   Txtglosa_col.Visible = False

   If FUNC_Valida_Ingreso_graba() = False Then
      Txtglosa_col.Visible = False
      Exit Sub

   End If

   Screen.MousePointer = 11

   FRM_ESTADO% = False

   Call BacBeginTransaction

   If Objrutcli.EliminarOperador("0", txtRut.Text, txtcodcli.Text) = False Then
      Screen.MousePointer = 0
      MsgBox "No se puede  eliminar en tabla apoderado ", 16
      Call BacRollBackTransaction
      Call LogAuditoria("03", OptLocal, Me.Caption & " Error al eliminar- Rut: " & txtRut.Text & "-" & txtDigito.Text, "", "")
      Exit Sub

   End If

   If grilla.Rows = 2 And grilla.TextMatrix(1, 0) = "" Then
      Screen.MousePointer = 0
      MsgBox "No se puede grabar en tabla apoderado falta informaciòn", 16
      Call BacRollBackTransaction
      Exit Sub
   End If
   
   If Objrutcli.GrabarOperadores(grilla, txtRut.Text, txtcodcli.Text) = True Then
      Screen.MousePointer = 0
      MsgBox "Grabación se realizó con exito", 64
      Call LogAuditoria("01", OptLocal, Me.Caption, "", "")

   Else
      Screen.MousePointer = 0
      MsgBox "No se puede grabar en tabla apoderado", 16
      Call BacRollBackTransaction
      Exit Sub

   End If

   Call BacCommitTransaction

      Call PROC_LIMPIAR
      Call PROC_APLimpiar

   txtcodcli.Enabled = True
   grilla.Row = 1
   grilla.Col = 0
   grilla.Rows = 1
   grilla.Rows = 2
   grilla.RowHeight(grilla.Rows - 1) = 345
   
   Screen.MousePointer = 0

End Sub

Private Sub txtRut_LostFocus()

   txtDigito.Text = ValidaRut(txtRut.Text)

End Sub
