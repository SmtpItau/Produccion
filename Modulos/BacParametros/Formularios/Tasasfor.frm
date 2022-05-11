VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{B32E9168-9676-11D5-B8E1-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form TasasForward 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tasas Forward"
   ClientHeight    =   4830
   ClientLeft      =   1620
   ClientTop       =   4260
   ClientWidth     =   7815
   Icon            =   "Tasasfor.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4830
   ScaleWidth      =   7815
   Begin Threed.SSPanel SSPanel1 
      Height          =   4215
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   7815
      _Version        =   65536
      _ExtentX        =   13785
      _ExtentY        =   7435
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
      Begin Threed.SSFrame SSFrame1 
         Height          =   4035
         Left            =   120
         TabIndex        =   2
         Top             =   120
         Width           =   7575
         _Version        =   65536
         _ExtentX        =   13361
         _ExtentY        =   7117
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "System"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin BACControles.TXTNumero txt_ingreso 
            Height          =   255
            Left            =   960
            TabIndex        =   5
            Top             =   2520
            Visible         =   0   'False
            Width           =   2535
            _ExtentX        =   4471
            _ExtentY        =   450
            BackColor       =   8388608
            ForeColor       =   16777215
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            Text            =   "0"
         End
         Begin VB.PictureBox Gr_Forward 
            BackColor       =   &H00FFFFFF&
            Height          =   1920
            Left            =   450
            ScaleHeight     =   1860
            ScaleWidth      =   5220
            TabIndex        =   4
            Top             =   4425
            Visible         =   0   'False
            Width           =   5280
         End
         Begin MSFlexGridLib.MSFlexGrid Table1 
            Height          =   3675
            Left            =   120
            TabIndex        =   3
            Top             =   240
            Width           =   7320
            _ExtentX        =   12912
            _ExtentY        =   6482
            _Version        =   393216
            Cols            =   7
            FixedCols       =   0
            RowHeightMin    =   315
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            BackColorBkg    =   -2147483645
            GridColor       =   16777215
            GridColorFixed  =   16777215
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
      Left            =   1320
      Top             =   2610
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
            Picture         =   "Tasasfor.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Tasasfor.frx":075C
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
      Width           =   7815
      _ExtentX        =   13785
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdGrabar"
            Description     =   "CmdGrabar"
            Object.ToolTipText     =   "Grabar Tasas"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "TasasForward"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim Sql As String
Dim datos()
Dim x As Long
Dim colpress As Integer
Dim rowpress As Integer

Sub Dibuja_Grilla()

Table1.TextMatrix(0, 0) = ""
Table1.TextMatrix(0, 1) = "Desde"
Table1.TextMatrix(0, 2) = "Hasta"
Table1.TextMatrix(0, 3) = "UF"
Table1.TextMatrix(0, 4) = "CLP"
Table1.TextMatrix(0, 5) = "Libor"
Table1.TextMatrix(0, 6) = "Spread"

Table1.RowHeight(0) = 500

Table1.ColAlignment(0) = 7
Table1.ColAlignment(1) = 7
Table1.ColAlignment(2) = 7
Table1.ColAlignment(3) = 7
Table1.ColAlignment(4) = 7
Table1.ColAlignment(5) = 7
Table1.ColAlignment(6) = 7

Table1.ColWidth(0) = 0
Table1.ColWidth(1) = 1400
Table1.ColWidth(2) = 1400
Table1.ColWidth(3) = 1110
Table1.ColWidth(4) = 1110
Table1.ColWidth(5) = 1110
Table1.ColWidth(6) = 1110

End Sub

Function Carga_Grilla() As Boolean
Dim Fila As Double
Dim Hay As Boolean

    Carga_Grilla = False
    Hay = False
    Fila = 0
    Table1.Rows = 1
    
    If Bac_Sql_Execute("sp_tasas_forward") Then
        Do While Bac_SQL_Fetch(datos())
            Table1.Rows = Table1.Rows + 1
            Fila = Fila + 1
            'Table1.Row = Fila
            'Table1.Col = 1:
            Table1.TextMatrix(Fila, 1) = Format(datos(1), FEntero)
            'Table1.Col = 2:
            Table1.TextMatrix(Fila, 2) = Format(datos(2), FEntero)
            'Table1.Col = 3:
            Table1.TextMatrix(Fila, 3) = BacCtrlDesTransMonto(datos(3))
            'Table1.Col = 4:
            Table1.TextMatrix(Fila, 4) = BacCtrlDesTransMonto(datos(4))
            'Table1.Col = 5:
            Table1.TextMatrix(Fila, 5) = BacCtrlDesTransMonto(datos(5))
            'Table1.Col = 6:
            Table1.TextMatrix(Fila, 6) = BacCtrlDesTransMonto(datos(6))
            Hay = True
        Loop
    End If

    If Not Hay Then
       Exit Function
    End If

    Carga_Grilla = True
    
End Function

Function Graba_Tasas_Forward() As Double
Graba_Tasas_Forward = False


If Not Bac_Sql_Execute("Sp_Borra_Tasas_Forward") Then
   Exit Function
End If

For x = 1 To Table1.Rows - 1

    'Table1.Row = X

    Envia = Array()
        
    'Table1.Col = 1
    AddParam Envia, CDbl(Table1.TextMatrix(x, 1))
    'Table1.Col = 2
    AddParam Envia, CDbl(Table1.TextMatrix(x, 2))
    'Table1.Col = 3
    AddParam Envia, CDbl(Table1.TextMatrix(x, 3))
    'Table1.Col = 4
    AddParam Envia, CDbl(Table1.TextMatrix(x, 4))
    'Table1.Col = 5
    AddParam Envia, CDbl(Table1.TextMatrix(x, 5))
    'Table1.Col = 6
    AddParam Envia, Table1.TextMatrix(x, 6)
    
    If Not Bac_Sql_Execute("Sp_Graba_Tasas_Forward ", Envia) Then
        Exit Function
    End If
Next

Graba_Tasas_Forward = True
End Function



Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
Dibuja_Grilla

Table1.Cols = 7
Table1.Rows = 1

If Not Carga_Grilla Then
   Table1.Rows = 2
   'Table1.Col = 1:
   Table1.TextMatrix(Table1.Row, 1) = 1
   'Table1.Col = 2:
   Table1.TextMatrix(Table1.Row, 2) = 0
   'Table1.Col = 3:
   Table1.TextMatrix(Table1.Row, 3) = 0
   'Table1.Col = 4:
   Table1.TextMatrix(Table1.Row, 4) = 0
   'Table1.Col = 5:
   Table1.TextMatrix(Table1.Row, 5) = 0
End If

Table1.Col = 1
Table1.Row = 1

End Sub

Private Sub Form_Unload(Cancel As Integer)
        
  cerrar = MsgBox("¿Desea Guardar las Modificaciones?", vbInformation + vbYesNo, TITSISTEMA)
          
  If cerrar = 6 Then
  
        If Graba_Tasas_Forward Then
           
           MsgBox "Tasas grabadas en forma correcta", vbOKOnly + vbInformation, TITSISTEMA
        
        Else
           
           MsgBox "Problemas al grabar tasas", vbOKOnly + vbCritical, TITSISTEMA
           
        End If
   
  End If

End Sub

Private Sub Table1_Click()
    Call PintaCelda(Table1)
End Sub

Private Sub Table1_GotFocus()
    Call PintaCelda(Table1)
End Sub

Private Sub Table1_KeyUp(KeyCode As Integer, Shift As Integer)
   
   Table1.Col = colpress
   Table1.Row = rowpress

End Sub

Private Sub Table1_LeaveCell()
   Call CellPintaCelda(Table1)
End Sub

Private Sub Table1_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

   colpress = Table1.Col
   rowpress = Table1.Row

End Sub

Private Sub Table1_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)

   Table1.Col = colpress
   Table1.Row = rowpress


