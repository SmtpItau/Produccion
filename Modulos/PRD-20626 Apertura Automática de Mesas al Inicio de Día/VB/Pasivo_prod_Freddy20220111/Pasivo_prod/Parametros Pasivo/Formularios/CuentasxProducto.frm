VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form CuentasxProducto 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cuentas por Producto"
   ClientHeight    =   4440
   ClientLeft      =   -15
   ClientTop       =   1605
   ClientWidth     =   10740
   Icon            =   "CuentasxProducto.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4440
   ScaleWidth      =   10740
   Begin Threed.SSPanel SSPanel1 
      Height          =   3945
      Left            =   0
      TabIndex        =   1
      Top             =   495
      Width           =   10740
      _Version        =   65536
      _ExtentX        =   18944
      _ExtentY        =   6959
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
      BevelOuter      =   1
      Begin Threed.SSFrame SSFrame1 
         Height          =   3900
         Left            =   15
         TabIndex        =   2
         Top             =   30
         Width           =   10710
         _Version        =   65536
         _ExtentX        =   18891
         _ExtentY        =   6879
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
         Begin BACControles.TXTNumero TXTNumero 
            Height          =   375
            Left            =   240
            TabIndex        =   6
            Top             =   2400
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   661
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
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.ComboBox CmbGrilla 
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
            ItemData        =   "CuentasxProducto.frx":030A
            Left            =   225
            List            =   "CuentasxProducto.frx":030C
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   1665
            Visible         =   0   'False
            Width           =   1365
         End
         Begin VB.TextBox TxtGrilla 
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
            Height          =   330
            Left            =   210
            MouseIcon       =   "CuentasxProducto.frx":030E
            MousePointer    =   99  'Custom
            TabIndex        =   3
            Top             =   1995
            Visible         =   0   'False
            Width           =   1365
         End
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   3960
            Left            =   -30
            TabIndex        =   5
            Top             =   -15
            Width           =   10755
            _ExtentX        =   18971
            _ExtentY        =   6985
            _Version        =   393216
            Rows            =   3
            FixedRows       =   2
            RowHeightMin    =   315
            BackColor       =   12632256
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorBkg    =   12632256
            GridColor       =   0
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5385
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "CuentasxProducto.frx":0618
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "CuentasxProducto.frx":0A6A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "CuentasxProducto.frx":0D84
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "CuentasxProducto.frx":11D6
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "CuentasxProducto.frx":14F0
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "CuentasxProducto.frx":1942
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "CuentasxProducto.frx":1C5C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10740
      _ExtentX        =   18944
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "PRODUCTO"
            Object.ToolTipText     =   "Producto Código RCC"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "CuentasxProducto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim dEmcodigo   As Double
Dim cEmnombre   As String
Dim cEmgeneric  As String
Dim cEmdirecc   As String
Dim dEmcomuna   As Double
Dim dEmtipo     As Double


Private Sub CmbGrilla_DblClick()

   CmbGrilla_KeyPress 13

End Sub

Private Sub CmbGrilla_GotFocus()

   Grilla.Tag = CmbGrilla.Text

End Sub

Private Sub CmbGrilla_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
      Case 13
            
            Grilla.Text = CmbGrilla.Text
            CmbGrilla.Visible = False
            Grilla.SetFocus
            
      Case 27
                  
            CmbGrilla.Visible = False
            
   End Select

End Sub

Private Sub CmbGrilla_LostFocus()
   
   If Grilla.Col = 1 Then
               
      If Grilla.Text <> Grilla.Tag Then
         
         Grilla.TextMatrix(Grilla.Row, 2) = ""
         Grilla.TextMatrix(Grilla.Row, 4) = ""
         Grilla.TextMatrix(Grilla.Row, 5) = ""
         Grilla.TextMatrix(Grilla.Row, 6) = ""
      
      End If
   
   End If
   
   If Grilla.Col = 2 Then
               
      If Grilla.Text <> Grilla.Tag Then
         
         Grilla.TextMatrix(Grilla.Row, 4) = ""
         Grilla.TextMatrix(Grilla.Row, 5) = ""
      
      End If
   
   End If
   
   CmbGrilla.Visible = False
   TxtGrilla.Visible = False
   Grilla.SetFocus

End Sub

Private Sub Form_Load()

   Me.top = 0
   Me.left = 0
   Me.Icon = BAC_Parametros.Icon
   Carga_grilla
   Carga_Datos
   If Grilla.Rows = 2 Then
   
      Grilla.Rows = Grilla.Rows + 1
      Grilla.Row = 2
   
   End If
   
