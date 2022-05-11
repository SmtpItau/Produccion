VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FrmMantenedorTasa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Tasa"
   ClientHeight    =   4455
   ClientLeft      =   2550
   ClientTop       =   1935
   ClientWidth     =   11805
   Icon            =   "FrmMantenedorTasa.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4455
   ScaleWidth      =   11805
   Begin Threed.SSPanel SSPanel1 
      Height          =   3990
      Left            =   -120
      TabIndex        =   0
      Top             =   510
      Width           =   11955
      _Version        =   65536
      _ExtentX        =   21087
      _ExtentY        =   7038
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
      BevelInner      =   2
      Begin BACControles.TXTNumero texto 
         Height          =   345
         Left            =   1530
         TabIndex        =   6
         Top             =   1770
         Visible         =   0   'False
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   609
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
      End
      Begin VB.Frame FrmInstrumento 
         Height          =   585
         Left            =   150
         TabIndex        =   3
         Top             =   90
         Width           =   11565
         Begin VB.ComboBox CmbInstrumento 
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
            Left            =   1200
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   180
            Width           =   10260
         End
         Begin VB.Label LblInstrumento 
            AutoSize        =   -1  'True
            Caption         =   "Instrumento"
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
            Left            =   90
            TabIndex        =   1
            Top             =   240
            Width           =   1005
         End
      End
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   3015
         Left            =   120
         TabIndex        =   2
         Top             =   810
         Width           =   11730
         _ExtentX        =   20690
         _ExtentY        =   5318
         _Version        =   393216
         RowHeightMin    =   315
         BackColor       =   -2147483644
         BackColorBkg    =   -2147483636
         GridColorFixed  =   16777215
         Enabled         =   0   'False
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   11805
      _ExtentX        =   20823
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   8
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "FrmMantenedorTasa.frx":000C
      OLEDropMode     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8490
      Top             =   690
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorTasa.frx":0326
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorTasa.frx":1200
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorTasa.frx":20DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorTasa.frx":2FB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorTasa.frx":3E8E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FrmMantenedorTasa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cFamiliaInstrumento As String
Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   
   Me.Icon = Acceso_Usuario.Icon
   
   Call BuscaCombo
   Call CargarGrid
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   texto.Visible = False
   
   Select Case Button.Index
    Case 1 'Limpiar

        Call BuscaCombo
        Call CargarGrid
    Case 2
       Call Graba
       Call BuscaCombo
       Call CargarGrid
    Case 3
       Call Elimina
       Call BuscaCombo
       Call CargarGrid
    Case 4
         Call Busca
         Grid1.Enabled = True
         Grid1.SetFocus
    Case 5  'Salir
       Unload Me
   End Select

End Sub

Private Sub CmbInstrumento_Change()
   Toolbar1.Buttons(4).Enabled = True
End Sub

Private Sub CmbInstrumento_Click()
   Toolbar1.Buttons(4).Enabled = True
   Toolbar1.Buttons(3).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   Call Busca
   Grid1.Enabled = True
   Grid1.SetFocus
End Sub

Private Sub Grid1_KeyDown(KEYCODE As Integer, Shift As Integer)
     Call Grid_KeyDown(KEYCODE, Shift, Grid1)
End Sub

Private Sub Grid1_KeyPress(KeyAscii As Integer)
     If KeyAscii = 27 Then
        Unload Me
        Exit Sub
     End If
     Call Grid_KeyPress(KeyAscii, Grid1, texto)
End Sub

Private Sub Texto_KeyDown(KEYCODE As Integer, Shift As Integer)
    Call TextoKeyDown(KEYCODE, Shift, Grid1, texto)
End Sub

