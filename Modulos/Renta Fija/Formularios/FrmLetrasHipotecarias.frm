VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form FrmLetrasHipotecarias 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Letras Hipotecarias de Terceros"
   ClientHeight    =   4005
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9375
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4005
   ScaleWidth      =   9375
   Begin Threed.SSPanel SSPanel1 
      Height          =   3570
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   9420
      _Version        =   65536
      _ExtentX        =   16616
      _ExtentY        =   6297
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8,25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   1
      Begin Threed.SSFrame SSFrame1 
         Height          =   3360
         Left            =   105
         TabIndex        =   2
         Top             =   60
         Width           =   9210
         _Version        =   65536
         _ExtentX        =   16245
         _ExtentY        =   5927
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8,25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ShadowStyle     =   1
         Begin MSFlexGridLib.MSFlexGrid Grilla2 
            Height          =   1455
            Left            =   885
            TabIndex        =   8
            Top             =   1170
            Visible         =   0   'False
            Width           =   8895
            _ExtentX        =   15690
            _ExtentY        =   2566
            _Version        =   393216
            FixedCols       =   0
         End
         Begin VB.ComboBox CmbTipLetra 
            BackColor       =   &H00800000&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8,25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   315
            Left            =   225
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   1935
            Visible         =   0   'False
            Width           =   1455
         End
         Begin VB.TextBox TxtCaracter 
            BackColor       =   &H00800000&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8,25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   315
            Left            =   225
            MouseIcon       =   "FrmLetrasHipotecarias.frx":0000
            TabIndex        =   6
            Top             =   2895
            Visible         =   0   'False
            Width           =   1455
         End
         Begin BacControles.txtFecha TxtFecha 
            Height          =   315
            Left            =   225
            TabIndex        =   5
            Top             =   2580
            Visible         =   0   'False
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   556
            Text            =   "03/05/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8,25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   16777215
            MinDate         =   -328716
            MaxDate         =   2958465
            BackColor       =   8388608
         End
         Begin BacControles.txtNumero TxtNumero 
            Height          =   330
            Left            =   225
            TabIndex        =   4
            Top             =   2250
            Visible         =   0   'False
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   582
            BackColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8,25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   16777215
            Text            =   "0,0000"
         End
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   3165
            Left            =   30
            TabIndex        =   3
            Top             =   120
            Width           =   9105
            _ExtentX        =   16060
            _ExtentY        =   5583
            _Version        =   393216
            Rows            =   3
            FixedRows       =   2
            FixedCols       =   0
            RowHeightMin    =   315
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            BackColorBkg    =   -2147483644
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9375
      _ExtentX        =   16536
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cortes"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Series"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Clientes"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Carga Interfaz"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5955
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   9
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":075C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":0BAE
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":0EC8
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":11E2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":1634
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":194E
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":1DA0
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmLetrasHipotecarias.frx":21F2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FrmLetrasHipotecarias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim MaxCol As Integer
Dim colpress As Integer
Dim rowpress As Integer

Private Sub CmbTipLetra_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
      Case 13
            Grilla.Text = CmbTipLetra.Text
            CmbTipLetra.Visible = False
            
            If Grilla.TextMatrix(Grilla.Row, 2) <> "" Then
               
               Grilla.TextMatrix(Grilla.Row, 7) = GeneraNemotecnico(Grilla.TextMatrix(Grilla.Row, 18), Grilla.TextMatrix(Grilla.Row, 5))
          
            End If
               
      Case 27
            CmbTipLetra.Visible = False
   
   End Select

End Sub

Private Sub CmbTipLetra_LostFocus()

   CmbTipLetra.Visible = False

End Sub

Private Sub Form_Load()

   Me.Top = 0
   Me.Left = 0
   Me.Icon = BacTrader.Icon
   
   MaxCol = 19
   txtFecha.Text = gsBac_Fecp
   CmbTipLetra.AddItem ""
   CmbTipLetra.AddItem "*"
   CmbTipLetra.AddItem "&"
   
   Call CargaGrilla
   Call CargaValoresGrilla
   Call CargaGrilla2
   Call CargaValoresGrilla2
   
   If Grilla.Rows = 2 Then
   
         Grilla.Rows = Grilla.Rows + 1
         Call ValoresDefectos
   
   End If

End Sub

