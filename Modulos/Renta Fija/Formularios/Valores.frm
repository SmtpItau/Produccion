VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{A14276F7-A3E0-11D5-B8EF-000102BF8447}#1.0#0"; "BACControles.ocx"
Begin VB.Form BacValores 
   Caption         =   "Valores de Documentos"
   ClientHeight    =   5160
   ClientLeft      =   1770
   ClientTop       =   6195
   ClientWidth     =   7785
   LinkTopic       =   "Form3"
   ScaleHeight     =   5160
   ScaleWidth      =   7785
   Begin Threed.SSPanel SSPanel1 
      Height          =   5085
      Left            =   30
      TabIndex        =   0
      Top             =   75
      Width           =   7725
      _Version        =   65536
      _ExtentX        =   13626
      _ExtentY        =   8969
      _StockProps     =   15
      Caption         =   "SSPanel1"
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
      Begin VB.TextBox TxtDv 
         BackColor       =   &H80000002&
         ForeColor       =   &H80000005&
         Height          =   285
         Left            =   2595
         TabIndex        =   8
         Top             =   1260
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.TextBox TxtNombre 
         BackColor       =   &H80000002&
         ForeColor       =   &H80000005&
         Height          =   270
         Left            =   2580
         TabIndex        =   3
         Top             =   1845
         Visible         =   0   'False
         Width           =   1245
      End
      Begin BACControles.TXTNumero TxtTotal 
         Height          =   315
         Left            =   6165
         TabIndex        =   1
         Top             =   4665
         Width           =   1395
         _ExtentX        =   2461
         _ExtentY        =   556
         ForeColor       =   -2147483646
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
      Begin BACControles.TXTNumero TxtRut 
         Height          =   240
         Left            =   810
         TabIndex        =   2
         Top             =   1905
         Visible         =   0   'False
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   423
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
      Begin BACControles.TXTNumero TxtNumero 
         Height          =   240
         Left            =   1335
         TabIndex        =   4
         Top             =   2565
         Visible         =   0   'False
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   423
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
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla_Valores 
         Height          =   3975
         Left            =   30
         TabIndex        =   5
         Top             =   570
         Width           =   7620
         _ExtentX        =   13441
         _ExtentY        =   7011
         _Version        =   393216
         Rows            =   3
         FixedRows       =   2
         BackColor       =   -2147483633
         ForeColor       =   -2147483635
         BackColorFixed  =   -2147483647
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   12632256
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSComctlLib.Toolbar Toolbar1 
         Height          =   480
         Left            =   15
         TabIndex        =   7
         Top             =   45
         Width           =   7635
         _ExtentX        =   13467
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         Appearance      =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Aceptar"
               Object.Tag             =   "1"
               ImageIndex      =   2
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Cancelar"
               Object.Tag             =   "2"
               ImageIndex      =   3
            EndProperty
         EndProperty
         MouseIcon       =   "Valores.frx":0000
         Begin MSComctlLib.ImageList ImageList1 
            Left            =   3465
            Top             =   15
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
                  Picture         =   "Valores.frx":0452
                  Key             =   ""
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Valores.frx":076C
                  Key             =   ""
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Valores.frx":0BBE
                  Key             =   ""
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Valores.frx":1010
                  Key             =   ""
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Valores.frx":1462
                  Key             =   ""
               EndProperty
               BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Valores.frx":18B4
                  Key             =   ""
               EndProperty
               BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Valores.frx":1BCE
                  Key             =   ""
               EndProperty
            EndProperty
         End
      End
      Begin VB.Label Label1 
         Caption         =   "Total  Documentos"
         ForeColor       =   &H8000000D&
         Height          =   285
         Left            =   4470
         TabIndex        =   6
         Top             =   4665
         Width           =   1665
      End
   End
End
Attribute VB_Name = "BacValores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Saldo_Valor As Long
Public Aceptar As Boolean
Public FILAS As Integer
Public error_digito As Boolean

Dim ValAnt, ValNue  As Double

Sub Limpiar_Var_Aux()
Saldo_Valor = 0
error_digito = False

End Sub

