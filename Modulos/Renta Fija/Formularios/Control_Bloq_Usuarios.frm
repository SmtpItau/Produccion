VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Control_Bloq_Usuarios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Control y Bloqueo de Usuarios"
   ClientHeight    =   5880
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8895
   Icon            =   "Control_Bloq_Usuarios.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5880
   ScaleWidth      =   8895
   Begin Threed.SSFrame SSFrame2 
      Height          =   3225
      Left            =   4560
      TabIndex        =   5
      Top             =   15
      Width           =   4320
      _Version        =   65536
      _ExtentX        =   7620
      _ExtentY        =   5689
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
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   480
         Left            =   30
         TabIndex        =   8
         Top             =   105
         Width           =   4245
         _ExtentX        =   7488
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         AllowCustomize  =   0   'False
         Appearance      =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Desbloquea"
               ImageIndex      =   1
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Bloquea"
               ImageIndex      =   2
            EndProperty
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla2 
         Height          =   2580
         Left            =   45
         TabIndex        =   6
         Top             =   585
         Width           =   4215
         _ExtentX        =   7435
         _ExtentY        =   4551
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         BackColorBkg    =   -2147483644
         GridColor       =   0
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   2625
      Left            =   15
      TabIndex        =   3
      Top             =   3225
      Width           =   8865
      _Version        =   65536
      _ExtentX        =   15637
      _ExtentY        =   4630
      _StockProps     =   14
      Caption         =   "Detalle Usuario"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      ShadowStyle     =   1
      Begin MSFlexGridLib.MSFlexGrid GrillaTmp2 
         Height          =   1695
         Left            =   2055
         TabIndex        =   10
         Top             =   780
         Visible         =   0   'False
         Width           =   2115
         _ExtentX        =   3731
         _ExtentY        =   2990
         _Version        =   393216
         FixedCols       =   0
      End
      Begin MSComctlLib.Toolbar Toolbar3 
         Height          =   480
         Left            =   45
         TabIndex        =   9
         Top             =   240
         Width           =   8775
         _ExtentX        =   15478
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         AllowCustomize  =   0   'False
         Appearance      =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.Visible         =   0   'False
               Object.ToolTipText     =   "Bloquea"
               ImageIndex      =   1
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               ImageIndex      =   2
            EndProperty
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla3 
         Height          =   1830
         Left            =   45
         TabIndex        =   4
         Top             =   720
         Width           =   8775
         _ExtentX        =   15478
         _ExtentY        =   3228
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         BackColorBkg    =   -2147483644
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3225
      Left            =   15
      TabIndex        =   0
      Top             =   0
      Width           =   4500
      Begin MSFlexGridLib.MSFlexGrid GrillaTmp 
         Height          =   1065
         Left            =   150
         TabIndex        =   7
         Top             =   1455
         Visible         =   0   'False
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   1879
         _Version        =   393216
         FixedCols       =   0
      End
      Begin MSComctlLib.Toolbar Toolbar1 
         Height          =   480
         Left            =   45
         TabIndex        =   2
         Top             =   135
         Width           =   4395
         _ExtentX        =   7752
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         AllowCustomize  =   0   'False
         Appearance      =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   3
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Desbloquea"
               ImageIndex      =   1
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Bloquea"
               ImageIndex      =   2
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Salir"
               ImageIndex      =   3
            EndProperty
         EndProperty
         Begin VB.Timer Timer1 
            Interval        =   100
            Left            =   1995
            Top             =   15
         End
         Begin MSComctlLib.ImageList ImageList1 
            Left            =   2400
            Top             =   -60
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
                  Picture         =   "Control_Bloq_Usuarios.frx":030A
                  Key             =   ""
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Control_Bloq_Usuarios.frx":075C
                  Key             =   ""
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Control_Bloq_Usuarios.frx":0BAE
                  Key             =   ""
               EndProperty
            EndProperty
         End
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   2535
         Left            =   45
         TabIndex        =   1
         Top             =   630
         Width           =   4395
         _ExtentX        =   7752
         _ExtentY        =   4471
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         BackColorBkg    =   -2147483644
         GridColor       =   0
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
      End
   End
