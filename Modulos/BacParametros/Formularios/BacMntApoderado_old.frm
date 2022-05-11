VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntApoderado 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Apoderados"
   ClientHeight    =   3600
   ClientLeft      =   1560
   ClientTop       =   2070
   ClientWidth     =   7200
   Icon            =   "BacMntApoderado.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3600
   ScaleWidth      =   7200
   Begin Threed.SSPanel SSPanel1 
      Height          =   3015
      Left            =   0
      TabIndex        =   14
      Top             =   540
      Width           =   7185
      _Version        =   65536
      _ExtentX        =   12674
      _ExtentY        =   5318
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
         Left            =   5970
         MaxLength       =   10
         MouseIcon       =   "BacMntApoderado.frx":030A
         MultiLine       =   -1  'True
         TabIndex        =   3
         Top             =   150
         Width           =   1095
      End
      Begin Threed.SSFrame Frame 
         Height          =   870
         Index           =   0
         Left            =   60
         TabIndex        =   15
         Top             =   15
         Width           =   7065
         _Version        =   65536
         _ExtentX        =   12462
         _ExtentY        =   1535
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
            BackColor       =   &H00FFFFFF&
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
            Left            =   900
            MaxLength       =   40
            TabIndex        =   4
            Top             =   480
            Width           =   6105
         End
         Begin VB.TextBox txtDigito 
            BackColor       =   &H00FFFFFF&
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
            Left            =   2175
            MaxLength       =   1
            TabIndex        =   2
            Top             =   135
            Width           =   255
         End
         Begin VB.TextBox txtRut 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFFF&
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
            Left            =   885
            MaxLength       =   10
            MouseIcon       =   "BacMntApoderado.frx":0614
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   1
            Top             =   135
            Width           =   1140
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00FFFFFF&
            BackStyle       =   0  'Transparent
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
            Left            =   60
            TabIndex        =   19
            Top             =   540
            Width           =   660
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
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
            Height          =   435
            Index           =   16
            Left            =   2040
            TabIndex        =   18
            Top             =   45
            Width           =   150
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00FFFFFF&
            BackStyle       =   0  'Transparent
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
            Left            =   60
            TabIndex        =   17
            Top             =   195
            Width           =   315
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00FFFFFF&
            BackStyle       =   0  'Transparent
            Caption         =   "Código Cliente"
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
            Left            =   4260
            TabIndex        =   16
            Top             =   180
            Width           =   1245
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   2100
         Index           =   1
         Left            =   45
         TabIndex        =   20
         Top             =   840
         Width           =   7080
         _Version        =   65536
         _ExtentX        =   12488
         _ExtentY        =   3704
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
         Begin VB.TextBox Textrut 
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
            Height          =   315
            Left            =   195
            MaxLength       =   11
            MultiLine       =   -1  'True
            TabIndex        =   6
            Text            =   "BacMntApoderado.frx":091E
            Top             =   795
            Width           =   500
         End
         Begin VB.TextBox Textapoderado 
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
            Height          =   315
            Left            =   675
            MaxLength       =   40
            MultiLine       =   -1  'True
            TabIndex        =   7
            Text            =   "BacMntApoderado.frx":0924
            Top             =   795
            Width           =   500
         End
         Begin VB.TextBox Textcargo 
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
            Height          =   315
            Left            =   195
            MaxLength       =   40
            MultiLine       =   -1  'True
            TabIndex        =   8
            Text            =   "BacMntApoderado.frx":092A
            Top             =   1125
            Width           =   500
         End
         Begin VB.TextBox Textfono 
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
            Height          =   315
            Left            =   660
            MaxLength       =   15
            MultiLine       =   -1  'True
            TabIndex        =   9
            Text            =   "BacMntApoderado.frx":0930
            Top             =   1125
            Width           =   500
         End
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   1935
            Left            =   45
            TabIndex        =   5
            Top             =   105
            Width           =   6990
            _ExtentX        =   12330
            _ExtentY        =   3413
            _Version        =   393216
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
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2880
      Top             =   -90
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
            Picture         =   "BacMntApoderado.frx":0936
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":0D8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":11E6
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntApoderado.frx":1502
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   7200
      _ExtentX        =   12700
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
   Begin Threed.SSFrame Frame 
      Height          =   2160
      Index           =   3
      Left            =   9675
      TabIndex        =   0
      Top             =   1230
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
         TabIndex        =   11
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
         TabIndex        =   13
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
         TabIndex        =   12
         Top             =   1275
         Width           =   1860
      End
   End
