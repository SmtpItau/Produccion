VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Control_Bloq_Usuarios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Control y Bloqueo de Usuarios"
   ClientHeight    =   3090
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9600
   Icon            =   "Control_Bloq_Usuarios.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3090
   ScaleWidth      =   9600
   Begin VB.Frame Frame1 
      Height          =   2535
      Left            =   0
      TabIndex        =   2
      Top             =   510
      Width           =   9585
      Begin MSFlexGridLib.MSFlexGrid Grilla2 
         Height          =   2115
         Left            =   7260
         TabIndex        =   4
         Top             =   240
         Visible         =   0   'False
         Width           =   2235
         _ExtentX        =   3942
         _ExtentY        =   3731
         _Version        =   393216
         FixedCols       =   0
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   2235
         Left            =   75
         TabIndex        =   3
         Top             =   165
         Width           =   9450
         _ExtentX        =   16669
         _ExtentY        =   3942
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   12632256
         GridColorFixed  =   16777215
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
         FormatString    =   ""
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   1215
      Left            =   -15
      TabIndex        =   0
      Top             =   -60
      Width           =   9840
      _Version        =   65536
      _ExtentX        =   17357
      _ExtentY        =   2143
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
         Left            =   0
         TabIndex        =   1
         Top             =   60
         Width           =   9705
         _ExtentX        =   17119
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         Appearance      =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   3
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Desbloquear"
               ImageIndex      =   1
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Bloquear"
               ImageIndex      =   2
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Salir"
               ImageIndex      =   3
            EndProperty
         EndProperty
         Begin VB.Timer Timer1 
            Interval        =   25
            Left            =   3360
            Top             =   0
         End
         Begin MSComctlLib.ImageList ImageList1 
            Left            =   5160
            Top             =   -15
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
   End
End
Attribute VB_Name = "Control_Bloq_Usuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim colpress As Long
Dim rowpress As Long

Private Sub Form_Load()

   Carga_Grilla

End Sub

Private Sub Grilla_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    colpress = grilla.Col
    rowpress = grilla.Row
    grilla.ColSel = grilla.Cols - 1

End Sub

Private Sub Grilla_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

    grilla.Col = colpress
    grilla.Row = rowpress
    grilla.ColSel = grilla.Cols - 1
    
End Sub

Private Sub Timer1_Timer()
    
    If grilla.Rows > 1 Then
         
         Toolbar1.Buttons(1).Enabled = True
         Toolbar1.Buttons(2).Enabled = True
         
         If grilla.TextMatrix(grilla.Row, 4) = "DESBLOQUEADO" Then
             
             Toolbar1.Buttons(1).Visible = False
             Toolbar1.Buttons(2).Visible = True
         
         Else
             
             Toolbar1.Buttons(2).Visible = False
             Toolbar1.Buttons(1).Visible = True
         
         End If
         
         With Grilla2
           
           .Rows = 1
         
           Sql = "SP_CONTROL_BLOQ_USUARIOS_LEE"
           
           If MISQL.SQL_Execute(Sql) = 0 Then
              
                    
              Do While MISQL.SQL_Fetch(Datos()) = 0
              
                 If Datos(1) <> "ERROR" Then
                          
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, 0) = Datos(1)
                    .TextMatrix(.Rows - 1, 1) = Datos(5)
                 
                  End If
              
              Loop
                 
           End If
                 
           .Col = 0
              
           If grilla.Rows < .Rows Then
           
                 Carga_Grilla
           
           End If
           
           If grilla.Rows > .Rows Then
           
                 Carga_Grilla
                 
           End If
              
        End With

    Else
    
        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = False
        Toolbar1.Buttons(1).Visible = False
    
             With Grilla2
           
           .Rows = 1
         
           Sql = "SP_CONTROL_BLOQ_USUARIOS_LEE"
           
           If MISQL.SQL_Execute(Sql) = 0 Then
              
                    
              Do While MISQL.SQL_Fetch(Datos()) = 0
              
                 If Datos(1) <> "ERROR" Then
                          
                    .Rows = .Rows + 1
                    .TextMatrix(.Rows - 1, 0) = Datos(1)
                    .TextMatrix(.Rows - 1, 1) = Datos(5)
                 
                  End If
              
              Loop
                 
           End If
                 
           .Col = 0
              
           If grilla.Rows < .Rows Then
           
                 Carga_Grilla
           
           End If
           
           If grilla.Rows > .Rows Then
           
                 Carga_Grilla
                 
           End If
              
        End With

    End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   
      Case Is = 1: DESBLOQUEAR_USUARIO
   
      Case Is = 2: BLOQUEAR_USUARIO
   
      Case Is = 3: Unload Me
   
   End Select