End
Attribute VB_Name = "Control_Bloq_Usuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Datos()
Dim I, inicio As Integer
Dim colpress, rowpress As Integer


Private Sub Form_Load()

    inicio = 0
    Me.Top = 0
    Me.Left = 0
    Call Carga_Grilla
    Call Carga_Grilla2
    Call Carga_Grilla3
    inicio = 1
    Toolbar2.Buttons(1).Visible = False
    Toolbar2.Buttons(2).Visible = True

    
End Sub


Sub Carga_Grilla()

    With Grilla
    
        .Rows = 1
        .Cols = 3
        .Col = 1: .CellFontBold = True
        .Col = 2: .CellFontBold = True
        .TextMatrix(0, 1) = "Usuario"
        .TextMatrix(0, 2) = "Nombre Usuario"
        .ColWidth(0) = 0
        .ColWidth(1) = 1500
        .ColWidth(2) = 2500
        .Enabled = False
                
    End With
    

End Sub

Sub Carga_Grilla2()

    With Grilla2
    
        .Rows = 1
        .Cols = 3
        .Col = 1:  .CellFontBold = True
        .Col = 2:  .CellFontBold = True
        .TextMatrix(0, 1) = "Sistema"
        .TextMatrix(0, 2) = "Estado"
        .ColWidth(0) = 0
        .ColWidth(1) = 2000
        .ColWidth(2) = 1500
        .Enabled = False
                
    End With
    

End Sub

Sub Carga_Grilla3()

    With Grilla3
    
        .RowHeight(0) = 315
'        .RowHeight(1) = 315
'        .RowHeight(2) = 315
        .Rows = 1
        .Cols = 6
        .Row = 0
        .Col = 0: .CellFontBold = True
        .Col = 1: .CellFontBold = True
        .Col = 2: .CellFontBold = True
        .Col = 3: .CellFontBold = True
        .Col = 4: .CellFontBold = True
        .ColWidth(0) = 2000
        .ColWidth(1) = 2000
        .ColWidth(2) = 1000
        .ColWidth(3) = 1500
        .ColWidth(4) = 1500
        .ColWidth(5) = 0
        .TextMatrix(0, 0) = "Nombre"
        .TextMatrix(0, 1) = "Sistema"
        .TextMatrix(0, 2) = "Terminal"
        .TextMatrix(0, 3) = "Fecha Proceso"
        .TextMatrix(0, 4) = "Fecha Sistema"
        .Enabled = False
                
    End With
    

End Sub