Sub CargaGrilla()
Dim I, j As Integer

   With Grilla
    
      .Cols = MaxCol
      .Rows = 2
      .ColWidth(0) = 0
      .ColWidth(1) = 1500: .TextMatrix(0, 1) = "Código": .TextMatrix(1, 1) = "Planilla"
      .ColWidth(2) = 1500: .TextMatrix(0, 2) = "Letra": .TextMatrix(1, 2) = "Serie"
      .ColWidth(3) = 1500: .TextMatrix(0, 3) = "Fecha Emision": .TextMatrix(1, 3) = "Nominal"
      .ColWidth(4) = 1500: .TextMatrix(0, 4) = "Fecha Emision": .TextMatrix(1, 4) = "Material"
      .ColWidth(5) = 1500: .TextMatrix(0, 5) = "Tipo Letra"
      .ColWidth(6) = 1500: .TextMatrix(0, 6) = "Fecha Ingreso"
      .ColWidth(7) = 1500: .TextMatrix(0, 7) = "Nemotécnico"
      .ColWidth(8) = 1500: .TextMatrix(0, 8) = "Moneda": .TextMatrix(1, 8) = "Emisión"
      .ColWidth(9) = 2000: .TextMatrix(0, 9) = "Nominal"
      .ColWidth(10) = 1500: .TextMatrix(0, 10) = "Rut": .TextMatrix(1, 10) = "Emisor"
      .ColWidth(11) = 1500: .TextMatrix(0, 11) = "Rut": .TextMatrix(1, 11) = "Cliente"
      .ColWidth(12) = 1500: .TextMatrix(0, 12) = "Sucursal"
      .ColWidth(13) = 1500: .TextMatrix(0, 13) = "Observaciones"
      .ColWidth(14) = 1500: .TextMatrix(0, 14) = "Codigo": .TextMatrix(1, 14) = "Obligacion"
      .ColWidth(15) = 0
      .ColWidth(16) = 0
      .ColWidth(17) = 0
      .ColWidth(18) = 0
    
      For I = 0 To 1
    
         For j = 0 To MaxCol - 1
         
            .Row = I: .Col = j
            .CellFontBold = True
         
         Next j
         
      Next I
    
      .Rows = .Rows + 1
      .Row = 2
      .Col = 1
      
      Call ValoresDefectos
    
   End With

End Sub

Private Sub Grilla_DblClick()

   TextosGrilla Grilla.Row, Grilla.Col, 13

End Sub

Private Sub Grilla_KeyDown(KEYCODE As Integer, Shift As Integer)

   colpress = Grilla.Col
   rowpress = Grilla.Row
   
   Select Case KEYCODE
      
      Case 45, 46
         TextosGrilla Grilla.Row, Grilla.Col, KEYCODE

   End Select

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

   TextosGrilla Grilla.Row, Grilla.Col, KeyAscii

End Sub

Private Sub Grilla_KeyUp(KEYCODE As Integer, Shift As Integer)
On Error Resume Next
   
   Grilla.Col = colpress
   Grilla.Row = rowpress

End Sub

Private Sub Grilla_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
   
   colpress = Grilla.Col
   rowpress = Grilla.Row

End Sub

Private Sub Grilla_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   Grilla.Col = colpress
   Grilla.Row = rowpress

End Sub

Private Sub Grilla_Scroll()

   Call Deshabilita_Textos

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
On Error GoTo ErrorF:

   Select Case Button.Index
   
      Case 1
            If Not Grabar Then
            
               MsgBox "No se Pudo Grabar Registro", vbExclamation + vbOKOnly, TITSISTEMA
            
            Else
            
               MsgBox "Grabación realizada Exitosamente", vbInformation + vbOKOnly, TITSISTEMA
            
            End If
      
            Grilla.SetFocus
      
      Case 2
            Call Eliminar
      
      Case 3
            Call Limpiar
   
      Case 4
            If Grilla.TextMatrix(Grilla.Row, 9) <> Format(0, FDecimal) Then
            
               Correlativo = Grilla.Row
               codigo_planilla = Grilla.TextMatrix(Grilla.Row, 1)
               FrmCortesLetrasH.Tag = Grilla.TextMatrix(Grilla.Row, 9)
               FrmCortesLetrasH.Show 1
               
            End If
      
      Case 5
            FrmMantenedorSeries.Show 1
      
      Case 6
            FrmClientesHipotecaria.Show 1
      
      Case 7
      
      Case 8
            Unload Me
      
   End Select