End
Attribute VB_Name = "BacMntApoderado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objCliente            As Object
Private Objrutcli             As Object
Private ObjApoderado          As Object

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
   
   txtRut.Enabled = True
   txtDigito.Enabled = True
   TxtNombre.Enabled = True
   txtcodcli.Enabled = True
   
   
   Call APHabilitarControles(False)
   
   txtRut.SetFocus

End Sub
Private Sub Form_Activate()

 'Call BacIniciaGrilla(8, 5, 1, 0, False, Grilla)
  
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
   Set Objrutcli = New clsCliente
   Set ObjApoderado = New clsApoderado
      
  
   Call BacIniciaGrilla(8, 5, 1, 0, False, Grilla)
   Call CargarParam_Ap(Grilla)
   Grilla.Enabled = False
 
   TxtNombre.Enabled = False
   Call Limpia_Txt
   
   FRM_ESTADO% = False
   APHabilitarControles (False)

   Call Grabar_Log_AUDITORIA(gsEntidad _
                              , gsbac_fecp _
                              , gsTerminal _
                              , gsUsuario _
                              , "PCA" _
                              , "opc_23" _
                              , "07" _
                              , "Usuario entra en Mantención Apoderados" _
                              , " " _
                              , " " _
                              , " ")

   Grilla.Rows = 2


End Sub

Private Sub Form_Unload(Cancel As Integer)
   
   Call Grabar_Log_AUDITORIA(gsEntidad _
                              , gsbac_fecp _
                              , gsTerminal _
                              , gsUsuario _
                              , "PCA" _
                              , "opc_23" _
                              , "08" _
                              , "Usuario Cierra Mantención Apoderados" _
                              , " " _
                              , " " _
                              , " ")


End Sub

Private Sub grilla_DblClick()
grilla_KeyPress 13
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 46 Then
      
      If (Grilla.TextMatrix(Grilla.Row, 0) = "" And Grilla.TextMatrix(Grilla.Row, 1) = "" And Grilla.TextMatrix(Grilla.Row, 2) = "") And Grilla.Rows > 2 Then
         
         Grilla.RemoveItem (Grilla.Row)
         Grilla.SetFocus
         Exit Sub
      
      End If
    
      If (Grilla.TextMatrix(Grilla.Row, 1) = "") And Grilla.Rows = 2 Then
      
      
         Grilla.Rows = 1
         Grilla.Rows = 2
         Grilla.SetFocus
         Exit Sub
      
      End If
           
           
      Call Eliminar
      
   End If

   If KeyCode = 45 Then
   
      If Grilla.TextMatrix(Grilla.Rows - 1, 0) <> "" And Grilla.TextMatrix(Grilla.Rows - 1, 0) <> "" Then
      'If Grilla.TextMatrix(Grilla.Rows - 1, 0) <> "" And Grilla.TextMatrix(Grilla.Rows - 1, 1) <> "" And Grilla.TextMatrix(Grilla.Rows - 1, 2) <> "" And Grilla.TextMatrix(Grilla.Rows - 1, 3) <> "" Then
   
         Grilla.Rows = Grilla.Rows + 1
         Grilla.SetFocus
         
      End If
      
   End If


End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
    
Dim row_tem%

With Grilla
   