End Sub

Sub Carga_Grilla()
Dim Datos()
Dim Estado As String
Dim SW As Integer

SW = 0

   With grilla
      
      .Enabled = False
      .Row = 0
      .Rows = 1
      .ColWidth(0) = 0
      .ColWidth(1) = 2000
      .ColWidth(2) = 2000
      .ColWidth(3) = 3000
      .ColWidth(4) = 2000
      .TextMatrix(0, 1) = "Usuario"
      .TextMatrix(0, 2) = "Sistema"
      .TextMatrix(0, 3) = "Nombre"
      .TextMatrix(0, 4) = "Estado"
      .Col = 1
      .CellFontBold = True
      .Col = 2
      .CellFontBold = True
      .Col = 3
      .CellFontBold = True
      .Col = 4
      .CellFontBold = True
      
      Sql = "SP_CONTROL_BLOQ_USUARIOS_LEE"
      
      If MISQL.SQL_Execute(Sql) = 0 Then
         
               
         Do While MISQL.SQL_Fetch(Datos()) = 0
         
            If Datos(1) <> "ERROR" Then
                     
               .Enabled = True
               .Rows = .Rows + 1
               .TextMatrix(.Rows - 1, 1) = Datos(1)
               .TextMatrix(.Rows - 1, 2) = Datos(6) + Space(100) + Datos(7)
               .TextMatrix(.Rows - 1, 3) = Datos(3)
               
               If Datos(5) = "S" Then Estado = "BLOQUEADO"
               
               If Datos(5) = "N" Then Estado = "DESBLOQUEADO"
               
               .TextMatrix(.Rows - 1, 4) = Estado
            
             End If
         
         Loop
            
      End If
            
      .Col = 0
         
   End With
  
End Sub


Sub BLOQUEAR_USUARIO()
Dim Datos()
Dim m As String

    Sql = "SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR "
    Sql = Sql & "'" & grilla.TextMatrix(grilla.Row, 1) & "'"
    Sql = Sql & ",'" & grilla.TextMatrix(grilla.Row, 3) & "'"
    Sql = Sql & ",'" & Right(grilla.TextMatrix(grilla.Row, 2), 3) & "'"

    If MISQL.SQL_Execute(Sql) = 0 Then
    
        Do While MISQL.SQL_Fetch(Datos()) = 0
        
                            
        Loop
        
    End If
    
    grilla.TextMatrix(grilla.Row, 4) = "BLOQUEADO"
    Grilla2.TextMatrix(grilla.Row, 1) = "S"

End Sub

Sub DESBLOQUEAR_USUARIO()
Dim Datos()

    Sql = "SP_CONTROL_BLOQ_USUARIOS_DESBLOQUEAR "
    Sql = Sql & "'" & grilla.TextMatrix(grilla.Row, 1) & "'"
    Sql = Sql & ",'" & grilla.TextMatrix(grilla.Row, 3) & "'"
    Sql = Sql & ",'" & Right(grilla.TextMatrix(grilla.Row, 2), 3) & "'"

    If MISQL.SQL_Execute(Sql) = 0 Then
    
        Do While MISQL.SQL_Fetch(Datos()) = 0
        
                            
        Loop
        
    End If
    
    grilla.TextMatrix(grilla.Row, 4) = "DESBLOQUEADO"
    Grilla2.TextMatrix(grilla.Row, 1) = "N"
    
       
End Sub
