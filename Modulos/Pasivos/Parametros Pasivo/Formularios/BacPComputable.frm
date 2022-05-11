VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacPComputable 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Porcentaje Computable"
   ClientHeight    =   3720
   ClientLeft      =   3015
   ClientTop       =   3870
   ClientWidth     =   6225
   DrawStyle       =   1  'Dash
   DrawWidth       =   3
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3720
   ScaleWidth      =   6225
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5475
      Top             =   -45
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacPComputable.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacPComputable.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacPComputable.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacPComputable.frx":20CE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   6225
      _ExtentX        =   10980
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Guardar"
            Object.ToolTipText     =   "Guardar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   600
      Left            =   60
      TabIndex        =   2
      Top             =   480
      Width           =   6135
      _Version        =   65536
      _ExtentX        =   10821
      _ExtentY        =   1058
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox CmbCanasta 
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
         Left            =   1590
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   150
         Width           =   1515
      End
      Begin VB.Label LblEtiquetas 
         Alignment       =   2  'Center
         Caption         =   "Código Canasta"
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
         Index           =   0
         Left            =   75
         TabIndex        =   3
         Top             =   210
         Width           =   1485
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   2655
      Left            =   45
      TabIndex        =   4
      Top             =   1065
      Width           =   6150
      _Version        =   65536
      _ExtentX        =   10848
      _ExtentY        =   4683
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.TextBox txtRango 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
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
         Height          =   225
         Left            =   1230
         MaxLength       =   6
         TabIndex        =   6
         Top             =   1470
         Visible         =   0   'False
         Width           =   1005
      End
      Begin BACControles.TXTNumero TxtGrid 
         Height          =   285
         Left            =   2520
         TabIndex        =   5
         Top             =   1365
         Visible         =   0   'False
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   503
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
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
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999999999.9999"
         Max             =   "9999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   2445
         Left            =   60
         TabIndex        =   7
         Top             =   105
         Width           =   6015
         _ExtentX        =   10610
         _ExtentY        =   4313
         _Version        =   393216
         Rows            =   3
         Cols            =   3
         FixedRows       =   2
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   16777215
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   12632256
         GridColor       =   0
         Redraw          =   -1  'True
         AllowBigSelection=   -1  'True
         FocusRect       =   0
         FillStyle       =   1
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
End
Attribute VB_Name = "BacPComputable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal As String

Sub Titulos_Grilla()
   With Me.Grid
      .Cols = 4
      .Rows = 3
      .FixedCols = 0
      .FixedRows = 2
         
      .TextMatrix(0, 0) = "Intervalo":  .TextMatrix(1, 0) = ""
      .TextMatrix(0, 1) = "Rango":      .TextMatrix(1, 1) = "Desde"
      .TextMatrix(0, 2) = "Rango":      .TextMatrix(1, 2) = "Hasta"
      .TextMatrix(0, 3) = "Porcentaje": .TextMatrix(1, 3) = "Computable"
      
      .ColWidth(0) = 1200
      .ColWidth(1) = 1200
      .ColWidth(2) = 1200
      .ColWidth(3) = 1200
   
   End With
End Sub

Private Sub CmbCanasta_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
 If CmbCanasta.ListIndex = -1 Then Exit Sub
      Call Buscar_Datos
End If
End Sub


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   If CmbCanasta.Enabled Then
      CmbCanasta.SetFocus
   End If

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer


If (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape) And UCase(Me.ActiveControl.Name) = "TXTGRID" Or UCase(Me.ActiveControl.Name) = "TXTRANGO" Then
      'KeyCode = 0
      'Exit Sub
End If


If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeyBuscar
               opcion = 3
         
         Case vbKeySalir
               If txtRango.Visible = False Then
                opcion = 4
               Else
                 Exit Sub
               End If
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If
      KeyCode = 0

   End If


End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
If UCase(Me.ActiveControl.Name) <> "GRILLA" Then
   If KeyAscii = 13 Then
         Bac_SendKey vbKeyTab
   End If
End If
End Sub


Private Sub Form_Load()
   OptLocal = Opt
   Me.Move 0, 0
   Me.Icon = BAC_Parametros.Icon
   Call Titulos_Grilla
   Call Formato_Grilla(Grid)
   Call Carga_Datos
   Call Registra_LogAuditoria(7)
   'Call Limpiar_Datos
   
   CmbCanasta.ListIndex = -1
   
   Grid.Rows = 2
   Grid.FocusRect = flexFocusLight
   Grid.Enabled = False
   Toolbar1.Buttons(1).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = True
   CmbCanasta.Enabled = True
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Sub Carga_Datos()
   With CmbCanasta
      .Clear
      .AddItem "1"
      .AddItem "2"
      .AddItem "3"
   End With