Exit Sub
ErrorF:

   MsgBox "Para Grabar Debe Llenar Todos Los Datos", vbExclamation, TITSISTEMA
   Grilla.SetFocus

End Sub

Sub Limpiar()

   With Grilla
   
      TxtNumero.Visible = False
      TxtCaracter.Visible = False
      txtFecha.Visible = False
      .Rows = 2
      .Col = 0
      .Rows = 3
      .Col = 1
      .Row = 2
      colpress = .Col
      rowpress = .Row
      Call ValoresDefectos
  
  End With

End Sub


Sub PosTexto(Control, Grid As Control)
On Error Resume Next

   Control.Left = Grid.CellLeft + 50
   Control.Top = Grid.CellTop + 130
   Control.Width = Grid.CellWidth
   Control.Height = Grid.CellHeight
   Control.Visible = True
   Control.SetFocus

End Sub

Sub TextosGrilla(Row, Col, key As Integer)
Dim tecla As Integer

   TxtNumero.Visible = False
   txtFecha.Visible = False
   TxtCaracter.Visible = False
      
      
   If (UCase(Chr(key)) >= "A" And UCase(Chr(key)) <= "Z") Or IsNumeric(Chr(key)) = True Then
   
      tecla = key
      key = 13
   
   Else
   
      tecla = 0
   
   End If

   Select Case key
      
      Case 13
               
               Select Case Col
               
                  Case 1, 9, 10, 11
                           
                           If Col = 9 Then
                           
                              TxtNumero.CantidadDecimales = 4
                           
                           Else
                           
                              TxtNumero.CantidadDecimales = 0
                           
                           End If
                           
                           PosTexto TxtNumero, Grilla
                           TxtNumero.Text = IIf(Grilla.Text <> "", BacCtrlTransMonto(Grilla.Text), 0)
                           
                           If IsNumeric(Chr(tecla)) Then
                  
                              TxtNumero.Text = Chr(tecla)
                  
                           End If
                  
                  Case 2, 12, 13, 14, 8
                           
                           PosTexto TxtCaracter, Grilla
                           TxtCaracter.Text = Grilla.Text
                           TxtCaracter.MousePointer = 0
               
                           If Grilla.Col = 8 Or Grilla.Col = 10 Or Grilla.Col = 11 Or Grilla.Col = 2 Or Grilla.Col = 12 Then
                              
                              TxtCaracter.MousePointer = 99
                           
                           End If
                           
                           If tecla <> 13 And tecla <> 0 Then
                              
                              TxtCaracter.Text = ""
                              SendKeys Chr(tecla)
                              
                           End If
               
                  Case 3, 4, 6
                           PosTexto txtFecha, Grilla
                           txtFecha.Text = IIf(Grilla.Text <> "", Grilla.Text, txtFecha.Text)
                  
                  Case 5
                           PosTexto CmbTipLetra, Grilla
                           CmbTipLetra = IIf(Grilla.Text <> "", Grilla.Text, "*")
               
               End Select
      
      Case 27


      Case 46
               
               Call Eliminar
                     
      Case 45
               
               If CamposNulos(Grilla) Then
                  
                  Grilla.Rows = Grilla.Rows + 1
                  Call ValoresDefectos
                  
               End If

  End Select

End Sub

Private Sub TxtCaracter_DblClick()
On Error GoTo ErrorF:

   Select Case Grilla.Col
   
      Case 2
            Me.Tag = ""
            BacAyuda.Tag = "SERIE"
            BacAyuda.Show 1
            If giAceptar = True Then

               Grilla.Text = Trim(gsSerie)
               Grilla.TextMatrix(Grilla.Row, 18) = gscodigo
               Grilla.TextMatrix(Grilla.Row, 7) = GeneraNemotecnico(Grilla.TextMatrix(Grilla.Row, 18), Grilla.TextMatrix(Grilla.Row, 5))

            End If
         
      Case 8
            Me.Tag = ""
            BacAyuda.Tag = "MDMN2"
            BacAyuda.Show 1
            
            If giAceptar = True Then

               Grilla.Text = gsSerie
               Grilla.TextMatrix(Grilla.Row, 15) = gscodigo$

            End If
      
      Case 12
          Me.Tag = ""
          BacAyuda.Tag = "SUCURSAL"
          BacAyuda.Show 1
   
   End Select

ErrorF:
End Sub

