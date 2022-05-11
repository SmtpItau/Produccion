VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntOperador 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Operadores"
   ClientHeight    =   3930
   ClientLeft      =   3090
   ClientTop       =   1665
   ClientWidth     =   6765
   Icon            =   "BacMntOperador.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3930
   ScaleWidth      =   6765
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   6765
      _ExtentX        =   11933
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
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3345
      Left            =   0
      TabIndex        =   12
      Top             =   540
      Width           =   6765
      _Version        =   65536
      _ExtentX        =   11933
      _ExtentY        =   5900
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
      Begin Threed.SSFrame Frame 
         Height          =   885
         Index           =   0
         Left            =   60
         TabIndex        =   13
         Top             =   15
         Width           =   6630
         _Version        =   65536
         _ExtentX        =   11695
         _ExtentY        =   1561
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
         Begin VB.TextBox TxtNombre 
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
            Left            =   915
            MaxLength       =   40
            TabIndex        =   4
            Top             =   480
            Width           =   5640
         End
         Begin VB.TextBox txtDigito 
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
            Left            =   2355
            MaxLength       =   1
            TabIndex        =   2
            Top             =   150
            Width           =   255
         End
         Begin VB.TextBox txtRut 
            Alignment       =   1  'Right Justify
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
            Left            =   915
            MaxLength       =   10
            MouseIcon       =   "BacMntOperador.frx":030A
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   1
            Top             =   150
            Width           =   1140
         End
         Begin VB.TextBox txtcodcli 
            Alignment       =   1  'Right Justify
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
            Left            =   5115
            MaxLength       =   10
            MouseIcon       =   "BacMntOperador.frx":0614
            MultiLine       =   -1  'True
            TabIndex        =   3
            Top             =   150
            Width           =   1440
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H80000004&
            Caption         =   "Nombre"
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
            Index           =   3
            Left            =   75
            TabIndex        =   17
            Top             =   525
            Width           =   660
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   18
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   630
            Index           =   16
            Left            =   2115
            TabIndex        =   16
            Top             =   45
            Width           =   150
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H80000004&
            Caption         =   "Rut"
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
            Index           =   2
            Left            =   75
            TabIndex        =   15
            Top             =   195
            Width           =   315
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H80000004&
            Caption         =   "Codigo Cliente"
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
            Index           =   4
            Left            =   3555
            TabIndex        =   14
            Top             =   210
            Width           =   1245
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   2430
         Index           =   1
         Left            =   60
         TabIndex        =   18
         Top             =   855
         Width           =   6630
         _Version        =   65536
         _ExtentX        =   11695
         _ExtentY        =   4286
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
         Begin VB.TextBox Txtrut_col 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00800000&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   300
            Left            =   150
            MaxLength       =   9
            MultiLine       =   -1  'True
            TabIndex        =   6
            Text            =   "BacMntOperador.frx":091E
            Top             =   615
            Width           =   960
         End
         Begin VB.TextBox Txtglosa_col 
            BackColor       =   &H00800000&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   300
            Left            =   1110
            MaxLength       =   40
            MultiLine       =   -1  'True
            TabIndex        =   7
            Text            =   "BacMntOperador.frx":0924
            Top             =   615
            Width           =   960
         End
         Begin VB.VScrollBar VScroll1 
            Height          =   135
            Left            =   4560
            TabIndex        =   19
            Top             =   120
            Visible         =   0   'False
            Width           =   975
         End
         Begin MSFlexGridLib.MSFlexGrid grilla 
            Height          =   2250
            Left            =   45
            TabIndex        =   5
            Top             =   120
            Width           =   6540
            _ExtentX        =   11536
            _ExtentY        =   3969
            _Version        =   393216
            FixedCols       =   0
            RowHeightMin    =   315
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483645
            GridColor       =   16777215
            GridColorFixed  =   16777215
            WordWrap        =   -1  'True
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6210
      Top             =   0
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
            Picture         =   "BacMntOperador.frx":092A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntOperador.frx":0D7C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntOperador.frx":11CE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntOperador.frx":14E8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame Frame 
      Height          =   2160
      Index           =   3
      Left            =   7425
      TabIndex        =   0
      Top             =   1035
      Visible         =   0   'False
      Width           =   3225
      _Version        =   65536
      _ExtentX        =   5689
      _ExtentY        =   3810
      _StockProps     =   14
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   780
         Left            =   285
         ScaleHeight     =   720
         ScaleWidth      =   2100
         TabIndex        =   9
         Top             =   330
         Width           =   2160
      End
      Begin VB.Label Label 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Label(1)"
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   330
         TabIndex        =   11
         Top             =   1620
         Width           =   1860
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Index           =   0
         Left            =   330
         TabIndex        =   10
         Top             =   1275
         Width           =   1860
      End
   End