'     If .Rows - 1 = .Row Then
'        .Rows = .Rows + 1
'     End If
   
    If KeyAscii = 45 Then
    
      .Rows = .Rows + 1
    
    End If
   
       If .Col = 0 Then                   ' rut
      
        If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
                  
                        
            'row_tem = .Row
              
            If Valida_Ingreso(Grilla) = False Then
                  
                  Exit Sub
            
            End If
                
            '.Row = row_tem
            .Col = 0
          
            PROC_POSICIONA_TEXTO Grilla, Textrut
            .Enabled = False
            Textrut.Visible = True
            
            If IsNumeric(Chr(KeyAscii)) Then
                
                Textrut.Text = Chr(KeyAscii)
                SendKeys "{RIGHT}"    'Comienzo Izquierda
            
            Else
                
                Textrut.Text = .TextMatrix(.Row, .Col)
                SendKeys "{END}"
            
            End If
            
            Textrut.SetFocus
            
            'SendKeys "{END}"     'Comienzo Derecha
        
        End If
     
     End If
        
    
       
    If .Col = 1 Or .Col = 2 Then             ' apoderado , cargo
          '.ColAlignment(.Col) = 8
         
        If Trim(.TextMatrix(.Row, 0)) = "" Then
             MsgBox "Debe Ingresar Rut del Apoderado", vbCritical, TITSISTEMA
             .Col = 0
             .SetFocus
             Exit Sub
          End If
       If .Col = 1 Then
          
            If KeyAscii > 0 And KeyAscii <> 27 Then
        
                PROC_POSICIONA_TEXTO Grilla, Textapoderado
                .Enabled = False
                Textapoderado.Visible = True
                If KeyAscii = 13 Then
                    Textapoderado.Text = .TextMatrix(.Row, .Col)
                    SendKeys "{END}"
                Else
                    Textapoderado.Text = UCase(Chr(KeyAscii))
                    SendKeys "{RIGHT}" 'Comienzo Izquierda
                End If
                Textapoderado.SetFocus
                    
                'SendKeys "{END}"     'Comienzo Derecha
            End If
          
      Else
           
            If KeyAscii > 0 And KeyAscii <> 27 Then
        
                PROC_POSICIONA_TEXTO Grilla, Textcargo
                .Enabled = False
                Textcargo.Visible = True
                If KeyAscii = 13 Then
                    Textcargo.Text = .TextMatrix(.Row, .Col)
                    SendKeys "{END}"     'Comienzo Derecha
                Else
                    Textcargo.Text = UCase(Chr(KeyAscii))
                    SendKeys "{RIGHT}" 'Comienzo Izquierda
                End If
                Textcargo.SetFocus
                    
                
          End If
      End If
          
   
    End If
        
        
    If .Col = 3 Then                    ' fono
          ' .ColAlignment(.Col) = 8
          
          If Trim(.TextMatrix(.Row, 0)) = "" Then
             MsgBox "Debe Ingresar Rut del Apoderado", vbCritical, TITSISTEMA
             .Col = 0
             .SetFocus
             Exit Sub
          End If
          
          If KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii)) Then
        
                PROC_POSICIONA_TEXTO Grilla, Textfono
                .Enabled = False
                Textfono.Visible = True
                If IsNumeric(Chr(KeyAscii)) Then
                    Textfono.Text = Chr(KeyAscii)
                    SendKeys "{RIGHT}"    'Comienzo Izquierda
                Else
                    Textfono.Text = .TextMatrix(.Row, .Col)
                    SendKeys "{END}"     'Comienzo Derecha
                End If
                Textfono.SetFocus
                
                
          End If
          
        
    End If
        
      
 End With

End Sub

Private Sub Textapoderado_KeyPress(KeyAscii As Integer)

 With Grilla
  
  KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  
    If KeyAscii = 13 Then
    
          .TextMatrix(.Row, .Col) = Textapoderado.Text
            Textapoderado.Text = ""
           .Enabled = True
           Textapoderado.Visible = False
          .SetFocus
      End If
   
   
     If KeyAscii = 27 Then
           Textapoderado.Text = ""
           Textapoderado.Visible = False
           .Enabled = True
          .SetFocus
     End If
     
 End With

End Sub

