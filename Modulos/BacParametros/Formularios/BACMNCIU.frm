VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntCiu 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Ciudad"
   ClientHeight    =   4155
   ClientLeft      =   2535
   ClientTop       =   3630
   ClientWidth     =   5865
   Icon            =   "BACMNCIU.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4155
   ScaleWidth      =   5865
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   3615
      Left            =   0
      TabIndex        =   3
      Top             =   540
      Width           =   5865
      _Version        =   65536
      _ExtentX        =   10345
      _ExtentY        =   6376
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
      Begin VB.ComboBox cmbPais 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   1005
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   90
         Width           =   2610
      End
      Begin VB.TextBox txtCodigoCiudad 
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Enabled         =   0   'False
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
         Height          =   210
         Left            =   255
         MaxLength       =   6
         MouseIcon       =   "BACMNCIU.frx":030A
         MousePointer    =   99  'Custom
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   1110
         Visible         =   0   'False
         Width           =   735
      End
      Begin VB.TextBox txtNombreCiudad 
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Enabled         =   0   'False
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
         Height          =   210
         Left            =   1230
         MaxLength       =   30
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   1110
         Visible         =   0   'False
         Width           =   705
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   3015
         Left            =   90
         TabIndex        =   7
         Top             =   495
         Width           =   5760
         _ExtentX        =   10160
         _ExtentY        =   5318
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         GridColor       =   255
         GridColorFixed  =   8421504
         FillStyle       =   1
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
      Begin VB.Label lblPais 
         AutoSize        =   -1  'True
         Caption         =   "País"
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
         Left            =   300
         TabIndex        =   11
         Top             =   180
         Width           =   405
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
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
         Height          =   195
         Left            =   4185
         TabIndex        =   10
         Top             =   165
         Width           =   600
      End
      Begin VB.Label lblCodigo 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Height          =   315
         Left            =   4860
         TabIndex        =   9
         Top             =   120
         Width           =   960
      End
      Begin VB.Label lblCodCom 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Height          =   300
         Left            =   4860
         TabIndex        =   8
         Top             =   120
         Visible         =   0   'False
         Width           =   945
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3600
      Top             =   -90
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
            Picture         =   "BACMNCIU.frx":0614
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACMNCIU.frx":0A66
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACMNCIU.frx":0EB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACMNCIU.frx":11D2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   5865
      _ExtentX        =   10345
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
   End
   Begin VB.Label lblNombreCiudad 
      AutoSize        =   -1  'True
      Caption         =   "Nombre Ciudad"
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
      Left            =   105
      TabIndex        =   1
      Top             =   4545
      Width           =   1305
   End
   Begin VB.Label lblCodigoCiudad 
      AutoSize        =   -1  'True
      Caption         =   "Código Ciudad"
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
      Left            =   105
      TabIndex        =   0
      Top             =   4260
      Width           =   1245
   End
End
Attribute VB_Name = "BacMntCiu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private objcodtab       As Object
Private objCodigos      As Object
Private objMensajesTB   As Object
Dim base As Database
Dim sql As String
Dim datos()
Dim sw As Boolean
Dim c As Integer
Dim Limpia As Boolean
Dim AuxCod As String
Dim AuxNom As String




Sub Consulta_Ciudad()

sql = ""
sql = "execute leerciu "
sql = sql & Trim(lblCodigo.Caption)
If MISQL.SQL_Execute(sql) <> 0 Then
   
  Exit Sub

End If
  
Do While MISQL.SQL_Fetch(datos()) = 0
 
Loop

End Sub

Sub Elimina_Ciudad()

Grilla.Row = Grilla.RowSel
Grilla.Col = 0: AuxCod = Grilla.Text
Grilla.Col = 1: AuxNom = Grilla.Text