Private Sub Grilla_EnterCell()

    If inicio = 1 Then
        
        Grilla3.Rows = 1
        
        If Grilla3.Rows = 1 Then
                                        
            Grilla3.Col = 5
            Grilla3.Row = 0
            Grilla3.Enabled = False
            
        End If

            
        If Grilla.Rows >= 2 Then
            
            Sql2 = "SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS "
            
            If miSQL.SQL_Execute(Sql2) = 0 Then
                
            
               Do While Bac_SQL_Fetch(Datos())
                    
                    If Datos(1) = Grilla.TextMatrix(Grilla.Row, 1) Or Mid(Datos(1), 1, Len(Datos(1)) - 1) = Grilla.TextMatrix(Grilla.Row, 1) Then
                            
                        Grilla3.Rows = Grilla3.Rows + 1
                        Grilla3.TextMatrix(Grilla3.Rows - 1, 0) = Grilla.TextMatrix(Grilla.Row, 2)
                        
                        If Datos(2) = "TES" Then Grilla3.TextMatrix(Grilla3.Rows - 1, 1) = "TESORERIA" + Space(80) + Datos(2)
                        If Datos(2) = "BCC" Then Grilla3.TextMatrix(Grilla3.Rows - 1, 1) = "SPOT" + Space(80) + Datos(2)
                        If Datos(2) = "BFW" Then Grilla3.TextMatrix(Grilla3.Rows - 1, 1) = "FORWARD" + Space(80) + Datos(2)
                        If Datos(2) = "BTR" Then Grilla3.TextMatrix(Grilla3.Rows - 1, 1) = "RENTA FIJA" + Space(80) + Datos(2)
                        If Datos(2) = "LIM" Then Grilla3.TextMatrix(Grilla3.Rows - 1, 1) = "LIMITES" + Space(80) + Datos(2)
                        If Datos(2) = "PCA" Then Grilla3.TextMatrix(Grilla3.Rows - 1, 1) = "PARAMETROS" + Space(80) + Datos(2)
                        If Datos(2) = "PCS" Then Grilla3.TextMatrix(Grilla3.Rows - 1, 1) = "SWAPS" + Space(80) + Datos(2)
                        If Datos(2) = "SCF" Then Grilla3.TextMatrix(Grilla3.Rows - 1, 1) = "CONTROL FINANCIERO" + Space(80) + Datos(2)
                        
                        Grilla3.TextMatrix(Grilla3.Rows - 1, 2) = Datos(3)
                        Grilla3.TextMatrix(Grilla3.Rows - 1, 3) = Datos(4)
                        Grilla3.TextMatrix(Grilla3.Rows - 1, 4) = Datos(5)
                        Grilla3.Enabled = True
                        
                        If Grilla3.Rows > 1 Then Grilla3.ColSel = 0
                            
                    
                    End If
                    
               Loop
               
            End If
        
        End If
        
        Call Lee_Sistemas
        
    End If

End Sub

Private Sub Grilla2_EnterCell()

    If inicio = 1 Then
    
        If Grilla2.TextMatrix(Grilla2.Row, 2) = "BLOQUEADO" Then
        
            Toolbar2.Buttons(1).Visible = True
            Toolbar2.Buttons(2).Visible = False
        
        Else
        
            Toolbar2.Buttons(2).Visible = True
            Toolbar2.Buttons(1).Visible = False
        
        End If
    
    End If

End Sub

Private Sub Grilla2_KeyDown(KeyCode As Integer, Shift As Integer)

    rowpress = Grilla2.Row
    colpress = Grilla2.Col
    Grilla2.ColSel = Grilla2.Cols - 1

End Sub

Private Sub Grilla2_KeyUp(KeyCode As Integer, Shift As Integer)

    Grilla2.Row = rowpress
    Grilla2.Col = colpress
    Grilla2.ColSel = Grilla2.Cols - 1

End Sub

Private Sub Grilla2_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

    rowpress = Grilla2.Row
    colpress = Grilla2.Col
    Grilla2.ColSel = Grilla2.Cols - 1

End Sub

Private Sub Grilla2_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)

    Grilla2.Row = rowpress
    Grilla2.Col = colpress
    Grilla2.ColSel = Grilla2.Cols - 1

End Sub

Private Sub Grilla3_KeyDown(KeyCode As Integer, Shift As Integer)

    rowpress = Grilla3.Row
    colpress = Grilla3.Col
    Grilla3.ColSel = Grilla3.Cols - 1

End Sub

Private Sub Grilla3_KeyUp(KeyCode As Integer, Shift As Integer)
On Error GoTo fin:
    
    Grilla3.Row = rowpress
    Grilla3.Col = colpress
    Grilla3.ColSel = Grilla3.Cols - 1

fin:
End Sub

Private Sub Grilla3_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

    rowpress = Grilla3.Row
    colpress = Grilla3.Col
    Grilla3.ColSel = Grilla3.Cols - 1

End Sub

Private Sub Grilla3_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)

    Grilla3.Row = rowpress
    Grilla3.Col = colpress
    Grilla3.ColSel = Grilla3.Cols - 1

End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

    rowpress = Grilla.Row
    colpress = Grilla.Col
    Grilla.ColSel = Grilla.Cols - 1

End Sub

Private Sub Grilla_KeyUp(KeyCode As Integer, Shift As Integer)

    Grilla.Row = rowpress
    Grilla.Col = colpress
    Grilla.ColSel = Grilla.Cols - 1

