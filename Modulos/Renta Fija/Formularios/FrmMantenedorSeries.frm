VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FrmMantenedorSeries 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Series"
   ClientHeight    =   5160
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4050
   Icon            =   "FrmMantenedorSeries.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5160
   ScaleWidth      =   4050
   StartUpPosition =   2  'CenterScreen
   Begin Threed.SSPanel SSPanel1 
      Height          =   4725
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   4095
      _Version        =   65536
      _ExtentX        =   7223
      _ExtentY        =   8334
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
      BevelOuter      =   0
      BevelInner      =   1
      Begin Threed.SSFrame SSFrame1 
         Height          =   4605
         Left            =   60
         TabIndex        =   2
         Top             =   60
         Width           =   3975
         _Version        =   65536
         _ExtentX        =   7011
         _ExtentY        =   8123
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
         Begin Threed.SSFrame SSFrame2 
            Height          =   855
            Left            =   60
            TabIndex        =   3
            Top             =   105
            Width           =   3855
            _Version        =   65536
            _ExtentX        =   6800
            _ExtentY        =   1508
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
            Begin VB.TextBox TxtSerie 
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
               Left            =   1215
               MaxLength       =   15
               TabIndex        =   7
               Top             =   135
               Width           =   2580
            End
            Begin VB.TextBox TxtNemotecnico 
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
               Left            =   1215
               MaxLength       =   10
               TabIndex        =   4
               Top             =   465
               Width           =   2580
            End
            Begin VB.Label Label1 
               Caption         =   "Serie"
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
               Height          =   285
               Left            =   60
               TabIndex        =   6
               Top             =   180
               Width           =   1515
            End
            Begin VB.Label Label2 
               Caption         =   "Nemotécnico"
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
               Height          =   270
               Left            =   60
               TabIndex        =   5
               Top             =   495
               Width           =   2010
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   3630
            Left            =   60
            TabIndex        =   8
            Top             =   900
            Width           =   3840
            _Version        =   65536
            _ExtentX        =   6773
            _ExtentY        =   6403
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
            Begin MSComctlLib.Toolbar Toolbar2 
               Height          =   480
               Left            =   45
               TabIndex        =   9
               Top             =   3090
               Width           =   3750
               _ExtentX        =   6615
               _ExtentY        =   847
               ButtonWidth     =   767
               ButtonHeight    =   741
               Appearance      =   1
               ImageList       =   "ImageList1"
               _Version        =   393216
               BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                  NumButtons      =   2
                  BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     ImageIndex      =   5
                  EndProperty
                  BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     ImageIndex      =   2
                  EndProperty
               EndProperty
            End
            Begin MSFlexGridLib.MSFlexGrid Grilla 
               Height          =   2970
               Left            =   30
               TabIndex        =   10
               Top             =   120
               Width           =   3765
               _ExtentX        =   6641
               _ExtentY        =   5239
               _Version        =   393216
               Cols            =   3
               FixedCols       =   0
               RowHeightMin    =   315
               BackColor       =   -2147483644
               ForeColor       =   8388608
               BackColorFixed  =   8421376
               ForeColorFixed  =   16777215
               BackColorSel    =   8388608
               BackColorBkg    =   -2147483644
               GridColorFixed  =   16777215
               FocusRect       =   0
               GridLines       =   2
               GridLinesFixed  =   0
               SelectionMode   =   1
            End
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4050
      _ExtentX        =   7144
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Graba"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Borra"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2085
         Top             =   60
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
               Picture         =   "FrmMantenedorSeries.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmMantenedorSeries.frx":075C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmMantenedorSeries.frx":0BAE
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmMantenedorSeries.frx":0EC8
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmMantenedorSeries.frx":11E2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FrmMantenedorSeries"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim colpress As Long
Dim rowpress As Long
Dim inicio As Integer

Private Sub Form_Activate()
   
   TxtSerie.SetFocus
   
End Sub

Private Sub Form_Load()
   inicio = 0
   Carga_Grilla
   Toolbar1.Buttons(1).Enabled = False
   Toolbar2.Buttons(2).Enabled = False
   Toolbar2.Buttons(1).Enabled = False
   inicio = 1
   
End Sub

