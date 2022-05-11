VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{7A0B0044-A403-11D5-B8EF-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Limites_tasas 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Limites de Tasas"
   ClientHeight    =   3960
   ClientLeft      =   1875
   ClientTop       =   870
   ClientWidth     =   8895
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3960
   ScaleWidth      =   8895
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   8895
      _ExtentX        =   15690
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   3255
      Left            =   0
      TabIndex        =   0
      Top             =   720
      Width           =   8895
      _Version        =   65536
      _ExtentX        =   15690
      _ExtentY        =   5741
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
      Begin BACControles.TXTNumero texto 
         Height          =   255
         Left            =   4560
         TabIndex        =   4
         Top             =   1440
         Visible         =   0   'False
         Width           =   975
         _ExtentX        =   1720
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
         Text            =   "0.000"
         Text            =   "0.000"
         CantidadDecimales=   "3"
         Separator       =   -1  'True
         SelStart        =   1
      End
      Begin VB.ComboBox Combo1 
         BackColor       =   &H00C0C0C0&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Limites_tasas.frx":0000
         Left            =   240
         List            =   "Limites_tasas.frx":0013
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   600
         Visible         =   0   'False
         Width           =   1095
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   240
         Top             =   3240
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   25
         ImageHeight     =   25
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Limites_tasas.frx":002B
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Limites_tasas.frx":047D
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Limites_tasas.frx":0797
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid Tabla1 
         Height          =   2775
         Left            =   120
         TabIndex        =   1
         Top             =   360
         Width           =   8655
         _ExtentX        =   15266
         _ExtentY        =   4895
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         BackColor       =   12632256
         BackColorFixed  =   8421376
         GridLines       =   2
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
Attribute VB_Name = "Limites_tasas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim i As Integer
Private Sub Crear_Grilla()
'Tabla1.WordWrap = True
Tabla1.TextMatrix(0, 0) = "Tip. Oper"
Tabla1.TextMatrix(0, 1) = "Glosa"
Tabla1.TextMatrix(0, 2) = "Moneda"
Tabla1.TextMatrix(0, 3) = "Tasa Inferior"
Tabla1.TextMatrix(0, 4) = "Tasa Superior"
Tabla1.ColWidth(0) = 1100
Tabla1.ColWidth(1) = 3700
Tabla1.ColWidth(2) = 1120
Tabla1.ColWidth(3) = 1150
Tabla1.ColWidth(4) = 1150
    
End Sub

Private Sub Grabar()
Screen.MousePointer = 11
Toolbar1.Buttons(1).Enabled = False
Toolbar1.Buttons(2).Enabled = False
        
For i = 1 To Tabla1.Rows - 1
    Envia = Array()
    
    AddParam Envia, Tabla1.TextMatrix(i, 0)
    AddParam Envia, Val(Tabla1.TextMatrix(i, 2))
    AddParam Envia, CDbl(Tabla1.TextMatrix(i, 3))
    AddParam Envia, CDbl(Tabla1.TextMatrix(i, 4))
    
    If Not Bac_Sql_Execute("SP_GRABA_LIMITE_TASA", Envia) Then
            MsgBox "ERROR AL GRABAR DATOS", vbCritical
            Exit Sub
    End If
Next i
MsgBox "Datos Grabados Correctamente", vbExclamation
Screen.MousePointer = 0
Toolbar1.Buttons(1).Enabled = True
Toolbar1.Buttons(2).Enabled = True

End Sub

Private Sub Llenar_Datos()
Dim i As Integer
Dim datos()
    Screen.MousePointer = 11
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    
     Envia = Array()
     Tabla1.Rows = 1
     
     If Not Bac_Sql_Execute("SP_LEE_LIMITES_TASAS", Envia) Then
            MsgBox ("ERROR AL TRAER DATOS")
     End If
        i = 0
        Do While Bac_SQL_Fetch(datos())
          If datos(1) <> "OK" Then
             i = i + 1
             Tabla1.Rows = Tabla1.Rows + 1
             Tabla1.TextMatrix(i, 0) = datos(1)
             Tabla1.TextMatrix(i, 1) = datos(2)
             Tabla1.TextMatrix(i, 2) = datos(3)
             Tabla1.TextMatrix(i, 3) = Format(datos(4), "###,##0.##0")
             Tabla1.TextMatrix(i, 4) = Format(datos(5), "###,##0.##0")
          End If
        Loop
    Screen.MousePointer = 0
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    
     
End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 27 Then
    Combo1.Visible = False
    Tabla1.SetFocus
End If

If KeyCode = 13 Then
   With Combo1
    Tabla1.TextMatrix(Tabla1.Row, 0) = .Text
    Select Case .ListIndex
    Case 0
        Tabla1.TextMatrix(Tabla1.Row, 1) = "Compra Definitiva"
    Case 1
        Tabla1.TextMatrix(Tabla1.Row, 1) = "Venta Definitiva"
    Case 2
        Tabla1.TextMatrix(Tabla1.Row, 1) = "Compra Con Pacto"
       
    Case 3
        Tabla1.TextMatrix(Tabla1.Row, 1) = "Venta Con Pacto"
        
    Case 4
        Tabla1.TextMatrix(Tabla1.Row, 1) = "Interbancario"
    
    End Select
    .Visible = False
   End With
End If
End Sub


Private Sub Form_Load()
Call Crear_Grilla
Call Llenar_Datos

End Sub
Private Sub MSFlexGrid1_Click()

End Sub


Private Sub Tabla1_KeyDown(KeyCode As Integer, Shift As Integer)

'If KeyCode = 45 Then
'        Tabla1.Rows = Tabla1.Rows + 1
'End If
'If KeyCode = 46 Then
'    If Tabla1.Rows = 2 Then
'        Call Limpiar
'    Else
'       Tabla1.RemoveItem (Tabla1.Row)
'    End If
'
'
'End If

End Sub

Private Sub Limpiar()
Tabla1.TextMatrix(1, 0) = ""
Tabla1.TextMatrix(1, 1) = ""
Tabla1.TextMatrix(1, 2) = ""
Tabla1.TextMatrix(1, 3) = ""
Tabla1.TextMatrix(1, 4) = ""
End Sub

Private Sub Tabla1_KeyPress(KeyAscii As Integer)
Dim x As Integer
'If Tabla1.Col = 0 Then
'    Call PROC_POSI_TEXTO(Tabla1, Combo1)
'    Combo1.ListIndex = 1
'    For x = 0 To Combo1.ListCount - 1
'         Combo1.ListIndex = x
'         If Left(Combo1, 1) = UCase(Chr(KeyAscii)) Then
'            Exit For
'         End If
'    Next
'
'    Combo1.Visible = True
'    Combo1.SetFocus
'End If
If Tabla1.Col > 2 Then
    Call PROC_POSI_TEXTO(Tabla1, texto)
     ' If KeyAscii > 47 And KeyAscii < 58 Then
     '       texto.Text = Chr(KeyAscii)
     ' End If
    
    'If Tabla1.Col = 2 Then
     '   Texto.Max = 999
      '  Texto.CantidadDecimales = 0
    'Else
    '    Texto.Max = 999999999
    '    Texto.CantidadDecimales = 4
    'End If
    texto.Visible = True
    texto.SetFocus
    texto.SelStart = 1

End If

End Sub


Private Sub Texto_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    Tabla1.TextMatrix(Tabla1.Row, Tabla1.Col) = texto.Text 'Format(texto.Text, "###,##0.##0")
    Tabla1.Text = BacFormatoMonto(Tabla1.TextMatrix(Tabla1.Row, Tabla1.Col), 3)
    texto.Text = 0
    texto.Visible = False
    
End If
If KeyCode = 27 Then
    texto.Text = 0
    texto.Visible = False
End If
'texto.SelStart = 1
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index

Case 1
        
         Call Grabar
        
Case 2
        Call Llenar_Datos
Case 3
        Unload Me
End Select

End Sub


