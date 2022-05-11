VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTm_mntrangos 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Rango de Plazos"
   ClientHeight    =   4440
   ClientLeft      =   3960
   ClientTop       =   2910
   ClientWidth     =   3270
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4440
   ScaleWidth      =   3270
   Begin VB.TextBox Text1_old 
      BackColor       =   &H8000000D&
      ForeColor       =   &H8000000E&
      Height          =   375
      Left            =   960
      TabIndex        =   5
      Text            =   "Text1"
      Top             =   2880
      Visible         =   0   'False
      Width           =   1215
   End
   Begin BACControles.TXTNumero Text1 
      Height          =   375
      Left            =   960
      TabIndex        =   4
      Top             =   2040
      Visible         =   0   'False
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   661
      BackColor       =   8547166
      ForeColor       =   -2147483643
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
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
      Max             =   "999999999999"
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   2040
      TabIndex        =   3
      Text            =   "Combo2"
      Top             =   600
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   600
      Width           =   1935
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2640
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mntrangos.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mntrangos.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mntrangos.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mntrangos.frx":0A86
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mntrangos.frx":0DA0
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mntrangos.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTm_mntrangos.frx":150C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   3285
      Left            =   120
      TabIndex        =   0
      Top             =   1080
      Width           =   3075
      _ExtentX        =   5424
      _ExtentY        =   5794
      _Version        =   393216
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483634
      BackColorSel    =   8388608
      GridColor       =   3947580
      FocusRect       =   0
      GridLines       =   2
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   465
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   10260
      _ExtentX        =   18098
      _ExtentY        =   820
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCerrar"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Cerrar el Formulario"
            ImageIndex      =   7
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacTm_mntrangos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Titulos_grilla()

    With Grilla
    
        'filas y columnas...
        .Rows = 11
        .Cols = 2
        
        .ColWidth(0) = 1400
        .ColWidth(1) = 1400
        
    
        'titulos y cabeceras
        .TextMatrix(0, 0) = "Plazo"
        .TextMatrix(0, 1) = "Rango"
    
        .TextMatrix(1, 0) = "Plazo 1"
        .TextMatrix(2, 0) = "Plazo 2"
        .TextMatrix(3, 0) = "Plazo 3"
        .TextMatrix(4, 0) = "Plazo 4"
        .TextMatrix(5, 0) = "Plazo 5"
        .TextMatrix(6, 0) = "Plazo 6"
        .TextMatrix(7, 0) = "Plazo 7"
        .TextMatrix(8, 0) = "Plazo 8"
        .TextMatrix(9, 0) = "Plazo 9"
        .TextMatrix(10, 0) = "Plazo 10"
        
        For I = 1 To (.Rows - 1)
            
            .TextMatrix(I, 1) = 0
            
        Next
            
    End With

    For I = 0 To (Grilla.Rows - 1)
    
        Grilla.RowHeight(I) = 270
    Next
    
End Sub

Private Sub Combo1_Click()
    
    Dim lsMsg As String
        
    If Combo1.Tag = "1" Then
    
        Exit Sub
    End If
    
    If Grilla.Tag = "1" Then
    
        lsMsg = "Los cambios realizados no se han guardado." & Chr(10) & Chr(13) _
                & "Al cambiar la selección estos se perderán." & Chr(10) & Chr(13) _
                & "Desea guardar los cambios ahora ?."
    
        'antes de cambiar posicion..
        If MsgBox(lsMsg, vbYesNo, gsBac_Version) = vbYes Then
    
            Call grabar_plazo
        End If
    End If
        
    Grilla.Tag = ""
    
    Combo2.ListIndex = Combo1.ListIndex
    
    'recupero los plazos del instrumento
    Call Lee_Plazos

    
End Sub

Private Sub Lee_Plazos()

    'dimensiono variables locales
    Dim Datos()
    
    Call Titulos_grilla
    
    'preparpo parametros para sp
    Envia = Array()
    
    AddParam Envia, Combo2.Text
    AddParam Envia, Combo2.ItemData(Combo2.ListIndex)
    
    If Not Bac_Sql_Execute("SP_TASAMERCADO_LEE_PLAZO ", Envia) Then
        
        'aviso al usuario
        MsgBox "Se ha producido un error durante la consulta a la base de datos"
        
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
    
        'muestro los plazos en la grilla
        Grilla.TextMatrix(Datos(1), 1) = Datos(2)
        
    Loop

    
End Sub

Private Sub Form_Load()
    
    'personalizo la ventana
    Me.Top = 0
    Me.Left = 0
    
    Me.Icon = BacTrader.Icon
    
    'muestro titulos de la grilla
    Call Titulos_grilla
    
    'marco el tag del combo
    Combo1.Tag = "1"
    
    'cargo instrumentos al combo
    Call Carga_combo
    
    Combo1.Tag = ""
    
    'Grilla.SetFocus
    
End Sub

Private Sub Carga_combo()

    'dimensiono variables...
    Dim I As Long
    Dim Datos()
    
    'recuepro instrumentos de la tabla tpra inm
    If Bac_Sql_Execute("SP_TASAMERCADO_LEE_INM") Then    '' ejecutado

        Do While Bac_SQL_Fetch(Datos())
                   
            With BacTm_mnttasas
            
                'inserto item al combo
                Combo2.AddItem Datos(3)
                Combo2.ItemData(Combo2.ListCount - 1) = Datos(1)
                Combo1.AddItem (Trim(Datos(2)) + String(10 - Len(Trim(Datos(2))), " ") + Trim(Datos(4)))
                
            End With

        Loop
        
    
        If Combo2.ListCount > 0 Then
        
            Combo1.ListIndex = 0
            Combo2.ListIndex = 0
            
            Call Lee_Plazos
            
        End If

        
    Else
    
        'aviso al usuario
        MsgBox "Error al recuperar instrumentos", vbcri, gsBac_Version
        
        'Unload Me
        
        Exit Sub
    
    End If
                