Private Sub grilla_Click()

   TxtSerie.Enabled = False
   TxtNemotecnico.Enabled = False
   TxtSerie.Text = Grilla.TextMatrix(Grilla.Row, 1)
   TxtNemotecnico.Text = Grilla.TextMatrix(Grilla.Row, 2)
   Toolbar2.Buttons(1).Enabled = True
   Toolbar2.Buttons(2).Enabled = True
   Toolbar1.Buttons(1).Enabled = False
   
End Sub

Private Sub grilla_DblClick()

   TxtSerie.Enabled = False
   TxtNemotecnico.Enabled = True
   Toolbar2.Buttons(1).Enabled = False
   Toolbar2.Buttons(2).Enabled = False
   Toolbar1.Buttons(1).Enabled = True
   'TxtSerie.SetFocus

End Sub

Private Sub Grilla_EnterCell()
On Error GoTo fin:
   
   If inicio = 1 Then

      TxtSerie.Text = Grilla.TextMatrix(Grilla.Row, 1)
      TxtNemotecnico.Text = Grilla.TextMatrix(Grilla.Row, 2)
      Toolbar1.Buttons(1).Enabled = False
      
   End If
   
fin:
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
   
   colpress = Grilla.Col
   rowpress = Grilla.Row
   Grilla.ColSel = Grilla.Cols - 1

   If KeyCode = 27 Then Unload Me

   If KeyCode = 46 Then Elimina
   
   If KeyCode = 45 Then Nuevo

End Sub

Private Sub Grilla_KeyUp(KeyCode As Integer, Shift As Integer)
   
   Grilla.Col = colpress
   Grilla.Row = rowpress
   Grilla.ColSel = Grilla.Cols - 1
   
End Sub

Private Sub Grilla_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

   colpress = Grilla.Col
   rowpress = Grilla.Row
   Grilla.ColSel = Grilla.Cols - 1
   
End Sub

Private Sub Grilla_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
   
   Grilla.Col = colpress
   Grilla.Row = rowpress
   Grilla.ColSel = Grilla.Cols - 1
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   
      Case Is = 1: Graba
     
      Case Is = 2: Limpiar
   
      Case Is = 3: Unload Me
      
   End Select

End Sub


Sub Limpiar()

   TxtSerie.Enabled = True
   TxtNemotecnico.Enabled = True
   Carga_Grilla
   TxtSerie.Text = ""
   TxtNemotecnico.Text = ""
   TxtSerie.SetFocus
   
End Sub

Sub Carga_Grilla()
Dim Datos()
Dim sw As Integer

sw = 0

   With Grilla
      
      .Redraw = False
      .Row = 0
      .Rows = 1
      .ColWidth(0) = 0
      .ColWidth(1) = 2000
      .ColWidth(2) = 2000
      .TextMatrix(0, 1) = "Serie"
      .TextMatrix(0, 2) = "Nemotecnico"
      .Col = 1
      .CellFontBold = True
      .Col = 2
      .CellFontBold = True
            
      
      
      If Bac_Sql_Execute("SP_FRMMANTENEDORSERIES_TRAEDATOS") Then
         
         Do While Bac_SQL_Fetch(Datos())
         
            If Datos(1) <> "" Then
            On Error GoTo Fin2:
               .Rows = .Rows + 1
               .TextMatrix(.Rows - 1, 1) = Datos(1)
               .TextMatrix(.Rows - 1, 2) = Datos(2)
               
            Else
               
               sw = 1
            
            End If
         
         Loop
      
      End If
         
      .Col = 0
      .Redraw = True
      
   End With
   
   If Grilla.Rows = 1 Then
   
      GoTo Fin2:
   
   End If

fin:
   
      Exit Sub
      
Fin2:
      Grilla.Rows = 1
      Grilla.Col = 0
      Grilla.Enabled = False
   
End Sub



Sub Graba()
Dim Datos()
Dim sw As Integer

   sw = 0
   
   Envia = Array()
   AddParam Envia, TxtSerie.Text
   AddParam Envia, TxtNemotecnico.Text
   
   If Bac_Sql_Execute("SP_FRMMANTENEDORSERIES_GRABA ", Envia) Then
   
      Do While Bac_SQL_Fetch(Datos())
      
         Select Case Datos(1)
         
            Case Is = "INSERTA": sw = 1
            
            Case Is = "MODIFICA": sw = 2
           
         End Select
      
         Grilla.Enabled = True
         
      Loop
   
   End If
   
   If sw = 1 Then MsgBox "La Información a sido Grabada", vbOKOnly + vbInformation, "BacParametros"
   
   If sw = 2 Then MsgBox "La Información a sido Modificada", vbOKOnly + vbInformation, "BacParametros"
             
   Carga_Grilla
   Limpiar
             