Private Sub TxtCaracter_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   Select Case KeyAscii
       
      Case 13
         
         Select Case Grilla.Col
         
            Case 2
                  If Not SerieExiste(TxtCaracter.Text) Then
                  
                     MsgBox "Serie No Existe", vbExclamation + vbOKOnly, TITSISTEMA
                     TxtCaracter.Text = ""
                     Grilla.SetFocus
                     Exit Sub
                  
                  End If
            
            Case 8
                  If Not MonedaExiste(TxtCaracter.Text) Then
                  
                     MsgBox "Moneda No Existe", vbExclamation + vbOKOnly, TITSISTEMA
                     TxtCaracter.Text = ""
                     Grilla.SetFocus
                     Exit Sub
                  
                  End If
            
            Case 12
                  If Not SucursalExiste(TxtCaracter.Text) Then
                  
                     MsgBox "Sucursal No Existe", vbExclamation + vbOKOnly, TITSISTEMA
                     TxtCaracter.Text = ""
                     Grilla.SetFocus
                     Exit Sub
                  
                  End If
            
         End Select
               
         Grilla.Text = TxtCaracter.Text
         TxtCaracter.Visible = False
         Grilla.TextMatrix(Grilla.Row, 7) = GeneraNemotecnico(Grilla.TextMatrix(Grilla.Row, 18), Grilla.TextMatrix(Grilla.Row, 5))

         
      Case 27
         TxtCaracter.Visible = False
   
   End Select

End Sub

Private Sub TxtCaracter_LostFocus()

   TxtCaracter.Visible = False
   TxtCaracter.Text = ""
      
End Sub

Private Sub TxtFecha_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
      Case 13
         Grilla.Text = txtFecha.Text
         txtFecha.Visible = False
         Grilla.TextMatrix(Grilla.Row, 7) = GeneraNemotecnico(Grilla.TextMatrix(Grilla.Row, 18), Grilla.TextMatrix(Grilla.Row, 5))
      
         Select Case Grilla.Col
         
            Case 3
                  Grilla.TextMatrix(Grilla.Row, 7) = GeneraNemotecnico(Grilla.TextMatrix(Grilla.Row, 18), Grilla.TextMatrix(Grilla.Row, 5))
            
         End Select
      
      Case 27
         txtFecha.Visible = False
   
   End Select

End Sub

Private Sub TxtFecha_LostFocus()

   txtFecha.Visible = False

End Sub

Private Sub TxtNumero_DblClick()
      
   Select Case Grilla.Col
   
      Case 10, 11
          Me.Tag = ""
          BacAyuda.Tag = "LETRA_HIPOTECARIA_CLIENTE"
          BacAyuda.Show 1
          
          If giAceptar = True Then
          
             Grilla.Text = Format(Trim(Str(ltRutCliente)), "###,##0") ' + "-" + ltDigito
             
             If Grilla.Col = 10 Then
               
               Grilla.TextMatrix(Grilla.Row, 16) = ltCodCliente
         
             Else
             
               Grilla.TextMatrix(Grilla.Row, 17) = ltCodCliente
             
             End If
         
         End If

   End Select

End Sub

Private Sub txtnumero_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
      Case 13
         
         Select Case Grilla.Col
            
            Case 9
               Grilla.Text = Format(TxtNumero.Text, FDecimal)
               Grilla.SetFocus
         
            Case 1, 8
      
               If PlanillaExiste(TxtNumero.Text) And Grilla.Col = 1 Then
               
                  MsgBox "La Planilla Fue Ingresada Anteriormente", vbExclamation + vbOKOnly, TITSISTEMA
                  Grilla.SetFocus
                  Exit Sub
                  
               End If
               
               
               Grilla.Text = Format(TxtNumero.Text, "###,##0")
               Grilla.SetFocus
         
            Case 10, 11
            
                  If Not ClienteExiste(TxtNumero.Text) And gsBac_RutC <> TxtNumero.Text Then
                  
                     MsgBox "Cliente No Existe", vbExclamation + vbOKOnly, TITSISTEMA
                     TxtCaracter.Text = ""
                     Grilla.SetFocus
                     Exit Sub
                  
                  End If
            
                  Grilla.Text = Format(TxtNumero.Text, "###,##0")
                  Grilla.SetFocus
         
         End Select
         
         TxtNumero.Visible = False
         
      Case 27
         TxtNumero.Visible = False
               
   End Select
   
End Sub

Private Sub TxtNumero_LostFocus()

   TxtNumero.Visible = False

End Sub

