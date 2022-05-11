VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_RIESGOINTERNO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Items de Riesgo Interno"
   ClientHeight    =   5265
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5895
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5265
   ScaleWidth      =   5895
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3030
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_RIESGOINTERNO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_RIESGOINTERNO.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_RIESGOINTERNO.frx":11F4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4770
      Left            =   45
      TabIndex        =   1
      Top             =   450
      Width           =   5820
      Begin VB.TextBox TXTTextGrid 
         BackColor       =   &H80000002&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   195
         Left            =   2055
         TabIndex        =   2
         Text            =   "Text1"
         Top             =   465
         Visible         =   0   'False
         Width           =   915
      End
      Begin BACControles.TXTNumero TXTNumGrid 
         Height          =   195
         Left            =   1095
         TabIndex        =   3
         Top             =   465
         Visible         =   0   'False
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   344
         BackColor       =   -2147483646
         ForeColor       =   -2147483639
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   4575
         Left            =   45
         TabIndex        =   4
         Top             =   135
         Width           =   5700
         _ExtentX        =   10054
         _ExtentY        =   8070
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_RIESGOINTERNO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function Grid_Setting()
   Let Grid.Rows = 50:     Let Grid.Cols = 3
   Let Grid.FixedRows = 1: Let Grid.FixedCols = 0
   
   Let Grid.TextMatrix(0, 0) = "Código":        Let Grid.ColWidth(0) = 1000
   Let Grid.TextMatrix(0, 1) = "Glosa":         Let Grid.ColWidth(1) = 1500
   Let Grid.TextMatrix(0, 2) = "Descripción":   Let Grid.ColWidth(2) = 2800
End Function

Private Sub Form_Load()
   Let Me.Icon = BacControlFinanciero.Icon
   Let Me.Top = 0: Let Me.Left = 0

   Call Grid_Setting
   Call Load_Datos
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyInsert Then
      Let Grid.Rows = Grid.Rows + 1
   End If
   If KeyCode = vbKeyDelete Then
      If Grid.TextMatrix(Grid.RowSel, 0) <> "" Then
         If DeleteItems(Grid.TextMatrix(Grid.RowSel, 0)) = False Then
            Exit Sub
         End If
      End If

      If Grid.Rows - 1 = Grid.FixedRows Then
         Let Grid.Rows = 1
      Else
         Call Grid.RemoveItem(Grid.RowSel)
      End If
   End If
End Sub

