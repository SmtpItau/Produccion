VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Mant_TipoUsuario 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Tipo Usuario"
   ClientHeight    =   5475
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5760
   Icon            =   "Mant_TipoUsuario.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5475
   ScaleWidth      =   5760
   Begin VB.Frame Frame1 
      Height          =   1080
      Left            =   0
      TabIndex        =   5
      Top             =   510
      Width           =   5760
      Begin Threed.SSPanel SSPanel2 
         Height          =   825
         Left            =   60
         TabIndex        =   6
         Top             =   150
         Width           =   5655
         _Version        =   65536
         _ExtentX        =   9975
         _ExtentY        =   1455
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
         Begin VB.TextBox TxtTipoUsuario 
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
            Left            =   1425
            MaxLength       =   15
            TabIndex        =   1
            Top             =   75
            Width           =   2145
         End
         Begin VB.TextBox TxtDescripcion 
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
            Left            =   1425
            MaxLength       =   40
            TabIndex        =   2
            Top             =   390
            Width           =   4140
         End
         Begin VB.Label lblcodigo 
            Caption         =   "Tipo Usuario"
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
            Left            =   120
            TabIndex        =   8
            Top             =   105
            Width           =   1515
         End
         Begin VB.Label Label2 
            Caption         =   "Descripción"
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
            Left            =   120
            TabIndex        =   7
            Top             =   480
            Width           =   2010
         End
      End
   End
   Begin VB.Frame Frame2 
      Height          =   3840
      Left            =   0
      TabIndex        =   0
      Top             =   1620
      Width           =   5745
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   480
         Left            =   75
         TabIndex        =   4
         Top             =   3285
         Width           =   5595
         _ExtentX        =   9869
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         Appearance      =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Nuevo"
               ImageIndex      =   5
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Elimina"
               ImageIndex      =   2
            EndProperty
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   3030
         Left            =   75
         TabIndex        =   3
         Top             =   180
         Width           =   5595
         _ExtentX        =   9869
         _ExtentY        =   5345
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         BackColorBkg    =   -2147483645
         GridColorFixed  =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   945
      Left            =   -180
      TabIndex        =   9
      Top             =   -15
      Width           =   9360
      _Version        =   65536
      _ExtentX        =   16510
      _ExtentY        =   1667
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
      Begin MSComctlLib.Toolbar Toolbar1 
         Height          =   480
         Left            =   165
         TabIndex        =   10
         Top             =   15
         Width           =   9225
         _ExtentX        =   16272
         _ExtentY        =   847
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
               Object.ToolTipText     =   "Limpia"
               ImageIndex      =   3
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Salir"
               ImageIndex      =   4
            EndProperty
         EndProperty
         Begin MSComctlLib.ImageList ImageList1 
            Left            =   4320
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
                  Picture         =   "Mant_TipoUsuario.frx":030A
                  Key             =   ""
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Mant_TipoUsuario.frx":075C
                  Key             =   ""
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Mant_TipoUsuario.frx":0BAE
                  Key             =   ""
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Mant_TipoUsuario.frx":0EC8
                  Key             =   ""
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Mant_TipoUsuario.frx":11E2
                  Key             =   ""
               EndProperty
            EndProperty
         End
      End
   End
End
Attribute VB_Name = "Mant_TipoUsuario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim colpress As Long
Dim rowpress As Long
Dim inicio As Integer

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
   inicio = 0
   Carga_Grilla
   Toolbar1.Buttons(1).Enabled = False
   Toolbar2.Buttons(2).Enabled = False
   Toolbar2.Buttons(1).Enabled = False
   inicio = 1
   
End Sub

Private Sub grilla_Click()

   TxtTipoUsuario.Enabled = False
   TxtDescripcion.Enabled = False
   TxtTipoUsuario.Text = Grilla.TextMatrix(Grilla.Row, 1)
   TxtDescripcion.Text = Grilla.TextMatrix(Grilla.Row, 2)
   Toolbar2.Buttons(1).Enabled = True
   Toolbar2.Buttons(2).Enabled = True
   Toolbar1.Buttons(1).Enabled = False
   
End Sub

Private Sub grilla_DblClick()

   TxtTipoUsuario.Enabled = False
   TxtDescripcion.Enabled = True
   Toolbar2.Buttons(1).Enabled = False
   Toolbar2.Buttons(2).Enabled = False
   Toolbar1.Buttons(1).Enabled = True
   'TxtTipoUsuario.SetFocus

End Sub

Private Sub Grilla_EnterCell()
On Error GoTo fin:
   
   If inicio = 1 Then

      TxtTipoUsuario.Text = Grilla.TextMatrix(Grilla.Row, 1)
      TxtDescripcion.Text = Grilla.TextMatrix(Grilla.Row, 2)
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

Private Sub Grilla_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

   colpress = Grilla.Col
   rowpress = Grilla.Row
   Grilla.ColSel = Grilla.Cols - 1
   
End Sub

Private Sub Grilla_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
   
   Grilla.Col = colpress
   Grilla.Row = rowpress
   Grilla.ColSel = Grilla.Cols - 1
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   
      Case Is = 1: Graba
                   TxtTipoUsuario.SetFocus
                        
      Case Is = 2: Limpiar
   
      Case Is = 3: Unload Me
      
   End Select

End Sub


Sub Limpiar()

   TxtTipoUsuario.Enabled = True
   TxtDescripcion.Enabled = True
   Carga_Grilla
   TxtTipoUsuario.Text = ""
   TxtDescripcion.Text = ""
   TxtTipoUsuario.SetFocus
   Toolbar2.Buttons(1).Enabled = False
   Toolbar2.Buttons(2).Enabled = False
   
End Sub

Sub Carga_Grilla()
Dim DATOS()
Dim Sw As Integer