If AuxCod <> "" Or AuxNom <> "" Then
    sql = ""
    sql = "sp_leerciudad " & "'" & Trim(lblCodigo) & "'" ' & Trim(AuxCod) & "'"
    
    If MISQL.SQL_Execute(sql) <> 0 Then
         MsgBox "Proceso no se realizó con exito", vbCritical, "Bac-Trader"
         Exit Sub
    End If
    If MISQL.SQL_Fetch(datos()) = 0 Then
         If MsgBox("Esta Seguro de Eliminar este elemento", 36, "Eliminación de Registro") = 6 Then
                 If Elimina_SQLCiu Then
                     MsgBox "Eliminación se realizó con exito", vbInformation, "Bac-Parametros"
                 Else
                     MsgBox "Eliminación no se realizó con exito", vbInformation, "Bac-Parametros"
                 End If
         End If
   Else
         MsgBox "Los datos no han sido grabados", vbCritical, "Bac-Parametros"
   End If
Else
          MsgBox "No ha ingresado datos", vbCritical, "Bac-Parametros"
End If
End Sub

Function Elimina_SQLCiu() As Boolean
Dim sql As String

Elimina_SQLCiu = True
sql = ""
sql = "execute SP_eliminarciu "
sql = sql & Trim(lblCodigo.Caption) & ","
sql = sql & Val(AuxCod)

    If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox ("El registro no puedo ser eliminado")
        Elimina_SQLCiu = False
        Exit Function
    Else
         Call CargarCiudades
    End If
End Function
Sub Graba_Ciudad()
Grilla.Row = Grilla.RowSel
Grilla.Col = 0: AuxCod = Grilla.Text
Grilla.Col = 1: AuxNom = Grilla.Text
If AuxCod <> "" Or AuxNom <> "" Then
      If Grabar_SQLCIU() Then
           MsgBox " La grabación se realizó con exito", vbInformation, "Bac-Parametros"
      Else
            MsgBox " La grabación no se realizó con exito", vbCritical, "Bac-Parametros"
      End If
Else
    MsgBox "No ha ingesado datos", vbCritical, "Bac-Parametros"
    txtCodigoCiudad.SetFocus
End If
End Sub

Function Grabar_SQLCIU() As Boolean
Dim sql As String
Grabar_SQLCIU = True
   sql = ""
   sql = "execute sp_grabaciu "
   sql = sql & Trim(lblCodigo.Caption) & ","
'   SQL = SQL & Val(txtCodigoCiudad.Text) & ","
'   SQL = SQL & "'" & Trim(txtNombreCiudad.Text) & "'"
   sql = sql & "'" & Val(AuxCod) & "',"
   sql = sql & "'" & Trim(AuxNom) & "'"
   If MISQL.SQL_Execute(sql) <> 0 Then
      MsgBox ("Grabación no tuvo exito")
      Grabar_SQLCIU = False
      Exit Function
   End If
End Function

Private Sub cmdEliminar_Click()
 Elimina_Ciudad
 Limpiar_Ciu
End Sub

Private Sub CmdGrabar_Click()
    Graba_Ciudad
End Sub

Private Sub cmdlimpiar_Click()
Limpiar_Ciu
Call cargargrilla
End Sub

Private Sub Limpiar_Ciu()

lblCodigo.Caption = ""
txtCodigoCiudad = ""
txtNombreCiudad = ""

Limpia = False
cmbPais.Enabled = True

HabilitarControles1 False
txtCodigoCiudad.Enabled = False
cmbPais.SetFocus
txtCodigoCiudad.Text = ""
txtNombreCiudad.Text = ""
txtCodigoCiudad.Visible = False
txtNombreCiudad.Visible = False
End Sub

Private Sub cmdSalir_Click()
Unload Me
End Sub

Private Sub cmbPais_Click()
Dim sql As String

If cmbPais.Text <> "" Then

lblCodigo.Caption = ""

sql = "SELECT tbcodigo1,tbglosa FROM Tabla_General_Detalle WHERE tbglosa="
sql = sql & "'" & cmbPais.Text & "'  AND tbcateg =  " & MDTC_Pais
If MISQL.SQL_Execute(sql) <> 0 Then
  MsgBox "Proceso no se realizó con exito", vbCritical, "Bac-Parametros"
  Exit Sub