End Sub

Sub Guardar_Datos()
   Dim X As Integer
   Dim Datos()
   
   If txtRango.Visible = True Or TxtGrid.Visible = True Then
      Exit Sub
   End If
   
   If Trim(Grid.TextMatrix(2, 1)) = "" Then
        MsgBox "Faltan Datos para Grabar", vbInformation
        Exit Sub
   End If
   
   If BacBeginTransaction = False Then
      MsgBox "No se Pudo Iniciar la Transacción"
      Exit Sub
   End If

   
   With Grid
      For X = .FixedRows To .Rows - 1
         
'CmbCanasta
'intervalo
'rango desde
'rango hasta
'Porcentaje computable

         Envia = Array()
         AddParam Envia, CDbl(Grid.TextMatrix(X, 0))
         AddParam Envia, CDbl(CmbCanasta.Text)
         AddParam Envia, CDbl(Trim(Grid.TextMatrix(X, 1)))
         AddParam Envia, CDbl(Trim(Grid.TextMatrix(X, 2)))
         AddParam Envia, CDbl(Grid.TextMatrix(X, 3))
         
         Dim v1, v2, v3, v4, v5 As String
         With Grid
            v1 = CmbCanasta.Text
            v2 = .TextMatrix(X, 0)
            v3 = .TextMatrix(X, 1)
            v4 = .TextMatrix(X, 2)
            v5 = .TextMatrix(X, 3)
         End With
         
         If Not BAC_SQL_EXECUTE("Sp_Graba_Plazo_Computable", Envia) Then
            Call BacRollBackTransaction
            MsgBox "Problemas en la Grabación del Registro", vbExclamation
            Call LogAuditoria("01", OptLocal, Me.Caption & "Error al grabar- Codigo: " & v1 & " Intervalo: " & v2 & " Rango desde: " & v3 & " Rango hasta: " & v4 & " Porcentaje: " & v5, "", "")
            Exit Sub
         End If
         
         If BAC_SQL_FETCH(Datos()) Then
            If Datos(1) < 0 Then
               Call BacRollBackTransaction
               MsgBox "Problemas en la Grabación de Porcentaje Computable", vbExclamation
               Call LogAuditoria("01", OptLocal, Me.Caption & "Error al grabar- Codigo: " & v1 & " Intervalo: " & v2 & " Rango desde: " & v3 & " Rango hasta: " & v4 & " Porcentaje: " & v5, "", "")
               Exit Sub
            End If
         End If
         
         Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo: " & v1 & " Intervalo: " & v2 & " Rango desde: " & v3 & " Rango hasta: " & v4 & " Porcentaje: " & v5)
      Next X
   End With

   Call BacCommitTransaction
   MsgBox "Grabación Ha Finalizado en Forma Correcta", vbInformation

End Sub


Function Verifica_Datos() As Boolean
   Verifica_Datos = False
   
   If Me.CmbCanasta.ListIndex = -1 Then
      MsgBox "Debe Seleccionar un Código de Canasta...", vbInformation
      Exit Function
   End If
      
   Verifica_Datos = True
      
End Function


Sub Buscar_Datos()
   Dim Datos()
   Dim X As Integer

   If CmbCanasta.ListIndex = -1 Then
      Exit Sub
   
   End If

   CmbCanasta.Enabled = False
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(3).Enabled = False
   
   With Me.Grid
      
      Envia = Array()
      AddParam Envia, CDbl(CmbCanasta.Text)
      
      If Not BAC_SQL_EXECUTE("Sp_Buscar_Datos_Porc_Computable", Envia) Then
         MsgBox "Problemas al buscar información de Porcentajes Computables.", vbCritical
         Exit Sub
      End If
      
      .Rows = .FixedRows
      Do While BAC_SQL_FETCH(Datos())
         .Rows = .Rows + 1
         .TextMatrix(.Rows - 1, 0) = Datos(1)
         .TextMatrix(.Rows - 1, 1) = Datos(2)
         .TextMatrix(.Rows - 1, 2) = Datos(3)
         .TextMatrix(.Rows - 1, 3) = Format(Datos(4), FDecimal)
      Loop
      
      If .Rows = .FixedRows Then
         .FocusRect = flexFocusLight
         .Enabled = False
         Call Limpiar_Datos
      Else
         .FocusRect = flexFocusNone
         .Enabled = True
         .SetFocus
      End If
      
   End With
End Sub

Sub Limpiar_Datos()
   CmbCanasta.ListIndex = -1
   
   Grid.Rows = 2
   Grid.FocusRect = flexFocusLight
   Grid.Enabled = False
   Toolbar1.Buttons(1).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = True
   CmbCanasta.Enabled = True
   CmbCanasta.SetFocus
   