Sub TextoKeyDown(KEYCODE As Integer, Shift As Integer, Grid As MSFlexGrid, texto As Control)
     If KEYCODE = vbKeyEscape Then
        texto.Visible = False
        Grid.SetFocus
     End If
     If KEYCODE = vbKeyReturn Then
     
       If Grid1.Col = 1 Or Grid1.Col = 2 Then
         
         If Grid1.Col = 1 And Grid.Rows > 3 Then
            If CDbl(Grid1.TextMatrix(Grid1.Row - 1, Grid1.Col + 1)) >= CDbl(texto.Text) Then
               MsgBox "El plazo que ingreso no corresponde ", vbCritical, TITSISTEMA
               texto.Text = Grid1.TextMatrix(Grid1.Row - 1, Grid1.Col + 1) + 1
               Grid1.TextMatrix(Grid1.Row, Grid1.Col) = Grid1.TextMatrix(Grid1.Row - 1, Grid1.Col + 1) + 1
               texto.Visible = False
               Grid.SetFocus
               Exit Sub
            ElseIf Grid1.Col = 1 And texto.Text = Grid1.TextMatrix(Grid1.Row, Grid1.Col + 1) Then
               Grid1.TextMatrix(Grid1.Row, Grid1.Col + 1) = Grid1.TextMatrix(Grid1.Row, Grid1.Col + 1) + 1
            ElseIf Grid1.Col = 1 And CDbl(texto.Text) > CDbl(Grid1.TextMatrix(Grid1.Row, Grid1.Col + 1)) Then
               Grid1.TextMatrix(Grid1.Row, Grid1.Col + 1) = texto.Text + 1
            End If
         End If
         
         If Grid1.Col = 2 And Grid.Rows > 3 Then
            If CDbl(Grid1.TextMatrix(Grid1.Row, Grid1.Col - 1)) >= CDbl(texto.Text) Then
               MsgBox "El plazo que ingreso no corresponde ", vbCritical, TITSISTEMA
               texto.Text = Grid1.TextMatrix(Grid1.Row, Grid1.Col - 1) + 1
               Grid1.TextMatrix(Grid1.Row, Grid1.Col) = Grid1.TextMatrix(Grid1.Row, Grid1.Col - 1) + 1
               texto.Visible = False
               Grid.SetFocus
               Exit Sub
            End If
         End If
         
         Grid1.Text = Format(texto.Text, FEntero)
       Else
         Grid1.Text = Format(texto.Text, FDecimal)
       End If
       Grid1.SetFocus
     End If
End Sub

Private Sub Texto_LostFocus()
   If Grid1.Col = 1 Or Grid1.Col = 2 Then
     Grid1.Text = Format(texto.Text, FEntero)
   Else
     Grid1.Text = Format(texto.Text, FDecimal)
   End If
  texto.Visible = False
End Sub

Sub CargarGrid()
   cFamiliaInstrumento = ""
   Titulos1 = Array("       ", "Dias ", "Dias ", "% Desviacion", "% Desviacion", "Tasa", "Seriado")
   Titulos2 = Array("Familia", "Desde", "Hasta", "Minima", "Maxima", "", "") '"SBIF", "")
   Anchos = Array("1600", "1000", "1000", "2200", "2200", "2200", "0") '"2100", "2000")
   Call PROC_CARGARGRILLA(Grid1, 315, 215, Anchos, Titulos1, , Titulos2)
   Grid1.Col = 0
   Grid1.Row = Grid1.FixedRows
   Grid1.Rows = Grid1.Rows - 1
   Call InsertarRow(Grid1)
   Grid1.Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   
End Sub