Private Sub Textapoderado_LostFocus()

   Textapoderado_KeyPress 27

End Sub

Private Sub Textcargo_KeyPress(KeyAscii As Integer)
With Grilla
  
  KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  
    If KeyAscii = 13 Then
    
          .TextMatrix(.Row, .Col) = Textcargo.Text
            Textcargo.Text = ""
           .Enabled = True
           Textcargo.Visible = False
          .SetFocus
      End If
   
   
     If KeyAscii = 27 Then
           Textcargo.Text = ""
           Textcargo.Visible = False
           .Enabled = True
          .SetFocus
     End If
     
 End With

End Sub

Private Sub Textcargo_LostFocus()

   Textcargo_KeyPress 27

End Sub

Private Sub Textfono_KeyPress(KeyAscii As Integer)
With Grilla
    
    KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  
    If KeyAscii = 13 Then
    
          .TextMatrix(.Row, .Col) = Textfono.Text
            Textfono.Text = ""
           .Enabled = True
           Textfono.Visible = False
          .SetFocus
      End If
   
   
     If KeyAscii = 27 Then
           Textfono.Text = ""
           Textfono.Visible = False
           .Enabled = True
          .SetFocus
     End If
     
 End With
End Sub

Private Sub Textfono_LostFocus()

   Textfono_KeyPress 27

End Sub

Private Sub Textrut_KeyPress(KeyAscii As Integer)

Dim Temp As String


With Grilla
  
  KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  
  
    If (KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 45 Or KeyAscii = 75 Or KeyAscii = 13 Or KeyAscii = 27 Or KeyAscii = 8 Then
  
      Else
         KeyAscii = 0
     End If
  
    If KeyAscii = 13 Then
        If Trim(Textrut.Text) = "" Then
          .TextMatrix(.Row, 0) = ""
          .TextMatrix(.Row, 1) = ""
          .TextMatrix(.Row, 2) = ""
          .TextMatrix(.Row, 3) = ""
           Textrut.Visible = False
           .Enabled = True
           .SetFocus
            Exit Sub
        End If
        
'      If Textrut.Text > 50000000 Then
'           MsgBox " El Rut no puede ser mayor a 50.000.000  ", vbCritical, TITSISTEMA
'           Temp = Textrut.Text
'           Textrut.Text = ""
'           Textrut.Text = Temp
'           KeyAscii = 0
'           Textrut.SetFocus
'           SendKeys "{end}"
'           Exit Sub
'        End If
'
        If Valid_Rut(Textrut.Text) = True Then
    
          Else
           MsgBox " El Rut Esta Incorrecto  ", vbCritical, TITSISTEMA
           Temp = Textrut.Text
           Textrut.Text = ""
           Textrut.Text = Temp
           KeyAscii = 0
           Textrut.SetFocus
           SendKeys "{end}"
        
           Exit Sub
        End If
    
        If bacBuscaRepetidoGrilla(0, Grilla, Trim(Textrut.Text)) = False Then
            '.ColAlignment(1) = 2
            .TextMatrix(.Row, 0) = Trim(Textrut.Text)
             Textrut.Visible = False
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
           Textrut.Text = ""
           Textrut.Visible = False
           .Enabled = True
          .SetFocus
     End If
     
 End With

End Sub

Private Sub Textrut_LostFocus()

   Textrut_KeyPress 27

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
      Dim idrutcli   As String
      Dim iddigito   As String
      Dim idrutapo   As String
      Dim IdOpcion   As Integer
      
      Screen.MousePointer = 11

      Call Limpia_Txt

      idrutcli = txtRut.Text
      iddigito = txtDigito.Text
      
      
      If Valida_Ingreso_graba(Grilla) = False Then
         
         Textapoderado.Visible = False
          Exit Sub
      
      End If
      
      
      
      FRM_ESTADO% = False
      eliminame = 50
      Call ObjApoderado.EliminarApoderado(Val(idrutcli), Val(txtcodcli.Text))
      Call ObjApoderado.RefrescaApo(Grilla)
      
      IdOpcion = ObjApoderado.GrabarApo(idrutcli, iddigito, Val(txtcodcli.Text))
      
      Screen.MousePointer = 0
      
      Select Case IdOpcion
      Case False: MsgBox "No se pueden grabar datos en tabla apoderados", 16, TITSISTEMA
      Case 1:     MsgBox "No se pueden grabar datos en tabla apoderado", 16, TITSISTEMA
      Case 2:     MsgBox "no se puede  eliminar en tabla apoderado ", 16, TITSISTEMA
      Case 3:     MsgBox "No se puede grabar en tabla apoderado", 16, TITSISTEMA
      Case 4:     MsgBox "No se puede grabar en tabla apoderado", 16, TITSISTEMA
      Case True:  MsgBox "Grabación se realizó con exito", 64, TITSISTEMA
                  FRM_ESTADO% = True
      End Select
      
      If FRM_ESTADO% = True Then
         Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBAC_Term _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_23 " _
                                    , "01 " _
                                    , "Grabacion De Apoderados Correcta " _
                                    , " " _
                                    , " " _
                                    , "GRABA APODERADOS CLIENTE : " & TxtNombre.Text)
      
         'Call BacLimpiaGrilla(Grilla)
         'Call BacIniciaGrilla(9, 5, 1, 0, False, grilla)
         'Call CargarParam_Ap(grilla)
         'Call APLimpiar
         'Grilla.Enabled = False
         'txtcodcli.Enabled = True
         'Unload Me
         'Load Me
      
         Call Limpiar
      
      End If