End Sub


Private Sub Grilla_DblClick()

   Grilla_KeyPress 13

End Sub


Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

         CmbGrilla.Tag = Grilla.Text
         
         If KeyCode = vbKeyInsert Or KeyCode = vbKeyDelete Then
            TextoGrilla CmbGrilla, KeyCode, KeyCode
         End If

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)
   
   TxtGrilla.MaxLength = 100
   
   Select Case Grilla.Col

      Case 1, 2, 3, 4, 5, 6, 8, 12, 13, 14, 9, 10, 12, 11  ', 25
         TextoGrilla CmbGrilla, 13, KeyAscii

      Case 17, 18, 19, 20, 15, 16, 21, 22, 23, 24
         
         TextoGrilla TxtGrilla, 13, Asc(UCase(Chr(KeyAscii)))
   
      Case 7, 25
         TextoGrilla TXTNumero, 13, KeyAscii
       
   End Select

End Sub

Private Sub Grilla_Scroll()
   
   CmbGrilla.Visible = False
   TxtGrilla.Visible = False
   Grilla.SetFocus

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)
   
      Case "GRABAR"
         
         If Campos_Blancos Then
      
            Call Grabar_Cuentas
      
         Else
         
            MsgBox "Falta Información por Ingresar", vbExclamation, TITSISTEMA
            If Grilla.Enabled Then
               Grilla.SetFocus
            End If
         End If
      
      Case "ELIMINAR"
         
             TextoGrilla TxtGrilla, 0, 46
      
      Case "IMPRIMIR"
      
         On Error GoTo ErrorRpt:
         Call limpiar_cristal
         Screen.MousePointer = vbHourglass
         BAC_Parametros.BacParam.Destination = crptToWindow
         BAC_Parametros.BacParam.ReportFileName = gsRPT_Path & "Cuentas_producto.rpt"
         BAC_Parametros.BacParam.WindowTitle = "INFORME DE CUENTAS POR PRODUCTO"
         BAC_Parametros.BacParam.Connect = SwConeccion
         BAC_Parametros.BacParam.Action = 1
         Screen.MousePointer = vbDefault
         Exit Sub
ErrorRpt:
         Screen.MousePointer = vbDefault
         MsgBox "Problemas Al Emitir Informe", vbExclamation, TITSISTEMA
         
      Case "SALIR"
         Unload Me
         
      Case "PRODUCTO"
           'BacProdRCC.Show 1
      
   End Select

End Sub

Sub Toolbar(G, E, L, S As String)

   Toolbar1.Buttons(1).Enabled = IIf(G = 1, True, False)
   Toolbar1.Buttons(2).Enabled = IIf(E = 1, True, False)
   Toolbar1.Buttons(3).Enabled = IIf(L = 1, True, False)
   Toolbar1.Buttons(4).Enabled = IIf(S = 1, True, False)

End Sub

Sub Carga_Sistemas()
   
    CmbGrilla.Clear
    
    If BAC_SQL_EXECUTE("SP_BUSCAR_SISTEMAS") Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            CmbGrilla.AddItem Mid$(Datos(2), 1, 20) & Space(50) & Datos(1)
        
        Loop
    
    Else
        
        MsgBox "No se pudo obtener información del servidor", vbCritical, TITSISTEMA
        Exit Sub
    
    End If

End Sub