End
Attribute VB_Name = "BacMntOperador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objCliente         As Object
Private Objrutcli          As Object
Dim FRM_ESTADO             As Integer


Function APHabilitarControles(Valor As Boolean)

   txtRut.Enabled = Not Valor
   txtDigito.Enabled = Not Valor
   TxtNombre.Enabled = Valor
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor

End Function

Sub APLimpiar()

   txtRut.Text = ""
   txtDigito.Text = ""
   TxtNombre.Text = ""
   txtcodcli.Text = ""
   Call APHabilitarControles(False)
   txtRut.SetFocus

End Sub

Private Sub cmdEliminar_Click()
grilla.Col = 0
   Dim idrutcli      As Long
   Dim a             As Integer
   Dim iok           As Integer

a = MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo, TITSISTEMA)
If a = 6 Then
    opecod = grilla.Text
       
     eliminame = 100
     If Objrutcli.EliminarOperador(txtRut.Text, txtcodcli.Text) = False Then
        Screen.MousePointer = 0
        MsgBox "no se puede  eliminar en tabla apoderado ", 16, TITSISTEMA
        Exit Sub
     Else
     End If
        Txtrut_col.Text = ""
        Txtrut_col.Visible = False
        Txtglosa_col.Text = ""
        Txtglosa_col.Visible = False
     
       grilla.Enabled = True
     
    With grilla
     
     If .Rows > 2 Then
           
         If Trim$(.TextMatrix(.Row, 0)) <> "" Then
                'row = .row
               .RemoveItem .Row
               .SetFocus
               'Call EstadoGrilla(Grilla)
               Exit Sub
          End If
      End If
    End With
End If

      


End Sub

Private Sub cmdGrabar_Click()

   Dim idrutcli   As String
   Dim iddigito   As String
   Dim idrutapo   As String
   Dim IdOpcion   As Integer

  
    Txtrut_col.Text = ""
    Txtrut_col.Visible = False
    Txtglosa_col.Text = ""
    Txtglosa_col.Visible = False
   
   
      If Valida_Ingreso(grilla) = False Then
          Txtglosa_col.Visible = False
           Exit Sub
       End If
      
   
    Screen.MousePointer = 11
  
   FRM_ESTADO% = False
    eliminame = 50
    If Objrutcli.EliminarOperador(txtRut.Text, txtcodcli.Text) = False Then
          Screen.MousePointer = 0
         MsgBox "no se puede  eliminar en tabla apoderado ", 16, TITSISTEMA
         Exit Sub
    Else
    End If
    
    'Call Objrutcli.LimpiaGrilla(grilla)
    'Call Objrutcli.RefrescaOpe(grilla)
    
   
      If Objrutcli.GrabarOperadores(grilla, txtRut.Text, txtcodcli.Text) = True Then
             Screen.MousePointer = 0
             MsgBox "Grabación se realizó con exito", 64, TITSISTEMA
      Else
            Screen.MousePointer = 0
            MsgBox "No se puede grabar en tabla apoderado", 16, TITSISTEMA
            Exit Sub
      End If
      
      Call BacLimpiaGrilla(grilla)
      Call BacIniciaGrilla(8, 2, 1, 0, True, grilla)
      Call CargarParam_op(grilla)
      Call APLimpiar
      txtcodcli.Enabled = True
      grilla.Enabled = False
       

   Screen.MousePointer = 0
  

End Sub