Private Function InsertarRow(Grid As MSFlexGrid)
    Dim Monto   As Integer
    Grid1.Rows = Grid1.Rows + 1
    Grid1.Row = Grid1.Rows - 1
    Grid1.Col = 0
    
    Grid1.TextMatrix(Grid1.Row, 0) = IIf(cFamiliaInstrumento = "", "", cFamiliaInstrumento)
    Grid1.TextMatrix(Grid1.Row, 1) = 0
    Grid1.TextMatrix(Grid1.Row, 2) = 0
    Grid1.TextMatrix(Grid1.Row, 3) = 0
    Grid1.TextMatrix(Grid1.Row, 4) = 0
    Grid1.TextMatrix(Grid1.Row, 5) = 0
    Grid1.TextMatrix(Grid1.Row, 6) = ""
    
    Grid1.TextMatrix(Grid1.Row, 1) = Format(Grid1.TextMatrix(Grid1.Row, 1), FEntero)
    Grid1.TextMatrix(Grid1.Row, 2) = Format(Grid1.TextMatrix(Grid1.Row, 2), FEntero)
    Grid1.TextMatrix(Grid1.Row, 3) = Format(Grid1.TextMatrix(Grid1.Row, 3), FDecimal)
    Grid1.TextMatrix(Grid1.Row, 4) = Format(Grid1.TextMatrix(Grid1.Row, 4), FDecimal)
    Grid1.TextMatrix(Grid1.Row, 5) = Format(Grid1.TextMatrix(Grid1.Row, 5), FDecimal)
    Grid1.TextMatrix(Grid1.Row, 6) = Format(Grid1.TextMatrix(Grid1.Row, 6), FDecimal)
    
    SendKeys "{HOME}"

End Function

Private Function Graba()
    
    Dim I%
    Dim datos()
    
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
       MsgBox "Error en Begin Transaction", vbCritical, TITSISTEMA
       Exit Function
    End If
    
        Envia = Array("E", _
                 Trim(Right(CmbInstrumento.Text, 5)))

        If Not Bac_Sql_Execute("SP_MNT_TASA_INSTRUMENTOS", Envia) Then
           MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
           Exit Function
        End If
    
    For I% = 2 To Grid1.Rows - 1
         Envia = Array("G", _
                       CDbl(Trim(Right(Grid1.TextMatrix(I%, 0), 5))), _
                       CDbl(Grid1.TextMatrix(I%, 1)), _
                       CDbl(Grid1.TextMatrix(I%, 2)), _
                       CDbl(Grid1.TextMatrix(I%, 3)), _
                       CDbl(Grid1.TextMatrix(I%, 4)), _
                       CDbl(IIf(Grid1.TextMatrix(I%, 5) = "SAFP", 0, Grid1.TextMatrix(I%, 5))))

        If Not Bac_Sql_Execute("SP_MNT_TASA_INSTRUMENTOS", Envia) Then

            Envia = Array("R")

            If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then

                MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
                Grid1.SetFocus

                Exit Function

            End If

            MsgBox "No se puede Grabar problema con la comunicacion", vbCritical, TITSISTEMA
            Grid1.SetFocus

            Exit Function

        End If

    Next I%
   
    Envia = Array("C")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
        MsgBox "Error en Commit Transaction", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    MsgBox "Grabación Realizada con Exito", vbInformation, TITSISTEMA
    
    Call CargarGrid
End Function

Private Function Elimina()
   
    res = MsgBox("Esta seguro que desea Eliminar?", vbYesNo + vbQuestion, TITSISTEMA)
    If res = vbYes Then
        
        Envia = Array("E", _
                 Trim(Right(CmbInstrumento.Text, 5)))

        If Not Bac_Sql_Execute("SP_MNT_TASA_INSTRUMENTOS", Envia) Then
           MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
           Exit Function
        End If
        
        MsgBox "Eliminación realizada con exito", vbInformation, TITSISTEMA
        Call CargarGrid
    End If
End Function