End Sub

Private Sub Table1_SelChange()
    Call PintaCelda(Table1)
End Sub
Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim i As Long
Dim ValorAnt As Double
Dim ValorDes As Double
 
Select Case KeyCode
Case vbKeyInsert
    
    Table1.Rows = Table1.Rows + 1
    Table1.Row = Table1.Rows - 1
    If Table1.Row <= Table1.Rows - 1 Then
       Table1.Row = Table1.Row - 1: Table1.Col = 2: ValorAnt = CDbl(CDbl(Table1.Text)) + 1
    End If
    Table1.Row = Table1.Rows - 1
    Table1.Col = 1: Table1.Text = Format(ValorAnt, "#,##0")
    Table1.Col = 2: Table1.Text = Format(0, "##0")
    Table1.Col = 3: Table1.Text = Format(0, "##0.0000")
    Table1.Col = 4: Table1.Text = Format(0, "##0.0000")
    Table1.Col = 5: Table1.Text = Format(0, "##0.0000")
    Table1.Col = 6: Table1.Text = Format(0, "##0.0000")
    Table1.Col = 2
    Call PintaCelda(Table1)
     
Case vbKeyDelete
      
      Table1.Col = 1
      If Table1.Row = Table1.Rows - 1 Then
         If Table1.Row = 1 Then
            Table1.Col = 1: Table1.Text = Format(1, "##0")
            Table1.Col = 2: Table1.Text = Format(0, "##0")
            Table1.Col = 3: Table1.Text = Format(0, "##0.0000")
            Table1.Col = 4: Table1.Text = Format(0, "##0.0000")
            Table1.Col = 5: Table1.Text = Format(0, "##0.0000")
            Table1.Col = 6: Table1.Text = Format(0, "##0.0000")
            Table1.Col = 2
            Call PintaCelda(Table1)
         Else
            Table1.RemoveItem Table1.Row
         End If
    Else
      If KeyCode = 46 And Table1.Rows >= 1 Then
        Table1.Col = 1
        If Table1.Row > 1 Then
           Table1.Row = Table1.Row - 1: ValorAnt = CDbl(Table1.Text)
        End If
        If Table1.Row < Table1.Rows - 1 Then
           Table1.Row = Table1.Row + 1: ValorDes = CDbl(Table1.Text)
        End If
        If (ValorAnt = 0 And Table1.Row >= 1 And ValorDes <> 0) Or (ValorAnt <> 0 And ValorDes <> 0) Then
           MsgBox "No se puede borrar un rango intermedio", vbOKOnly + vbExclamation, TITSISTEMA
           Table1.SetFocus
           Exit Sub
        End If
      End If
    End If

