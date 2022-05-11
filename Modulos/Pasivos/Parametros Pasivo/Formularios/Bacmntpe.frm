VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntPe 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Periodos"
   ClientHeight    =   4425
   ClientLeft      =   3855
   ClientTop       =   2205
   ClientWidth     =   5295
   Icon            =   "Bacmntpe.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4425
   ScaleWidth      =   5295
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   660
      Top             =   2415
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpe.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntpe.frx":11E4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame Frame 
      Height          =   3870
      Index           =   0
      Left            =   45
      TabIndex        =   0
      Top             =   540
      Width           =   5220
      _Version        =   65536
      _ExtentX        =   9208
      _ExtentY        =   6826
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
      Begin VB.TextBox txtIngreso 
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
         Height          =   285
         Left            =   1950
         TabIndex        =   6
         Top             =   2100
         Visible         =   0   'False
         Width           =   1080
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   3600
         Left            =   90
         TabIndex        =   5
         Top             =   165
         Width           =   5055
         _ExtentX        =   8916
         _ExtentY        =   6350
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483636
         FocusRect       =   0
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
   End
   Begin Threed.SSFrame Frame 
      Height          =   2055
      Index           =   3
      Left            =   6285
      TabIndex        =   1
      Top             =   105
      Visible         =   0   'False
      Width           =   2715
      _Version        =   65536
      _ExtentX        =   4789
      _ExtentY        =   3625
      _StockProps     =   14
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   780
         Left            =   270
         ScaleHeight     =   720
         ScaleWidth      =   2100
         TabIndex        =   2
         Top             =   300
         Width           =   2160
      End
      Begin VB.Label Label 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Label(1)"
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   255
         TabIndex        =   4
         Top             =   1590
         Width           =   1860
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Index           =   0
         Left            =   255
         TabIndex        =   3
         Top             =   1245
         Width           =   1860
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMntPe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal As String

Sub Dibuja_Grilla()

Table1.TextMatrix(0, 0) = ""
Table1.TextMatrix(0, 1) = "Codigo"
Table1.TextMatrix(0, 2) = "Periodo"
Table1.TextMatrix(0, 3) = "Numero"
Table1.TextMatrix(0, 4) = "Tipo"
Table1.TextMatrix(0, 5) = "Descripcion Periodo"

Table1.RowHeight(0) = 500

Table1.ColAlignment(0) = 0
Table1.ColAlignment(1) = 7
Table1.ColAlignment(2) = 1
Table1.ColAlignment(3) = 7
Table1.ColAlignment(4) = 4
Table1.ColAlignment(5) = 1

Table1.ColWidth(0) = 0
Table1.ColWidth(1) = 800
Table1.ColWidth(2) = 800
Table1.ColWidth(3) = 800
Table1.ColWidth(4) = 500
Table1.ColWidth(5) = 2000

End Sub

Function peGrabar() As Boolean
   Dim Sql        As String
   Dim nLin       As Integer
   Dim Primera_Vez   As String

   peGrabar = False

   If Not BacBeginTransaction Then
      Exit Function

   End If
   

   With Table1
      .Redraw = False

      For nLin = 1 To .Rows - 1
         .Row = nLin
         .Col = 1
         Primera_Vez = IIf(nLin = 1, "S", "N")
         If .Text <> "" Then
         Envia = Array()
         
         .Col = 1: AddParam Envia, CDbl(.Text)
         .Col = 2: AddParam Envia, .Text
         .Col = 3: AddParam Envia, CDbl(.Text)
         .Col = 4: AddParam Envia, .Text
         .Col = 5: AddParam Envia, .Text
         AddParam Envia, Primera_Vez
         
         Dim v1, v2, v3, v4, v5 As String
         .Col = 1: v1 = .Text
         .Col = 2: v2 = .Text
         .Col = 3: v3 = .Text
         .Col = 4: v4 = .Text
         .Col = 5: v5 = .Text

         If Not BAC_SQL_EXECUTE("sp_mdpegrabar ", Envia) Then
            Call LogAuditoria("01", OptLocal, Me.Caption & " Error al Grabar- Codigo: " & v1 & " Periodo: " & v2 & " Numero: " & v3 & " Tipo: " & v4 & " Descripcion Periodo: " & v5, "", "")
            GoTo ErrorGrabar:

         End If
         Do While BAC_SQL_FETCH(Datos())
            If Datos(1) = 1 Then
                Call LogAuditoria("01", OptLocal, Me.Caption & " Error al Grabar- Codigo: " & v1 & " Periodo: " & v2 & " Numero: " & v3 & " Tipo: " & v4 & " Descripcion Periodo: " & v5, "", "")
                GoTo ErrorGrabar:
            End If
         Loop
                             
         Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo: " & v1 & " Periodo: " & v2 & " Numero: " & v3 & " Tipo: " & v4 & " Descripcion Periodo: " & v5)
         End If
      Next nLin

      .Redraw = True

   End With

   

   If Not BacCommitTransaction Then
      GoTo ErrorGrabar

   End If

   peGrabar = True

   Exit Function

ErrorGrabar:
   
   Call BacRollBackTransaction

   MsgBox "Problemas al grabar la tabla de periodos", vbCritical


End Function