Sub CargaCombos(xCombo As ComboBox, xOperacion As String)
On Error Resume Next

   Select Case UCase(xOperacion)

      Case "OPERACION"
            
               xCombo.Clear
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Evento") Then
               
                  MsgBox "Problemas al Buscar Operación", vbExclamation, TITSISTEMA
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(1)
            
               Wend
                           
               xCombo.ListIndex = -1
               
      Case "PRODUCTO"
      
               xCombo.Clear
               Envia = Array()
               AddParam Envia, right(Grilla.TextMatrix(Grilla.Row, 1), 3)
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Producto", Envia) Then
               
                  MsgBox "Problemas al Buscar Producto", vbExclamation, TITSISTEMA
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(1)
            
               Wend
            
      Case "MONEDA"
            
               xCombo.Clear
               Envia = Array()
               AddParam Envia, Trim(right(Grilla.TextMatrix(Grilla.Row, 2), 5))
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Moneda", Envia) Then
               
                  MsgBox "Problemas al Buscar Moneda", vbExclamation, TITSISTEMA
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(1)
                  'xcombo.ItemData(xcombo.NewIndex) = Datos(1)
            
               Wend
            
      Case "INSTRUMENTO"
            
               xCombo.Clear
               Envia = Array()
               AddParam Envia, right(Grilla.TextMatrix(Grilla.Row, 1), 3)
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Instrumento", Envia) Then
               
                  MsgBox "Problemas al Buscar Moneda", vbExclamation, TITSISTEMA
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(2)
                  xCombo.ItemData(xCombo.NewIndex) = Datos(1)
            
               Wend
   
      Case "TIPO OPERACION"
         
               xCombo.Clear
               xCombo.AddItem ""
               xCombo.AddItem "COMPRA"
               xCombo.AddItem "VENTA"
               xCombo.AddItem "COLOCACION"
               xCombo.AddItem "CAPTACION"
               
      
      Case "MODALIDAD"
         
               xCombo.Clear
               xCombo.AddItem ""
               xCombo.AddItem "FISICA"
               xCombo.AddItem "COMPENSACION"
      
      Case "TIPO MERCADO"
         
               xCombo.Clear
               xCombo.AddItem ""
               xCombo.AddItem "EXTERNO"
               xCombo.AddItem "LOCAL"
   
   
      Case "TIPO EMISOR", "PLAZO", "TIPO CLIENTE", "CARTERA SUPER", "PRODUCTO INTERFAZ"
   
               xCombo.Clear
               xCombo.AddItem ""
               Envia = Array()
               AddParam Envia, UCase(xOperacion)
               If Not BAC_SQL_EXECUTE("Sp_CamposXproducto_Combo", Envia) Then
               
                  MsgBox "Problemas al Buscar Operación", vbExclamation, TITSISTEMA
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(1)
            
               Wend
               xCombo.ListIndex = -1
   
         Case "FORMA DE PAGO"
      
               xCombo.Clear
               xCombo.AddItem ""
              
               If Not BAC_SQL_EXECUTE("SP_LEER_FORMA_DE_PAGO") Then
               
                  MsgBox "Problemas al Buscar Forma de Pago", vbExclamation, TITSISTEMA
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(1)
            
               Wend
   
   End Select

End Sub


Sub Carga_grilla()

   With Grilla
   
      .RowHeight(0) = 260
      .RowHeight(1) = 260
      .Cols = 26
      .Rows = 3
      .TextMatrix(0, 1) = "Sistema"
      .TextMatrix(0, 2) = "Producto"
      .TextMatrix(0, 3) = "Moneda1"
      .TextMatrix(0, 4) = "Moneda2"
      .TextMatrix(0, 5) = "Instrumento"
      .TextMatrix(0, 6) = "Tipo": .TextMatrix(1, 6) = "Operación"
      .TextMatrix(0, 7) = "Emisor/Pais"
      .TextMatrix(0, 8) = "Tipo": .TextMatrix(1, 8) = "Emisor"
      .TextMatrix(0, 9) = "Plazo"
      .TextMatrix(0, 10) = "Tipo": .TextMatrix(1, 10) = "Cliente"
''agregar forma pago
      .TextMatrix(0, 11) = "Forma": .TextMatrix(1, 11) = "Pago"
      .TextMatrix(0, 12) = "Modalidad"
      .TextMatrix(0, 13) = "Tipo": .TextMatrix(1, 13) = "Mercado"
      .TextMatrix(0, 14) = "Cartera": .TextMatrix(1, 14) = "Super"
      .TextMatrix(0, 15) = "Descripcion"
      .TextMatrix(0, 16) = "Cuenta": .TextMatrix(1, 16) = "Capital"
      .TextMatrix(0, 17) = "Cuenta": .TextMatrix(1, 17) = "Interes"
      .TextMatrix(0, 18) = "Cuenta": .TextMatrix(1, 18) = "Reajuste"
      .TextMatrix(0, 19) = "Cuenta Resultado": .TextMatrix(1, 19) = "Interes"
      .TextMatrix(0, 20) = "Cuenta Resultado": .TextMatrix(1, 20) = "Reajuste"
      .TextMatrix(0, 21) = "Codigo": .TextMatrix(1, 21) = "Producto"
      .TextMatrix(0, 22) = "Cuenta P17"
      .TextMatrix(0, 23) = "Producto P17"
      .TextMatrix(0, 24) = "Código P17"
      .TextMatrix(0, 25) = "Moneda": .TextMatrix(1, 25) = "Contable"
      .ColWidth(0) = 0
      .ColWidth(1) = 1600
      .ColWidth(2) = 4100
      .ColWidth(3) = 890
      .ColWidth(4) = 890
      .ColWidth(5) = 2300
      .ColWidth(6) = 1400
      .ColWidth(7) = 2000 '1250
      .ColWidth(8) = 2970
      .ColWidth(9) = 1800
      .ColWidth(10) = 2865
      .ColWidth(11) = 1800
      .ColWidth(12) = 1740
      .ColWidth(13) = 1470
      .ColWidth(14) = 1665
      .ColWidth(15) = 4470
      .ColWidth(16) = 1650
      .ColWidth(17) = 1650
      .ColWidth(18) = 1650
      .ColWidth(19) = 1650
      .ColWidth(20) = 1650
      .ColWidth(21) = 4000
      .ColWidth(22) = 1500
      .ColWidth(23) = 1500
      .ColWidth(24) = 1500
      .ColWidth(25) = 1500