Private Sub cmdlimpiar_Click()

    Call BacLimpiaGrilla(grilla)
    Call BacIniciaGrilla(8, 2, 1, 0, True, grilla)
    'Call BacAgrandaGrilla(Grilla, 40)
    Call CargarParam_op(grilla)
    grilla.Enabled = False
    txtcodcli.Enabled = True
    Txtrut_col.Text = ""
    Txtrut_col.Visible = False
    Txtglosa_col.Text = ""
    Txtglosa_col.Visible = False
    Call APLimpiar
   
End Sub
Private Sub cmdSalir_Click()
    Unload Me

End Sub



Private Sub Form_Activate()

 'Call BacIniciaGrilla(8, 2, 1, 0, False, grilla)
   
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      SendKeys "{TAB}"

   End If

End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
   
   Dim iCol       As Integer

   Set objCliente = New clsCliente
   Set Objrutcli = New clsOperador

    Call BacIniciaGrilla(8, 2, 1, 0, False, grilla)
    Call CargarParam_op(grilla)
    
    Call APHabilitarControles(False)
    grilla.Col = 0
    grilla.Row = grilla.FixedRows
    
    TxtNombre.Enabled = False
    Txtrut_col.Text = ""
    Txtrut_col.Visible = False
    Txtglosa_col.Text = ""
    Txtglosa_col.Visible = False

    grilla.Rows = 2

    Call Grabar_Log_AUDITORIA(gsEntidad _
                                 , gsbac_fecp _
                                 , gsBac_IP _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_22" _
                                 , "07" _
                                 , "Usuario entra en Mantención Operadores" _
                                 , " " _
                                 , " " _
                                 , " ")
   

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set objCliente = Nothing
   Set Objrutcli = Nothing

   Call Grabar_Log_AUDITORIA(gsEntidad _
                                 , gsbac_fecp _
                                 , gsBac_IP _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_22" _
                                 , "08" _
                                 , "Usuario Sale de Mantención Operadores" _
                                 , " " _
                                 , " " _
                                 , " ")


End Sub

Private Sub grilla_DblClick()
 
 grilla_KeyPress 13