Case 2
       'Dim idrutcli   As String
      Dim a          As Integer
      Dim iok        As Integer

Grilla.Col = 0
a = MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo, TITSISTEMA)
If a = 6 Then
    opecod = Val(Mid(Grilla.Text, 1, 9))
    idrutcli = txtRut.Text
      
    Call Limpia_Txt
    
    Grilla.Enabled = True
      
     With Grilla
     eliminame = 100
     Call ObjApoderado.EliminarApoderado(Val(idrutcli), Val(txtcodcli.Text))
    
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
    
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBAC_Term _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_23 " _
                                    , "03" _
                                    , "Eliminacion de Apoderado " _
                                    , " " _
                                    , " " _
                                    , "ELIMININA APODERADO CLIENTE : " & TxtNombre.Text)
      
End If
' Screen.MousePointer = 0
Case 3
    'Unload Me
    'Load Me
    Screen.MousePointer = 11
    'Call BacLimpiaGrilla(Grilla)
    'Call BacIniciaGrilla(9, 5, 5, 0, False, Grilla)
    'Call CargarParam_Ap(Grilla)
    Grilla.Enabled = False
    txtcodcli.Enabled = True
    Call APLimpiar
    Call Limpia_Txt
    Grilla.Rows = 1
    Grilla.Rows = 2
    Screen.MousePointer = 0

Case 4
    Unload Me
End Select
End Sub

Private Sub txtcodcli_KeyPress(KeyAscii As Integer)
   
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
      
   End If

   If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
      KeyAscii = 0

   End If
   
   BacToUCase KeyAscii

End Sub

