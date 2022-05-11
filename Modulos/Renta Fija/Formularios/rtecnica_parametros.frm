VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form rtecnica_parametros 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Información General"
   ClientHeight    =   5490
   ClientLeft      =   2250
   ClientTop       =   2400
   ClientWidth     =   7950
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5490
   ScaleWidth      =   7950
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   375
      Left            =   6000
      TabIndex        =   8
      Top             =   4920
      Width           =   1695
   End
   Begin BACControles.TXTNumero txtNumero1 
      Height          =   375
      Left            =   3120
      TabIndex        =   3
      Top             =   2640
      Visible         =   0   'False
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      BackColor       =   -2147483646
      ForeColor       =   -2147483643
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Text            =   "0"
      Text            =   "0"
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H80000002&
      ForeColor       =   &H80000005&
      Height          =   375
      Left            =   4560
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   2640
      Visible         =   0   'False
      Width           =   1215
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla_resta 
      Height          =   1215
      Left            =   120
      TabIndex        =   1
      Top             =   3600
      Width           =   7695
      _ExtentX        =   13573
      _ExtentY        =   2143
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   -2147483648
      ForeColor       =   -2147483635
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483634
      GridColor       =   3947580
      FocusRect       =   0
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla_suma 
      Height          =   2055
      Left            =   120
      TabIndex        =   0
      Top             =   1080
      Width           =   7695
      _ExtentX        =   13573
      _ExtentY        =   3625
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483628
      GridColor       =   3947580
      FocusRect       =   0
   End
   Begin MSComctlLib.ImageList imagelist1 
      Left            =   4320
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   23
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":134C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_parametros.frx":1AB8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   9435
      _ExtentX        =   16642
      _ExtentY        =   900
      ButtonWidth     =   794
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "imagelist1"
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
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdsalir"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   9
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Label Label3 
      Caption         =   "Total monto"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   4440
      TabIndex        =   7
      Top             =   5040
      Width           =   1575
   End
   Begin VB.Label Label2 
      BackColor       =   &H8000000A&
      Caption         =   "Montos a favor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   720
      Width           =   2895
   End
   Begin VB.Label Label1 
      BackColor       =   &H8000000A&
      Caption         =   "Montos en contra"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   3240
      Width           =   3135
   End
End
Attribute VB_Name = "rtecnica_parametros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub Grabar()
       
    'recupero datos de las grillas
    For I = 1 To Grilla_suma.Rows - 1
    
        Envia = Array()
        AddParam Envia, CDbl(Grilla_suma.TextMatrix(I, 0))
        AddParam Envia, CDbl(Grilla_suma.TextMatrix(I, 2))
        
        'inserto datos
        If Not Bac_Sql_Execute("SP_RTECNICA_PARAMETROS_GRABAR", Envia()) Then
        
            'aviso al usuario
            MsgBox "Se ha producido un error al grabar", vbCritical, gsBac_Version
            
            Exit Sub
            
        End If
        
    Next
    
    For I = 1 To Grilla_resta.Rows - 1
    
        Envia = Array()
        AddParam Envia, Grilla_resta.TextMatrix(I, 0)
        AddParam Envia, CDbl(Grilla_resta.TextMatrix(I, 2))
        
        'inserto datos
        If Not Bac_Sql_Execute("SP_RTECNICA_PARAMETROS_GRABAR", Envia()) Then
        
            'aviso al usuario
            MsgBox "Se ha producido un error al grabar", vbCritical, gsBac_Version
            
            Exit Sub
            
        End If
        
    Next

    'aviso al usuario
    MsgBox "Los datos fueron grabados exitosamente", vbInformation, gsBac_Version
    
End Sub

Sub Llena_grillas()
    
    'edefinicion variables locales
    Dim Datos()
    Dim ll_monto_suma As Double
    Dim ll_monto_resta As Double
        
    'recupero datos para grillas
    If Not Bac_Sql_Execute("SP_RTECNICA_PARAMETROS_LEER") Then
    
        'aviso al usuario
        MsgBox "Se ha producido un error al recuperar datos", vbCritical, gsBac_Version
    
    End If
    
    'recorro registros
    Do While Bac_SQL_Fetch(Datos())
    
        'agrego datos a la grilla
        If Datos(4) = 1 Then
        
            Grilla_suma.TextMatrix(Grilla_suma.Rows - 1, 0) = Datos(1)
            Grilla_suma.TextMatrix(Grilla_suma.Rows - 1, 1) = Datos(2)
            Grilla_suma.TextMatrix(Grilla_suma.Rows - 1, 2) = Format(Datos(3), "###,###,###,###,##0")
            
            ll_monto_suma = ll_monto_suma + CDbl(Datos(3))
            
            'agrego un row a la grilla
            Grilla_suma.Rows = Grilla_suma.Rows + 1
            
        ElseIf Datos(4) = 2 Then
            
            Grilla_resta.TextMatrix(Grilla_resta.Rows - 1, 0) = Datos(1)
            Grilla_resta.TextMatrix(Grilla_resta.Rows - 1, 1) = Datos(2)
            Grilla_resta.TextMatrix(Grilla_resta.Rows - 1, 2) = Format(Datos(3), "###,###,###,###,##0")
            
            ll_monto_resta = ll_monto_resta + CDbl(Datos(3))
            
            'agrego un row a la grilla
            Grilla_resta.Rows = Grilla_resta.Rows + 1
            
        End If
        
    Loop
    
    If Grilla_suma.Rows > 2 Then
        
       Grilla_suma.Rows = Grilla_suma.Rows - 1
       
    End If
    
    If Grilla_resta.Rows > 2 Then
    
        Grilla_resta.Rows = Grilla_resta.Rows - 1
        
    End If
    
    Text2.Text = Format(ll_monto_suma - ll_monto_resta, "###,###,###,###,##0")
    