End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

   
   If KeyCode = 46 Then
   
     If (grilla.TextMatrix(grilla.Row, 0) = "" Or grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows > 2 Then
     
         grilla.RemoveItem (grilla.Row)
         grilla.SetFocus
         Exit Sub
     
     End If
   
     If (grilla.TextMatrix(grilla.Row, 0) = "" Or grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows = 2 Then
     
         grilla.Rows = 1
         grilla.Rows = 2
         Exit Sub
     
     End If
   
      Call Eliminar
   
   End If
   
   If KeyCode = 45 Then
   
      If grilla.TextMatrix(grilla.Rows - 1, 0) <> "" And grilla.TextMatrix(grilla.Rows - 1, 0) <> "" Then
      
        grilla.Rows = grilla.Rows + 1
        grilla.SetFocus
      
      End If
   
   End If
   
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)

Dim row_tem%
    
    
With grilla
        
  
'''''''     If .Rows - 1 = .Row Then
'''''''        .Rows = .Rows + 1
'''''''     End If
      
 If .Col = 0 Then
           
    If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
        
         row_tem = .Row
              
             If Valida_Ingreso(grilla) = False Then
                Exit Sub
             End If
                
            .Row = row_tem
            .Col = 0
        
        PROC_POSICIONA_TEXTO grilla, Txtrut_col
        .Enabled = False
        Txtrut_col.Visible = True
        If IsNumeric(Chr(KeyAscii)) Then
            Txtrut_col.Text = Chr(KeyAscii)
            SendKeys "{RIGHT}"    'Comienzo Izquierda
        Else
            Txtrut_col.Text = .TextMatrix(.Row, .Col)
            SendKeys "{END}"
        End If
        Txtrut_col.SetFocus
        
        'SendKeys "{END}"     'Comienzo Derecha
    End If
           
End If
    
    
   If .Col = 1 Then         ' 32 SPACE
      
     If KeyAscii > 0 And KeyAscii <> 27 Then
        
        If Trim(.TextMatrix(.Row, 0)) = "" Then
            MsgBox " Debe Ingresar Codigo Del Operador ", vbCritical, TITSISTEMA
            .Col = 0
            .SetFocus
            Exit Sub
        End If
        PROC_POSICIONA_TEXTO grilla, Txtglosa_col
        .Enabled = False
        Txtglosa_col.Visible = True
        If KeyAscii = 13 Then
           Txtglosa_col.Text = .TextMatrix(.Row, .Col)
           SendKeys "{END}"     'Comienzo Derecha
        Else
           Txtglosa_col.Text = UCase(Chr(KeyAscii))
           SendKeys "{RIGHT}"    'Comienzo Izquierda
        End If
        Txtglosa_col.SetFocus
        
        'SendKeys "{END}"     'Comienzo Derecha
    
    End If
  End If
        
    
 End With

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1
   Dim idrutcli   As String
   Dim iddigito   As String
   Dim idrutapo   As String
   Dim IdOpcion   As Integer

  
    Txtrut_col.Text = ""
    Txtrut_col.Visible = False
    Txtglosa_col.Text = ""
    Txtglosa_col.Visible = False
   
   
      If Valida_Ingreso_graba(grilla) = False Then
          Txtglosa_col.Visible = False
           Exit Sub
       End If
      
   
    Screen.MousePointer = 11
  
   FRM_ESTADO% = False
    eliminame = 50
    If Objrutcli.EliminarOperador(txtRut.Text, txtcodcli.Text) = False Then
          Screen.MousePointer = 0
         MsgBox "no se puede  eliminar en tabla apoderado ", 16, TITSISTEMA
         Exit Sub
    Else
    End If
    
    'Call Objrutcli.LimpiaGrilla(grilla)
    'Call Objrutcli.RefrescaOpe(grilla)
    
   
      If Objrutcli.GrabarOperadores(grilla, txtRut.Text, txtcodcli.Text) = True Then
             Screen.MousePointer = 0
             Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_22 " _
                                    , "01" _
                                    , "Grabacion De Operador Correcta " _
                                    , "CLIENTE_OPERADOR" _
                                    , " " _
                                    , "GRABA OPERADORES CLIENTE : " & TxtNombre.Text)
             MsgBox "Grabación se realizó con exito", 64, TITSISTEMA
      Else
            Screen.MousePointer = 0
            MsgBox "No se puede grabar en tabla apoderado", 16, TITSISTEMA
            Exit Sub
      End If
      
      'Call BacLimpiaGrilla(Grilla)
      'Call BacIniciaGrilla(8, 2, 1, 0, True, Grilla)
      'Call CargarParam_op(Grilla)
      Call APLimpiar
      txtcodcli.Enabled = True
      grilla.Enabled = False
      grilla.Row = 1
      grilla.Col = 0
      grilla.Rows = 1
      grilla.Rows = 2


   Screen.MousePointer = 0