End If
Do While MISQL.SQL_Fetch(datos()) = 0
    lblCodigo.Caption = Val(datos(1))
Loop
HabilitarControles1 True
txtCodigoCiudad.Enabled = True
cmbPais.Enabled = False
End If
Call CargarCiudades
End Sub
Sub CargarCiudades()
With Grilla
   Dim sql As String
   Dim datos()
      sql = ""
      sql = "execute sp_leerciudad " 'arreglado
      sql = sql & Val(lblCodigo) '(cod_Pais)
      If MISQL.SQL_Execute(sql) <> 0 Then
          Exit Sub
      End If
      .Rows = 2
      .Row = 1
      Do While MISQL.SQL_Fetch(datos()) = 0
         .Col = 0: .Text = Val(datos(2)) 'tres
         .Col = 1: .Text = Trim(datos(1))
         .Rows = .Rows + 1
         .Row = .Row + 1
      Loop
      If .Rows <= 2 Then
         Exit Sub
      Else
         .Rows = .Rows - 1
         .Row = 1: .Col = 1
      End If
      
End With
End Sub
Sub Paises()
Dim sql As String
   If cmbPais.Text <> "" Then
      lblCodigo.Caption = ""
      sql = "SELECT tbcodigo1,tbglosa FROM Tabla_General_Detalle WHERE tbglosa="
      sql = sql & "'" & cmbPais.Text & "'  AND tbcateg =  " & MDTC_Pais
      If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox "Proceso no se realizó con exito", vbCritical, "Bac-Trader"
        Exit Sub
      End If
      Do While MISQL.SQL_Fetch(datos()) = 0
          lblCodigo.Caption = Val(datos(1))
      Loop
      HabilitarControles1 True
      txtCodigoCiudad.Enabled = True
      cmbPais.Enabled = False
   End If
End Sub

Private Sub HabilitarControles1(Valor As Boolean)
    txtCodigoCiudad.Enabled = Not Valor
    txtNombreCiudad.Enabled = Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
End Sub

Sub cargargrilla()
With Grilla
   .Clear
   .Rows = 2
   .Cols = 2
   .Row = 0
   .Col = 0: .Text = "Codigo Ciudad": .CellAlignment = 4
   .Col = 1: .Text = "Nombre Ciudad": .CellAlignment = 4
   .ColWidth(0) = 2000
   .ColWidth(1) = 3400
End With
End Sub
Private Sub Form_Load()
Call cargargrilla
Dim Hay As Integer
On Error GoTo Eti1
    sw = False
    Hay = 0
    Limpia = True
    HabilitarControles1 False
    txtCodigoCiudad.Enabled = False
    'Llena combo paises el código de la categoría pais es el 180
    '-----------------------------------------------------------------------
    sql = "sp_leepa " & MDTC_Pais
     
    If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox "Problemas en procedimiento almacenado", vbCritical, gsBac_Version
        Exit Sub
    End If

    Do While MISQL.SQL_Fetch(datos()) = 0
       Hay = 1
        cmbPais.AddItem datos(6)
    Loop
    If Hay = 0 Then
        
        Unload Me
        Exit Sub
    End If
    
Exit Sub
Eti1:
  MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
  Unload Me
  Exit Sub
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next
With Grilla
   Select Case KeyCode
   Case vbKeyInsert
            If KeyCode = vbKeyInsert Then
            .Row = .Rows - 1
            If .Text <> "" Then
               .Rows = .Rows + 1
               .Row = .Rows - 1
            End If
               .Col = 0
               .Col = 0: Call PROC_POSI_TEXTO(Grilla, txtCodigoCiudad)
               '.Col = 1: Call PROC_POSI_TEXTO(Grilla, txtNombreCiudad)
               If .Col = 0 Then
                  txtNombreCiudad.Visible = False
                  txtCodigoCiudad.Text = ""
                  txtCodigoCiudad.Visible = True
                  txtCodigoCiudad.SetFocus
               Else
                  txtNombreCiudad.Visible = True
                  txtCodigoCiudad.Visible = False
                  txtNombreCiudad.SetFocus
               End If
            End If
   Case vbKeyDelete
            .Row = .Rows - 1
            .Col = 0
            If .Text = "" Then
               .Rows = .Rows - 1
            End If
   End Select