'      .ColAlignment(7) = 1
'      .ColAlignment(8) = 1
      .ColAlignment(9) = 1
      .ColAlignment(10) = 1
   
   End With

End Sub



Sub TextoGrilla(xText As Control, Key, Keypress As Integer)
Dim X As Integer
   With Grilla
   
      Select Case .Col
      
         Case 1
      
                If Key = 13 Then
                  
                     Call Carga_Sistemas
                     
                     If .Text <> "" Then
                        For X = 0 To xText.ListCount - 1
                           xText.ListIndex = X
                           If right(xText, 3) = right(.Text, 3) Then
                              Exit For
                           End If
                        Next X
                     End If
                     
                     PROC_POSICIONA_TEXTO Grilla, xText
                     xText.Visible = True
                     xText.SetFocus
                     
                End If
      
         Case 2
      
                If Key = 13 Then
                  
                     If .TextMatrix(.Row, 1) <> "" Then
                  
                        CargaCombos CmbGrilla, "PRODUCTO"
                        
                        If .Text <> "" Then
                           For X = 0 To xText.ListCount - 1
                              xText.ListIndex = X
                              If right(xText, 4) = right(.Text, 4) Then
                                 Exit For
                              End If
                           Next X
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                                   
                     End If
                    
                End If
      
'         Case 3
'
'                If Key = 13 Then
'
'                     CargaCombos CmbGrilla, "OPERACION"
'
'                     If .Text <> "" Then
'
'                        xText.Text = .Text
'
'                     End If
'
'                     PROC_POSICIONA_TEXTO Grilla, xText
'                     xText.Visible = True
'                     xText.SetFocus
'
'                End If

         Case 3, 4
                If Key = 13 Then
                  
                     If .TextMatrix(.Row, 2) <> "" Then
                     
                        CargaCombos CmbGrilla, "MONEDA"
                        
                        If .Text <> "" Then
                        On Error Resume Next
                           
                           xText.Text = .Text
                           
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                                 
                     End If
                     
                End If
   
         Case 5
   
                If Key = 13 Then
                  
                     If right(.TextMatrix(.Row, 1), 3) = "BTR" Then
                  
                        CargaCombos CmbGrilla, "INSTRUMENTO"
                        On Error Resume Next
                        
                        If .Text <> "" Then
                           
                           xText.Text = .Text
                           
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                     End If
                                      
                End If
                
         Case 6
   
                If Key = 13 Then
                        
                        CargaCombos CmbGrilla, "TIPO OPERACION"
                        
                        If .Text <> "" Then
                           
                           xText.Text = .Text
                           
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If
                
         Case 8
   
                If Key = 13 Then
                        
                        CargaCombos CmbGrilla, "TIPO EMISOR"
                        
                        If Trim(.Text) <> "" Then
                        On Error GoTo Omitir
                           xText.Text = .Text
                           