Private Function ValidaPosibilidadaModificacion(xItems As Long) As Boolean
   Dim DATOS()
   
   Let ValidaPosibilidadaModificacion = False
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, xItems
   If Not Bac_Sql_Execute("SP_RIESGOINTERNO", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en el proceso de lectura", vbExclamation, App.Title)
      Exit Function
   End If
   If Bac_SQL_Fetch(DATOS()) Then
      If DATOS(1) < 0 Then
         Exit Function
      End If
   End If
   
   Let ValidaPosibilidadaModificacion = True

End Function

Private Function DeleteItems(xItems As Long) As Boolean
   Dim DATOS()
   
   Let DeleteItems = False
   
   If MsgBox("Se Eliminara un Items de Riesgo Interno : " & xItems & " - " & Grid.TextMatrix(Grid.RowSel, 1) & vbCrLf & " ¿ Esta Seguro ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, xItems
   If Not Bac_Sql_Execute("SP_RIESGOINTERNO", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en el proceso de lectura", vbExclamation, App.Title)
      Exit Function
   End If
   If Bac_SQL_Fetch(DATOS()) Then
      If DATOS(1) < 0 Then
         Call MsgBox("Error de Eliminación." & vbCrLf & DATOS(2), vbExclamation, App.Title)
         Exit Function
      End If
   End If
   
   Let DeleteItems = True
   
   Call MsgBox("Itemas ha sido Eliminadoen de manera correcta.", vbInformation, App.Title)
   
End Function


Private Sub Grid_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Let Toolbar1.Enabled = False
      If Grid.ColSel = 0 Then
         
         If ValidaPosibilidadaModificacion(Val(Grid.TextMatrix(Grid.RowSel, 0))) = False Then
            Call MsgBox("Items se encunentra en sso... NO SE PUEDE MODIFICAR", vbExclamation, App.Title)
            Call Grid.SetFocus
            Exit Sub
         End If
         
         Let Grid.Enabled = False
         Let TXTNumGrid.Visible = True
         Let TXTNumGrid.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         Call AJObjeto(Grid, TXTNumGrid)
         Call TXTNumGrid.SetFocus
      End If
      If Grid.ColSel = 1 Or Grid.ColSel = 2 Then
         Let Grid.Enabled = False
         Let TXTTextGrid.Visible = True
         Let TXTTextGrid.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         Call AJObjeto(Grid, TXTTextGrid)
         Call TXTTextGrid.SetFocus
      End If
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Save_Data
      Case 2
         Call Unload(Me)
   End Select
End Sub

Private Function Load_Datos()
   Dim DATOS()
   Dim iFilas  As Integer

   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("SP_RIESGOINTERNO", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en el proceso de lectura", vbExclamation, App.Title)
      Exit Function
   End If
   Let iFilas = 0
   Do While Bac_SQL_Fetch(DATOS())
      Let iFilas = iFilas + 1
      If iFilas > 50 Then Let Grid.Rows = Grid.Rows + 1
      
      Let Grid.TextMatrix(iFilas, 0) = DATOS(1)
      Let Grid.TextMatrix(iFilas, 1) = DATOS(2)
      Let Grid.TextMatrix(iFilas, 2) = DATOS(3)
   Loop
End Function

Private Sub TXTNumGrid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Verificacion_Llave(TXTNumGrid.Text) = False Then
         Call MsgBox("Validación" & vbCrLf & "Código ya se encuentra creado para otro Items.... reemplace", vbExclamation, App.Title)
         Call TXTNumGrid.SetFocus
         Exit Sub
      End If
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TXTNumGrid.Text
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TXTNumGrid.Visible = False
      Let Toolbar1.Enabled = True
   End If
   If KeyCode = vbKeyEscape Then
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TXTNumGrid.Visible = False
      Let Toolbar1.Enabled = True
   End If
End Sub

Private Sub TXTTextGrid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TXTTextGrid.Text
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TXTTextGrid.Visible = False
      Let Toolbar1.Enabled = True
   End If
   If KeyCode = vbKeyEscape Then
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TXTTextGrid.Visible = False
      Let Toolbar1.Enabled = True
   End If
End Sub

Private Sub TXTTextGrid_KeyPress(KeyAscii As Integer)
   Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub

Private Function Save_Data()
   Dim iContador  As Long

   Envia = Array()
   AddParam Envia, CDbl(2)
   If Not Bac_Sql_Execute("SP_RIESGOINTERNO", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en el proceso de lectura", vbExclamation, App.Title)
      Exit Function
   End If

   For iContador = 1 To Grid.Rows - 1
      If Val(Grid.TextMatrix(iContador, 0)) > 0 Then
         Envia = Array()
         AddParam Envia, CDbl(1)
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 0))
         AddParam Envia, Trim(Grid.TextMatrix(iContador, 1))
         AddParam Envia, Trim(Grid.TextMatrix(iContador, 2))
         If Not Bac_Sql_Execute("SP_RIESGOINTERNO", Envia) Then
            Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en el proceso de lectura", vbExclamation, App.Title)
            Exit Function
         End If
      Else
         Exit For
      End If
   Next iContador

   Call MsgBox("Proceso Terminado." & vbCrLf & vbCrLf & "Se ha generado la grabación sin problemas", vbInformation, App.Title)

   Call Load_Datos
End Function

Private Function Verificacion_Llave(nValor As Long) As Boolean
   Dim nContador  As Long

   For nContador = 1 To Grid.Rows - 1
      If Val(Grid.TextMatrix(nContador, 0)) = nValor And nContador <> Grid.RowSel Then
         Let Verificacion_Llave = False
         Exit Function
      End If
   Next nContador

   Let Verificacion_Llave = True
End Function