End With
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
With Grilla
   Select Case KeyAscii
      Case 13
         If .Col = 0 Then
            If .Text <> "" Then
               Exit Sub
            Else
               Call PROC_POSI_TEXTO(Grilla, txtCodigoCiudad)
               txtCodigoCiudad.Visible = True
               txtCodigoCiudad.Enabled = True
               txtCodigoCiudad.SetFocus
            End If
         Else
            .Col = .ColSel
            .Row = .RowSel
            Call PROC_POSI_TEXTO(Grilla, txtNombreCiudad)
            txtNombreCiudad.Visible = True
            txtNombreCiudad.Text = .Text
            txtNombreCiudad.SetFocus
         End If
      Case 27
         .Col = 0: .Row = .Rows - 1
         If .Text = "" Then
            .Rows = .Rows - 1
            .Row = .Rows - 1
         End If
         txtCodigoCiudad.Visible = False
         txtNombreCiudad.Visible = False
   End Select
End With
'
'With Grilla
'   If KeyAscii = 13 Then
'      If .RowSel = 0 Then Exit Sub
'      .Row = .RowSel
'      .Col = 0
'      If .Text = "" Then
'      .Col = 0: Call PROC_POSI_TEXTO(Grilla, txtCodigoCiudad)
'      Else
'      .Col = 1
'      .Col = 1: Call PROC_POSI_TEXTO(Grilla, txtNombreCiudad)
'      End If
'      If .Col = 0 Then
'         txtNombreCiudad.Visible = False
'         txtCodigoCiudad.Visible = True
'         txtCodigoCiudad.SetFocus
'      Else
'         txtNombreCiudad.Visible = True
'         txtCodigoCiudad.Visible = False
'         txtNombreCiudad.SetFocus
'      End If
'   ElseIf KeyAscii = 27 Then
'         .Row = .RowSel
'         .Col = 0
'         If .Text = "" Then .Rows = .Rows - 1: .Row = .Rows - 1
'   End If
'End With
End Sub


Private Sub Grilla_Scroll()
If txtCodigoCiudad.Text = "" Then
   txtCodigoCiudad.Visible = False
   txtNombreCiudad.Visible = False
End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
      Graba_Ciudad
   Case 2
      Elimina_Ciudad
      Limpiar_Ciu
      Call cargargrilla
   Case 3
      Limpiar_Ciu
      Call cargargrilla
   Case 4
      Unload Me
End Select
End Sub

Private Sub txtCodigoCiudad_DblClick()
'Llama la ayuda
'=========================================
'   BacControlWindows 100
'   BacAyuda.Tag = "MDCIUCIU"
'   BacAyuda.Show 1
'   If giAceptar% = True Then
'      txtCodigoCiudad.Text = BacAyuda.Codigo
'      txtNombreCiudad.Text = BacAyuda.Glosa
'      SendKeys "{Tab}"
'   End If
End Sub

Private Sub txtCodigoCiudad_KeyDown(KeyCode As Integer, Shift As Integer)
'If KeyCode = vbKeyF3 Then Call txtCodigoCiudad_DblClick
End Sub


Private Sub txtCodigoCiudad_KeyPress(KeyAscii As Integer)
 If KeyAscii >= 47 And KeyAscii <= 57 Or KeyAscii = 8 Or KeyAscii = 13 Or KeyAscii = 27 Then
   With Grilla
      Select Case KeyAscii
         Case 13
           If txtCodigoCiudad.Text <> "" Then
               .Text = txtCodigoCiudad.Text
               AuxCod = txtCodigoCiudad.Text
               'txtCodigoCiudad.Text = ""
               txtCodigoCiudad.Visible = False
               .SetFocus: .Col = 1
               txtNombreCiudad.Visible = True
               Call PROC_POSI_TEXTO(Grilla, txtNombreCiudad)
               txtNombreCiudad.SetFocus
            Else
               .Row = .Rows - 1
               .Rows = .Rows - 1
               txtNombreCiudad.SetFocus
           End If
         Case 27
            .Col = 0
            If .Text = "" Then
               .Rows = .Rows - 1
               .Row = .Rows - 1
               'txtCodigoCiudad.Text = ""
               txtCodigoCiudad.Visible = False
               'txtNombreCiudad.Text = ""
               txtNombreCiudad.Visible = False
            End If
      End Select
   End With