Sub Cargar_Grilla_Valores()
'carga la grilla con los titulos correspondientes
Dim m, mm As Integer
With Grilla_Valores
   .Enabled = True
   .Clear
   .Rows = 3
   .Cols = 5
   .FixedRows = 2
   .FixedCols = 1
   
   .TextMatrix(0, 1) = "R.U.T."
   .TextMatrix(0, 2) = " "
   .TextMatrix(0, 3) = "Cliente"
   .TextMatrix(0, 4) = "Valor de"
   .TextMatrix(1, 4) = "Vale Vista"
   
   
   
   .ColWidth(0) = 0
    
   .ColWidth(1) = 1200
   .ColWidth(2) = 300
   .ColWidth(3) = 3800
   .ColWidth(4) = 2200
   
     
    For m = 0 To .Rows - 2
        .RowHeight(m) = 227
    Next m
    For m = 0 To .Rows - 1
        For mm = 0 To .Cols - 1
            .Col = mm
            .Row = m
            .CellFontBold = True
            .GridLinesFixed = flexGridNone
        Next mm
    Next m
    .CellFontBold = False
    .Rows = .Rows - 1
    If .Rows > 2 Then
       .Col = 0
       .ColSel = .Cols - 1
    Else
       .Col = 0
       .ColSel = 0
    End If
    
    
    .Enabled = False
       
End With
End Sub

Sub Ingreso_Datos_Grilla()
Grilla_Valores.Enabled = True
I = 2
With Grilla_Valores
    .AddItem ("")
    .RowHeight(2) = 315
    .Row = 2
    .Col = 1
    .TextMatrix(Row + 2, 1) = Format(BacValeVista.Rut, FEntero)
    .TextMatrix(Row + 2, 2) = BacValeVista.Dv
    .TextMatrix(Row + 2, 3) = BacValeVista.NOMBRE
    .TextMatrix(Row + 2, 4) = Format(BacValeVista.Valor_Documento, FEntero)
    
    TxtTotal = BacValeVista.Valor_Documento
    TxtTotal.Enabled = False
    
    
    
    .Rows = I + 1
    .RowHeight(I) = 315
    
         
    I = I + 1
End With

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
  
If KeyAscii = 13 Then
   SendKeys "{TAB}"

End If

End Sub

Private Sub Form_Load()
    Me.Icon = BacTrader.Icon
    Me.Top = 2000
    Me.Left = 2000
    Call Limpiar_Grilla_Valores
    Call Limpiar_Var_Aux
    Call Cargar_Grilla_Valores
    Call Ingreso_Datos_Grilla
    Me.Top = 1150
    Me.Left = 50

End Sub

Sub Limpiar_Grilla_Valores()
'permite inicializar la grilla
Dim x As Integer
With Grilla_Valores
    .Enabled = True
    .Clear
    .Rows = 3
    .Cols = 3
    .FixedRows = 2
    .FixedCols = 1
    .CellFontBold = False
    .GridLinesFixed = flexGridRaised
    .Enabled = False
        
End With
End Sub

Private Sub Grilla_Valores_KeyDown(KeyCode As Integer, Shift As Integer)
'With Grilla_Valores
'    If .Col = 1 Then
'        Call PROC_POSI_TEXTO(Grilla_Valores, TxtRut)
'        ValAnt = .TextMatrix(.RowSel, 1)
'        TxtRut.Text = CDbl(.TextMatrix(.RowSel, 1))
'        TxtRut.Visible = True
'        TxtRut.SetFocus
'    End If
'    If .Col = 4 Then
'        Call PROC_POSI_TEXTO(Grilla_Valores, TxtNumero)
'        ValAnt = .TextMatrix(.RowSel, 4)
'        TxtNumero = CDbl(.TextMatrix(.RowSel, 4))
'        TxtNumero.Visible = True
'        TxtNumero.SetFocus
'    End If
'    If .Col = 2 Then
'        Call PROC_POSI_TEXTO(Grilla_Valores, TxtDv)
'        ValAnt = .TextMatrix(.RowSel, 2)
'        TxtDv = .TextMatrix(.RowSel, 2)
'        TxtDv.Visible = True
'        TxtDv.SetFocus
'    End If
'    If .Col = 3 Then
'        Call PROC_POSI_TEXTO(Grilla_Valores, TxtNombre)
'        ValAnt = .TextMatrix(.RowSel, 3)
'        TxtNombre = .TextMatrix(.RowSel, 3)
'        TxtNombre.Visible = True
'        TxtNombre.SetFocus
'    End If
'End With
End Sub

