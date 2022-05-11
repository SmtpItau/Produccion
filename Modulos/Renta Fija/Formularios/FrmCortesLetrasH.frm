VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form FrmCortesLetrasH 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cortes"
   ClientHeight    =   4455
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4800
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4455
   ScaleWidth      =   4800
   StartUpPosition =   2  'CenterScreen
   Begin Threed.SSPanel SSPanel1 
      Height          =   4020
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   4830
      _Version        =   65536
      _ExtentX        =   8520
      _ExtentY        =   7091
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
      Begin Threed.SSFrame SSFrame2 
         Height          =   3150
         Left            =   105
         TabIndex        =   3
         Top             =   60
         Width           =   4620
         _Version        =   65536
         _ExtentX        =   8149
         _ExtentY        =   5556
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
         Begin Threed.SSFrame SSFrame3 
            Height          =   2970
            Left            =   60
            TabIndex        =   4
            Top             =   105
            Width           =   4485
            _Version        =   65536
            _ExtentX        =   7911
            _ExtentY        =   5239
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
            Begin BacControles.txtNumero TxtNumero 
               Height          =   345
               Left            =   3000
               TabIndex        =   6
               Top             =   165
               Visible         =   0   'False
               Width           =   1380
               _ExtentX        =   2434
               _ExtentY        =   609
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
               Height          =   2820
               Left            =   30
               TabIndex        =   5
               Top             =   105
               Width           =   4425
               _ExtentX        =   7805
               _ExtentY        =   4974
               _Version        =   393216
               Cols            =   3
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
      Begin Threed.SSFrame SSFrame1 
         Height          =   780
         Left            =   90
         TabIndex        =   2
         Top             =   3135
         Width           =   4635
         _Version        =   65536
         _ExtentX        =   8176
         _ExtentY        =   1376
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
         Begin Threed.SSFrame SSFrame5 
            Height          =   630
            Left            =   2295
            TabIndex        =   9
            Top             =   105
            Width           =   2280
            _Version        =   65536
            _ExtentX        =   4022
            _ExtentY        =   1111
            _StockProps     =   14
            Caption         =   "Total Nominal"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8,25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   1
            Begin VB.Label LblNominal 
               Alignment       =   1  'Right Justify
               BackStyle       =   0  'Transparent
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8,25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   330
               Left            =   45
               TabIndex        =   10
               Top             =   255
               Width           =   2175
            End
         End
         Begin Threed.SSFrame SSFrame4 
            Height          =   630
            Left            =   45
            TabIndex        =   7
            Top             =   105
            Width           =   2235
            _Version        =   65536
            _ExtentX        =   3942
            _ExtentY        =   1111
            _StockProps     =   14
            Caption         =   "Nominal"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8,25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   1
            Begin VB.Label Label2 
               Alignment       =   1  'Right Justify
               BackStyle       =   0  'Transparent
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8,25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   45
               TabIndex        =   8
               Top             =   255
               Width           =   2145
            End
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4800
      _ExtentX        =   8467
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3660
         Top             =   -15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmCortesLetrasH.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmCortesLetrasH.frx":0452
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FrmCortesLetrasH"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Activate()

   Call Carga

End Sub


Sub Carga()
Dim I As Integer

   LblNominal = Format(0, FDecimal)
   Label2 = Format(FrmCortesLetrasH.Tag, FDecimal)

   With Grilla
   
      .Rows = 1
      .Cols = 4
      .ColWidth(0) = 0
      .ColWidth(1) = 1100: .TextMatrix(0, 1) = "Cortes"
      .ColWidth(2) = 1600: .TextMatrix(0, 2) = "Monto en Cortes"
      .ColWidth(3) = 1600: .TextMatrix(0, 3) = "Nominal"
      
      .Rows = 2
      
      .Row = 0
      For I = 1 To .Cols - 1
      
         .Col = I
         .CellFontBold = True
      
      Next I
      
      .Col = 1
      .Row = 1
      
      Call ValoresDefectos
      Call CargaDeOculta
      
   End With

End Sub



Sub TextosGrilla(Row, Col, key As Integer)
Dim tecla As Integer

   If IsNumeric(Chr(key)) = True Then
   
      tecla = key
      key = 13
   
   End If

   TxtNumero.Visible = False

   Select Case key
      
      Case 13
               
               Select Case Col
               
                  Case 1, 2
                           
                           If Col = 3 Or Col = 2 Then
                           
                              TxtNumero.CantidadDecimales = 4
                           
                           Else
                           
                              TxtNumero.CantidadDecimales = 0
                           
                           End If
                           
                           PosTexto TxtNumero, Grilla
                           TxtNumero.Text = IIf(Grilla.Text <> "", BacCtrlTransMonto(Grilla.Text), 0)
                           
                           If IsNumeric(Chr(tecla)) Then
                  
                              TxtNumero.Text = Chr(tecla)
                  
                           End If
               
               End Select
      
      Case 27


      Case 46
               If Grilla.Rows > 2 Then
              
                  Grilla.RemoveItem (Grilla.Row)
               
               Else
              
                  Call Limpiar
              
               End If
               
               Call SumaValores
      
      Case 45
               
               If CamposNulos(Grilla) Then
                  
                  Grilla.Rows = Grilla.Rows + 1
                  Call ValoresDefectos
                  
               End If

  End Select

End Sub


Sub Limpiar()

   With Grilla
   
      TxtNumero.Visible = False
      .Rows = 2
      .Col = 0
      .Rows = 2
      .Col = 1
      .Row = 1