Omitir:                         err.Number = 0
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If
                
         Case 9
   
                If Key = 13 Then
                        
                        CargaCombos CmbGrilla, "PLAZO"
                        
                        If Trim(.Text) <> "0" And Trim(.Text) <> "" Then
                           
                           xText.Text = .Text
                           
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If
                
         Case 10
   
                If Key = 13 Then
                        
                        CargaCombos CmbGrilla, "TIPO CLIENTE"
                        
                        If Trim(.Text) <> "0" And Trim(.Text) <> "" Then
                           
                           xText.Text = .Text
                           
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If
                
         Case 12
   
                If Key = 13 Then
                  
                        CargaCombos CmbGrilla, "MODALIDAD"
                        
                        If .Text <> "" Then
                           
                           xText.Text = .Text
                           
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If
                
         Case 13
   
                If Key = 13 Then
                  
                        CargaCombos CmbGrilla, "TIPO MERCADO"
                        
                        If .Text <> "" Then
                           
                           xText.Text = .Text
                           
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                                      
                End If
                
         Case 14
   
                If Key = 13 Then
                  
                        CargaCombos CmbGrilla, "CARTERA SUPER"
                        
                        If Trim(.Text) <> "" Then
                           
                           xText.Text = .Text
                           
                        End If
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                                      
                End If
                
         Case 21
   
                If Key = 13 Then
                  
                          
                        xText.MousePointer = 0
                        TxtGrilla.MaxLength = 15
                        TxtGrilla.Text = .Text
                        TxtGrilla.Alignment = 0
                        If Keypress <> 13 Then
                        
                           xText.Text = Chr(Keypress)
                           xText.SelStart = 1
                        
                        End If
                        
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                                      
                End If
                
         Case 18, 19, 20, 21, 16, 17, 22, 23, 24
                
                If Key = 13 Then
                     
                        xText.MousePointer = 99
                        TxtGrilla.Text = .Text
                        TxtGrilla.Alignment = 1
                        
         
                        If Grilla.Col = 22 Then TxtGrilla.MaxLength = 12
                        If Grilla.Col = 23 Or Grilla.Col = 24 Then TxtGrilla.MaxLength = 10
                        If Grilla.Col <> 23 And Grilla.Col <> 24 And Grilla.Col <> 22 Then TxtGrilla.MaxLength = 0
                        
                        If Keypress <> 13 And IsNumeric(Chr(Keypress)) Then
                        
                           xText.Text = Chr(Keypress)
                           xText.SelStart = 1
                        
                        End If
                        
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If
            
         Case 11
                
                If Key = 13 Then
                  
                        CargaCombos CmbGrilla, "FORMA DE PAGO"
                        
                        If .Text <> "" Then
                           For X = 0 To xText.ListCount - 1
                              xText.ListIndex = X
                              If right(xText, 5) = right(.Text, 5) Then
                                 Exit For
                              End If
                           Next X
                        End If
                           
                           
                     
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If
            
         Case 7, 25
                
                If Key = 13 Then
                     
                        'xText.MousePointer = 99
                        'xText.Text = .Text
                        'xText.Alignment = 1
                        If .Col = 25 Then TXTNumero.Max = 99999
                        If .Col = 7 Then TXTNumero.Max = 999999999
                        
                        If Keypress <> 13 And IsNumeric(Chr(Keypress)) Then
                        
                           xText.Text = Chr(Keypress)
                           xText.SelStart = 1
                        
                        Else
                        
                           xText.Text = Grilla.Text
                        
                        End If
                        
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If

   
         Case 15
                
                If Key = 13 Then
                  
                        xText.MousePointer = 0
                        TxtGrilla.MaxLength = 80
                        TxtGrilla.Text = .Text
                        TxtGrilla.Alignment = 0
                        If Keypress <> 13 Then
                        
                           xText.Text = Chr(Keypress)
                           xText.SelStart = 1
                        
                        End If
                        
                        PROC_POSICIONA_TEXTO Grilla, xText
                        xText.Visible = True
                        xText.SetFocus
                        
                End If
   
   
      End Select
   
      Select Case Keypress
   
         Case 27
            Call CmbGrilla_LostFocus

         Case 45
            
            If Campos_Blancos Then
               
               .Rows = .Rows + 1
            
            End If
   
         Case 46
                     
                        
            
            If MsgBox("¿Esta Seguro de eliminar Registro?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            
               ' Call Eliminar
            
               If .Rows = 3 Then
               
                  .Rows = 2
                  .Rows = 3
               
               End If
               
               If .Rows > 3 Then
                                       
                     .RemoveItem (.Row)
               
               End If
            
            End If
            
            Grilla.SetFocus
            
      End Select
   
   
   
   End With
   
End Sub

Private Sub TxtGrilla_DblClick()
   
   
   Select Case Grilla.Col
   
      Case 17, 18, 19, 20, 16
      
         BacAyuda.parAyuda = "CON_PLAN_CUENTAS"
         BacAyuda.Tag = "CUENTAS"
         BacAyuda.parFiltro = ""
         BacAyuda.Show 1
         
         If giAceptar% = True Then
           
           If Trim(gsCodigo$) <> "" Then
             
             Grilla.TextMatrix(Grilla.Row, Grilla.Col) = Trim(gsCodigo$)
           
           End If
         
         End If
      
      Case 15
      
         Exit Sub
      
   End Select

End Sub

Private Sub TxtGrilla_KeyPress(KeyAscii As Integer)

   KeyAscii = Asc(UCase(Chr(KeyAscii)))

   Select Case KeyAscii
   
      Case 13
         
         If Grilla.Col <> 15 And Grilla.Col <> 7 And Grilla.Col <> 11 And Grilla.Col <> 21 And Grilla.Col <> 22 And Grilla.Col <> 23 And Grilla.Col <> 24 And Grilla.Col <> 25 Then
         
            If Not FUNC_VALIDA_CUENTA(TxtGrilla.Text) Then
         
               Grilla.SetFocus
               Exit Sub
            
            End If
         
         Else
            
            If Grilla.Col <> 15 And Grilla.Col <> 7 And Grilla.Col <> 11 And Grilla.Col <> 21 And Grilla.Col <> 22 And Grilla.Col <> 23 And Grilla.Col <> 24 And Grilla.Col <> 25 Then
            
               If Not FUNC_VALIDA_CONDICION(Trim(right(Grilla.TextMatrix(Grilla.Row, 2), 5)), TxtGrilla.Text) Then
            
                  MsgBox "Condicion NO Existe.", vbExclamation, TITSISTEMA
                  Grilla.SetFocus
                  Exit Sub
               
               End If
         
            End If
         
         End If
                  
         Grilla.Text = TxtGrilla.Text
         Grilla.SetFocus
         
      Case 27
         
         TxtGrilla.Visible = False
         
   End Select

End Sub

Private Sub TxtGrilla_LostFocus()

   TxtGrilla.Visible = False

End Sub

Function FUNC_VALIDA_CUENTA(Cuenta As String) As Boolean
Dim Datos()

   FUNC_VALIDA_CUENTA = False
   
   Envia = Array()
   AddParam Envia, Cuenta
   
   If Not BAC_SQL_EXECUTE("sp_busca_cuenta_contable ", Envia) Then
      
      Screen.MousePointer = 0
      Exit Function
   
   End If
   
   Screen.MousePointer = 0
   
   If Not BAC_SQL_FETCH(Datos()) Then
      
      MsgBox "Cuenta NO Existe.", vbExclamation, TITSISTEMA
      Exit Function
   
   End If
   
   FUNC_VALIDA_CUENTA = True

End Function



Function Campos_Blancos() As Boolean
Dim i As Integer
Dim X As Integer

   Campos_Blancos = False

   With Grilla

      For i = 2 To .Rows - 1

         For X = 1 To .Cols - 1
         
            If (X >= 1 And X <= 4) Or (X = 21) Then
            
               If (.TextMatrix(i, X) = "" And (right(.TextMatrix(i, 1), 3) <> "BTR" And X <> 6)) Or (.TextMatrix(i, X) = "" And (right(.TextMatrix(i, 1), 3) = "BTR" And X = 6)) Then
               
                  Exit Function
               
               End If
         
            End If
         
         Next X

      Next i
      
   End With

   Campos_Blancos = True

End Function


Function FUNC_VALIDA_CONDICION(Producto, Condicion As String) As Boolean
Dim Datos()

   FUNC_VALIDA_CONDICION = False
   
   Envia = Array()
   AddParam Envia, Trim(Producto)
   AddParam Envia, Trim(Condicion)
   
   If Not BAC_SQL_EXECUTE("Sp_Campo_cnt_logico_X_Producto ", Envia) Then
      
      Exit Function
   
   End If
   
   If Not BAC_SQL_FETCH(Datos()) Then
         
         Exit Function
      
   End If
   
   FUNC_VALIDA_CONDICION = True

End Function


Sub Grabar_Cuentas()
Dim i As Integer
Dim SW As String


   With Grilla
      
      SW = "1"
      
      Call BacBeginTransaction
            
      For i = 2 To .Rows - 1
      
         Envia = Array()
         AddParam Envia, right(.TextMatrix(i, 1), 3)
         AddParam Envia, Trim(right(.TextMatrix(i, 2), 10))
         AddParam Envia, CDbl(Trim(right(.TextMatrix(i, 3), 3)))
         AddParam Envia, CDbl(Trim(right(.TextMatrix(i, 4), 3)))
         AddParam Envia, Trim(right(.TextMatrix(i, 5), 15))
         AddParam Envia, IIf(.TextMatrix(i, 6) = "COLOCACION" Or .TextMatrix(i, 6) = "CAPTACION", Mid(.TextMatrix(i, 6), 2, 1), left(.TextMatrix(i, 6), 1))
         AddParam Envia, Val(Format(.TextMatrix(i, 7), "#########"))
         AddParam Envia, Val(Trim(right(.TextMatrix(i, 8), 5)))
         AddParam Envia, Val(Trim(right(.TextMatrix(i, 9), 5)))
         AddParam Envia, Val(Trim(right(.TextMatrix(i, 10), 5)))
         AddParam Envia, IIf(left(.TextMatrix(i, 12), 1) = "F", "E", left(.TextMatrix(i, 12), 1))
         AddParam Envia, left(.TextMatrix(i, 13), 1)
         AddParam Envia, left(.TextMatrix(i, 14), 1)
         AddParam Envia, .TextMatrix(i, 15)
         AddParam Envia, .TextMatrix(i, 16)
         AddParam Envia, .TextMatrix(i, 17)
         AddParam Envia, .TextMatrix(i, 18)
         AddParam Envia, .TextMatrix(i, 19)
         AddParam Envia, .TextMatrix(i, 20)
         AddParam Envia, Trim(.TextMatrix(i, 21))
         AddParam Envia, SW
         AddParam Envia, Val(Trim(right(.TextMatrix(i, 11), 5)))
         AddParam Envia, .TextMatrix(i, 22)
         AddParam Envia, .TextMatrix(i, 23)
         AddParam Envia, .TextMatrix(i, 24)
         AddParam Envia, Val(Format(.TextMatrix(i, 25), "#####"))

      
         If Not BAC_SQL_EXECUTE("Sp_CuentaXProducto_Graba", Envia) Then
         
         Call BacRollBackTransaction
            
            MsgBox "Problemas con la Grabación", vbExclamation, TITSISTEMA
            Exit Sub
      
         End If
      
         SW = "0"
      
      Next i
      
      Call BacCommitTransaction
      
      MsgBox "Cuentas Grabadas sin Problemas", vbInformation, TITSISTEMA

   End With

End Sub


Sub Carga_Datos()

   If Not BAC_SQL_EXECUTE("Sp_CuentasXproducto_LeerTabla") Then
   
   
   End If
   
   With Grilla
   
      .Rows = 2
   
      While BAC_SQL_FETCH(Datos())
      
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, 1) = Datos(2) + Space(80) + Datos(1)
            .TextMatrix(.Rows - 1, 2) = Datos(4) + Space(80) + Datos(3)
            .TextMatrix(.Rows - 1, 3) = Datos(6) + Space(80) + Datos(5)
            .TextMatrix(.Rows - 1, 4) = Datos(8) + Space(80) + Datos(7)
            .TextMatrix(.Rows - 1, 5) = Datos(9) + Space(80) + Datos(9)
            .TextMatrix(.Rows - 1, 6) = Datos(11)
            .TextMatrix(.Rows - 1, 7) = IIf(Format(Datos(12), FEntero) = 0, "", Format(Datos(12), FEntero)) '+ Space(80) + datos(12)
            .TextMatrix(.Rows - 1, 8) = Datos(15) + Space(80) + Datos(14)
            .TextMatrix(.Rows - 1, 9) = Datos(17) + Space(80) + Datos(16)
            .TextMatrix(.Rows - 1, 10) = Datos(19) + Space(80) + Datos(18)
            .TextMatrix(.Rows - 1, 11) = Datos(33) + Space(80) + Datos(32)
            .TextMatrix(.Rows - 1, 12) = Datos(20)
            .TextMatrix(.Rows - 1, 13) = Datos(21)
            .TextMatrix(.Rows - 1, 14) = Datos(23) + Space(80) + Datos(22)
            .TextMatrix(.Rows - 1, 15) = Datos(24)
            .TextMatrix(.Rows - 1, 16) = Datos(25)
            .TextMatrix(.Rows - 1, 17) = Datos(26)
            .TextMatrix(.Rows - 1, 18) = Datos(27)
            .TextMatrix(.Rows - 1, 19) = Datos(28)
            .TextMatrix(.Rows - 1, 20) = Datos(29)
            .TextMatrix(.Rows - 1, 21) = Datos(31) + Space(80) + Datos(30)
            .TextMatrix(.Rows - 1, 22) = Datos(34)
            .TextMatrix(.Rows - 1, 23) = Datos(35)
            .TextMatrix(.Rows - 1, 24) = Datos(36)
            .TextMatrix(.Rows - 1, 25) = Datos(37)
      
      Wend

   End With