Case 2
   
   
     If (grilla.TextMatrix(grilla.Row, 0) = "" Or grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows > 2 Then
     
         grilla.RemoveItem (grilla.Row)
         grilla.SetFocus
         Exit Sub
     
     End If
   
      Call Eliminar
   
   
'''''''''''''''   Grilla.Col = 0
'''''''''''''''   Dim a             As Integer
'''''''''''''''   Dim iok           As Integer
'''''''''''''''
'''''''''''''''a = MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo)
'''''''''''''''If a = 6 Then
'''''''''''''''    opecod = Grilla.Text
'''''''''''''''
'''''''''''''''     eliminame = 100
'''''''''''''''     If Objrutcli.EliminarOperador(txtrut.Text, txtcodcli.Text) = False Then
'''''''''''''''        Screen.MousePointer = 0
'''''''''''''''        MsgBox "no se puede  eliminar en tabla apoderado ", 16, gsPARAMS_Version
'''''''''''''''        Exit Sub
'''''''''''''''     Else
'''''''''''''''     End If
'''''''''''''''        Txtrut_col.Text = ""
'''''''''''''''        Txtrut_col.Visible = False
'''''''''''''''        Txtglosa_col.Text = ""
'''''''''''''''        Txtglosa_col.Visible = False
'''''''''''''''
'''''''''''''''       Grilla.Enabled = True
'''''''''''''''
'''''''''''''''    With Grilla
'''''''''''''''
'''''''''''''''     If .Rows > 2 Then
'''''''''''''''
'''''''''''''''         If Trim$(.TextMatrix(.Row, 0)) <> "" Then
'''''''''''''''                'row = .row
'''''''''''''''               .RemoveItem .Row
'''''''''''''''               .SetFocus
'''''''''''''''               'Call EstadoGrilla(Grilla)
'''''''''''''''               Exit Sub
'''''''''''''''          End If
'''''''''''''''      End If
'''''''''''''''    End With
'''''''''''''''End If

   

Case 3
    'Call BacLimpiaGrilla(Grilla)
    'Call BacIniciaGrilla(8, 2, 1, 0, True, Grilla)
    'Call BacAgrandaGrilla(Grilla, 40)
    'Call CargarParam_op(Grilla)
    'Grilla.Col = 0
    'Grilla.Row = Grilla.FixedRows
    grilla.Enabled = False
    txtcodcli.Enabled = True
    Txtrut_col.Text = ""
    Txtrut_col.Visible = False
    Txtglosa_col.Text = ""
    Txtglosa_col.Visible = False
    Call APLimpiar
    grilla.Rows = 1
    grilla.Rows = 2
    
    
Case 4
   Unload Me
End Select

End Sub

Private Sub txtcodcli_KeyPress(KeyAscii As Integer)
  
  BacSoloNumeros KeyAscii
  
   If Trim$(txtcodcli.Text) <> "" Then
   
     If KeyAscii = 13 Then
         KeyAscii = 0
         SendKeys "{tab}"
         
      End If
      
   End If
   
   If KeyAscii = 13 Then
         KeyAscii = 0
   End If
   
End Sub

Private Sub txtcodcli_LostFocus()
   
   Dim idRut     As String
   Dim IdDig     As String
   Dim Idcodcli  As String
   Dim lValor  As Boolean
   
   idRut = txtRut.Text
   IdDig = txtDigito.Text
   Idcodcli = txtcodcli.Text
   lValor = True

   If txtRut.Text = "" Or txtDigito.Text = "" Or txtcodcli.Text = "" Then
      Exit Sub
   End If

   Screen.MousePointer = 11

   If Controla_RUT(txtRut, txtDigito) = True Then
      
      objCliente.clrut = txtRut.Text
      objCliente.cldv = txtDigito.Text
      objCliente.clcodigo = txtcodcli.Text

      
      If objCliente.LeerxRut(objCliente.clrut, objCliente.clcodigo) Then
         
         If objCliente.clrut <> 0 Then
            'TxtNombre.Text = objCliente.clnombre
             TxtNombre.Text = gsNombre$
            TxtNombre.Tag = TxtNombre.Text
          
         Else
             MsgBox "Error : No existe , Rut o el Codigo del Cliente ", 16, TITSISTEMA
             lValor = False
         
         End If

      Else
         Screen.MousePointer = 0
         MsgBox "Error : En Carga de Datos", 16, TITSISTEMA
         lValor = False
         Exit Sub

      End If
    
   Else
      Screen.MousePointer = 0
      MsgBox "Error : Rut Incorrecto", 16, TITSISTEMA
      lValor = False
   
   End If
   
   If Not (lValor) Then
      txtRut.Text = ""
      txtDigito.Text = ""
      txtcodcli.Text = ""
      Call APLimpiar
      Call APHabilitarControles(False)
      txtRut.SetFocus
      Screen.MousePointer = 0
      Exit Sub
    Else
      Call APHabilitarControles(True)
                      
    End If
   
    TxtNombre.Enabled = False
    
    ' Carga Grilla de operadores
    
    If Not objCliente.CargaOperador(grilla, CLng(idRut), CLng(Idcodcli), 0) Then
        Screen.MousePointer = 0
        Exit Sub
    Else
        grilla.Col = 0
        grilla.Row = 1
        'Call BacAgrandaGrilla(Grilla, 40)
        grilla.Enabled = True
        grilla.SetFocus
   End If
   
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(1).Enabled = True
        TxtNombre.Enabled = False
        txtcodcli.Enabled = False
   
        Screen.MousePointer = 0

End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn And Trim$(txtDigito.Text) <> "" Then
            SendKeys "{TAB}"
            Exit Sub
    End If

  If InStr("0123456789K", UCase(Chr(KeyAscii))) = 0 Then
       KeyAscii = 0
  End If

End Sub

Private Sub txtDigito_LostFocus()
   
   If Controla_RUT(txtRut, txtDigito) = True Then
      objCliente.clrut = txtRut.Text
      objCliente.cldv = txtDigito.Text
  Else
      MsgBox "Error : El Rut Esta Incorrecto", 16, TITSISTEMA
      Call APHabilitarControles(False)
      txtRut.SetFocus
      Exit Sub
     
  End If

 
End Sub

Private Sub Txtglosa_col_KeyPress(KeyAscii As Integer)

 With grilla
  
  KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  
    If KeyAscii = 13 Then
               
          '.ColAlignment(1) = 2
          .TextMatrix(.Row, .Col) = Txtglosa_col.Text
           Txtglosa_col.Text = ""
           .Enabled = True
           Txtglosa_col.Visible = False
          .SetFocus
      End If
   
   
     If KeyAscii = 27 Then
           Txtglosa_col.Text = ""
           Txtglosa_col.Visible = False
           .Enabled = True
          .SetFocus
     End If
     
 End With

End Sub

Private Sub Txtglosa_col_LostFocus()

   Txtglosa_col_KeyPress 27
   
'With grilla
'.ColAlignment(1) = 2
'.TextMatrix(.Row, .Col) = Txtglosa_col.Text
' Txtglosa_col.Text = ""
' .Enabled = True
' Txtglosa_col.Visible = False
'.SetFocus
'End With
End Sub

Private Sub Txtrut_col_KeyPress(KeyAscii As Integer)

 With grilla
  
  KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  
   If (KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 13 Or KeyAscii = 27 Or KeyAscii = 8 Then
  
      Else
         KeyAscii = 0
   End If
 
 
   If KeyAscii = 13 Then
        
        If bacBuscaRepetidoGrilla(0, grilla, Trim(Txtrut_col.Text)) = False Then
            
          If Trim$(Txtrut_col) = "" Then
            .TextMatrix(.Row, 0) = ""
            .TextMatrix(.Row, 1) = ""
          End If
            
            '.ColAlignment(0) = 8
            .TextMatrix(.Row, 0) = ""
            .TextMatrix(.Row, 0) = Trim(Txtrut_col.Text)
             Txtrut_col.Visible = False
            .Enabled = True
            .Col = 0
            .SetFocus
             Exit Sub
        Else
             KeyAscii = 0
             Exit Sub
        End If
             
        
    End If
   
   
     If KeyAscii = 27 Then
           Txtrut_col.Text = ""
           Txtrut_col.Visible = False
           .Enabled = True
          .SetFocus
     End If
     
 End With
 
End Sub

Private Sub Txtrut_col_LostFocus()

   Txtrut_col_KeyPress 27
   
'With grilla
'        If bacBuscaRepetidoGrilla(0, grilla, Trim(Txtrut_col.Text)) = False Then
'
'          If Trim$(Txtrut_col) = "" Then
'            .TextMatrix(.Row, 0) = ""
'            .TextMatrix(.Row, 1) = ""
'          End If
'
'            .ColAlignment(0) = 8
'            .TextMatrix(.Row, 0) = ""
'            .TextMatrix(.Row, 0) = Trim(Txtrut_col.Text)
'             Txtrut_col.Visible = False
'            .Enabled = True
'            .Col = 0
'            .SetFocus
'             Exit Sub
'        Else
'             Exit Sub
'        End If
'End With
End Sub

Private Sub txtRut_DblClick()

   ' BacAyuda.Tag = "MDCL_U" --orgiginal
   ' BacAyuda.Show 1
   BacAyudaCliente.Tag = "MDCL_U"
   BacAyudaCliente.Show 1
    
    If giAceptar% = True Then
    
        txtRut.Text = CDbl(gsCodigo$)
        txtDigito.Text = gsDigito$
        txtcodcli.Text = gsCodCli
        
        txtcodcli.SetFocus
        SendKeys "{ENTER}"
    
    End If

End Sub

Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyF3 Then Call txtRut_DblClick

End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
   
 BacSoloNumeros KeyAscii
 
   If KeyAscii% = vbKeyReturn And Trim$(txtRut.Text) <> "" Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub

Public Function CargarParam_op(Grillas As Object)

     With Grillas
 
         .Enabled = True
         .Row = 0
         .RowHeight(0) = 400
         .CellFontWidth = 4         ' TAMAÑO
         .ColWidth(0) = 1330
         .ColWidth(1) = 4940
         

         .Row = 0

         .Col = 0
         .CellFontBold = True       'RESALSE
         .FixedAlignment(0) = 4
         .Text = "   Codigo "

         .Col = 1
         .CellFontBold = True       'RESALSE
         .FixedAlignment(1) = 4
         .Text = " Nombre del Operador  "

    End With

End Function

Public Function Valida_Ingreso_graba(obj As Object) As Boolean

Dim Fila%
Valida_Ingreso_graba = True

grilla.Enabled = True

With obj
  
    For Fila = 1 To .Rows - 1
      
      '.Row = Fila
       
      If Trim$(.TextMatrix(Fila, 0)) <> "" And Trim$(.TextMatrix(Fila, 1)) = "" Then
           Screen.MousePointer = 0
           MsgBox "Falta Ingresar el Nombre a Un Operador", 16, TITSISTEMA
          
           Valida_Ingreso_graba = False
           .Col = 0
           .SetFocus
           Exit Function
       End If
         
   Next Fila
              
End With
        
End Function


Public Function Valida_Ingreso(obj As Object) As Boolean

Dim Fila%
Valida_Ingreso = True

grilla.Enabled = True

With obj
  
    For Fila = 1 To .Rows - 1
      
      .Row = Fila
       
      If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 1)) = "" Then
           'Screen.MousePointer = 0
          ' MsgBox "Falta Ingresar el Nombre a Un Operador", 16, gsPARAMS_Version
          
          ' Valida_Ingreso = False
          PROC_POSICIONA_TEXTO grilla, Txtrut_col
            .Col = 0
           
           Exit Function
       End If
         
   Next Fila
              