Sw = 0

   With Grilla
      
      .Row = 0
      .Rows = 1
      .ColWidth(0) = 0
      .ColWidth(1) = 2600
      .ColWidth(2) = 2600
      .TextMatrix(0, 1) = "Tipo Usuario"
      .TextMatrix(0, 2) = "Descripción"
      .Col = 1
      .CellFontBold = True
      .Col = 2
      .CellFontBold = True
            
      
      
      If Bac_Sql_Execute("SP_MantTipoUsuario_Busca") Then
         
         Do While Bac_SQL_Fetch(DATOS())
         
            If DATOS(1) <> "" Then
            On Error GoTo Fin2:
               .Rows = .Rows + 1
               .TextMatrix(.Rows - 1, 1) = DATOS(1)
               .TextMatrix(.Rows - 1, 2) = DATOS(2)
               
            Else
               
               Sw = 1
            
            End If
         
         Loop
      
      End If
         
      .Col = 0
         
   End With
   

fin:
      
      TxtDescripcion.Text = ""
      TxtTipoUsuario.Text = ""
     
      Exit Sub
      
Fin2:
      Grilla.Rows = 1
      Grilla.Col = 0
      Grilla.Enabled = False
   
End Sub



Sub Graba()
Dim DATOS()
Dim Sw As Integer

   Sw = 0
   
   Envia = Array()
   AddParam Envia, TxtTipoUsuario.Text
   AddParam Envia, TxtDescripcion.Text
   
   If Bac_Sql_Execute("SP_Mant_TipoUsuario_Graba ", Envia) Then
   
      Do While Bac_SQL_Fetch(DATOS())
      
         Select Case DATOS(1)
         
            Case Is = "INSERTA": Sw = 1
            
            Case Is = "MODIFICA": Sw = 2
           
         End Select
      
         Grilla.Enabled = True
         
      Loop
   
   End If
   
   If Sw = 1 Then MsgBox "La Información a sido Grabada", vbOKOnly + vbInformation, TITSISTEMA
   
   If Sw = 2 Then MsgBox "La Información a sido Modificada", vbOKOnly + vbInformation, TITSISTEMA
             
   Carga_Grilla
             
End Sub

Sub Elimina()
Dim DATOS()
Dim Sw As Integer

   Sw = 0
   
   If TxtTipoUsuario.Text <> "" And TxtDescripcion.Text <> "" Then
      
      Envia = Array()
      AddParam Envia, TxtTipoUsuario.Text
      AddParam Envia, TxtDescripcion.Text

      If Bac_Sql_Execute("SP_Mant_TipoUsuario_Elimina ", Envia) Then
   
         Do While Bac_SQL_Fetch(DATOS())
         
            Select Case DATOS(1)
            
               Case Is = "OK": Sw = 1
               
               Case Is = "ERROR": Sw = 2
            
            End Select
         
         Loop
      
      End If
      
      If Sw = 1 Then
      
      On Error GoTo Fin2:
         
      If Grilla.Rows = 2 Then Grilla.Rows = 2
 
         Grilla.RemoveItem (Grilla.RowSel)
         TxtTipoUsuario.Text = Grilla.TextMatrix(Grilla.Row, 1)
         TxtDescripcion.Text = Grilla.TextMatrix(Grilla.Row, 2)
         MsgBox "Tipo Usuario Eliminado", vbOKOnly + vbInformation, TITSISTEMA
      
      End If
      
      If Sw = 2 Then MsgBox "Error Leyendo " & "SP_Mant_TipoUsuario_Elimina", vbOKOnly + vbInformation, TITSISTEMA
   
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

Private Sub TxtTipoUsuario_Change()
   
   If TxtTipoUsuario.Text <> "" And TxtDescripcion.Text <> "" Then
      
      Toolbar1.Buttons(1).Enabled = True
      
   Else
      
      Toolbar1.Buttons(1).Enabled = False
   
   End If

End Sub

Private Sub TxtTipoUsuario_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 13 Then TxtDescripcion.SetFocus
   
   If KeyCode = 27 And TxtTipoUsuario.Text = TxtTipoUsuario.Tag Then Unload Me: Exit Sub
   
   If KeyCode = 27 And TxtTipoUsuario.Text <> TxtTipoUsuario.Tag Then TxtTipoUsuario.Text = TxtTipoUsuario.Tag
  
End Sub

Private Sub TxtTipoUsuario_LostFocus()

   TxtTipoUsuario.Tag = TxtTipoUsuario.Text

End Sub

Private Sub TxtDescripcion_Change()

   If TxtTipoUsuario.Text <> "" And TxtDescripcion.Text <> "" Then
      
      Toolbar1.Buttons(1).Enabled = True
      
   Else
      
      Toolbar1.Buttons(1).Enabled = False
   
   End If

End Sub


Sub Nuevo()

   TxtTipoUsuario.Enabled = True
   TxtDescripcion.Enabled = True
   Toolbar2.Buttons(1).Enabled = False
   Toolbar2.Buttons(2).Enabled = False
   TxtTipoUsuario.SetFocus
   Limpiar
   TxtTipoUsuario.Text = ""
   TxtDescripcion.Text = ""

End Sub

Private Sub TxtDescripcion_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = 13 Then TxtTipoUsuario.SetFocus

   If KeyCode = 27 And TxtDescripcion.Text = TxtDescripcion.Tag Then Unload Me: Exit Sub
   
   If KeyCode = 27 And TxtDescripcion.Text <> TxtDescripcion.Tag Then TxtDescripcion.Text = TxtDescripcion.Tag
      
End Sub

Private Sub TxtDescripcion_LostFocus()

   TxtDescripcion.Tag = TxtDescripcion.Text

End Sub