Private Sub txtcodcli_LostFocus()
   
   Dim idRut     As String
   Dim IdDig     As String
   Dim lValor  As Boolean

  
   idRut = txtRut.Text
   IdDig = txtDigito.Text
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
            TxtNombre.Text = objCliente.clnombre
            TxtNombre.Tag = TxtNombre.Text
         Else
            MsgBox "Error : No existe , El Rut o el Codigo del cliente ", 16, TITSISTEMA
            lValor = False
         End If

      Else
         Screen.MousePointer = 0
         MsgBox "Error : En Carga de Datos", 16, TITSISTEMA
         lValor = False
         Exit Sub

      End If
   Else
      MsgBox "Error : Rut Incorrecto", 16, TITSISTEMA
      lValor = False
         
   End If
  
    If Not (lValor) Then  ' ES FALSO
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
            Grilla.Enabled = True
            'Call BacAgrandaGrilla(Grilla, 40)
            Grilla.Col = 0
            Grilla.Row = 1
            Grilla.SetFocus
   End If
  
      idRut = txtRut.Text

     '-------- Carga grilla de apoderados -----------'
     'LeeTabApo(nRut As String, codcli As Integer)
   If Not objCliente.CargaApoderados(Grilla, Val(txtRut.Text), Val(txtcodcli.Text), 0) Then
      Screen.MousePointer = 0
      Exit Sub

   Else
     
     
     'Call BacAgrandaGrilla(Grilla, 40)
     Grilla.Col = 0
     Grilla.Row = 1
     Grilla.SetFocus
   
   End If
   
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   TxtNombre.Enabled = False
   txtcodcli.Enabled = False
   
   Screen.MousePointer = 0
   
End Sub
Private Sub txtDigito_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

   If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
       KeyAscii = 0

   End If

   BacCaracterNumerico KeyAscii
  
   
End Sub

Private Sub txtDigito_LostFocus()
  
  If Controla_RUT(txtRut, txtDigito) = True Then
      objCliente.clrut = txtRut.Text
      objCliente.cldv = txtDigito.Text
  Else
      MsgBox "Error : Rut Incorrecto", 16, TITSISTEMA
      Call APLimpiar
      Call APHabilitarControles(False)
      txtRut.SetFocus
      Exit Sub
     
  End If

End Sub

Private Sub txtRut_DblClick()

    BacControlWindows 100

    BacAyuda.Tag = "MDCL_U"
    BacAyuda.Show 1

    If giAceptar% Then
        txtRut.Text = Val(gsCodigo$)
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

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

   If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
       KeyAscii = 0

   End If

   BacCaracterNumerico KeyAscii
   
End Sub

Public Function CargarParam_Ap(Grillas As Object)

     With Grillas
 
         .Enabled = True
         .Row = 0
         .RowHeight(0) = 360
         .CellFontWidth = 4         ' TAMAÑO
         
         .ColWidth(0) = 1410        'RUT
         .ColWidth(1) = 5000        'NOMBRE
         .ColWidth(2) = 5000        'CARGO
         .ColWidth(3) = 1400        'FONO
         .ColWidth(4) = 10          'MARCA
         
         .Row = 0

         .Col = 0
         .CellFontBold = True       'RESALSE
         .FixedAlignment(0) = 4
         .Text = "     Rut    "

         .Col = 1
         .CellFontBold = True       'RESALSE
         .FixedAlignment(1) = 4
         .Text = " Nombre Apoderado   "
         
         .Col = 2
         .CellFontBold = True       'RESALSE
         .FixedAlignment(2) = 4
         .Text = " Cargo Apoderado   "
         
         .Col = 3
         .CellFontBold = True       'RESALSE
         .FixedAlignment(3) = 4
         .Text = "   Fono     "
         
         
    End With

End Function

Public Function Valid_Rut(Rut_valid As String) As Boolean
   
 
Dim Fila       As Integer
Dim sRut       As String
Dim sDv        As String

 Valid_Rut = False

      
    If Trim$(Len(Rut_valid)) > 1 And InStr(1, Rut_valid, "-") <> 0 Then
                    
             sRut = Mid$(Rut_valid, 1, Len(Rut_valid) - IIf(InStr(Rut_valid, "-") = 0, 1, 2))
             sDv = Right$(Rut_valid, 1)
          
       If Control_RUT(sRut, sDv) Then
          Valid_Rut = True
          Exit Function
       Else
          Exit Function
       End If
            
    End If

End Function


Public Function Control_RUT(tex As String, tex1 As String)
   
   Dim Valida As Integer
   Dim idRut As String
   Dim IdDig As String

   idRut = tex
   IdDig = tex1

   Valida = True

   If Trim$(idRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(idRut$) = "0" And Trim$(IdDig$) = "0") Then
      Valida = False
   
   End If
    
   If BacValidaRut(tex, tex1) = False Then
      Valida = False
   
   End If

   Control_RUT = Valida