Sub Deshabilita_Textos()

   TxtNumero.Visible = False
   TxtCaracter.Visible = False
   txtFecha.Visible = False
   CmbTipLetra.Visible = False

End Sub

Function CamposNulos(Grilla As Control) As Boolean
Dim I, j As Integer

   CamposNulos = True

   With Grilla

      For I = 2 To .Rows
   
         For j = 1 To .Cols - 1
   
            If .TextMatrix(.Rows - 1, j) = "" Then
            
               If j <> 5 Then
                  
                  CamposNulos = False
                  Exit Function
                     
               End If
            
            End If
   
         Next j
         
      Next I

   End With

End Function



Sub ValoresDefectos()

   With Grilla
   
      .TextMatrix(.Rows - 1, 1) = "0"
      .TextMatrix(.Rows - 1, 2) = ""
      .TextMatrix(.Rows - 1, 3) = gsBac_Fecp
      .TextMatrix(.Rows - 1, 4) = gsBac_Fecp
      .TextMatrix(.Rows - 1, 5) = ""
      .TextMatrix(.Rows - 1, 6) = gsBac_Fecp
      .TextMatrix(.Rows - 1, 7) = ""
      .TextMatrix(.Rows - 1, 8) = "UF"
      .TextMatrix(.Rows - 1, 9) = Format(0, FDecimal)
      .TextMatrix(.Rows - 1, 10) = Format(gsBac_RutC, "###,##0") '+ "-" + gsBac_DigC
      .TextMatrix(.Rows - 1, 11) = ""
      .TextMatrix(.Rows - 1, 12) = ""
      .TextMatrix(.Rows - 1, 13) = ""
      .TextMatrix(.Rows - 1, 14) = ""
      .TextMatrix(.Rows - 1, 15) = "998"
      .TextMatrix(.Rows - 1, 16) = gsBac_RutComi
   
   End With

End Sub


Function Grabar() As Boolean

Dim I As Integer
Dim X As Integer
Dim corre As Integer
   With Grilla
   
         For I = 2 To .Rows - 1
            
            Envia = Array()
         
            AddParam Envia, CDbl(.TextMatrix(I, 1))                                          'CODIGO PLANILLA
            AddParam Envia, .TextMatrix(I, 6)                                                'FECHA INGRESO
            AddParam Envia, .TextMatrix(I, 2)                                                'LETRA SERIE
            AddParam Envia, .TextMatrix(I, 3)                                                'FECHA EMISION NOMINAL
            AddParam Envia, .TextMatrix(I, 4)                                                'Fecha Emision Material
            AddParam Envia, .TextMatrix(I, 5)                                                'Tipo Letra
            AddParam Envia, .TextMatrix(I, 7)                                                'NEMOTECNICO
            AddParam Envia, CDbl(.TextMatrix(I, 15))                                         'codigo moneda
            AddParam Envia, CDbl(.TextMatrix(I, 9))                                          'NOMINAL
            AddParam Envia, CDbl(Trim(.TextMatrix(I, 11)))              'RUT CLIENTE
            'AddParam Envia, CDbl(Mid(Trim(.TextMatrix(I, 11)), 1, Len(Trim(.TextMatrix(I, 11))) - 2)) 'RUT CLIENTE
            AddParam Envia, CDbl(Right(.TextMatrix(I, 17), 1))                               'DIGITO VER CLIENTE
            AddParam Envia, CDbl(Trim(.TextMatrix(I, 10)))              'RUT EMISOR
            'AddParam Envia, CDbl(Mid(Trim(.TextMatrix(I, 10)), 1, Len(Trim(.TextMatrix(I, 10))) - 2)) 'RUT EMISOR
            AddParam Envia, CDbl(Right(.TextMatrix(I, 16), 1))                               'DIGITO VER EMISOR
            AddParam Envia, .TextMatrix(I, 12)                                               'SUCURSAL
            AddParam Envia, ""                                                                  'LETRA CONDICION
            AddParam Envia, .TextMatrix(I, 14)                                               'CODIGO OBLIGACION
            AddParam Envia, .TextMatrix(I, 13)                                               'OBSERVACIONES
            AddParam Envia, ""                                                                  'LETRA ESTADO
            AddParam Envia, gsBac_User                                                          'USUARIO
         
            Grabar = Bac_Sql_Execute("Sp_FrmLetrasHipotecarias_Graba", Envia)
            
            If Not Grabar Then
               
               Exit Function
            
            End If
            
            Envia = Array()
            AddParam Envia, CDbl(.TextMatrix(I, 1))
            
            
            Grabar = Bac_Sql_Execute("Sp_FrmLetrasHipotecarias_Graba_Elimina_Cortes", Envia)
            
            If Grabar Then
            
               corre = 0
            
               For X = 1 To Grilla2.Rows - 1
                  
                  If Grilla2.TextMatrix(X, 0) = .TextMatrix(I, 1) Then
                     
                     corre = corre + 1
                     Envia = Array()
                     AddParam Envia, CDbl(Grilla2.TextMatrix(X, 0))
                     AddParam Envia, corre 'CDbl(Grilla2.TextMatrix(X, 1))
                     AddParam Envia, CDbl(Grilla2.TextMatrix(X, 2))
                     AddParam Envia, CDbl(Grilla2.TextMatrix(X, 3))
                     AddParam Envia, CDbl(Grilla2.TextMatrix(X, 4))
                  
                  
                     Grabar = Bac_Sql_Execute("Sp_FrmLetrasHipotecarias_Graba_Cortes", Envia)
                  
                     If Not Grabar Then
                     
                        Exit Function
                     
                     End If
                  
                  End If
               
               Next X
               
            Else
            
               Exit Function
            
            End If
      
      Next I
      
   End With
   