End With
        
End Function


Sub Eliminar()

   grilla.Col = 0
   Dim a             As Integer
   Dim iok           As Integer

On Error GoTo ErrorF:

a = MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo, TITSISTEMA)

If a = 6 Then
    
     If (grilla.TextMatrix(grilla.Row, 0) = "" Or grilla.TextMatrix(grilla.Row, 1) = "") And grilla.Rows > 2 Then
     
         grilla.RemoveItem (grilla.Row)
         grilla.SetFocus
         Exit Sub
     
     End If
    
    
     If grilla.Rows = 2 Then
     
         grilla.Rows = 1
         grilla.Rows = 2
         grilla.SetFocus
         Exit Sub
      
     End If
    
     opecod = grilla.Text
       
     eliminame = 100
     
     If Objrutcli.EliminarOperador(txtRut.Text, txtcodcli.Text) = False Then
        Screen.MousePointer = 0
        MsgBox "no se puede  eliminar en tabla apoderado ", 16, TITSISTEMA
        Exit Sub
     End If
        Txtrut_col.Text = ""
        Txtrut_col.Visible = False
        Txtglosa_col.Text = ""
        Txtglosa_col.Visible = False
        'Grilla.Rows = 1
        'Grilla.Rows = 2
        
     
       grilla.Enabled = True
     
    With grilla
     
     If .Rows > 2 Then
           
         If Trim$(.TextMatrix(.Row, 0)) <> "" Then
                'row = .row
               .RemoveItem .Row
               .SetFocus
               'Call EstadoGrilla(Grilla)
               Exit Sub
          End If
      End If
    
    End With

End If

    grilla.SetFocus

ErrorF:

End Sub


Sub Limpiar()

   Set objCliente = New clsCliente
   Set Objrutcli = New clsOperador

    Call BacIniciaGrilla(8, 2, 1, 0, False, grilla)
    Call CargarParam_op(grilla)
    
    Call APHabilitarControles(False)
    grilla.Col = 0
    grilla.Row = grilla.FixedRows
    
    TxtNombre.Enabled = False
    Txtrut_col.Text = ""
    Txtrut_col.Visible = False
    Txtglosa_col.Text = ""
    Txtglosa_col.Visible = False

    grilla.Rows = 2

End Sub