End Function

Public Sub Limpia_Txt()

   Textrut.Visible = False
   Textrut.Text = ""
   Textapoderado.Visible = False
   Textapoderado.Text = ""
   Textcargo.Visible = False
   Textcargo.Text = ""
   Textfono.Visible = False
   Textfono.Text = ""
End Sub
Public Function Valida_Ingreso_graba(obj As Object) As Boolean

Dim Fila%
Valida_Ingreso_graba = True

Grilla.Enabled = True
With obj
  
    For Fila = 1 To .Rows - 1
      
      .Row = Fila
       
      If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 1)) = "" Then
           Screen.MousePointer = 0
           MsgBox "Falta Ingresar el Nombre de Un Apoderado ", 16, TITSISTEMA
           Valida_Ingreso_graba = False
           
            .Col = 1
           .SetFocus
           Exit Function
       End If
         
   Next Fila
              
End With
        
End Function
Public Function Valida_Ingreso(obj As Object) As Boolean

Dim Fila%
Valida_Ingreso = True

Grilla.Enabled = True
With obj
  
    For Fila = 1 To .Rows - 1
      
      .Row = Fila
       
      If Trim$(.TextMatrix(.Row, 0)) <> "" And Trim$(.TextMatrix(.Row, 1)) = "" Then
           'Screen.MousePointer = 0
          ' MsgBox "Falta Ingresar el Nombre de Un Apoderado ", 16, gsPARAMS_Version
           'Valida_Ingreso = False
           PROC_POSICIONA_TEXTO Grilla, Textrut
            .Col = 0
           '.SetFocus
           Exit Function
       End If
         
   Next Fila
              
End With
        
End Function


Sub Eliminar()

   Dim idrutcli   As String
   Dim a          As Integer
   Dim iok        As Integer
   Dim nPos       As Integer

On Error GoTo ErrorF:

Grilla.Col = 0
a = MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo, TITSISTEMA)
If a = 6 Then
    
    
      If (Grilla.TextMatrix(Grilla.Row, 1) = "") And Grilla.Rows = 2 Then
      
      
         Grilla.Rows = 1
         Grilla.Rows = 2
         Grilla.SetFocus
         Exit Sub
      
      End If
    
      If Grilla.Rows > 1 Then
      
        ' Call ObjApoderado.EliminarApoderado(Val(txtRut), Left(Grilla.TextMatrix(Grilla.Row, 0), Len(Grilla.TextMatrix(Grilla.Row, 0)) - 2))
         nPos = Grilla.Row
         
         If Grilla.Rows > 2 Then
            
            Grilla.RemoveItem (nPos)
            
         Else
         
            Grilla.Rows = 1
            Grilla.Rows = 2
            
         End If
         
         Grilla.SetFocus
         Grilla.Refresh
         Exit Sub
      
      End If
    
      opecod = Val(Mid(Grilla.Text, 1, 9))
    
      idrutcli = txtRut.Text
       
      ' Screen.MousePointer = 11
       
       Call Limpia_Txt
    
       Grilla.Enabled = True
      
       With Grilla
     eliminame = 100
     
     Call ObjApoderado.EliminarApoderado(Val(idrutcli), Val(txtcodcli.Text))
    
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
  
Grilla.Refresh
Grilla.SetFocus

ErrorF:

End Sub


Sub Limpiar()

   Set objCliente = New clsCliente
   Set Objrutcli = New clsCliente
   Set ObjApoderado = New clsApoderado
      
  
   'Call BacIniciaGrilla(8, 5, 1, 0, False, Grilla)
   'Call CargarParam_Ap(Grilla)
   Grilla.Enabled = False
 
   Call APLimpiar
   
   TxtNombre.Enabled = False
   Call Limpia_Txt
   
   FRM_ESTADO% = False
   APHabilitarControles (False)

   Grilla.Rows = 1
   Grilla.Rows = 2
   

End Sub