End Sub

Private Sub Form_Unload(Cancel As Integer)

    BacTm_mnttasas.Enabled = True
    
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 113 Then
    
        Text1.Text = Grilla.TextMatrix(Grilla.Row, Grilla.Col)
    
        'posiciono texto
        Call pos_texto
    
    End If
    
End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

    If KeyAscii = 27 Then

        Exit Sub
    ElseIf KeyAscii = 13 Then

        Grilla.Row = IIf(Grilla.Row < Grilla.Rows - 1, Grilla.Row + 1, Grilla.Row)
        
    ElseIf IsNumeric(Chr(KeyAscii)) Then

        Text1.Text = Chr(KeyAscii)

        'posiciono texto
        Call pos_texto

    End If

End Sub

Private Sub pos_texto()

    With Text1
    
        .Width = Grilla.CellWidth '- 20
        .Height = Grilla.CellHeight
        .Top = Grilla.CellTop + Grilla.Top '+ 20
        .Left = Grilla.CellLeft + Grilla.Left '+ 20
        
        'If IsNumeric(Chr(key)) Then
        '    .Text = Chr(key)
        'End If
                
        Text1.SelStart = Len(Text1.Text)
        .Visible = True
        .SetFocus
        
    End With

End Sub


Private Sub Text1_KeyPress(KeyAscii As Integer)

'''    If KeyAscii = 13 Then
'''
'''        With Text1
'''
'''            Grilla.Text = CDbl(BACChBl(.Text))
'''            Grilla.Tag = 1
'''            .Visible = False
'''
'''        End With
'''
'''    ElseIf KeyAscii = 27 Then
'''
'''        Text1.Visible = False
'''
'''    End If

End Sub

Private Sub Text1_LostFocus()
  
    Text1.Visible = False
        
End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Key
        Case Is = "cmdGrabar": Call grabar_plazo
    
        Case Is = "cmdCerrar": Unload BacTm_mntrangos
         
    End Select

End Sub

Private Sub grabar_plazo()

    'dimensiono variables locales...
    Dim livalida        As Long
    Dim llCodigoInm     As Long
    'Dim llTipoEmisor As Long
    Dim lsGenericoEmi   As String
    Dim liIdPlazo       As Integer
    Dim lirango         As Integer
    Dim lscadena        As String
    Dim I               As Integer
    
    'valido rangos
    'recorro grilla para validar rangos
    For I = 1 To (Grilla.Rows - 1)
    
        If Val(Grilla.TextMatrix(I - 1, 1)) = 0 _
            And Val(Grilla.TextMatrix(I, 1)) <> 0 And I > 1 Then
        
            'aviso al usuario
            MsgBox "El rango para el plazo " & I & " no es válido."
    
            Exit Sub
        End If
        
        'valido que el row actual sea mayor al anterior
        If Val(Grilla.TextMatrix(I, 1)) < Val(Grilla.TextMatrix(I - 1, 1)) _
            And I > 1 Then
                 
            If Grilla.TextMatrix(I, 1) <> 0 Then
        
                'aviso al usuario
                MsgBox "El rango para el plazo " & I & " no es válido."
        
                Exit Sub
                
            Else
                
                If I < Grilla.Rows - 1 Then
                
                    If Grilla.TextMatrix(I + 1, 1) <> 0 Then
                
                        'aviso al usuario
                        MsgBox "El rango para el plazo " & I & " no es válido."
                
                        Exit Sub
                    
                    End If
                End If
            End If

        End If
    
        'valido que el plazo siguiente sea mayor
        If I < (Grilla.Rows - 1) Then
            
            If Val(Grilla.TextMatrix(I, 1)) > Val(Grilla.TextMatrix(I + 1, 1)) _
                Then
        
                If Grilla.TextMatrix(I + 1, 1) <> 0 Then
        
                    'aviso al usuario
                    MsgBox "El rango para el plazo " & I & " no es válido."

                    Exit Sub
            
                End If
            End If
        End If
    Next
    
    'tomo los datos de los controles
    llCodigoInm = Val(Combo2.ItemData(Combo2.ListIndex))
    lsGenericoEmi = Combo2.Text
    
    livalida = 0
    
    With Grilla
    
        For I = 1 To (.Rows - 1)
            
            'preparo parametros para sp
            Envia = Array()
            
            AddParam Envia, lsGenericoEmi
            AddParam Envia, llCodigoInm
            AddParam Envia, I
            AddParam Envia, .TextMatrix(I, 1)
                        
            'lscadena = llCodigoInm & ", " & i & ", " & .TextMatrix(i, 1)
            
            If Not Bac_Sql_Execute("SP_TASAMERCADO_GRABA_PLAZO ", Envia) Then
            
                MsgBox "Se ha producido un error durante la grabación de los datos"
                livalida = 1
                Exit For
                
            End If

        Next
        
        If livalida = 0 Then
        
            MsgBox "Información Grabada Correctamente", vbInformation, Me.Caption
            
            Grilla.Tag = ""
            Grilla.SetFocus
            
        End If
        
    End With

End Sub