'      ColPress = .Col
'      RowPress = .Row
  
      Call ValoresDefectos
  
  End With

End Sub

Private Sub Form_Load()

   Me.Icon = BacTrader.Icon

End Sub

Private Sub Grilla_DblClick()

   TextosGrilla Grilla.Row, Grilla.Col, 13

End Sub

Private Sub Grilla_KeyDown(KEYCODE As Integer, Shift As Integer)

   Select Case KEYCODE
      
      Case 45, 46
         TextosGrilla Grilla.Row, Grilla.Col, KEYCODE

   End Select

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

   TextosGrilla Grilla.Row, Grilla.Col, KeyAscii

End Sub


Function CamposNulos(Grilla As Control) As Boolean
Dim I, j As Integer

   CamposNulos = True

   With Grilla

      For I = 2 To .Rows
   
         For j = 1 To .Cols - 1
   
            If Format(.TextMatrix(.Rows - 1, j), "#,###") = "" Then
            
'               If .Col <> 5 Then
                  
                  CamposNulos = False
                  Exit Function
                     
'               End If
            
            End If
   
         Next j
         
      Next I

   End With

End Function


Sub PosTexto(Control, Grid As Control)
On Error Resume Next

   Control.Left = Grid.CellLeft + 40
   Control.Top = Grid.CellTop + 120
   Control.Width = Grid.CellWidth
   Control.Height = Grid.CellHeight
   Control.Visible = True
   Control.SetFocus

End Sub

Private Sub Grilla_Scroll()

   TxtNumero.Visible = False

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   
      Case 1
         Call Grabar
   
      Case 2
         Unload Me
         
   End Select

End Sub

Private Sub txtnumero_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
      Case 13
         
         Select Case Grilla.Col
            
            Case 2
               Grilla.Text = Format(TxtNumero.Text, FDecimal)
         
            Case 1
               Grilla.Text = Format(TxtNumero.Text, "###,##0")
         
         End Select
         
         TxtNumero.Visible = False
         Grilla.TextMatrix(Grilla.Row, 3) = Format(CDbl(Grilla.TextMatrix(Grilla.Row, 1)) * CDbl(Grilla.TextMatrix(Grilla.Row, 2)), FDecimal)
         
         Call SumaValores
      
      Case 27
         TxtNumero.Visible = False
               
   End Select

End Sub

Private Sub TxtNumero_LostFocus()

   TxtNumero.Visible = False

End Sub


Sub ValoresDefectos()

   With Grilla
   
      .TextMatrix(.Rows - 1, 1) = "0" 'Format(0, FDecimal)
      .TextMatrix(.Rows - 1, 2) = Format(0, FDecimal)
      .TextMatrix(.Rows - 1, 3) = Format(0, FDecimal)

   End With
   
End Sub

Sub Grabar()
Dim I As Integer
On Error GoTo Siguiente:

   If Label2 = LblNominal Then

         With FrmLetrasHipotecarias.Grilla2
         
            For I = 0 To .Rows - 1
            
               If Val(.TextMatrix(I, 0)) = codigo_planilla Then
            
                  If .Rows > 2 Then
                  
                     .RemoveItem (I)
                     I = I - 1
                     
                  Else
                  
                     .Rows = 1
                     Exit For
                  
                  End If
            
               End If
            
            Next I
      
Siguiente:
      
            For I = 1 To Grilla.Rows - 1
            
               .Rows = .Rows + 1
               .TextMatrix(.Rows - 1, 0) = codigo_planilla
               .TextMatrix(.Rows - 1, 1) = Correlativo
               .TextMatrix(.Rows - 1, 2) = Grilla.TextMatrix(I, 1)
               .TextMatrix(.Rows - 1, 3) = Grilla.TextMatrix(I, 2)
               .TextMatrix(.Rows - 1, 4) = Grilla.TextMatrix(I, 3)
      
            Next I
      
         End With
      
      MsgBox "La grabación se realizó correctamente", vbOKOnly + vbInformation, TITSISTEMA

   Else
   
      MsgBox "El Nominal con el Total Nominal deben ser Iguales", vbOKOnly + vbExclamation, TITSISTEMA
   
   End If

End Sub


Sub SumaValores()
Dim I As Integer

   With Grilla
   
      LblNominal = Format(0, FDecimal)
   
      For I = 1 To .Rows - 1
   
         LblNominal = Format(CDbl(.TextMatrix(I, 3)) + CDbl(LblNominal), FDecimal)
   
      Next I
      
   End With

End Sub


Sub CargaDeOculta()
Dim I As Integer


   With FrmLetrasHipotecarias.Grilla2
   
      Grilla.Rows = 1
      
      For I = 1 To .Rows - 1
      
         If Val(.TextMatrix(I, 0)) = codigo_planilla Then
            
            Grilla.Rows = Grilla.Rows + 1
            Grilla.TextMatrix(Grilla.Rows - 1, 1) = .TextMatrix(I, 2)
            Grilla.TextMatrix(Grilla.Rows - 1, 2) = Format(.TextMatrix(I, 3), FDecimal)
            Grilla.TextMatrix(Grilla.Rows - 1, 3) = Format(.TextMatrix(I, 4), FDecimal)
      
         End If
      
      Next I
      
      Call SumaValores

   End With

   If Grilla.Rows = 1 Then
   
      Grilla.Rows = 2
      Call ValoresDefectos
      
   End If

End Sub
