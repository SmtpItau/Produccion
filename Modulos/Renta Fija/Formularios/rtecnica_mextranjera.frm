VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form rtecnica_mextranjera 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Otras Operaciones a Incluir"
   ClientHeight    =   3045
   ClientLeft      =   1860
   ClientTop       =   1845
   ClientWidth     =   10215
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3045
   ScaleWidth      =   10215
   Begin BACControles.TXTNumero txtNumero1 
      Height          =   375
      Left            =   4680
      TabIndex        =   2
      Top             =   1080
      Visible         =   0   'False
      Width           =   1215
      _ExtentX        =   2143
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
      Min             =   "-9999999999"
      Max             =   "9999999999"
      Separator       =   -1  'True
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla1 
      Height          =   2175
      Left            =   120
      TabIndex        =   0
      Top             =   720
      Width           =   10095
      _ExtentX        =   17806
      _ExtentY        =   3836
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
            Picture         =   "rtecnica_mextranjera.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_mextranjera.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_mextranjera.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_mextranjera.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_mextranjera.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_mextranjera.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_mextranjera.frx":134C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_mextranjera.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "rtecnica_mextranjera.frx":1AB8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   10155
      _ExtentX        =   17912
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
            Key             =   "cmdSalir"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   9
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "rtecnica_mextranjera"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub Llena_Grilla()
    'declaracion de variables locales
    Dim Datos()
    
    'ejecuto sp
    If Not Bac_Sql_Execute("SP_RTECNICA_MEXTRANJERA_LEER") Then
    
        MsgBox "Se ha producido un error al leer los datos", vbCritical, gsBac_Version
        
        Exit Sub
        
    End If
    
    Do While Bac_SQL_Fetch(Datos())
    
        'inserto registro en la grilla
        Grilla1.TextMatrix(Grilla1.Rows - 1, 0) = Datos(1)
        Grilla1.TextMatrix(Grilla1.Rows - 1, 1) = Datos(2)
        Grilla1.TextMatrix(Grilla1.Rows - 1, 2) = Format(Datos(3), "###,###,###,###,##0")
        Grilla1.TextMatrix(Grilla1.Rows - 1, 3) = Format(Datos(4), "###,###,###,###,##0")
        
        Grilla1.Rows = Grilla1.Rows + 1
        
    Loop
    
    If Grilla1.Rows > 2 Then
    
        Grilla1.Rows = Grilla1.Rows - 1
        
    End If
    
End Sub
Sub Grabar()
        
    'declaracion de variables locales
    Dim I As Integer
    Dim ll_monto1 As Double
    Dim ll_monto2 As Double
    
    With Grilla1
    
        'valido montos de la grilla
        For I = 1 To .Rows - 1
            
            ll_monto1 = CDbl(.TextMatrix(I, 2))
            ll_monto2 = CDbl(.TextMatrix(I, 3))
            'comparo valores
            If ll_monto1 < ll_monto2 Then
            
                'aviso al usuario
                MsgBox "Los montos ingresados para " & .TextMatrix(I, 1) & " no son validos", vbCritical, gsBac_Version
                
                Exit Sub
                
            End If
            
        Next
            
        'recorro grilla
        For I = 1 To .Rows - 1
        
            Envia = Array()
            
            AddParam Envia, CDbl(.TextMatrix(I, 0))
            AddParam Envia, CDbl(.TextMatrix(I, 2))
            AddParam Envia, CDbl(.TextMatrix(I, 3))
            
            'ejecuto sp
            If Not Bac_Sql_Execute("SP_RTECNICA_MEXTRANJERA_GRABAR", Envia) Then
            
                MsgBox "Se ha producido un error mientras se guardaban los datos", vbCritical, gsBac_Version
                
                Exit Sub
            End If
                                   
        Next
        
        MsgBox "Los datos fueron grabados exitosamente", vbInformation, gsBac_Version
    End With
End Sub
Sub Titulos_grilla()

    Grilla1.Cols = 4
    
    'defino ancho de celdas
    Grilla1.ColWidth(0) = 0
    Grilla1.ColWidth(1) = 6000
    Grilla1.ColWidth(2) = 1500
    Grilla1.ColWidth(3) = 1500
        
    Grilla1.TextMatrix(0, 1) = "Detalle"
    Grilla1.TextMatrix(0, 2) = "Monto Exigible"
    Grilla1.TextMatrix(0, 3) = "Monto Ocupado"

End Sub
Sub pos_texto(Key As Integer)

    With txtNumero1
    
        .Width = Grilla1.CellWidth - 20
        .Height = Grilla1.CellHeight
        .Top = Grilla1.CellTop + Grilla1.Top + 20
        .Left = Grilla1.CellLeft + Grilla1.Left + 20
        
        .Text = ""
        
        If IsNumeric(Chr(Key)) Then
            .Text = Chr(Key)
        
        End If
        
        If Key = 13 Then
        
            .Text = Grilla1.Text
        End If
        
        .Visible = True
        .Tag = Grilla1.Name
        .SetFocus
        .SelStart = Len(.Text)
        
    End With

End Sub

Private Sub Form_Load()

    Me.Icon = BacTrader.Icon
    Me.Top = 0
    Me.Left = 0
    'lleno titulos
    Call Titulos_grilla
    
    'recupero data
    Call Llena_Grilla
    
End Sub

Private Sub Grilla1_KeyPress(KeyAscii As Integer)

    If (Grilla1.Col = 2 Or Grilla1.Col = 3) And IsNumeric(Chr(KeyAscii)) _
        Or KeyAscii = 13 Then
    
        'muestro text
        Call pos_texto(KeyAscii)
        
    End If
End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Key
    
    Case Is = "cmdGrabar": Call Grabar
    Case Is = "cmdSalir": Unload Me

End Select
End Sub

Private Sub txtNumero1_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then

        Grilla1.Text = Format(txtNumero1.Text, "###,###,###,###,##0")

        If txtNumero1.Text = "" Then Grilla1.Text = "0"

        txtNumero1.Visible = False

        Bac_SendKey (vbKeyRight)

    ElseIf KeyAscii = 27 Then

        txtNumero1.Visible = False
    
    End If
    
End Sub

Private Sub txtNumero1_LostFocus()

txtNumero1.Visible = False

End Sub