End Select
'  If KeyCode = 46 And Table1.Rows >= 1 Then
'  Table1.Col = 1
'  If Table1.Row > 1 Then
'  Table1.Row = Table1.Row - 1: ValorAnt = CDbl(Table1.Text)
'  End If
'  If Table1.Row < Table1.Rows - 1 Then
'    Table1.Row = Table1.Row + 1: ValorDes = CDbl(Table1.Text)
'  End If
'  If (ValorAnt = 0 And Table1.Row >= 1 And ValorDes <> 0) Or (ValorAnt <> 0 And ValorDes <> 0) Then
'     MsgBox "No se puede borrar un rango intermedio", vbOKOnly + vbExclamation
'     Exit Sub
'  End If

   colpress = Table1.Col
   rowpress = Table1.Row
  
  
End Sub
Private Sub Table1_KeyPress(KeyAscii As Integer)

If KeyAscii = 27 Then
   
   Table1.Text = Txt_Ingreso.Tag

End If

If KeyAscii = 13 And KeyAscii = 8 Then
   KeyAscii = 0
End If
If IsNumeric(Chr(KeyAscii)) Or KeyAscii = 13 Then
      Txt_Ingreso.Text = ""
      
      PROC_POSICIONA_TEXTO Table1, Txt_Ingreso
      
      If Table1.Col = 1 Or Table1.Col = 2 Then
         
         Txt_Ingreso.CantidadDecimales = 0
         Txt_Ingreso.Tag = Table1.Text
         
         If KeyAscii = 13 Then
         
            Txt_Ingreso.Text = Table1.Text
         
         Else
            
            Txt_Ingreso.Text = IIf(KeyAscii = 13, 0, Chr(KeyAscii))
         
         End If
         
         Txt_Ingreso.Visible = True
         Txt_Ingreso.SetFocus
      
      Else
      
         Txt_Ingreso.CantidadDecimales = 4
         
         If KeyAscii = 13 Then
         
            Txt_Ingreso.Text = Table1.Text
         
         Else
            
            Txt_Ingreso.Text = IIf(KeyAscii = 13, 0, Chr(KeyAscii))
         
         End If
         
         Txt_Ingreso.Visible = True
         Txt_Ingreso.SetFocus
      
      End If
      'SendKeys "{END}"