End Sub

Sub Eliminar()
   On Error GoTo ErrorF:

   With Grilla

         Envia = Array()
         AddParam Envia, right(.TextMatrix(.Row, 1), 3)
         AddParam Envia, Trim(right(.TextMatrix(.Row, 2), 10))
         AddParam Envia, CDbl(Trim(right(.TextMatrix(.Row, 3), 3)))
         AddParam Envia, CDbl(Trim(right(.TextMatrix(.Row, 4), 3)))
         AddParam Envia, Trim(right(.TextMatrix(.Row, 5), 15))
         AddParam Envia, right(.TextMatrix(.Row, 6), 1)
         AddParam Envia, CDbl(.TextMatrix(.Row, 7))
         AddParam Envia, CDbl(Trim(right(.TextMatrix(.Row, 8), 5)))
         AddParam Envia, CDbl(Trim(right(.TextMatrix(.Row, 9), 5)))
         AddParam Envia, CDbl(Trim(right(.TextMatrix(.Row, 10), 5)))
         AddParam Envia, right(.TextMatrix(.Row, 11), 1)
         AddParam Envia, right(.TextMatrix(.Row, 12), 1)
         AddParam Envia, right(.TextMatrix(.Row, 13), 1)
      
         If Not BAC_SQL_EXECUTE("Sp_CuentaXProducto_Elimina", Envia) Then
      
            MsgBox "Problemas con la Eliminación", vbExclamation, TITSISTEMA
            Exit Sub
      
         End If
            
         MsgBox "Eliminación Realizada con Exito", vbInformation, TITSISTEMA

   End With