End Sub

Sub Elimina()
Dim Datos()
Dim sw As Integer

   sw = 0
   
   If TxtSerie.Text <> "" And TxtNemotecnico.Text <> "" Then
      
      Envia = Array()
      AddParam Envia, TxtSerie.Text
      AddParam Envia, TxtNemotecnico.Text

      If Bac_Sql_Execute("SP_FRMMANTENEDORSERIES_ELIMINA ", Envia) Then
      
         Do While Bac_SQL_Fetch(Datos())
         
            Select Case Datos(1)
            
               Case Is = "OK": sw = 1
               
               Case Is = "ERROR": sw = 2
            
            End Select
         
         Loop
      
      Else
      
         MsgBox "Esta Serie Esta Siendo Utilizada", vbExclamation + vbOKOnly, TITSISTEMA
      
      End If
      
      If sw = 1 Then
      
      On Error GoTo Fin2:
         
         If Grilla.Rows = 2 Then Grilla.Rows = 2
 
         Grilla.RemoveItem (Grilla.RowSel)
         TxtSerie.Text = Grilla.TextMatrix(Grilla.Row, 1)
         TxtNemotecnico.Text = Grilla.TextMatrix(Grilla.Row, 2)
         MsgBox "Concepto Eliminado", vbOKOnly + vbInformation, TITSISTEMA
      
      End If
      
      If sw = 2 Then MsgBox "Problemas al Eliminar Serie", vbOKOnly + vbInformation, TITSISTEMA
      
      Grilla.SetFocus
   
   End If

fin:
   
   Exit Sub

Fin2:

   Grilla.Col = 0
   Grilla.Rows = 1
   Grilla.Enabled = False
   Nuevo

End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index

      Case Is = 1: Nuevo
      
      Case Is = 2: Elimina
         
   End Select

End Sub

Private Sub TxtSerie_Change()
   
   If TxtSerie.Text <> "" And TxtNemotecnico.Text <> "" Then
      
      Toolbar1.Buttons(1).Enabled = True
      
   Else
      
      Toolbar1.Buttons(1).Enabled = False
   
   End If

End Sub

Private Sub TxtSerie_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 13 Then TxtNemotecnico.SetFocus
   
   If KeyCode = 27 And TxtSerie.Text = TxtSerie.Tag Then Unload Me: Exit Sub
   
   If KeyCode = 27 And TxtSerie.Text <> TxtSerie.Tag Then TxtSerie.Text = TxtSerie.Tag
  
End Sub

Private Sub TxtNemotecnico_KeyPress(KeyAscii As Integer)
   
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub

Private Sub TxtSerie_KeyPress(KeyAscii As Integer)

      BacToUCase KeyAscii

End Sub

Private Sub TxtSerie_LostFocus()

   TxtSerie.Tag = TxtSerie.Text

End Sub

Private Sub TxtNemotecnico_Change()

   If TxtSerie.Text <> "" And TxtNemotecnico.Text <> "" Then
      
      Toolbar1.Buttons(1).Enabled = True
      
   Else
      
      Toolbar1.Buttons(1).Enabled = False
   
   End If

End Sub


Sub Nuevo()

   TxtSerie.Enabled = True
   TxtNemotecnico.Enabled = True
   Toolbar2.Buttons(1).Enabled = False
   Toolbar2.Buttons(2).Enabled = False
   TxtSerie.SetFocus
   Limpiar
   TxtSerie.Text = ""
   TxtNemotecnico.Text = ""

End Sub

Private Sub TxtNemotecnico_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = 13 Then TxtSerie.SetFocus

   If KeyCode = 27 And TxtNemotecnico.Text = TxtNemotecnico.Tag Then Unload Me: Exit Sub
   
   If KeyCode = 27 And TxtNemotecnico.Text <> TxtNemotecnico.Tag Then TxtNemotecnico.Text = TxtNemotecnico.Tag
      
End Sub

Private Sub TxtNemotecnico_LostFocus()

   TxtNemotecnico.Tag = TxtNemotecnico.Text

End Sub
