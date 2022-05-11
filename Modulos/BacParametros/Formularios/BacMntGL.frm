VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntCuentasGL 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención Cuantes GL-CODE"
   ClientHeight    =   4995
   ClientLeft      =   1275
   ClientTop       =   2565
   ClientWidth     =   10035
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4995
   ScaleWidth      =   10035
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame Frame 
      Height          =   1200
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   720
      Width           =   9825
      _Version        =   65536
      _ExtentX        =   17330
      _ExtentY        =   2117
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
      Begin VB.TextBox TextDesc 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         TabIndex        =   11
         Top             =   240
         Width           =   4935
      End
      Begin VB.TextBox txtCodigo 
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
         Left            =   1440
         MaxLength       =   5
         MousePointer    =   99  'Custom
         TabIndex        =   2
         Top             =   240
         Width           =   690
      End
      Begin VB.ComboBox cmbCondicion 
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
         Left            =   1440
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   720
         Width           =   3380
      End
      Begin VB.Label Label 
         Caption         =   "Transacción"
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
         Index           =   90
         Left            =   120
         TabIndex        =   4
         Top             =   330
         Width           =   1155
      End
      Begin VB.Label Label 
         Caption         =   "Condición"
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
         Index           =   92
         Left            =   105
         TabIndex        =   3
         Top             =   720
         Width           =   915
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   3015
      Index           =   1
      Left            =   120
      TabIndex        =   5
      Top             =   1920
      Width           =   9825
      _Version        =   65536
      _ExtentX        =   17330
      _ExtentY        =   5318
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.TextBox Txt_Ingreso 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000005&
         Height          =   465
         Left            =   1860
         TabIndex        =   12
         Top             =   1200
         Visible         =   0   'False
         Width           =   2175
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   2775
         Left            =   120
         TabIndex        =   10
         Top             =   120
         Width           =   9615
         _ExtentX        =   16960
         _ExtentY        =   4895
         _Version        =   393216
         Cols            =   13
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         BackColorBkg    =   -2147483645
         FocusRect       =   0
         GridLines       =   2
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
   Begin Threed.SSFrame SSFrame1 
      Height          =   2145
      Left            =   7860
      TabIndex        =   6
      Top             =   75
      Visible         =   0   'False
      Width           =   1455
      _Version        =   65536
      _ExtentX        =   2566
      _ExtentY        =   3784
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
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   705
         Left            =   90
         ScaleHeight     =   645
         ScaleWidth      =   1170
         TabIndex        =   9
         Top             =   240
         Width           =   1230
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(1)"
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Index           =   1
         Left            =   120
         TabIndex        =   8
         Top             =   1650
         Width           =   855
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Top             =   1215
         Width           =   855
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   13
      Top             =   0
      Width           =   10035
      _ExtentX        =   17701
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   2760
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntGL.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntGL.frx":0452
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntGL.frx":08A4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntGL.frx":0BBE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntGL.frx":0ED8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacMntCuentasGL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Private lEncontro As Boolean
Function BuscaCodTran(nCodTr#) As Boolean
  Dim DATOS()
    BuscaCodTran = False
    On Error GoTo ErrCmbTr
    Envia = Array()
    AddParam Envia, nCodTr#
    If Bac_Sql_Execute("Sp_BuscaTran", Envia) Then
       Do While Bac_SQL_Fetch(DATOS())
           If DATOS(1) = "NO" Then
              Exit Function
           Else
              TextDesc.Text = DATOS(2)
           End If
       Loop
       Screen.MousePointer = 0
    End If
    BuscaCodTran = True
Exit Function
ErrCmbTr:
    MsgBox Err.Description, vbCritical, "Error"


End Function

Sub Dibuja_Grilla()

Table1.TextMatrix(0, 0) = ""
Table1.TextMatrix(0, 1) = "Código"
Table1.TextMatrix(0, 2) = "Descripción"
Table1.TextMatrix(0, 3) = "Cuenta GlCode"
Table1.TextMatrix(0, 4) = "Cuenta Super"
Table1.TextMatrix(0, 5) = "Cta.Altamira (+) "
Table1.TextMatrix(0, 6) = "Cta.Altamira (-)"
Table1.TextMatrix(0, 7) = "Cuenta COSIF"
Table1.TextMatrix(0, 8) = "Cuenta COSIF_GER"
Table1.TextMatrix(0, 9) = "Cuenta INT.SIGIR"
Table1.TextMatrix(0, 10) = "Cuenta REA.SIGIR"
Table1.TextMatrix(0, 11) = "Cuenta GL GRM"
Table1.TextMatrix(0, 12) = "Cuenta Sbif GRM"

Table1.RowHeight(0) = 500

Table1.ColAlignment(0) = 1
Table1.ColAlignment(1) = 4
Table1.ColAlignment(2) = 1
Table1.ColAlignment(3) = 4
Table1.ColAlignment(4) = 4
Table1.ColAlignment(5) = 4
Table1.ColAlignment(6) = 4
Table1.ColAlignment(7) = 4
Table1.ColAlignment(8) = 4
Table1.ColAlignment(9) = 4
Table1.ColAlignment(10) = 4
Table1.ColAlignment(11) = 4
Table1.ColAlignment(12) = 4

Table1.ColWidth(0) = 0
Table1.ColWidth(1) = 700
Table1.ColWidth(2) = 3000
Table1.ColWidth(3) = 1500
Table1.ColWidth(4) = 1500
Table1.ColWidth(5) = 1500
Table1.ColWidth(6) = 1500
Table1.ColWidth(7) = 1500
Table1.ColWidth(8) = 1800
Table1.ColWidth(9) = 1800
Table1.ColWidth(10) = 1800
Table1.ColWidth(11) = 1800
Table1.ColWidth(12) = 1800


Table1.Rows = 1
End Sub
Function Habilitacontroles(Valor As Boolean)

   txtCodigo.Enabled = Not Valor
'   TextDesc.Enabled = Not Valor
   If lEncontro Then
      cmbCondicion.Enabled = Not Valor
   End If
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   Table1.Enabled = Valor
   If Not lEncontro Then
      txtCodigo.SetFocus
   End If


End Function
Sub Llena_ComboCondcion()
  Dim DATOS()
  Dim i#
    On Error GoTo ErrCmb

    If Not Bac_Sql_Execute("Sp_traeCondiciones") Then
       Screen.MousePointer = 0
       Exit Sub
    End If

    Do While Bac_SQL_Fetch(DATOS())
        cmbCondicion.AddItem Trim(DATOS(2))
        cmbCondicion.ItemData(i) = DATOS(1)
        i = i + 1
    Loop
    Exit Sub
ErrCmb:
    MsgBox Err.Description, vbCritical, "Error"

End Sub
Function BorraGl(nCodTr, nCond) As Boolean
   On Error GoTo ErrGLcEl
   BorraGl = False
   Envia = Array()
   AddParam Envia, nCodTr
   AddParam Envia, nCond

   If Not Bac_Sql_Execute("Sp_EliminaGlCode ", Envia) Then
      Exit Function
   End If
   BorraGl = True
   Exit Function
ErrGLcEl:
    MsgBox Err.Description, vbCritical, "Error"

End Function
Function BACGrabarGl(nCodTr As Integer, nCond As String) As Boolean
  Dim i#
   On Error GoTo ErrGLcgrb
    BACGrabarGl = False
    If Not BorraGl(nCodTr, nCond) Then
       MsgBox "No se puede eliminar datos anteriores", vbCritical, "Error de Eliminación"
       Exit Function
    End If

    With Table1
    For i = 1 To Table1.Rows - 1
        'nCodCond = .TextMatrix(i, 1)
        'nDesc = .TextMatrix(i, 2)
        'nCtaGl = .TextMatrix(i, 3)
        'nCtaSuper = .TextMatrix(i, 4)

        Envia = Array()
        AddParam Envia, nCodTr
        AddParam Envia, CDbl(nCond)
        AddParam Envia, .TextMatrix(i, 1)
        AddParam Envia, .TextMatrix(i, 2)
        AddParam Envia, .TextMatrix(i, 3)
        AddParam Envia, .TextMatrix(i, 4)
        AddParam Envia, .TextMatrix(i, 5)
        AddParam Envia, .TextMatrix(i, 6)
        AddParam Envia, .TextMatrix(i, 7)
        AddParam Envia, .TextMatrix(i, 8)
        AddParam Envia, .TextMatrix(i, 9)
        AddParam Envia, .TextMatrix(i, 10)

        '--+++jcamposd 20141218 para interfaz grm
        AddParam Envia, .TextMatrix(i, 11)
        AddParam Envia, .TextMatrix(i, 12)
        '-----jcamposd 20141218 para interfaz grm

        If Not Bac_Sql_Execute("Sp_GrabarCuentasGl", Envia) Then
           Exit Function
        End If

    Next i
    End With
    BACGrabarGl = True
    Exit Function
ErrGLcgrb:
    MsgBox Err.Description, vbCritical, "Error"

End Function
Private Function BACLeerCuentasCo(CodTr As Integer, CodCond As Integer) As Boolean
   Dim i#, j#
   On Error GoTo ErrGLco
    BACLeerCuentasCo = False
    Envia = Array()
    AddParam Envia, CodTr
    AddParam Envia, CodCond

    If Not Bac_Sql_Execute("Sp_traeCuentasCo", Envia) Then
       Screen.MousePointer = 0
       Exit Function
    End If

    With Table1
     '.Rows = 2
    Do While Bac_SQL_Fetch(DATOS())
            i# = i# + 1
            .Rows = .Rows + 1
            .TextMatrix(i#, 1) = DATOS(1)
            .TextMatrix(i#, 2) = DATOS(2)
            .TextMatrix(i#, 3) = DATOS(3)
            .TextMatrix(i#, 4) = DATOS(4)
            .TextMatrix(i#, 5) = DATOS(5)
            .TextMatrix(i#, 10) = DATOS(10)
            .TextMatrix(i#, 6) = DATOS(6)
            .TextMatrix(i#, 7) = DATOS(7)
            .TextMatrix(i#, 8) = DATOS(8)
            .TextMatrix(i#, 9) = DATOS(9)


    Loop

    .Rows = i# + 1
    End With
    BACLeerCuentasCo = True
    Exit Function
ErrGLco:
    MsgBox Err.Description, vbCritical, "Error"

End Function

Private Function BACLeerCuentasGl(nCodTran#) As Boolean
   Dim i#, j#, nCodi#
   On Error GoTo ErrGLc
    BACLeerCuentasGl = False
    Envia = Array()
    AddParam Envia, nCodTran
    lEncontro = False
    If Not Bac_Sql_Execute("Sp_traeCuentasGl", Envia) Then
       Screen.MousePointer = 0
       Exit Function
    End If

    With Table1
    Do While Bac_SQL_Fetch(DATOS())
       If DATOS(1) = "SI" Then
            nCodi = DATOS(2)
            i# = i# + 1
            .Rows = .Rows + 1
            .TextMatrix(i#, 1) = DATOS(3)
            .TextMatrix(i#, 2) = DATOS(4)
            .TextMatrix(i#, 3) = DATOS(5) ' Cuentas_Glcode
            .TextMatrix(i#, 4) = DATOS(6)
            .TextMatrix(i#, 5) = DATOS(7)
            .TextMatrix(i#, 6) = DATOS(8)
            .TextMatrix(i#, 7) = DATOS(9)
            .TextMatrix(i#, 8) = DATOS(10)
            .TextMatrix(i#, 9) = DATOS(11)
            .TextMatrix(i#, 10) = DATOS(12)
            .TextMatrix(i#, 11) = DATOS(14)
            .TextMatrix(i#, 12) = DATOS(15)

            lEncontro = True
       End If
    Loop

    For j# = 0 To cmbCondicion.ListCount - 1
        If nCodi = cmbCondicion.ItemData(j#) Then
           cmbCondicion.ListIndex = j#
           Exit For
        End If
    Next j#

    If nCodi = 0 Then
       cmbCondicion.ListIndex = -1
    Else
      .Rows = i# + 1
    End If

    End With
    BACLeerCuentasGl = True
    Exit Function
ErrGLc:
    MsgBox Err.Description, vbCritical, "Error"
End Function

Sub Limpiar()

   Table1.Clear
   Table1.Rows = 2

    Dibuja_Grilla
    txtCodigo.Text = ""
    Txt_Ingreso.Visible = False
    cmbCondicion.ListIndex = -1
    TextDesc.Text = ""
End Sub

Private Sub Valores2Grilla()

   On Error GoTo Label1

   Dim nCondicion As String

   MousePointer = 11

   If CDbl(txtCodigo.Text) = 0 Then
      MousePointer = 0
      Exit Sub

   End If

'   If cmbCondicion.ListIndex <> -1 Then
'      nCondicion = cmbCondicion.ItemData(cmbCondicion.ListIndex)
'   Else
'      MsgBox "Debe seleccionar una condición", vbCritical, "Error"
'      Exit Sub
'   End If

   If Not BACLeerCuentasGl(CDbl(txtCodigo.Text)) Then
      MsgBox "No se Pudo ejecutar Consulta de GLCODE", vbCritical, TITSISTEMA
      Exit Sub
   End If

   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(1).Enabled = True
   Table1.Refresh
   MousePointer = 0

   Exit Sub

Label1:

   MousePointer = 0

End Sub

Private Sub cmdBuscar()

   If txtCodigo.Text <> "" Then
      'Call Valores2Grilla
      Call Habilitacontroles(True)
      Table1.SetFocus

   End If

End Sub

Private Sub CmdGrabar()
   Dim nCondicion$
   If cmbCondicion.ListIndex <> -1 Then
      nCondicion = cmbCondicion.ItemData(cmbCondicion.ListIndex)
   Else
      MsgBox "Debe seleccionar una condición", vbCritical, "Error"
      Exit Sub
   End If
   If CDbl(txtCodigo.Text) = 0 Then
      MsgBox "Debe seleccionar una Transacción", vbCritical, "Error"
      Exit Sub

   End If

   If Not BACGrabarGl(CDbl(txtCodigo.Text), nCondicion) Then
      MsgBox "No se pueden grabar datos", 16, "Bac-Parametros"

   Else
      Call Limpiar
      lEncontro = False
      Call Habilitacontroles(False)
      MsgBox "Datos Grabados OK", vbInformation, "Bac-Parametros"
   End If

End Sub
Private Sub cmdEliminar()
   Dim nCondicion$
   If cmbCondicion.ListIndex <> -1 Then
      nCondicion = cmbCondicion.ItemData(cmbCondicion.ListIndex)
   Else
      MsgBox "Debe seleccionar una condición", vbCritical, "Error"
      Exit Sub
   End If
   If CDbl(txtCodigo.Text) = 0 Then
      MsgBox "Debe seleccionar una Transacción", vbCritical, "Error"
      Exit Sub

   End If
  If MsgBox("Esta seguro de eliminar ", vbInformation + vbYesNo) = vbYes Then
      Envia = Array()
      AddParam Envia, CDbl(txtCodigo.Text)
      AddParam Envia, nCondicion

      'If Not Bac_Sql_Execute("SP_ELIMINA_CTA_GLCODE", Envia) Then
      If Not Bac_Sql_Execute("Sp_EliminaGlCode", Envia) Then
         MsgBox "No se pueden Eliminar datos", 16, "Bac-Parametros"
         Exit Sub
      End If

         Call Limpiar
         lEncontro = False
         Call Habilitacontroles(False)
         MsgBox "Datos Eliminados OK", vbInformation, "Bac-Parametros"
  End If

End Sub

Private Sub cmdLimpiar()

   Call Limpiar
   Call Habilitacontroles(False)

End Sub
Private Function BuscarCondicion(CodTr As Integer, CodCond As Integer) As Boolean
   On Error GoTo Label2
   Dim nCondicion As String

   MousePointer = 11
   If CDbl(txtCodigo.Text) = 0 Then
      MousePointer = 0
      Exit Function

   End If

   If cmbCondicion.ListIndex <> -1 Then
      nCondicion = cmbCondicion.ItemData(cmbCondicion.ListIndex)
   Else
      MsgBox "Debe seleccionar una condición", vbCritical, "Error"
      Exit Function
   End If
      If Not BACLeerCuentasCo(CDbl(txtCodigo.Text), CodCond) Then
        MsgBox "No se Puede Leer Tabla Cuentas GLCODE", vbCritical, "Busqueda"
        Exit Function
      End If
   Toolbar1.Buttons(2).Enabled = True
   Table1.Refresh

   MousePointer = 0

   Exit Function
Label2:
   MsgBox Err.Description, vbCritical, "BacParametros"
End Function

Private Sub cmbCondicion_Click()
   If txtCodigo.Text <> "" And cmbCondicion.ListIndex <> -1 Then
      If Not lEncontro Then
        If Not BuscarCondicion(txtCodigo.Text, cmbCondicion.ItemData(cmbCondicion.ListIndex)) Then
            If Not lEncontro Then
               Table1.SetFocus
            End If
        End If
      End If
   End If

End Sub

Private Sub Form_Activate()
   txtCodigo.SetFocus
End Sub

Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0

   Dibuja_Grilla
   Llena_ComboCondcion
   cmbCondicion.Enabled = False
   TextDesc.Enabled = False
   Toolbar1.Buttons(1).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Table1.Enabled = False


End Sub

Private Sub Table1_Click()
    Call PintaCelda(Table1)
End Sub

Private Sub Table1_GotFocus()
    Call PintaCelda(Table1)
End Sub

Private Sub Table1_LeaveCell()
    Call CellPintaCelda(Table1)
End Sub

Private Sub Table1_SelChange()
    Call PintaCelda(Table1)
End Sub
Private Sub Table1_KeyPress(KeyAscii As Integer)

If Not IsNumeric(Chr(KeyAscii)) And KeyAscii = 13 And KeyAscii = 8 Then

  KeyAscii = 0

End If

If (Table1.Col = 3 Or Table1.Col = 4 Or Table1.Col = 5 Or Table1.Col = 6 Or Table1.Col = 7 Or Table1.Col = 8 Or Table1.Col = 9 Or Table1.Col = 10 Or Table1.Col = 11 Or Table1.Col = 12) And IsNumeric(Chr(KeyAscii)) Then

      Txt_Ingreso.Text = ""

      PROC_POSICIONA_TEXTO Table1, Txt_Ingreso

      Txt_Ingreso.Text = Chr(KeyAscii)
      Txt_Ingreso.Visible = True
      Txt_Ingreso.Enabled = True
      Txt_Ingreso.SetFocus

      'SendKeys "{END}"

End If
If (Table1.Col = 3 Or Table1.Col = 4 Or Table1.Col = 5 Or Table1.Col = 6 Or Table1.Col = 7 Or Table1.Col = 8 Or Table1.Col = 9 Or Table1.Col = 10 Or Table1.Col = 11 Or Table1.Col = 12) And KeyAscii = 13 Then

      PROC_POSICIONA_TEXTO Table1, Txt_Ingreso

      Txt_Ingreso.Text = Table1.Text
      Txt_Ingreso.Visible = True
      Txt_Ingreso.Enabled = True
      Txt_Ingreso.SetFocus

      'SendKeys "{END}"

End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
'    Case 1          '"Buscar"
'        Call cmdBuscar
    Case 1          '"Grabar"
        Call CmdGrabar
    Case 2          '"Limpiar"
        Call cmdLimpiar
    Case 3
        Call cmdEliminar
    Case 4          '"Salir"
        Unload Me
    End Select
End Sub

Private Sub Txt_Ingreso_GotFocus()
   Txt_Ingreso.SelStart = Len(Txt_Ingreso)
   If Table1.Col = 3 Then
      Txt_Ingreso.MaxLength = 8
   ElseIf Table1.Col = 4 Or Table1.Col = 5 Or Table1.Col = 6 Or Table1.Col = 7 Or Table1.Col = 9 Or Table1.Col = 10 Or Table1.Col = 11 Or Table1.Col = 12 Then
      Txt_Ingreso.MaxLength = 10
   End If
End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)
If (KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 27 Or KeyAscii = 13 Or KeyAscii = 8 Then
    If KeyAscii = 27 Then
        Txt_Ingreso.Visible = False
        Txt_Ingreso.Text = ""
        Table1.SetFocus
    End If
    If Table1.Col = 3 Or Table1.Col = 4 Or Table1.Col = 5 Or Table1.Col = 6 Or Table1.Col = 7 Or Table1.Col = 8 Or Table1.Col = 9 Or Table1.Col = 10 Or Table1.Col = 11 Or Table1.Col = 12 Then

        If KeyAscii = 13 Then
            If Trim(Txt_Ingreso.Text) = "" Then Exit Sub
            Table1.Text = Txt_Ingreso.Text
            Table1.Text = Table1.Text
            Txt_Ingreso.Text = ""
            Txt_Ingreso.Visible = False
            Table1.SetFocus
        End If
    End If
Else
    KeyAscii = 0
End If
End Sub



Private Sub txtCodigo_DblClick()
    auxilio = 200
    On Error GoTo Label1

   txtCodigo.Text = 0
   BacAyuda.Tag = "PERFIL"
   BacAyuda.parAyuda = "BAC_CNT_PERFIL"
   BacAyuda.parFiltro = "BTR"
   BacAyuda.Show 1

   If Trim(gsCodigo$) <> "" And giAceptar% = True Then
      txtCodigo.Text = CDbl(gsCodigo$)
      TextDesc.Text = gsDescripcion$
      SendKeys "{ENTER}"

   End If

   Exit Sub

Label1:
   MousePointer = 0

End Sub


Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call txtCodigo_DblClick
End Sub


Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      If Val(txtCodigo.Text) <> 0 Then
         If BuscaCodTran(CDbl(txtCodigo.Text)) Then
            Call TxtCodigo_LostFocus
         Else
            MsgBox "No existe codigo Transacción", vbCritical, "Busqueda"
            KeyAscii = 0
         End If
      'SendKeys$ "{TAB}"
      End If
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacCaracterNumerico KeyAscii

End Sub


Private Sub TxtCodigo_LostFocus()
   If txtCodigo.Text <> "" Then
   If CDbl(txtCodigo.Text) = 0 Then
      MousePointer = 0
      Exit Sub
   Else
      Call Valores2Grilla
      If lEncontro Then
         Call Habilitacontroles(True)
         TextDesc.Enabled = False
      Else
         cmbCondicion.Enabled = True
         cmbCondicion.SetFocus
         Dibuja_Grilla
         Table1.Enabled = True
      End If
      Table1.Refresh
      Grid1.Refresh
   End If
   End If
End Sub