End Sub
Sub pos_texto(Grilla As Control, Key As Integer)

With txtNumero1 'Text1

    .Width = Grilla.CellWidth - 20
    .Height = Grilla.CellHeight
    .Top = Grilla.CellTop + Grilla.Top + 20
    .Left = Grilla.CellLeft + Grilla.Left + 20
    
    .Text = ""
    
    If IsNumeric(Chr(Key)) Then
        .Text = Chr(Key)
    
    End If
    
    If Key = 13 Then
    
        .Text = Grilla.Text
    End If
    
    .Visible = True
    .Tag = Grilla.Name
    .SetFocus
    .SelStart = Len(.Text)
    
End With

End Sub

Sub titulos_grillas()

Grilla_suma.Cols = 3

'defino ancho de celdas
Grilla_suma.ColWidth(0) = 0
Grilla_suma.ColWidth(1) = 6000
Grilla_suma.ColWidth(2) = 1500

Grilla_resta.Cols = 3

Grilla_resta.ColWidth(0) = 0
Grilla_resta.ColWidth(1) = 6000
Grilla_resta.ColWidth(2) = 1500

Grilla_suma.TextMatrix(0, 1) = "Detalle"
Grilla_suma.TextMatrix(0, 2) = "Monto"

Grilla_resta.TextMatrix(0, 1) = "Detalle"
Grilla_resta.TextMatrix(0, 2) = "Monto"

Grilla_resta.ColAlignment(1) = 0

End Sub
Private Sub Form_Load()

Move 0, 0

Me.Icon = BacTrader.Icon

Call titulos_grillas

Call Llena_grillas

End Sub

Private Sub Grilla_resta_KeyPress(KeyAscii As Integer)

   
    If Grilla_resta.Col = 2 Then
            
        If Not (IsNumeric(Chr(KeyAscii)) And KeyAscii = 13) Then
        
            'posiciono el texto
            Call pos_texto(Grilla_resta, KeyAscii)
            
                   
        End If
    End If
    
End Sub

Private Sub Grilla_suma_KeyPress(KeyAscii As Integer)

    If Grilla_suma.Col = 2 Then
            
        If Not (IsNumeric(Chr(KeyAscii)) And KeyAscii = 13) Then
        
            'posiciono el texto
            Call pos_texto(Grilla_suma, KeyAscii)
            
        End If
    End If
    
End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Key
    
    Case Is = "cmdGrabar": Call Grabar
    Case Is = "cmdsalir":  Unload Me
    
End Select

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        
        Dim ll_monto_total
        
        If text1.Tag = "Grilla_suma" Then
        
            ll_monto_total = CDbl(Text2.Text) - CDbl(Grilla_suma.Text)
            
            Grilla_suma.Text = Format(text1.Text, "###,###,###,###,##0")
            
            If text1.Text = "" Then Grilla_suma.Text = "0"
            
            ll_monto_total = ll_monto_total + CDbl(Grilla_suma.Text)
            
            Text2.Text = Str(Format(ll_monto_total, "###,###,###,###,##0"))
            
            text1.Visible = False
            Grilla_suma.SetFocus
            
        Else
            
            ll_monto_total = CDbl(Text2.Text) + CDbl(Grilla_resta.Text)
            
            Grilla_resta.Text = Format(text1.Text, "###,###,###,###,##0")
        
            If text1.Text = "" Then Grilla_resta.Text = "0"
        
            ll_monto_total = ll_monto_total - CDbl(Grilla_resta.Text)
                        
            Text2.Text = Str(Format(ll_monto_total, "###,###,###,###,##0"))
            
            text1.Visible = False
            
            Grilla_resta.SetFocus
            
        End If
        
        Bac_SendKey (vbKeyRight)
        
    ElseIf KeyAscii = 27 Then
    
        txtNumero1.Visible = False
        
    End If
    
End Sub

Private Sub txtNumero1_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        
        Dim ll_monto_total
        
        If txtNumero1.Tag = "Grilla_suma" Then
        
            ll_monto_total = CDbl(Text2.Text) - CDbl(Grilla_suma.Text)
            
            Grilla_suma.Text = txtNumero1.Text
            
            If txtNumero1.Text = "" Then Grilla_suma.Text = "0"
            
            ll_monto_total = ll_monto_total + CDbl(Grilla_suma.Text)
            
            Text2.Text = Format(ll_monto_total, "###,###,###,###,##0")
            
            txtNumero1.Visible = False
            
            Grilla_suma.SetFocus
            
        Else
            
            ll_monto_total = CDbl(Text2.Text) + CDbl(Grilla_resta.Text)
            
            Grilla_resta.Text = txtNumero1.Text
        
            If txtNumero1.Text = "" Then Grilla_resta.Text = "0"
            
            ll_monto_total = ll_monto_total - CDbl(Grilla_resta.Text)
                                  
            Text2.Text = Format(ll_monto_total, "###,###,###,###,##0")
            
            txtNumero1.Visible = False
            
            Grilla_resta.SetFocus
            
        End If
        
        Bac_SendKey (vbKeyRight)
        
    ElseIf KeyAscii = 27 Then
    
        txtNumero1.Visible = False
        
    End If

End Sub

Private Sub txtNumero1_LostFocus()

    txtNumero1.Visible = False

End Sub