End Function

Sub CargaGrilla2()

   With Grilla2
   
      .Cols = 6
      .Rows = 1
   
   End With

End Sub


Sub CargaValoresGrilla()
Dim Datos()
Dim I As Integer
      
      With Grilla

         If Bac_Sql_Execute("Sp_FrmLetrasHipotecarias_Trae_Datos") Then

            While Bac_SQL_Fetch(Datos())

               .TextMatrix(.Rows - 1, 1) = Format(Datos(1), "#,##0")                                        'CODIGO PLANILLA
               .TextMatrix(.Rows - 1, 6) = Datos(2)                                            'FECHA INGRESO
               .TextMatrix(.Rows - 1, 2) = Left(Datos(3), 15)                                           'LETRA SERIE
               .TextMatrix(.Rows - 1, 18) = Trim(Right(Datos(3), 10))                                          'LETRA SERIE
               .TextMatrix(.Rows - 1, 3) = Datos(4)                                            'FECHA EMISION NOMINAL
               .TextMatrix(.Rows - 1, 4) = Datos(5)                                            'Fecha Emision Material
               .TextMatrix(.Rows - 1, 5) = Datos(6)                                            'Tipo Letra
               .TextMatrix(.Rows - 1, 7) = Datos(7)                                            'NEMOTECNICO
               .TextMatrix(.Rows - 1, 8) = IIf(IsNull(Datos(8)), " ", Trim(Right(Datos(8), 5)))                                  'codigo moneda
               .TextMatrix(.Rows - 1, 15) = IIf(IsNull(Datos(8)), " ", Trim(Left(Datos(8), 4)))                                  'codigo moneda
               .TextMatrix(.Rows - 1, 9) = Format(Datos(9), FDecimal)                                     'NOMINAL
               .TextMatrix(.Rows - 1, 11) = Format(Datos(10), "###,##0")                                      'RUT CLIENTE
               .TextMatrix(.Rows - 1, 17) = Datos(11)                                      'DIGITO VER CLIENTE
               .TextMatrix(.Rows - 1, 10) = Format(Datos(12), "###,##0")                                     'RUT EMISOR
               .TextMatrix(.Rows - 1, 16) = Datos(13)                                       'DIGITO VER EMISOR
               .TextMatrix(.Rows - 1, 12) = Datos(14)                                           'SUCURSAL
               '""               =Datos(15)                                                   'LETRA CONDICION
               .TextMatrix(.Rows - 1, 14) = Datos(16)                                           'CODIGO OBLIGACION
               .TextMatrix(.Rows - 1, 13) = Datos(17)                                           'OBSERVACIONES
               '""               =Datos(18)                                                   'LETRA ESTADO
               .Rows = .Rows + 1

            Wend
            
            .Rows = .Rows - 1
            
         End If

      End With

End Sub


