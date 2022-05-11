VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacMNTComuna 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención Comunas"
   ClientHeight    =   4170
   ClientLeft      =   2610
   ClientTop       =   3105
   ClientWidth     =   6045
   Icon            =   "BACMNCOM.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4170
   ScaleWidth      =   6045
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4320
      Top             =   90
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
            Picture         =   "BACMNCOM.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACMNCOM.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACMNCOM.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACMNCOM.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   6045
      _ExtentX        =   10663
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
   Begin Threed.SSPanel SSPanel1 
      Height          =   3615
      Left            =   0
      TabIndex        =   2
      Top             =   540
      Width           =   6045
      _Version        =   65536
      _ExtentX        =   10663
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
      Begin VB.ComboBox cmbCiudad 
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
         Left            =   1020
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   90
         Width           =   3030
      End
      Begin VB.TextBox txtCodigoComuna 
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
         MaxLength       =   5
         MouseIcon       =   "BACMNCOM.frx":11E2
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   1140
         Visible         =   0   'False
         Width           =   810
      End
      Begin VB.TextBox txtNombreComuna 
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
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   1155
         Visible         =   0   'False
         Width           =   795
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   3000
         Left            =   90
         TabIndex        =   6
         Top             =   555
         Width           =   5865
         _ExtentX        =   10345
         _ExtentY        =   5292
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
      Begin VB.Label lblCodCom 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Height          =   300
         Left            =   4875
         TabIndex        =   10
         Top             =   120
         Visible         =   0   'False
         Width           =   945
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
         Left            =   4200
         TabIndex        =   8
         Top             =   135
         Width           =   600
      End
      Begin VB.Label lblPais 
         AutoSize        =   -1  'True
         Caption         =   "Ciudad"
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
         Left            =   240
         TabIndex        =   7
         Top             =   180
         Width           =   600
      End
   End
   Begin VB.Label lblCodigoCiudad 
      AutoSize        =   -1  'True
      Caption         =   "Código Comuna"
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
      Left            =   135
      TabIndex        =   0
      Top             =   4155
      Width           =   1335
   End
   Begin VB.Label lblNombreCiudad 
      AutoSize        =   -1  'True
      Caption         =   "Nombre Comuna"
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
      Left            =   165
      TabIndex        =   1
      Top             =   4500
      Width           =   1395
   End
End
Attribute VB_Name = "BacMNTComuna"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql As String
Dim Datos()
Dim AuxCodigo As Integer
Dim AuxNombre As String

Private Sub cmbciudad_Click()
If cmbCiudad.Text <> "" Then
   lblCodigo.Caption = ""
   lblCodigo.Caption = cmbCiudad.ItemData(cmbCiudad.ListIndex)
   lblCodigo.Tag = Trim(Right(cmbCiudad.Text, 5))
   lblCodigo.Tag = Trim(Mid(cmbCiudad.Text, Len(cmbCiudad) - 25, 26))
   HabilitarControles1 True
   txtCodigoComuna.Enabled = True
   cmbCiudad.Enabled = False
End If
Call CargarComunas
End Sub
Sub CargarComunas()
With grilla
   Dim Sql As String
   Dim Datos()
   cod_Ciudad = lblCodigo.Caption
   cod_Pais = lblCodigo.Tag
   Sql = ""
   Sql = "execute sp_leercom "
   Sql = Sql & Val(cod_Pais) & "," & Val(cod_Ciudad)
      If MISQL.SQL_Execute(Sql) <> 0 Then
          Exit Sub
      End If
      .Rows = 2
      .Row = 1
      Do While MISQL.SQL_Fetch(Datos()) = 0
         .Col = 0: .Text = Val(Datos(1))
         .Col = 1: .Text = Trim(Datos(2))
         .Rows = .Rows + 1
         .Row = .Row + 1
         txtCodigoComuna.Visible = False
         txtNombreComuna.Visible = False
      Loop
      If .Rows <= 2 Then
         Exit Sub
      Else
         .Rows = .Rows - 1
         .Row = 1: .Col = 1
      End If