Private Sub Grilla_Valores_KeyPress(KeyAscii As Integer)
With Grilla_Valores
    If .Col = 1 Then
        Call PROC_POSI_TEXTO(Grilla_Valores, txtrut)
        If IsNumeric(Chr(KeyAscii)) Then
            ValAnt = .TextMatrix(.RowSel, 1)
            txtrut.Text = ""
            txtrut.Text = CDbl(Chr(KeyAscii))
            txtrut.Visible = True
            txtrut.SetFocus
        End If
    End If
    If .Col = 2 Then
        Call PROC_POSI_TEXTO(Grilla_Valores, TxtDv)
        ValAnt = .TextMatrix(.RowSel, 2)
        TxtDv.Text = ""
        IIf (KeyAscii = 13), TxtDv.Text = "", TxtDv.Text = UCase(Chr(KeyAscii))
        TxtDv.Visible = True
        TxtDv.SetFocus
    End If
    If .Col = 3 Then
        Call PROC_POSI_TEXTO(Grilla_Valores, txtnombre)
        ValAnt = .TextMatrix(.RowSel, 3)
        txtnombre.Text = ""
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
        IIf (KeyAscii = 13), txtnombre.Text = "", txtnombre.Text = UCase(Chr(KeyAscii))
        txtnombre.Visible = True
        txtnombre.SetFocus
       
    End If
    If .Col = 4 Then
        Call PROC_POSI_TEXTO(Grilla_Valores, TxtNumero)
        If IsNumeric(Chr(KeyAscii)) Then
            ValAnt = .TextMatrix(.RowSel, 4)
            TxtNumero.Text = ""
            TxtNumero.Text = CDbl(Chr(KeyAscii))
            TxtNumero.Visible = True
            TxtNumero.SetFocus
        End If
    End If
    
End With

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        'Graba
        Aceptar = True
        'Call BacValeVista.Insertar_Datos_grilla(BacValeVista.Grilla.RowSel)
        Me.Hide
                
    Case 2
        'Salir
        Call Limpiar_Grilla_Valores
        Aceptar = False
        Unload Me
        
End Select


End Sub

Private Sub TxtDv_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
Select Case KeyAscii
    Case 13
        Me.TxtDv.Visible = False
        Me.Grilla_Valores.SetFocus
        Grilla_Valores.Text = TxtDv.Text
        'If BacValidaRut(Grilla_Valores.TextMatrix(Grilla_Valores.Row, 1), Grilla_Valores.TextMatrix(Grilla_Valores.Row, 2)) = False Then
        TxtDv.Text = " "
    Case 27
        Grilla_Valores.TextMatrix(Grilla_Valores.RowSel, Grilla_Valores.ColSel) = ValAnt
        Grilla_Valores.SetFocus
        TxtDv.Visible = False
End Select
End Sub

Private Sub TxtNombre_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
Select Case KeyAscii
   Case 13
        Me.txtnombre.Visible = False
        Me.Grilla_Valores.SetFocus
        Grilla_Valores.Text = txtnombre.Text
        txtnombre.Text = " "
    Case 27
        Grilla_Valores.TextMatrix(Grilla_Valores.RowSel, Grilla_Valores.ColSel) = ValAnt
        Grilla_Valores.SetFocus
        txtnombre.Visible = False
End Select

End Sub


Sub Calculos_Saldo(Numero As Double)
On Error Resume Next
Saldo_Valor = BacValeVista.Valor_Documento - Numero
With Grilla_Valores
If BacValeVista.Valor_Documento >= Numero Then
    'agrega datos
        If Saldo_Valor <> 0 Then
            .Rows = .Row + 1
            I = .Rows - 2
            .AddItem ("")
            .RowHeight(.Row) = 315
            .ColSel = .Cols - 1
            .RowSel = .Row + 1
            
            
            .Col = 1
            
            .TextMatrix(.Row + 1, 1) = .TextMatrix(.Row, 1)
            .TextMatrix(.Row + 1, 2) = .TextMatrix(.Row, 2)
            .TextMatrix(.Row + 1, 3) = .TextMatrix(.Row, 3)
            .TextMatrix(.Row + 1, 4) = Format(Saldo_Valor, FEntero)
            BacValeVista.Valor_Documento = Saldo_Valor
            
        End If
        
Else
   MsgBox "Valor Superior al Saldo", vbCritical
   .TextMatrix(.Row, 4) = Format(BacValeVista.Valor_Documento, FEntero)
       
End If
End With

End Sub

Private Sub txtnumero_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
    Case 13
        Me.TxtNumero.Visible = False
        Me.Grilla_Valores.SetFocus
        If TxtNumero.Text <> 0 Then
            Grilla_Valores.Text = Format(TxtNumero.Text, FEntero)
            Call Calculos_Saldo(TxtNumero.Text)
        End If
        TxtNumero.Text = 0
        
   Case 27
        Grilla_Valores.TextMatrix(Grilla_Valores.RowSel, Grilla_Valores.ColSel) = ValAnt
        Grilla_Valores.SetFocus
        TxtNumero.Visible = False
End Select
End Sub


Private Sub txtRut_KeyPress(KeyAscii As Integer)
With Grilla_Valores

    Select Case KeyAscii
        Case 13
            Me.txtrut.Visible = False
            .SetFocus
            .Text = Format(txtrut.Text, FEntero)
            txtrut.Text = 0
        Case 27
            .TextMatrix(.RowSel, .ColSel) = ValAnt
            .SetFocus
             txtrut.Visible = False
            
    End Select

End With
End Sub