ErrorF:

End Sub

Private Sub TXTNumero_DblClick()

   Select Case Grilla.Col
   
      Case 7
         
         
        If Trim(right(Grilla.TextMatrix(Grilla.Row, 1), 5)) <> "BCC" Then
         
             BacAyuda.Tag = "MDEM"
             BacAyuda.Show 1
    
             If giAceptar% = True Then
               
               If Trim(gsCodigo$) <> "" Then
                 
                 Grilla.TextMatrix(Grilla.Row, Grilla.Col) = Format(gsCodigo$, FEntero)
               
               End If
             
             End If

        Else
        
             BacAyuda.Tag = "PaisMntLocalidades"
             BacAyuda.Show 1
    
             If giAceptar% = True Then
               
               If Trim(RETORNOAYUDA) <> "" Then
                 
                 Grilla.TextMatrix(Grilla.Row, Grilla.Col) = RETORNOAYUDA
               
               End If
             
             End If

        End If
    
   End Select

End Sub

Private Sub TxtNumero_KeyPress(KeyAscii As Integer)
Dim Encontro As Boolean

   Encontro = False

   Select Case KeyAscii
   
      Case 13
         
        If Grilla.Col = 7 Then
                
                
         If TXTNumero.Text <> 0 Then
                
            If Trim(right(Grilla.TextMatrix(Grilla.Row, 1), 5)) <> "BCC" Then
                If EmisorLeerPorRut(TXTNumero.Text) Then
                   Grilla.Text = TXTNumero.Text
                Else
                    MsgBox "Rut del Emisor no existe", vbExclamation, TITSISTEMA
                    TXTNumero.SetFocus
                    Exit Sub
                End If
            
            Else
         
                If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PAIS") Then
                    Exit Sub
                End If
                If Trim(TXTNumero.Text) <> "" Then
                    Do While BAC_SQL_FETCH(Datos())
                        If TXTNumero.Text = Datos(1) Then
                            Grilla.Text = TXTNumero.Text
                            Encontro = True
                            Exit Do
                        End If
                    Loop
                End If
                                
                If Not Encontro Then
                    MsgBox "País no existe", vbExclamation, TITSISTEMA
                    TXTNumero.SetFocus
                    Exit Sub
                End If
         
         
            End If
      
          Else
            Grilla.Text = TXTNumero.Text
      
          End If
      
         End If
         
         If Grilla.Col = 25 Then
               Grilla.Text = TXTNumero.Text
         End If
         
         Grilla.SetFocus
         TXTNumero.Visible = False
         
      Case 27
         
         TXTNumero.Visible = False
         
   End Select

End Sub

Private Sub TxtNumero_LostFocus()

   TXTNumero.Visible = False

End Sub

Function EmisorLeerPorRut(parEdRut As Double) As Boolean

    EmisorLeerPorRut = False
    
'    cSql = "EXECUTE sp_trae_emisor " & parEdRut
    
    Envia = Array()
    
    AddParam Envia, parEdRut
    

    If Not BAC_SQL_EXECUTE("sp_trae_emisor", Envia) Then Exit Function
    
    If Not BAC_SQL_FETCH(Datos()) Then Exit Function
    
    dEmcodigo = Val(Datos(1))
    cEmnombre = Datos(4)
    cEmgeneric = Datos(5)
    dEmtipo = Val(Datos(8))
    
    EmisorLeerPorRut = True
    
End Function

