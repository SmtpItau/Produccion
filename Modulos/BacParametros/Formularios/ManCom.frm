VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form ManCom 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Comuna"
   ClientHeight    =   4920
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7005
   Icon            =   "ManCom.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4920
   ScaleWidth      =   7005
   Begin Threed.SSPanel SSPanel1 
      Height          =   4440
      Left            =   -30
      TabIndex        =   1
      Top             =   480
      Width           =   7035
      _Version        =   65536
      _ExtentX        =   12409
      _ExtentY        =   7832
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
      Begin VB.TextBox txtIngreso 
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
         Left            =   1545
         TabIndex        =   6
         Top             =   1425
         Visible         =   0   'False
         Width           =   1125
      End
      Begin VB.ComboBox cmbCiudad 
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
         Left            =   825
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   120
         Width           =   3030
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   3690
         Left            =   135
         TabIndex        =   7
         Top             =   600
         Width           =   6705
         _ExtentX        =   11827
         _ExtentY        =   6509
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483645
         FocusRect       =   2
         HighLight       =   2
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
         Left            =   135
         TabIndex        =   5
         Top             =   195
         Width           =   600
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
         Left            =   5160
         TabIndex        =   4
         Top             =   210
         Width           =   600
      End
      Begin VB.Label lblCodCom 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
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
         Height          =   300
         Left            =   5880
         TabIndex        =   3
         Top             =   165
         Width           =   945
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6480
      Top             =   15
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
            Picture         =   "ManCom.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ManCom.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ManCom.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ManCom.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7005
      _ExtentX        =   12356
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
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
End
Attribute VB_Name = "ManCom"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim auxcod
Dim auxnom
Dim grabo
Function Elimina_SQLCom() As Boolean
Dim Sql As String
   Elimina_SQLCom = True
   
   Envia = Array()
   AddParam Envia, Trim(lblCodCom.Tag)
   AddParam Envia, Trim(lblCodCom.Caption)
   AddParam Envia, CDbl(auxcod)
               
    If Not Bac_Sql_Execute("sp_eliminarcom", Envia) Then
        MsgBox "El registro no puedo ser eliminado", vbCritical, TITSISTEMA
        Elimina_SQLCom = False
        Exit Function
    Else
        auxcod = 0
        auxnom = ""
         Call NombresGrilla
         Call CargarComunas
    End If
End Function

Sub cargargrilla()
With Table1
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

Sub Elimina_Comuna()
Table1.Row = Table1.RowSel
Table1.Col = 0: auxcod = Table1.Text
Table1.Col = 1: auxnom = Table1.Text

If auxcod <> "" Or auxnom <> "" Then
    
    'Sql = "sp_leerciudad " & "'" & Trim(lblCodigo) & "'" ' & Trim(AuxCod) & "'"
    Envia = Array()
    AddParam Envia, lblCodCom.Tag
    AddParam Envia, Trim(lblCodCom.Caption)
    AddParam Envia, Trim(auxcod)
    
    If Not Bac_Sql_Execute("leercomuna", Envia) Then
         MsgBox "Proceso no se realizó con exito", vbCritical, TITSISTEMA
         Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
         If MsgBox("Esta Seguro de Eliminar este elemento", 36, TITSISTEMA) = 6 Then
                 If Elimina_SQLCom Then
                     MsgBox "Eliminación se realizó con exito", vbInformation, TITSISTEMA
                 Else
                     MsgBox "Eliminación no se realizó con exito", vbInformation, TITSISTEMA
                 End If
         End If
   Else
         MsgBox "Los datos no han sido grabados", vbCritical, TITSISTEMA
   End If
Else
          MsgBox "No ha ingresado datos", vbCritical, TITSISTEMA
End If
End Sub
Function Grabar_SQLCIU() As Boolean
Grabar_SQLCIU = True
   
   Envia = Array()
   AddParam Envia, Trim(lblCodCom.Tag)
   AddParam Envia, Trim(lblCodCom.Caption)
   AddParam Envia, CDbl(auxcod)
   AddParam Envia, Trim(auxnom)
                 
   If Not Bac_Sql_Execute("grabacom", Envia) Then
      MsgBox "Grabación no tuvo exito", vbCritical, TITSISTEMA
      Grabar_SQLCIU = False
      Exit Function
   End If
End Function

Private Sub Limpiar_Comuna()
   lblCodCom.Tag = ""
   lblCodCom.Caption = ""
   txtIngreso = ""
   Limpia = False
   CmbCiudad.Enabled = True
   HabilitarControles1 False
   CmbCiudad.SetFocus
   txtIngreso.Visible = False
End Sub

Sub Graba_Comuna()
Table1.Row = Table1.RowSel
Table1.Col = 0: auxcod = Table1.Text
Table1.Col = 1: auxnom = Table1.Text
If auxcod <> "" Or auxnom <> "" Then
      If Grabar_SQLCIU() Then
           grabo = 5000
      Else
           grabo = 1
           MsgBox " La grabación no se realizó con exito", vbCritical, TITSISTEMA
      End If
Else
    MsgBox "No ha ingesado datos", vbCritical, TITSISTEMA
    
    txtIngreso.SetFocus
End If
End Sub