End If

End Sub

Function Valida_Rango() As Boolean

Valida_Rango = False

Dim ValorAnt As Double
Dim ValorDes As Double

With Table1
' si DESDE es menor o igual a HASTA de fila anterior
If .Row > 1 And .Col = 1 Then
   If CDbl(.TextMatrix(.Row - 1, 2)) >= CDbl(Txt_Ingreso.Text) Then
       MsgBox "Error : Rango no válido", vbOKOnly + vbCritical, TITSISTEMA
       Txt_Ingreso.SetFocus
       Exit Function
   End If
End If

' si DESDE mayor o igual a HASTA de la misma fila
If .Row = 1 And .Col = 2 Then
    If CDbl(.TextMatrix(.Row, 1)) >= CDbl(Txt_Ingreso.Text) Then
           MsgBox "Error : Rango no válido", vbOKOnly + vbCritical, TITSISTEMA
           Txt_Ingreso.SetFocus
       Exit Function
    End If
End If

'si HASTA es menor o igual a Desde de fila posterior
If .Row > 1 And .Col = 2 Then
   If CDbl(.TextMatrix(.Row, 1)) >= CDbl(Txt_Ingreso.Text) Then
      MsgBox "Error : Plazo debe ser mayor al Rango", vbOKOnly + vbCritical, TITSISTEMA
      Txt_Ingreso.SetFocus
      Exit Function
   End If
End If


End With

Valida_Rango = True

End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index

    Case 1          '   "CmdGrabar"
        Screen.MousePointer = vbHourglass
        If Graba_Tasas_Forward Then
           MsgBox "Tasas grabadas en forma correcta", vbOKOnly + vbInformation, TITSISTEMA
        Else
           MsgBox "Problemas al grabar tasas", vbOKOnly + vbCritical, TITSISTEMA
           
        End If
        
        Table1.SetFocus
'        If Not Carga_Grilla Then
 '       End If
        Screen.MousePointer = vbDefault
    
    Case 2          '   "Salir"
        Unload Me

End Select

End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 And Chr(KeyAscii) <> "," And Chr(KeyAscii) <> "." And KeyAscii <> 27 Then
   KeyAscii = 0
End If

If KeyAscii = 27 Then
  Txt_Ingreso.Text = ""
  Txt_Ingreso.Visible = False
  Table1.Text = Txt_Ingreso.Tag
  Table1.SetFocus
  Exit Sub
End If

Select Case Table1.Col
  
Case 1, 2

     'KeyAscii = BacPunto(txt_ingreso, KeyAscii, 6, 0)
     Txt_Ingreso.Max = 9999
     Txt_Ingreso.CantidadDecimales = 0

Case 3, 4, 5, 6

     'KeyAscii = BacPunto(txt_ingreso, KeyAscii, 3, 4)
     Txt_Ingreso.Max = 9999
     Txt_Ingreso.CantidadDecimales = 4


End Select

If KeyAscii = 13 Then

  If Trim(Txt_Ingreso.Text) = "" Then Exit Sub
  
  If Not Valida_Rango Then Exit Sub
  
  If Table1.Col = 1 Or Table1.Col = 2 Then
  
      Table1.Text = Format(Txt_Ingreso.Text, FEntero) 'Format(CDbl(Txt_Ingreso.Text), "##0.0000")
      Txt_Ingreso.Text = ""
      Txt_Ingreso.Visible = False
  
  Else
  
      Table1.Text = Format(Txt_Ingreso.Text, FDecimal) 'Format(CDbl(Txt_Ingreso.Text), "##0.0000")
      Txt_Ingreso.Text = ""
      Txt_Ingreso.Visible = False
   
  End If
  
  Txt_Ingreso.Tag = Table1.Text
  
End If
End Sub