Sub PeLeer()

   Dim Sql        As String
   Dim Datos()
   

   If Not BAC_SQL_EXECUTE("sp_mdpeleer ") Then
      MsgBox "Problemas al leer los periodos", vbCritical

   End If

   With Table1

      .Rows = 1

      Do While BAC_SQL_FETCH(Datos())

         .Rows = .Rows + 1
         .Row = .Rows - 1

         .Col = 1: .Text = CDbl(Datos(1))
         .Col = 2: .Text = Datos(2)
         .Col = 3: .Text = Datos(3)
         .Col = 4: .Text = Datos(4)
         .Col = 5: .Text = Datos(5)

      Loop

   End With

End Sub

Private Sub CmdGrabar_Click()

   If peGrabar() Then
      MsgBox "Se grabaron los datos OK.", vbInformation

   End If

End Sub

Private Sub cmdSalir_Click()

   Unload Me

End Sub


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape) And UCase(Me.ActiveControl.Name) = "TXTINGRESO" Then 'And UCase(Me.ActiveControl.Name) <> "GRILLA" Then
      KeyCode = 0
      Exit Sub
End If


If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyGrabar
               opcion = 1
         
         Case vbKeySalir
               opcion = 2
   End Select
   

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
         KeyCode = 0
      End If

   End If

End If

End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   Dim nCol          As Integer

   Call BacSetMinBox(Me)
   
   Dibuja_Grilla

   Call PeLeer
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
   
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim bOk        As Boolean
   Dim nOk        As Integer
   Dim cPeriodo   As String
     

   Select Case KeyCode
      
   Case vbKeyInsert And Label(1).Caption <> "E"
      Table1.Rows = Table1.Rows + 1
      Table1.Row = Table1.Rows - 1
      Table1.Col = 1

   Case vbKeyDelete And Table1.Row = (Table1.Rows - 1)

      'Validar que no se encuentre enlazado con algun perfil.
      If Table1.Rows > 2 Then
         Table1.RemoveItem Table1.Row
         Table1.Row = Table1.Rows - 1

      Else
         'Grid1.Rows = 1
         Table1.Rows = 2

      End If
   
   End Select

End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)
BacControlWindows 100

If KeyAscii <> 13 Then
    If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") Then
        KeyAscii = 0
        Exit Sub
    End If
End If

Select Case Table1.Col

   Case 1, 3
   
      If KeyAscii <> 13 Then
        If Not IsNumeric(Chr(KeyAscii)) Then
            KeyAscii = 0
        End If
      Else
        txtIngreso.Text = Table1.Text
      End If
    
      PROC_POSICIONA_TEXTO Table1, txtIngreso
            
      If KeyAscii <> 13 Then
         txtIngreso.Text = Chr(KeyAscii)
      End If
      txtIngreso.Visible = True
      txtIngreso.SetFocus
      
      SendKeys "{END}"

   Case Else
      
      If UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z" And KeyAscii <> 13 And KeyAscii <> 97 Then
         txtIngreso = UCase(Chr(KeyAscii))
      Else
        txtIngreso.Text = Table1.Text
      End If
      
      PROC_POSICIONA_TEXTO Table1, txtIngreso
      txtIngreso.Visible = True
      txtIngreso.SetFocus
      SendKeys "{END}"
End Select
      
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1      '"Grabar"
       If peGrabar() Then
          MsgBox "Grabación realizada con éxito", vbInformation
          Table1.SetFocus
       End If
    Case 2      '"Salir"
        Unload Me
    End Select
End Sub

Private Sub txtIngreso_KeyPress(KeyAscii As Integer)
KeyAscii = Caracter(KeyAscii)

If KeyAscii = 27 Then
    
    txtIngreso.Visible = False
    
    Table1.SetFocus
     
End If

If Table1.Col = 1 Then          'Código
 txtIngreso.MaxLength = 3
 KeyAscii = BacPunto(txtIngreso, KeyAscii, 5, 0)
ElseIf Table1.Col = 2 Then      'Periodo
  txtIngreso.MaxLength = 6
  KeyAscii = Asc(UCase(Chr(KeyAscii)))
ElseIf Table1.Col = 3 Then      'Número
 txtIngreso.MaxLength = 4
 KeyAscii = BacPunto(txtIngreso, KeyAscii, 5, 0)
ElseIf Table1.Col = 4 Then      'Tipo
  txtIngreso.MaxLength = 1
  KeyAscii = Asc(UCase(Chr(KeyAscii)))
ElseIf Table1.Col = 5 Then      'Glosa
  txtIngreso.MaxLength = 15
  KeyAscii = Asc(UCase(Chr(KeyAscii)))
End If

If KeyAscii = 13 Then

    If Table1.Col = 1 Then
       If Not FUNC_VERIFICA_GRILLA(txtIngreso.Text) Then
         txtIngreso.Visible = False
         Exit Sub
       End If
    
    End If

    If Trim(txtIngreso.Text) = "" Then Exit Sub
   
    Table1.Text = txtIngreso.Text
    
    txtIngreso.Visible = False
    
    Table1.SetFocus
    
End If

End Sub

Private Function FUNC_VERIFICA_GRILLA(Txt1 As String) As Boolean
Dim nFila As Integer

   FUNC_VERIFICA_GRILLA = False

   With Table1
      
      For nFila = .FixedRows To .Rows - 1
         
         If Txt1 = .TextMatrix(nFila, 1) And Not nFila = .Row Then
         
            MsgBox "El Código no se puede repetir", vbExclamation
            Exit Function
      
         End If
         
      Next nFila

   End With

   FUNC_VERIFICA_GRILLA = True

End Function