End Sub

Private Sub Grid_DblClick()
   Grid_KeyPress vbKeyReturn
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    Call Grid_KeyPress(13)
End If
End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)
If Grid.Col = 2 Or Grid.Col = 3 Then
    txtRango.MaxLength = 6
End If

   If Grid.Col = 1 Or Grid.Col = 2 Then
      
      If KeyAscii = 13 Then
         IsNumeric (Chr(KeyAscii))
         txtRango.Text = Grid.TextMatrix(Grid.RowSel, Grid.Col)
         
'         txtRango.Text = Chr(KeyAscii)
'         txtRango.SelStart = 1
         
         
      ElseIf IsNumeric(Chr(KeyAscii)) Then
         
         txtRango.Text = Chr(KeyAscii)
         txtRango.SelStart = 1
         
      ElseIf Not IsNumeric(Chr(KeyAscii)) Then
      
         KeyAscii = 0
         Exit Sub
         
      End If
      
      
      PROC_POSICIONA_TEXTO Grid, txtRango
      txtRango.Visible = True
      txtRango.SetFocus
      
   ElseIf Grid.Col = 3 Then
      
      If KeyAscii = 13 Then
         
         TxtGrid.Text = Grid.TextMatrix(Grid.RowSel, Grid.Col)
         
      ElseIf IsNumeric(Chr(KeyAscii)) Then
         
         TxtGrid.Text = Chr(KeyAscii)
         TxtGrid.SelStart = 1
         
      ElseIf Not IsNumeric(Chr(KeyAscii)) Then
      
         KeyAscii = 0
         Exit Sub
         
      End If
      
      PROC_POSICIONA_TEXTO Grid, TxtGrid
      TxtGrid.Visible = True
      DoEvents
      TxtGrid.SetFocus
      
   End If

End Sub

Private Sub TxtGrid_KeyPress(KeyAscii As Integer)
   
   Select Case KeyAscii
      Case Is = 27
         TxtGrid.Visible = False
         Grid.SetFocus
      Case Is = 13
         Grid.Text = Format(TxtGrid.Text, FDecimal)
         TxtGrid.Visible = False
         Grid.SetFocus
   End Select
   
End Sub

Private Sub TxtGrid_LostFocus()
   TxtGrid.Visible = False
End Sub

Private Sub txtRango_LostFocus()
On Error GoTo Malo
If txtRango < 0 Then
End If
   txtRango.Visible = False
Exit Sub
Malo:
  MsgBox ("El rango deber ser numérico"), vbOKOnly
  txtRango.Visible = True
  txtRango.SetFocus
End Sub

Private Sub txtRango_KeyPress(KeyAscii As Integer)
On Error GoTo MAL
BacToUCase KeyAscii
KeyAscii = Caracter(KeyAscii)
   Select Case KeyAscii
      Case Is = 27
         txtRango.Visible = False
         Grid.SetFocus
      Case Is = 13
         'Grid.Text = Format(txtRango.Text, "@@@@@@")
         Grid.Text = txtRango
         txtRango.Visible = False
         Grid.SetFocus
   End Select
   
Exit Sub
MAL:
    MsgBox ("EL campo debe ser numérico y mayor a cero"), vbOKOnly

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      Case Is = "Guardar"
         Call Guardar_Datos
      Case Is = "Limpiar"
         Call Limpiar_Datos
      Case Is = "Buscar"
         Call Buscar_Datos
      Case Else
         Unload Me
   End Select
End Sub

Sub Registra_LogAuditoria(xCODIGO As String)
Select Case xCODIGO
   Case 7
      Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
   Case 5
      Call LogAuditoria("05", OptLocal, Me.Caption, "", "")
End Select
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call Registra_LogAuditoria(5)
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub


Function Valida_Montos() As Boolean
   Valida_Montos = False
'   Select Case Grid.Col
'      Case 1
'         If CDbl(Grid.TextMatrix(Grid.Row, 2)) < TxtGrid.Text And CDbl(Grid.TextMatrix(Grid.Row, 2)) > 0 Then
'            MsgBox "El Plazo Desde no debe ser Mayor al Plazo Hasta ...", vbExclamation
'            Exit Function
'         End If
'      Case 2
'         If CDbl(Grid.TextMatrix(Grid.Row, 1)) > TxtGrid.Text And CDbl(Grid.TextMatrix(Grid.Row, 1)) > 0 Then
'            MsgBox "El Plazo Hasta no debe ser Menor al Plazo Desde ...", vbExclamation
'            Exit Function
'         End If
'   End Select
   Valida_Montos = True
End Function