Private Function Busca()
    Dim I%
    Dim datos()
    cFamiliaInstrumento = ""
    
    Envia = Array("B", _
                 Trim(Right(CmbInstrumento.Text, 5)))

    If Not Bac_Sql_Execute("SP_MNT_TASA_INSTRUMENTOS", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    Grid1.Rows = Grid1.FixedRows
    
       
    Do While Bac_SQL_Fetch(datos())
        
        Grid1.Rows = Grid1.Rows + 1
        Grid1.Row = Grid1.Rows - 1
        Grid1.TextMatrix(Grid1.Row, 0) = ""
        Grid1.TextMatrix(Grid1.Row, 0) = datos(2) + Space(150) + datos(1)
        cFamiliaInstrumento = datos(2) + Space(150) + datos(1)
        Grid1.TextMatrix(Grid1.Row, 1) = Format(datos(3), FEntero)
        Grid1.TextMatrix(Grid1.Row, 2) = Format(datos(4), FEntero)
        Grid1.TextMatrix(Grid1.Row, 3) = Format(datos(5), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 4) = Format(datos(6), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 5) = Format(datos(7), FDecimal)
        'Grid1.TextMatrix(Grid1.Row, 5) = IIf(datos(8) = "N", Format(datos(7), FDecimal), "SAFP")
        Grid1.TextMatrix(Grid1.Row, 6) = datos(8)
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    Loop
    
    If Grid1.Rows = Grid1.FixedRows Then
        Call InsertarRow(Grid1)
        Grid1.TextMatrix(Grid1.Row, 0) = Me.CmbInstrumento.Text
    End If
    
    Grid1.Col = 0
    Grid1.Row = Grid1.FixedRows

End Function

Sub Grid_KeyPress(KeyAscii As Integer, Grid As MSFlexGrid, texto As Control)
    
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        If Grid.Col <> 0 Then
            Call textovisible(Grid, texto)
            texto.Text = Chr(KeyAscii)
            texto.SelStart = 1
        End If
    End If

End Sub

Sub Grid_KeyDown(KEYCODE As Integer, Shift As Integer, Grid As MSFlexGrid)
    If KEYCODE = 45 Then
      Call InsertarRow(Grid1)
      Grid1.TextMatrix(Grid1.Row, 0) = Grid1.TextMatrix(Grid1.Row - 1, 0)
      Grid1.TextMatrix(Grid1.Row, 1) = Grid1.TextMatrix(Grid1.Row - 1, 2) + 1
      Grid1.TextMatrix(Grid1.Row, 2) = Grid1.TextMatrix(Grid1.Row, 1) + 1
      Grid1.SetFocus
    End If
    
    If KEYCODE = 46 Then
      
      res = MsgBox("Esta Seguro que Desea Eliminar", vbQuestion + vbYesNo, TITSISTEMA)
      If res = vbYes Then
         Grid1.Rows = Grid1.Rows - 1
            If Grid.Rows = Grid1.FixedRows Then
               Call InsertarRow(Grid)
            End If
      End If
      Grid1.SetFocus
      
    End If
    If KEYCODE = 13 Then
        If Grid.Col > 1 Then
        
          If Grid.Col = 5 And Grid.TextMatrix(Grid.Row, 6) = "S" Then
          
          Else
            Call textovisible(Grid, texto)
          End If
        End If
    End If
End Sub

Sub textovisible(Grid As MSFlexGrid, texto As Control)
    
    If Grid.Col = 1 Or Grid.Col = 2 Then
        texto.CantidadDecimales = 0
        texto.Max = "99999"
        texto.Text = Grid.Text
    ElseIf Grid.Col = 3 Then
        texto.CantidadDecimales = 4
        texto.Max = "999999"
        texto.Text = Grid.Text
    ElseIf Grid.Col = 4 Or Grid.Col = 5 Or Grid.Col = 6 Then
        texto.CantidadDecimales = 4
        texto.Max = "99999999999"
        texto.Text = Grid.Text
    End If
    Call PROC_POSICIONA_TEXTO(Grid, texto)
    texto.Visible = True
    texto.SetFocus
End Sub

Private Function BuscaCombo()
    Dim I%
    Dim datos()
       CmbInstrumento.Clear
    
    Envia = Array("C")

    If Not Bac_Sql_Execute("SP_MNT_TASA_INSTRUMENTOS", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Function
    End If
 
    Do While Bac_SQL_Fetch(datos())
      CmbInstrumento.AddItem datos(1) + Space(150) + datos(2)
    Loop
    
End Function