Else
KeyAscii = 0
End If
   
End Sub

Private Sub txtCodigoCiudad_LostFocus()
Dim sql As String
With Grilla

If txtCodigoCiudad.Text <> "" Then
    .Row = .RowSel
    .Col = 0
    .Text = txtCodigoCiudad.Text
    AuxCod = txtCodigoCiudad.Text
    txtCodigoCiudad.Visible = False
    sql = ""
    sql = "SP_leerciudad " & Trim(lblCodigo)
    ''''    "''' '," & Trim(txtCodigoCiudad.Text)
    
    If MISQL.SQL_Execute(sql) <> 0 Then
         MsgBox "Proceso no se realizó con exito", vbCritical, "Bac-Trader"
         Exit Sub
    End If

    
    If MISQL.SQL_Fetch(datos()) = 0 Then
        txtCodigoCiudad.Text = Val(datos(2))
        txtNombreCiudad.Text = Trim(datos(1))

        HabilitarControles1 True
    Else
        txtNombreCiudad = ""
        HabilitarControles1 True
    End If
    txtNombreCiudad.Visible = True
    .Col = 1: .Row = .RowSel
    Call PROC_POSI_TEXTO(Grilla, txtNombreCiudad)
    txtNombreCiudad.SetFocus
Else
   .Rows = .Rows - 1
   txtCodigoCiudad.Visible = False
   txtNombreCiudad.Visible = False
End If
End With
End Sub


Private Sub txtCodigoCiudad_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
txtCodigoCiudad.MousePointer = 0
'txtCodigoCiudad.MouseIcon =

End Sub

Private Sub txtNombreCiudad_GotFocus()
With Grilla
   .Row = .RowSel: .Col = .ColSel
   txtNombreCiudad.Text = .Text
End With
End Sub

Private Sub txtNombreCiudad_KeyPress(KeyAscii As Integer)
   If KeyAscii = 27 Then
      'Grilla.Rows = Grilla.Rows - 1
      'Grilla.Row = Grilla.Rows - 1
      txtCodigoCiudad.Visible = False
      txtNombreCiudad.Visible = False
      Grilla.SetFocus
      Exit Sub
   End If
   If KeyAscii = 13 Then
      KeyAscii% = 0
      If Trim(txtNombreCiudad.Text) = "" Then
         MsgBox "debe ingresar datos", 16, "Bac-Trader"
         txtCodigoCiudad.Visible = True
         txtNombreCiudad.Visible = False
         txtCodigoCiudad.Enabled = True
         txtCodigoCiudad.SetFocus
      End If
      Grilla.Text = Trim(txtNombreCiudad.Text)
      txtNombreCiudad.Text = ""
      txtNombreCiudad.Visible = False
      If Grilla.Row >= Grilla.Rows - 1 Then
         Grilla.Row = Grilla.Rows - 1
      Else
         Grilla.Row = Grilla.Row + 1
      End If
      Grilla.SetFocus
   Else
      BacToUCase KeyAscii
   End If
End Sub

Private Sub txtNombreCiudad_LostFocus()
With Grilla
   If txtNombreCiudad.Text <> "" Then
       .Row = .RowSel
       .Col = 1:
       .Text = txtNombreCiudad.Text
       AuxNom = txtNombreCiudad.Text
       txtNombreCiudad.Visible = False
   Else
       txtNombreCiudad.Visible = False
   End If
End With
End Sub