End Sub

Private Sub Grilla_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

    rowpress = Grilla.Row
    colpress = Grilla.Col
    Grilla.ColSel = Grilla.Cols - 1

End Sub

Private Sub Grilla_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)

    Grilla.Row = rowpress
    Grilla.Col = colpress
    Grilla.ColSel = Grilla.Cols - 1

End Sub



Private Sub Timer1_Timer()

    Grilla.Redraw = False
    Call Lee_Usuario
    Call Detalle_usuario
    Grilla.Redraw = True
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case Is = 1:    DesBloquea_Sistemas_Usuario
        
        Case Is = 2:    Bloquea_Sistemas_Usuario
        
        Case Is = 3:    Unload Me
        
    End Select
        
End Sub

Sub Lee_Usuario()
Dim digitos As String
Dim Sw As Integer
Dim J As Integer

    digitos = "123456789"

    With GrillaTmp
        .Rows = 1
        .Cols = 3
'        Sql = "SP_CONTROL_BLOQ_USUARIOS_LEE_CONTROL_US "
      
        I = 1
                
        If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_LEE_CONTROL_US") Then
            Do While Bac_SQL_Fetch(Datos())
                If Datos(1) <> "ERROR" Then
                    sw = 0
                    For J = 1 To Len(digitos)
                        If Right(Datos(1), 1) = Mid(digitos, J, 1) Then
                            sw = 1
                        End If
                    Next J
                    If Datos(1) <> .TextMatrix(I - 1, 0) Then 'If Sw <> 1 Then
                        .Rows = .Rows + 1
                        .TextMatrix(I, 0) = Datos(1)
                        .TextMatrix(I, 1) = Datos(2)
                        .TextMatrix(I, 2) = Datos(3)
                        I = I + 1
                    End If
                    If .Rows > Grilla.Rows Then
                         Grilla.Rows = Grilla.Rows + 1
                         Grilla.TextMatrix(Grilla.Rows - 1, 1) = .TextMatrix(.Rows - 1, 0)
                         Grilla.TextMatrix(Grilla.Rows - 1, 2) = .TextMatrix(.Rows - 1, 2)
                         Grilla.Enabled = True
                         inicio = 1
                         Grilla_EnterCell
                         Grilla.Row = 1
                         Grilla.ColSel = 0
                         Lee_Sistemas
                     End If
                End If
            Loop
        End If
    End With

End Sub


Sub Lee_Sistemas()
Dim digitos As String
Dim sw As Integer
Dim J, J2 As Integer

    digitos = "123456789"
        
    With Grilla2
    
        .Rows = 1
        
'        Sql = "SP_CONTROL_BLOQ_USUARIOS_LEE_CONTROL_US "
        
        J2 = 1
        
        If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_LEE_CONTROL_US") Then
            
            Do While Bac_SQL_Fetch(Datos())
            
                If Datos(1) <> "ERROR" Then

                    If Datos(1) = Grilla.TextMatrix(Grilla.RowSel, 1) Or Mid(Datos(1), 1, Len(Grilla.TextMatrix(Grilla.RowSel, 1))) = Grilla.TextMatrix(Grilla.RowSel, 1) Then
                        
                        .Rows = .Rows + 1
                        
                        If Datos(2) = "TES" Then .TextMatrix(J2, 1) = "TESORERIA" + Space(80) + Datos(2)
                        If Datos(2) = "BCC" Then .TextMatrix(J2, 1) = "SPOT" + Space(80) + Datos(2)
                        If Datos(2) = "BFW" Then .TextMatrix(J2, 1) = "FORWARD" + Space(80) + Datos(2)
                        If Datos(2) = "BTR" Then .TextMatrix(J2, 1) = "RENTA FIJA" + Space(80) + Datos(2)
                        If Datos(2) = "LIM" Then .TextMatrix(J2, 1) = "LIMITES" + Space(80) + Datos(2)
                        If Datos(2) = "PCA" Then .TextMatrix(J2, 1) = "PARAMETROS" + Space(80) + Datos(2)
                        If Datos(2) = "PCS" Then .TextMatrix(J2, 1) = "SWAPS" + Space(80) + Datos(2)
                        If Datos(2) = "SCF" Then .TextMatrix(J2, 1) = "CONTROL FINANCIERO" + Space(80) + Datos(2)
                        
                        If Datos(5) = "S" Then
                            
                            .TextMatrix(J2, 2) = "BLOQUEADO"
                        
                        Else
                                                    
                            .TextMatrix(J2, 2) = "DESBLOQUEADO"
                            
                        End If
                        
                        J2 = J2 + 1
                        Grilla2.Enabled = True
                        Grilla2.ColSel = 0
                        
                        If Grilla2.TextMatrix(1, 2) = "BLOQUEADO" Then
                            
                            Toolbar2.Buttons(1).Visible = True
                            Toolbar2.Buttons(2).Visible = False

                        Else
                            
                            Toolbar2.Buttons(1).Visible = False
                            Toolbar2.Buttons(2).Visible = True

                                                
                        End If
                        
                    End If
                    
                End If
                
            Loop
            
        End If

    End With