Public Function PVerCodigo()
   Dim Fila       As Long
   Dim imax       As Long
   Dim Sql        As String

   imax = Table1.Rows - 1
   With Table1
      .Col = 0
      For Fila = 1 To imax
          .Row = Fila
          If txtIngreso.Text = .Text Then
             MsgBox "Codigo " & .Text & " ya existe en tabla", vbCritical, TITSISTEMA
             .Row = Table1.Rows - 1
             .Text = ""
             txtIngreso.Text = ""
             txtIngreso.SetFocus
             Exit Function
          End If
      Next Fila
   End With

End Function

Sub CargarComunas()
On Error GoTo ErrorF:

With Table1
   Dim Sql As String
   Dim Datos()
   cod_Ciudad = lblCodCom.Caption
   cod_Pais = lblCodCom.Tag
   
   Envia = Array()
   AddParam Envia, CDbl(cod_Pais)
   AddParam Envia, CDbl(cod_Ciudad)
               
      If Not Bac_Sql_Execute("sp_leercom", Envia) Then
          Exit Sub
      End If
      .Rows = 2
      .Row = 1
      Do While Bac_SQL_Fetch(Datos())
         .Col = 0: .Text = CDbl(Datos(1))
         .Col = 1: .Text = Trim(Datos(2))
         .Rows = .Rows + 1
         .Row = .Row + 1
         txtIngreso.Visible = False
      Loop
      If .Rows <= 2 Then
         Exit Sub
      Else
         .Rows = .Rows - 1
         .Row = 1: .Col = 1
      End If
End With

ErrorF:
End Sub

Private Sub HabilitarControles1(Valor As Boolean)
    txtIngreso.Enabled = Not Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
End Sub

Sub NombresGrilla()
With Table1
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

Private Sub CmbCiudad_Click()
If CmbCiudad.Text <> "" Then
   lblCodCom.Caption = ""
   lblCodCom.Caption = CmbCiudad.ItemData(CmbCiudad.ListIndex)
   lblCodCom.Tag = Trim(Right(CmbCiudad.Text, 5))
   lblCodCom.Tag = Trim(Mid(CmbCiudad.Text, Len(CmbCiudad) - 25, 26))
   HabilitarControles1 True
   txtIngreso.Enabled = True
   
End If
Call CargarComunas
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
Dim Hay As Integer
Dim Conta As Long
Dim Stringx As String
Dim blanco As String
Call NombresGrilla
On Error GoTo Eti1
    Sw = False
    Hay = 0
    Limpia = True
    'Llena combo paises el código de la categoría pais es el 180
    '-----------------------------------------------------------------------
     
    
    
    
     
    If Not Bac_Sql_Execute("sp_leerciu") Then
        MsgBox "Problemas en procedimiento almacenado", vbCritical, TITSISTEMA
        Exit Sub
    End If

    '==========================Adrian==================================
    CmbCiudad.Clear
    Do While Bac_SQL_Fetch(Datos())
       Hay = 1
       Stringx = Datos(1)
       Stringx = Stringx & Space(80): Stringx = Stringx & Datos(3)
       Stringx = Stringx & Space(80): Stringx = Stringx & CDbl(Datos(4))
       CmbCiudad.AddItem Stringx
       CmbCiudad.ItemData(CmbCiudad.NewIndex) = CDbl(Datos(2))
    Loop
    If Hay = 0 Then
        Unload Me
    End If
Exit Sub
Eti1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   Unload Me
   Exit Sub

End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim bOk        As Boolean
   Dim nOk        As Integer

   Select Case KeyCode
   Case vbKeyInsert
      Table1.Rows = Table1.Rows + 1
      Table1.Row = Table1.Rows - 1
      Table1.Refresh

   Case vbKeyDelete

      'Validar que no se encuentre enlazado con algUn perfÝl.
      If Table1.Rows > 2 Then
         Table1.RemoveItem Table1.Row

      Else
         Table1.Rows = 1
         Table1.Rows = 2

      End If

   End Select
End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)
 If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
       KeyAscii = 0
   End If
      
      txtIngreso.Text = ""
      
      PROC_POSICIONA_TEXTO Table1, txtIngreso
      
      txtIngreso.Visible = True
      txtIngreso.Text = UCase(Chr(KeyAscii))
      txtIngreso.SetFocus
      
      SendKeys "{END}"
   If KeyAscii = 13 Then
    txtIngreso.Text = ""
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim coun
Dim fo
Select Case Button.Index
   Case 1
   If Trim(lblCodCom.Tag) <> "" And Trim(lblCodCom.Caption) <> "" Then
    coun = Table1.Rows
    For fo = 1 To coun - 1
        Table1.Row = fo
        Graba_Comuna
    Next fo
   Else
         MsgBox " Debe Ingresar Todos los datos", vbInformation, TITSISTEMA
         Exit Sub
   End If
    If grabo = 5000 Then
        MsgBox " La grabación se realizó con exito", vbInformation, TITSISTEMA
    End If
   Case 2
      Elimina_Comuna
      Limpiar_Comuna
      cargargrilla
   Case 3
      Limpiar_Comuna
      cargargrilla
   Case 4
      Unload Me
End Select
End Sub


Private Sub txtIngreso_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then

   txtIngreso.Visible = False
   Table1.SetFocus
   
End If

    If Table1.Col = 0 Then
        KeyAscii = BacPunto(txtIngreso, KeyAscii, 5, 0)
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
    
If KeyAscii = 13 Then

    If Trim(txtIngreso.Text) = "" Then Exit Sub
    If Table1.Col = 0 Then
       Call PVerCodigo
    End If
     
    Table1.Text = txtIngreso.Text
    txtIngreso.Visible = False
    Table1.SetFocus

End If
End Sub
