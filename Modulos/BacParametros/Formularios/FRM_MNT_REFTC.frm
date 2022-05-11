VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_REFTC 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantencion de Referencias de Tipo de Cambio"
   ClientHeight    =   4500
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8610
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4500
   ScaleWidth      =   8610
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8610
      _ExtentX        =   15187
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
         Left            =   4545
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REFTC.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REFTC.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FRA_Marco 
      Height          =   4020
      Left            =   30
      TabIndex        =   1
      Top             =   450
      Width           =   8565
      Begin BACControles.TXTNumero TxtNumGrid 
         Height          =   195
         Left            =   2055
         TabIndex        =   4
         Top             =   465
         Visible         =   0   'False
         Width           =   885
         _ExtentX        =   1561
         _ExtentY        =   344
         BackColor       =   -2147483645
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
      Begin VB.TextBox TxtTextGrid 
         BackColor       =   &H80000003&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   195
         Left            =   1110
         TabIndex        =   3
         Top             =   465
         Visible         =   0   'False
         Width           =   870
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3825
         Left            =   45
         TabIndex        =   2
         Top             =   135
         Width           =   8445
         _ExtentX        =   14896
         _ExtentY        =   6747
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
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
Attribute VB_Name = "FRM_MNT_REFTC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function Setting_Grid()
   Let Grid.Cols = 2:      Let Grid.Rows = 2
   Let Grid.FixedCols = 0: Let Grid.FixedRows = 1
   Let Grid.RowHeightMin = 300
   
   Let Grid.TextMatrix(0, 0) = "Código":        Let Grid.ColWidth(0) = 650
   Let Grid.TextMatrix(0, 1) = "Descripción":   Let Grid.ColWidth(1) = 3000

End Function

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Caption = "Mantención de Referencias de Tipos de Cambio."
   
   Call Setting_Grid
   Call Load_Reference
End Sub

Private Function Load_Reference()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("SP_MNT_REFRENCIA_MERCADO", Envia) Then
      Call MsgBox("Error de lectura" & vbCrLf & vbCrLf & "Se ha originado un error al leer referencias de mercado.", vbExclamation, App.Title)
      Exit Function
   End If
   Let Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Let Grid.Rows = Grid.Rows + 1
      Let Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1)
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)
   Loop
End Function

Private Sub Form_Unload(Cancel As Integer)
   Call EraseBlanckSection
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 1 Then
         Call PosTexto(Grid, TxtTextGrid)
          Let TxtTextGrid.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
          Let TxtTextGrid.Visible = True
         Call TxtTextGrid.SetFocus
          Let Grid.Enabled = False
          Let Toolbar1.Enabled = False
      End If
      'If Grid.ColSel = 2 Then
      '   Call PosTexto(Grid, TxtNumGrid)
      '    Let TxtNumGrid.Text = Val(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
      '    Let TxtNumGrid.Visible = True
      '   Call TxtNumGrid.SetFocus
      '    Let Grid.Enabled = False
      '    Let Toolbar1.Enabled = False
      'End If
   End If

   If KeyCode = vbKeyDelete Then
      If MsgBox("¿ Esta seguro de eliminar el registro ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
         Call DeleteItems
      End If
   End If

   If KeyCode = vbKeyInsert Then
      Call AddItems
   End If

End Sub

Private Function AddNewItems() As Long
   Dim Datos()

   Let AddNewItems = 0
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   If Not Bac_Sql_Execute("SP_MNT_REFRENCIA_MERCADO", Envia) Then
      Call MsgBox("Se ha producido un error en la creación de un nuevo items.", vbExclamation, App.Title)
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      Let AddNewItems = Datos(1)
   End If
   
End Function

Private Function AddItems()
   Let Grid.Rows = Grid.Rows + 1
   Let Grid.TextMatrix(Grid.Rows - 1, 0) = AddNewItems()
   Let Grid.TextMatrix(Grid.Rows - 1, 1) = ""
End Function

Private Function DeleteItems()
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, Val(Grid.TextMatrix(Grid.RowSel, 0))
   If Not Bac_Sql_Execute("SP_MNT_REFRENCIA_MERCADO", Envia) Then
      Call MsgBox("Se ha producido un error en la eliminación del Items.", vbExclamation, App.Title)
      Exit Function
   End If
   Call MsgBox("Eliminacion de Registro ha finalizado correctamente.", vbInformation, App.Title)
   Call Load_Reference
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call SaveData
      Case 2
         Call Unload(Me)
   End Select
End Sub

Private Function SaveData()
   Dim nContador  As Long
   
   Call BacBeginTransaction
   
   For nContador = Grid.FixedRows To Grid.Rows - 1
      
      Envia = Array()
      AddParam Envia, CDbl(1)
      AddParam Envia, Val(Grid.TextMatrix(nContador, 0))
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 1))
      If Not Bac_Sql_Execute("SP_MNT_REFRENCIA_MERCADO", Envia) Then
         Call BacRollBackTransaction
         Call MsgBox("Error en la actualización deitems...", vbExclamation, App.Title)
         Exit Function
      End If

   Next nContador

   Call BacCommitTransaction
   Call MsgBox("Actualización OK" & vbCrLf & vbCrLf & "Se han actualizado correctamente los registros.", vbInformation, App.Title)
   Call Load_Reference
End Function


Private Sub PosTexto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub


Private Sub TxtNumGrid_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Let KeyAscii = 0
      
      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TxtNumGrid.Text
      Let TxtNumGrid.Visible = False
   End If
   
   If KeyAscii = vbKeyEscape Then
      Let KeyAscii = 0
      
      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TxtNumGrid.Visible = False
   End If
End Sub

Private Sub TXTTextGrid_KeyPress(KeyAscii As Integer)
   Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
   
   If KeyAscii = vbKeyReturn Then
      Let KeyAscii = 0
      
      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TxtTextGrid.Text
      Let TxtTextGrid.Visible = False
   End If
   
   If KeyAscii = vbKeyEscape Then
      Let KeyAscii = 0
      
      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TxtTextGrid.Visible = False
   End If
End Sub

Private Function EraseBlanckSection()
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, Val(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
   If Not Bac_Sql_Execute("SP_MNT_REFRENCIA_MERCADO", Envia) Then
      Call MsgBox("Se ha producido un error en la eliminación del Items.", vbExclamation, App.Title)
      Exit Function
   End If
   
End Function