End With
End Sub
Private Sub cmdEliminar_Click()
If AuxCodigo <> Null Or AuxNombre <> "" Then
    Sql = ""
    Sql = "leercomuna " & lblCodigo.Tag & "," & Trim(lblCodigo.Caption) & "," & Trim(AuxCodigo)
   If MISQL.SQL_Execute(Sql) <> 0 Then
      MsgBox "Proceso no se realizó con exito", vbCritical, gsBac_Version
      Exit Sub
   End If
   If MISQL.SQL_Fetch(Datos()) = 0 Then
      If MsgBox("Esta Seguro de Eliminar este elemento", 36, "Eliminación de Registro") = 6 Then
         If Elimina_SQLCom Then
             MsgBox "Eliminación se realizó con exito", vbInformation, "Bac_trader"
         Else
              MsgBox "Eliminación no se realizó con exito", vbInformation, "Bac_trader"
         End If
      End If
   Else
         MsgBox "Los datos no han sido grabados", vbCritical, "Bac_Trader"
   End If
Else
      MsgBox "No ha ingresado datos", vbCritical, "Bac_Trader"
End If
End Sub

Function Elimina_SQLCom() As Boolean
Dim Sql As String
   Elimina_SQLCom = True
   Sql = ""
   Sql = "execute sp_eliminarcom "
   Sql = Sql & Trim(lblCodigo.Tag) & ","
   Sql = Sql & Trim(lblCodigo.Caption) & ","
   Sql = Sql & Val(AuxCodigo)
    If MISQL.SQL_Execute(Sql) <> 0 Then
        MsgBox ("El registro no puedo ser eliminado")
        Elimina_SQLCom = False
        Exit Function
    Else
        AuxCodigo = 0
        AuxNombre = ""
         Call NombresGrilla
         Call CargarComunas
    End If
End Function
Private Sub CmdGrabar_Click()
With grilla
         .Row = .RowSel
         .Col = 0: AuxCodigo = .Text
         .Col = 1: AuxNombre = .Text
      If AuxCodigo <> Null Or AuxNombre <> "" Then
            If Grabar_SQLCom() Then
                 MsgBox " La grabación se realizó con exito", vbInformation, "Bac_Trade"
            Else
                 MsgBox " La grabación no se realizó con exito", vbCritical, "Bac_Trader"
            End If
      Else
          MsgBox "No ha ingesado datos", vbCritical, "Bac_trader"
      End If
End With
End Sub

Function Grabar_SQLCom() As Boolean
Dim Sql As String
Grabar_SQLCom = True
   Sql = ""
   Sql = "execute grabacom "
   Sql = Sql & Trim(lblCodigo.Tag) & ","
   Sql = Sql & Trim(lblCodigo.Caption) & ","
   Sql = Sql & Trim(Val(AuxCodigo)) & ","
   Sql = Sql & "'" & Trim(AuxNombre) & "'"
   If MISQL.SQL_Execute(Sql) <> 0 Then
      MsgBox ("Grabación no tuvo exito")
      Grabar_SQLCom = False
      Exit Function
   End If
End Function
Function Buscar_Fox(nCategoria As String, nTabla As String, nTasa As Double, nFecha As Date) As Boolean
Dim Buscar As String
   DataFox.Recordset.Index = "MBTABLAS"
   DataFox.Recordset.Seek "=", nCategoria, Trim(nTabla), nTasa, nFecha
If DataFox.Recordset.NoMatch Then
   Buscar_Fox = False
Else
   Buscar_Fox = True
End If
End Function
'Sub Mover_FoxCom()
'    DataFox.Recordset.Fields!tbcateg = MDTC_COMUNAS
'    DataFox.Recordset.Fields!tbcodigo1 = Trim(txtCodigoComuna.Text)
'    DataFox.Recordset.Fields!tbtasa = 0
'    DataFox.Recordset.Fields!tbfecha = CDate("01/01/1900")
'    DataFox.Recordset.Fields!tbvalor = 0
'    DataFox.Recordset.Fields!tbglosa = Trim(txtNombreComuna.Text)
'    DataFox.Recordset.Fields!Nemo = " "
'End Sub
Private Sub cmdlimpiar_Click()
   Limpiar_Com
   Call NombresGrilla
End Sub
Private Sub cmdSalir_Click()
    Unload Me
End Sub
Private Sub Limpiar_Com()
   lblCodigo.Tag = ""
   lblCodigo.Caption = ""
   txtCodigoComuna = ""
   txtNombreComuna = ""
   Limpia = False
   cmbCiudad.Enabled = True
   HabilitarControles1 False
   txtCodigoComuna.Enabled = False
   cmbCiudad.SetFocus
   txtCodigoComuna.Visible = False
   txtNombreComuna.Visible = False