Sub CargaValoresGrilla2()
Dim Datos()
Dim I As Integer
      
      With Grilla2

         If Bac_Sql_Execute("Sp_FrmLetrasHipotecarias_Trae_Cortes") Then

            While Bac_SQL_Fetch(Datos())
               
               .Rows = .Rows + 1
               .TextMatrix(.Rows - 1, 0) = Datos(1)                                         'CODIGO PLANILLA
               .TextMatrix(.Rows - 1, 1) = Datos(2)                                            'FECHA INGRESO
               .TextMatrix(.Rows - 1, 2) = Datos(3)                                            'LETRA SERIE
               .TextMatrix(.Rows - 1, 3) = Datos(4)                                            'FECHA EMISION NOMINAL
               .TextMatrix(.Rows - 1, 4) = Datos(5)                                            'Fecha Emision Material
               

            Wend
            
         End If

      End With

End Sub

Sub Eliminar()

   Envia = Array()
   AddParam Envia, Grilla.TextMatrix(Grilla.Row, 1)
   
   If Bac_Sql_Execute("Sp_FrmLetrasHipotecarias_Elimina", Envia) Then
               
       If Grilla.Rows > 3 Then
      
          Grilla.RemoveItem (Grilla.Row)
       
       Else
      
          Call Limpiar
      
       End If

       MsgBox "El registro fue eliminado", vbOKOnly + vbInformation, TITSISTEMA
       Grilla.SetFocus

   End If

End Sub

Function PlanillaExiste(Planilla As Integer) As Boolean
Dim I As Integer

   PlanillaExiste = False
   
   With Grilla

      For I = 2 To .Rows - 1
      
         If Planilla = .TextMatrix(I, 1) And .Row <> I Then
         
            PlanillaExiste = True
         
         End If
      
      Next I

   End With

End Function

Function SerieExiste(Serie As String) As Boolean
Dim I As Integer
Dim Datos()

   SerieExiste = False
   
   With Grilla
   
      If Bac_Sql_Execute("Sp_FrmMantenedorSeries_TraeDatos") Then
      
         While Bac_SQL_Fetch(Datos())
   
            If Trim(Serie) = Trim(Datos(1)) Then
            
               .TextMatrix(.Row, 18) = Trim(Datos(2))
               SerieExiste = True
            
            End If

         Wend
         
      End If

   End With

End Function

Function MonedaExiste(Moneda As String) As Boolean
Dim I As Integer
Dim Datos()

   MonedaExiste = False
   
   With Grilla

      If Bac_Sql_Execute("SP_MNLEEALGUNAS") Then

         While Bac_SQL_Fetch(Datos())
   
            If Trim(Moneda) = Trim(Datos(2)) Then
            
              MonedaExiste = True
              .TextMatrix(.Row, 15) = Datos(1)
               
            End If

         Wend

      End If

   End With
   
End Function

Function SucursalExiste(Sucursal As String) As Boolean
Dim I As Integer
Dim Datos()

   SucursalExiste = False
   
   With Grilla

      If Bac_Sql_Execute("Sp_FrmMantenedorSucursal_TraeDatos") Then

         While Bac_SQL_Fetch(Datos())
   
            If Trim(Sucursal) = Trim(Datos(1)) Then
            
              SucursalExiste = True
              Exit Function
               
            End If

         Wend

      End If

   End With

End Function

Function ClienteExiste(Cliente) As Boolean
Dim I As Integer
Dim Datos()

   ClienteExiste = False
   
   With Grilla

      If Bac_Sql_Execute("Sp_Letras_Hipotecarias_BuscarCliente") Then

         While Bac_SQL_Fetch(Datos())
   
            If Trim(Cliente) = Trim(Datos(1)) Then
            
               ClienteExiste = True
              
                  Select Case .Col
                     
                     Case 10
                           Grilla.TextMatrix(Grilla.Row, 16) = Datos(2)
                     
                     Case 11
                           Grilla.TextMatrix(Grilla.Row, 17) = Datos(2)
                     
                  End Select
              
               Exit Function
               
            End If

         Wend

      End If

   End With

End Function

Function GeneraNemotecnico(Serie, Tipo As String) As String

   Select Case Trim(Tipo)
      
      Case "*"
            GeneraNemotecnico = Serie + " *" + Format(Grilla.TextMatrix(Grilla.Row, 3), "yy")
   
      Case "&"
            GeneraNemotecnico = Serie + " &" + Format(Grilla.TextMatrix(Grilla.Row, 3), "mm")
   
      Case ""
            GeneraNemotecnico = Serie + Format(Grilla.TextMatrix(Grilla.Row, 3), "mmyy")
   
   
   End Select

End Function