End Sub


Sub Detalle_usuario()

    If inicio = 1 Then

        
            GrillaTmp2.Rows = 1
            
            Sql2 = "SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS "
            
            
            If miSQL.SQL_Execute(Sql2) = 0 Then
                
            
               Do While Bac_SQL_Fetch(Datos())
                    
                    If Datos(1) = Grilla.TextMatrix(Grilla.Row, 1) Or Mid(Datos(1), 1, Len(Datos(1)) - 1) = Grilla.TextMatrix(Grilla.Row, 1) Then
                            
                        GrillaTmp2.Rows = GrillaTmp2.Rows + 1
                        GrillaTmp2.TextMatrix(GrillaTmp2.Rows - 1, 0) = Grilla.TextMatrix(Grilla.Row, 2)
                        
                    End If
                    
               Loop
               
            End If

    End If

    If GrillaTmp2.Rows <> Grilla3.Rows Then
    
        Call Grilla_EnterCell
    
    End If

End Sub


Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case Is = 1: DESBloquear_Sistema
        
        Case Is = 2: Bloquear_Sistema
        
    End Select
    
End Sub


Sub Bloquear_Sistema()
Dim Datos()
Dim m As String

'    Sql = "SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR "
'    Sql = Sql & "'" & Grilla.TextMatrix(Grilla.Row, 1)
'    Sql = Sql & "','" & Grilla.TextMatrix(Grilla.Row, 2)
'    Sql = Sql & "','" & Right(Grilla2.TextMatrix(Grilla2.Row, 1), 3)
'    Sql = Sql & "','S'"
    
    Envia = Array(Grilla.TextMatrix(Grilla.Row, 1), _
            Grilla.TextMatrix(Grilla.Row, 2), _
            Right(Grilla2.TextMatrix(Grilla2.Row, 1), 3), _
            "S")
    
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        Loop
    End If

    Grilla2.TextMatrix(Grilla2.Row, 2) = "BLOQUEADO"
    Toolbar2.Buttons(1).Visible = True
    Toolbar2.Buttons(2).Visible = False


End Sub



Sub DESBloquear_Sistema()
Dim Datos()
Dim m As String

'    Sql = "SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR "
'    Sql = Sql & "'" & Grilla.TextMatrix(Grilla.Row, 1)
'    Sql = Sql & "','" & Grilla.TextMatrix(Grilla.Row, 2)
'    Sql = Sql & "','" & Right(Grilla2.TextMatrix(Grilla2.Row, 1), 3)
'    Sql = Sql & "','N'"
    
    Envia = Array(Grilla.TextMatrix(Grilla.Row, 1), _
            Grilla.TextMatrix(Grilla.Row, 2), _
            Right(Grilla2.TextMatrix(Grilla2.Row, 1), 3), _
            "N")
    
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        Loop
    End If

    Grilla2.TextMatrix(Grilla2.Row, 2) = "DESBLOQUEADO"
    Toolbar2.Buttons(1).Visible = False
    Toolbar2.Buttons(2).Visible = True