End Sub
Sub NombresGrilla()
With grilla
   .Clear
   .Rows = 2
   .Cols = 2
   .Row = 0
   .Col = 0: .Text = "Codigo Comuna": .CellAlignment = 4
   .Col = 1: .Text = "Nombre Comuna": .CellAlignment = 4
   .ColWidth(0) = 2000
   .ColWidth(1) = 3400
End With
End Sub
Private Sub Form_Load()
Dim Hay As Integer
Dim Conta As Long
Dim Stringx As String
Dim blanco As String
Call NombresGrilla
On Error GoTo Eti1
    sw = False
    Hay = 0
    Limpia = True
    'Llena combo paises el código de la categoría pais es el 180
    '-----------------------------------------------------------------------
     
    Sql = "sp_leerciu "
    
    
     
    If MISQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Problemas en procedimiento almacenado", vbCritical, gsBac_Version
        Exit Sub
    End If

    '==========================Adrian==================================
    cmbCiudad.Clear
    Do While MISQL.SQL_Fetch(Datos()) = 0
       Hay = 1
       Stringx = Datos(1)
       Stringx = Stringx & Space(25): Stringx = Stringx & Datos(3)
       Stringx = Stringx & Space(25): Stringx = Stringx & Val(Datos(4))
       cmbCiudad.AddItem Stringx
       cmbCiudad.ItemData(cmbCiudad.NewIndex) = Val(Datos(2))
    Loop
    If Hay = 0 Then
        Unload Me
    End If
Exit Sub
Eti1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
   Unload Me
   Exit Sub
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
With grilla
   Select Case KeyCode
      Case vbKeyInsert
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 0
         txtCodigoComuna.Visible = True
         Call PROC_POSI_TEXTO(grilla, txtCodigoComuna)
         txtCodigoComuna.SetFocus
      Case vbKeyDelete
         .Row = .RowSel
         .Col = 0
         If .Text = "" Then
            .Rows = .Rows - 1
            .Row = .Rows - 1
         End If
   End Select
End With
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
With grilla
   Select Case KeyAscii
      Case 13
         If .Col = 0 Then
            If .Text <> "" Then
               Exit Sub
            Else
               Call PROC_POSI_TEXTO(grilla, txtCodigoComuna)
               txtCodigoComuna.Visible = True
               txtCodigoComuna.SetFocus
            End If
         Else
            .Col = .ColSel
            .Row = .RowSel
            Call PROC_POSI_TEXTO(grilla, txtNombreComuna)
            txtNombreComuna.Visible = True
            txtNombreComuna.Text = .Text
            txtNombreComuna.SetFocus
         End If
      Case 27
         .Col = 0: .Row = .Rows - 1
         If .Text = "" Then
            .Rows = .Rows - 1
            .Row = .Rows - 1
         End If
         txtCodigoComuna.Visible = False
         txtNombreComuna.Visible = False
   End Select
End With
End Sub

Private Sub Grilla_LostFocus()
With grilla
   .Row = .RowSel
   .Col = 0: If .Text <> Null Then AuxCodigo = .Text
   .Row = .RowSel
   .Col = 1: If .Text <> "" Then AuxNombre = .Text
End With
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
         With grilla
                  .Row = .RowSel
                  .Col = 0: AuxCodigo = .Text
                  .Col = 1: AuxNombre = .Text
               If AuxCodigo <> Null Or AuxNombre <> "" Then
                     If Grabar_SQLCom() Then
                          MsgBox " La grabación se realizó con exito", vbInformation, "Bac_Trade"
                     Else
                          MsgBox " La grabación no se realizó con exito", vbCritical, "Bac_Trader"
                     End If
               Else
                   MsgBox "No ha ingesado datos", vbCritical, "Bac_trader"
               End If
         End With
   Case 2
         If AuxCodigo <> Null Or AuxNombre <> "" Then
    Sql = ""
    Sql = "leercomuna " & lblCodigo.Tag & "," & Trim(lblCodigo.Caption) & "," & Trim(AuxCodigo)
   If MISQL.SQL_Execute(Sql) <> 0 Then
      MsgBox "Proceso no se realizó con exito", vbCritical, gsBac_Version
      Exit Sub
   End If
   If MISQL.SQL_Fetch(Datos()) = 0 Then
      If MsgBox("Esta Seguro de Eliminar este elemento", 36, "Eliminación de Registro") = 6 Then
         If Elimina_SQLCom Then
             MsgBox "Eliminación se realizó con exito", vbInformation, "Bac_trader"
         Else
              MsgBox "Eliminación no se realizó con exito", vbInformation, "Bac_trader"
         End If
      End If
   Else
         MsgBox "Los datos no han sido grabados", vbCritical, "Bac_Trader"
   End If