End Sub

Private Sub Toolbar3_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case Is = 1:
        
        Case Is = 2: Bloquear_Usuario
        
    End Select

End Sub

Sub Bloquear_Usuario()
Dim Datos()
Dim m As String

'    Sql = "SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_US "
'    Sql = Sql & "'" & Grilla.TextMatrix(Grilla.Row, 1)
'    Sql = Sql & "','" & Right(Grilla3.TextMatrix(Grilla3.Row, 1), 3)
'    Sql = Sql & "','" & Trim(Grilla3.TextMatrix(Grilla3.Row, 2))
'    Sql = Sql & "','N'"
    
    Envia = Array(Grilla.TextMatrix(Grilla.Row, 1), _
            Right(Grilla3.TextMatrix(Grilla3.Row, 1), 3), _
            Trim(Grilla3.TextMatrix(Grilla3.Row, 2)), _
            "N")
            
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_US", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        Loop
    End If

End Sub



'''''''Sub DESBloquear_Usuario()
'''''''Dim datos()
'''''''Dim M As String
'''''''
'''''''    Sql = "SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_US "
'''''''    Sql = Sql & "'" & Grilla.TextMatrix(Grilla.Row, 1)
'''''''    Sql = Sql & "','" & Grilla.TextMatrix(Grilla.Row, 2)
'''''''    Sql = Sql & "','" & Right(Grilla3.TextMatrix(Grilla3.Row, 1), 3)
'''''''    Sql = Sql & "','N'"
'''''''
'''''''
'''''''    If Bac_SQL_Execute(" ",Envia) = 0 Then
'''''''
'''''''        Do While Bac_SQL_Fetch(Datos())
'''''''
'''''''
'''''''        Loop
'''''''
'''''''    End If
'''''''
'''''''    Grilla2.TextMatrix(Grilla2.Row, 2) = "DESBLOQUEADO"
'''''''
'''''''End Sub


Sub Bloquea_Sistemas_Usuario()
Dim Datos()
Dim m As String

'    Sql = "SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_SISTEMAS_US "
'    Sql = Sql & "'" & Grilla.TextMatrix(Grilla.Row, 1)
'    Sql = Sql & "','" & Grilla.TextMatrix(Grilla.Row, 2)
'    Sql = Sql & "','" & Right(Grilla3.TextMatrix(Grilla3.Row, 1), 3)
'    Sql = Sql & "','S'"
    
    Envia = Array(Grilla.TextMatrix(Grilla.Row, 1), _
            Grilla.TextMatrix(Grilla.Row, 2), _
            Right(Grilla3.TextMatrix(Grilla3.Row, 1), 3), _
            "S")
            
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_SISTEMAS_US", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        Loop
    End If

    Grilla2.TextMatrix(Grilla2.Row, 2) = "BLOQUEADO"
    Grilla_EnterCell

End Sub

Sub DesBloquea_Sistemas_Usuario()
Dim Datos()
Dim m As String

'    Sql = "SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_SISTEMAS_US "
'    Sql = Sql & "'" & Grilla.TextMatrix(Grilla.Row, 1)
'    Sql = Sql & "','" & Grilla.TextMatrix(Grilla.Row, 2)
'    Sql = Sql & "','" & Right(Grilla3.TextMatrix(Grilla3.Row, 1), 3)
'    Sql = Sql & "','N'"
    
    Envia = Array(Grilla.TextMatrix(Grilla.Row, 1), _
            Grilla.TextMatrix(Grilla.Row, 2), _
            Right(Grilla3.TextMatrix(Grilla3.Row, 1), 3), _
            "N")
    
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_SISTEMAS_US", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        Loop
    End If

    Grilla2.TextMatrix(Grilla2.Row, 2) = "DESBLOQUEADO"
    Grilla_EnterCell

End Sub