Else
      MsgBox "No ha ingresado datos", vbCritical, "Bac_Trader"
End If

   Case 3
            Limpiar_Com
   Call NombresGrilla

   Case 4
      Unload Me
End Select
End Sub

Private Sub txtCodigoComuna_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF3 Then
   'Call txtCodigoComuna_DblClick
End If
End Sub

Private Sub txtCodigoComuna_KeyPress(KeyAscii As Integer)
If KeyAscii >= 47 And KeyAscii <= 57 Or KeyAscii = 8 Or KeyAscii = 13 Or KeyAscii = 27 Then
   With grilla
      Select Case KeyAscii
         Case 13
           If txtCodigoComuna.Text <> "" Then
               .SetFocus
               .Col = 0: .Text = txtCodigoComuna.Text
               AuxCodigo = txtCodigoComuna.Text
               txtCodigoComuna.Text = ""
               txtCodigoComuna.Visible = False
               .Col = 1
               txtNombreComuna.Visible = True
               Call PROC_POSI_TEXTO(grilla, txtNombreComuna)
               txtNombreComuna.SetFocus
            Else
               .Row = .Rows - 1
               .Rows = .Rows - 1
           End If
         Case 27
            .Col = 0
            If .Text = "" Then
               .Rows = .Rows - 1
               .Row = .Rows - 1
               txtCodigoComuna.Text = ""
               txtCodigoComuna.Visible = False
               txtNombreComuna.Text = ""
               txtNombreComuna.Visible = False
            End If
      End Select
   End With
Else
KeyAscii = 0
End If
End Sub


Private Sub txtCodigoComuna_LostFocus()
Dim Sql As String
With grilla
If txtCodigoComuna.Text <> "" Then
      .Row = .RowSel
      .Col = 0
      .Text = txtCodigoComuna.Text
      AuxCodigo = txtCodigoComuna.Text
      txtCodigoComuna.Visible = False
    Sql = ""
    Sql = "SP_leercomuna " & lblCodigo.Tag & "," & Trim(lblCodigo.Caption) & "," & Trim(txtCodigoComuna.Text)
    If MISQL.SQL_Execute(Sql) <> 0 Then
         MsgBox "Proceso no se realizó con exito", vbCritical, gsBac_Version
         Exit Sub
    End If
    If MISQL.SQL_Fetch(Datos()) = 0 Then
        txtCodigoComuna.Text = Val(Datos(1))
        txtNombreComuna.Text = Trim(Datos(2))
        HabilitarControles1 True
    Else
        txtNombreComuna.Text = ""
        HabilitarControles1 True
    End If
    txtNombreComuna.Visible = True
    .Col = 1: .Row = .RowSel
    Call PROC_POSI_TEXTO(grilla, txtNombreComuna)
    txtNombreComuna.SetFocus
Else
   txtCodigoComuna.Visible = False
   txtNombreComuna.Visible = True
   txtNombreComuna.SetFocus
End If
End With
End Sub

Private Sub HabilitarControles1(Valor As Boolean)
    txtCodigoComuna.Enabled = Not Valor
    txtNombreComuna.Enabled = Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
End Sub
Private Sub txtNombreComuna_KeyPress(KeyAscii As Integer)
With grilla
   BacToUCase KeyAscii
   Select Case KeyAscii
      Case 13
         If txtNombreComuna.Text <> "" Then
            .SetFocus
            .Col = 1: .Text = txtNombreComuna.Text
            AuxNombre = txtNombreComuna.Text
            txtNombreComuna.Text = ""
            txtNombreComuna.Visible = False
         Else
            .Row = .Rows - 1
            .Rows = .Rows - 1
        End If
      Case 27
         .Col = 0
         If .Text = "" Then
            .Rows = .Rows - 1
            .Row = .Rows - 1
            txtCodigoComuna.Text = ""
            txtCodigoComuna.Visible = False
            txtNombreComuna.Text = ""
            txtNombreComuna.Visible = False
         End If
   End Select
End With
End Sub

Private Sub txtNombreComuna_LostFocus()
With grilla
   If txtNombreComuna.Text <> "" Then
      .Row = .RowSel
      .Col = 1
      .Text = txtNombreComuna.Text
      AuxNombre = txtNombreComuna.Text
      txtNombreComuna.Visible = False
   Else
      txtNombreComuna.Visible = False
   End If
End With
End Sub
