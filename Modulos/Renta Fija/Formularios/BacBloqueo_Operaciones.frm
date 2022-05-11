VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacBloqueo_Operaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Bloqueo Operaciones"
   ClientHeight    =   7410
   ClientLeft      =   120
   ClientTop       =   420
   ClientWidth     =   10320
   Icon            =   "BacBloqueo_Operaciones.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Picture         =   "BacBloqueo_Operaciones.frx":0442
   ScaleHeight     =   7410
   ScaleWidth      =   10320
   Visible         =   0   'False
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   1
      Left            =   330
      Picture         =   "BacBloqueo_Operaciones.frx":205084
      ScaleHeight     =   315
      ScaleWidth      =   345
      TabIndex        =   4
      Top             =   1890
      Visible         =   0   'False
      Width           =   345
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   0
      Left            =   780
      Picture         =   "BacBloqueo_Operaciones.frx":409CC6
      ScaleHeight     =   315
      ScaleWidth      =   345
      TabIndex        =   3
      Top             =   1800
      Visible         =   0   'False
      Width           =   345
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   0
      Left            =   330
      Picture         =   "BacBloqueo_Operaciones.frx":409E20
      ScaleHeight     =   315
      ScaleWidth      =   345
      TabIndex        =   2
      Top             =   1920
      Visible         =   0   'False
      Width           =   345
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10995
      _ExtentX        =   19394
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Desbloquear Operaciones Marcadas"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   2
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid1 
      Height          =   5355
      Left            =   120
      TabIndex        =   1
      Top             =   1740
      Width           =   10155
      _ExtentX        =   17912
      _ExtentY        =   9446
      _Version        =   393216
      Cols            =   10
      FixedCols       =   0
      BackColor       =   -2147483638
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483634
      FocusRect       =   0
      GridLines       =   2
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
   Begin VB.Frame Frame1 
      Height          =   7095
      Left            =   -120
      TabIndex        =   5
      Top             =   480
      Width           =   10455
      Begin VB.TextBox TxtSerie 
         Height          =   315
         Left            =   3000
         TabIndex        =   9
         Top             =   360
         Width           =   1575
      End
      Begin VB.CommandButton Bloquear 
         Caption         =   "+"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1200
         TabIndex        =   8
         Top             =   840
         Width           =   495
      End
      Begin BACControles.TXTNumero TxtNroOperacion 
         Height          =   315
         Left            =   1200
         TabIndex        =   10
         Top             =   360
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
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
         Min             =   "0"
         Max             =   "99999999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtCorrela 
         Height          =   315
         Left            =   2520
         TabIndex        =   11
         Top             =   360
         Width           =   375
         _ExtentX        =   661
         _ExtentY        =   556
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
         Min             =   "0"
         Max             =   "99"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtNominal 
         Height          =   315
         Left            =   4680
         TabIndex        =   12
         Top             =   360
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   556
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
         Min             =   "0"
         Max             =   "99999999999999.999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label1 
         Caption         =   "Bloquear"
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
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   840
         Width           =   975
      End
      Begin VB.Label Lbl_conceptoBloqueo 
         Caption         =   "Operación"
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
         Height          =   255
         Left            =   240
         TabIndex        =   6
         Top             =   360
         Width           =   975
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   8421504
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueo_Operaciones.frx":409F7A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueo_Operaciones.frx":40A294
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueo_Operaciones.frx":40A6E6
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueo_Operaciones.frx":40AB38
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueo_Operaciones.frx":40AE52
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueo_Operaciones.frx":40B16C
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueo_Operaciones.frx":40B5BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueo_Operaciones.frx":40B8D8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Image ImgCheck 
      Height          =   480
      Left            =   0
      Top             =   8520
      Width           =   480
   End
   Begin VB.Image ImgChk 
      Height          =   375
      Left            =   870
      Stretch         =   -1  'True
      Top             =   8625
      Width           =   480
   End
End
Attribute VB_Name = "BacBloqueo_Operaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Datos()
Dim objTipSubCar   As New ClsCodigos
   

Private Sub Bloquear_Click()

On Error GoTo Err_Blq

Envia = Array()
AddParam Envia, Format(Me.TxtNroOperacion.text, "#########")   'numero operacion
AddParam Envia, Format(Me.TxtCorrela.text, "###")  'correlativo de la ope
AddParam Envia, "S"
            
If Me.TxtNroOperacion.text > 0 And Me.TxtSerie <> "" Then
    If Not Bac_Sql_Execute("SP_BLOQUEO_INSTRUMENTO", Envia) Then
        MsgBox "Error: Servidor SQL", 16, TITSISTEMA
        Exit Sub
    Else
        MsgBox "Instrumento Bloqueado", 16, TITSISTEMA
    End If
End If

Me.TxtNroOperacion.text = 0
Me.TxtCorrela.text = 0
Me.TxtNominal.text = ""
Me.TxtSerie.text = ""

Desplegar_instrumentos

Exit Sub

Err_Blq:
    MsgBox "Error: Servidor SQL", 16, TITSISTEMA

End Sub


Private Sub Form_Load()
Me.Top = 1
Me.Left = 16


    Dim Conta As Integer
    Dim i As Integer
    
       
        Desplegar_instrumentos
        
End Sub

Private Sub Nombres_Grilla_cartera()
    Call Formato_Grilla(Grid1)
    With Grid1
        .Rows = 3
        .cols = 9
        .FixedRows = 2
        .FixedCols = 0
        
        .TextMatrix(0, 0) = "Marcar     ": .TextMatrix(1, 0) = "Desbloquear"
        .TextMatrix(0, 1) = "Serie      ": .TextMatrix(1, 1) = ""
        .TextMatrix(0, 2) = "Nro.Docu   ": .TextMatrix(1, 2) = ""
        .TextMatrix(0, 3) = "Correla    ": .TextMatrix(1, 3) = ""
        .TextMatrix(0, 4) = "Tipo       ": .TextMatrix(1, 4) = ""
        .TextMatrix(0, 5) = "Instrumento": .TextMatrix(1, 5) = ""
        .TextMatrix(0, 6) = "Moneda     ": .TextMatrix(1, 6) = ""
        .TextMatrix(0, 7) = "Nominal    ": .TextMatrix(1, 7) = ""
        .TextMatrix(0, 8) = "Tir        ": .TextMatrix(1, 8) = ""
        
        
        .ColWidth(0) = 1000
        .ColWidth(1) = 1200
        .ColWidth(2) = 1000
        .ColWidth(3) = 500
        .ColWidth(4) = 500
        .ColWidth(5) = 1000
        .ColWidth(6) = 800
        .ColWidth(7) = 1500
        .ColWidth(8) = 800
        
        .RowHeight(0) = 260
        .RowHeight(1) = 260
    End With
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
    Case 1
        Desplegar_instrumentos
    Case 2
        Desbloquear_operaciones
'        Grabar_Operacion
    Case 3
         Unload Me
    End Select
End Sub
Private Sub Grabar_Operacion()
    Screen.MousePointer = 0
End Sub

Private Function Desplegar_instrumentos()

Dim c1 As String
Dim Cartera As Integer

Call Nombres_Grilla_cartera

Me.MousePointer = 11
    
If Not Bac_Sql_Execute("SP_INFORME_OPER_BLOQ") Then
    Me.MousePointer = 0
    MsgBox "Ha ocurrido un error en Operaciones Bloqueadas", 16, TITSISTEMA
    Unload Me
    Exit Function
End If
  
c1 = ""
With Grid1
    .Redraw = False

    .Rows = 2
    Do While Bac_SQL_Fetch(Datos())
    
            c1 = "1"
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .Col = 0: .text = Space(100) '+ Datos(18) 'estado
            .CellPictureAlignment = 4
             Set .CellPicture = Me.SinCheck(0).Image
        
            .Col = 1: .text = Datos(7)  'serie
            .Col = 2: .text = Datos(1) 'Holding
            .Col = 3: .text = Datos(2) 'UM
            .Col = 4: .text = Datos(5)  'Nomina
            .Col = 5: .text = Datos(6)  'tir
            .Col = 6: .text = Datos(8) 'vpar
            .Col = 7: .text = Format(Datos(9), "#,###,###,##0") 'Nominal
            .Col = 8: .text = Datos(10) 'tir
        
        .RowHeight(.Rows - 1) = 300
        
        'End If
    
    Loop
    '.Enabled = True
    .Redraw = True
End With

Me.MousePointer = 0
If c1 = "" Then
    MsgBox "NO existen instrumentos disponibles para bloqueo", 16, TITSISTEMA
End If
  
End Function

Private Sub TxtCorrela_LostFocus()
On Error GoTo Err_Leer

Envia = Array()
AddParam Envia, Format(Me.TxtNroOperacion.text, "#########")  'numero operacion
AddParam Envia, Format(Me.TxtCorrela.text, "###")  'correlativo de la ope
            
If Not Bac_Sql_Execute("SP_BUSCA_OPER_BLOQ", Envia) Then
    MsgBox "Error: Operacion No existe", 16, TITSISTEMA
    Exit Sub
End If
If Bac_SQL_Fetch(Datos()) Then
    If Datos(1) = "SI" Then
        Me.TxtSerie.text = Datos(3)
        Me.TxtNominal.text = Datos(5)
    Else
        MsgBox "Operacion no existe " & Format(Me.TxtNroOperacion.text, "#########"), 16, TITSISTEMA
    End If
End If

Exit Sub

Err_Leer:
    MsgBox "Error: Servidor SQL", 16, TITSISTEMA


End Sub

Private Sub TxtNroOperacion_LostFocus()
'On Error GoTo Err_Leer
'
'Envia = Array()
'AddParam Envia, Format(Me.TxtNroOperacion.text, "#########")  'numero operacion
'AddParam Envia, Format(Me.TxtCorrela.text, "###")  'correlativo de la ope
'
'If Not Bac_Sql_Execute("SP_BUSCA_OPER_BLOQ", Envia) Then
'    MsgBox "Error: Servidor SQL", 16, TITSISTEMA
'    Exit Sub
'End If
'If Bac_SQL_Fetch(Datos()) Then
'    If Datos(1) = "SI" Then
'        Me.TxtSerie.text = Datos(3)
'        Me.TxtNominal.text = Datos(5)
'    Else
'        MsgBox "Error: Servidor SQL", 16, TITSISTEMA
'    End If
'End If
'
'Exit Sub
'Err_Leer:
'        MsgBox "Error: Servidor SQL", 16, TITSISTEMA
'
End Sub
Sub Desbloquear_operaciones()
On Error GoTo Err_DesB
Dim nNumOpe, nCont As Integer

For nCont = 2 To Grid1.Rows - 1
    If Trim(Grid1.TextMatrix(nCont, 0)) = "C" Then
            Envia = Array()
            AddParam Envia, Trim(Grid1.TextMatrix(nCont, 2))   'numero operacion
            AddParam Envia, Trim(Grid1.TextMatrix(nCont, 3))   'correlativo de la ope
            AddParam Envia, "N"
                
            
            If Not Bac_Sql_Execute("SP_BLOQUEO_INSTRUMENTO", Envia) Then
                MsgBox "Error: Servidor SQL", 16, TITSISTEMA
            Else
                MsgBox "Desbloqueo Operacion :" & Trim(Grid1.TextMatrix(nCont, 2)), 16, TITSISTEMA
            End If
    End If
Next nCont

Desplegar_instrumentos

Exit Sub
Err_DesB:
    MsgBox "Error: Servidor SQL", 16, TITSISTEMA

End Sub
Private Sub Grid1_Click()

Dim ciclo As Integer
Dim tipoExceso As String

    
    If Grid1.Rows > 1 And Grid1.Col = 0 Then
        If Trim(Grid1.TextMatrix(Grid1.Row, 1)) <> "" Then  'No parece vacía...
            'numeroOperación = Int(Grid1.TextMatrix(Grid1.Row, 14))
            If Grid1.CellBackColor <> vbYellow And Grid1.CellBackColor <> vbRed Then
                'If Trim(Grid1.TextMatrix(Grid1.Row, 0)) <> "" Then
                    'Grid1.TextMatrix(Grid1.Row, 0) = ""
                '    Set Grid1.CellPicture = Me.SinCheck(0).Image
                'ElseIf Tipo_Aut = 2 Or Tipo_Aut = 1 Then
                    'Grid1.CellAlignment = 4
                    'Grid1.TextMatrix(Grid1.Row, 0) = Space(100) + "C"
                'ElseIf Tipo_Aut = 3 Then
                    Set Grid1.CellPicture = Me.ConCheck(0).Image
                    Grid1.CellAlignment = 4
                    Grid1.TextMatrix(Grid1.Row, 0) = Space(100) + "C"
                'End If
            End If
        End If
    'ElseIf Grid1.Rows > 1 And Grid1.Col = 6 And Tipo_Aut = 2 Then
     '   Grid1_KeyPress 13
    End If
    
        'MsgBox "usuario, acontinuación se marcarán todos los documentos asociados a la operación según limite seleccionado", vbOKOnly + vbInformation
    
End Sub

Private Sub Grid1_dblClick()

Dim ciclo As Integer

'If Tipo_Aut <> 3 Then
    If Grid1.Rows > 1 And Grid1.Col = 0 Then
        If Grid1.TextMatrix(Grid1.Row, 1) <> "" Then  'No parece vacía...
            '+++jcamposd control automatico
            'numeroOperación = Int(Grid1.TextMatrix(Grid1.Row, 14))
            '---jcamposd control automatico
            If Grid1.CellBackColor <> vbYellow And Grid1.CellBackColor <> vbRed Then
                If Trim(Grid1.TextMatrix(Grid1.Row, 0)) <> "" Then
                    Grid1.TextMatrix(Grid1.Row, 0) = ""
                    Set Grid1.CellPicture = Me.SinCheck(0).Image
                Else
                    Set Grid1.CellPicture = Me.ConCheck(1).Image
                    Grid1.CellAlignment = 4
                    Grid1.TextMatrix(Grid1.Row, 0) = Space(100) + "P"
                End If
            End If
        End If
    'ElseIf Grid1.Rows > 1 And Grid1.Col = 6 And Tipo_Aut = 2 Then
     '   Grid1_KeyPress 13
    End If

End Sub

Private Sub Grid1_KeyDown_(KeyCode As Integer, Shift As Integer)
   Select Case KeyCode
      Case vbKeySpace
          If Grid1.TextMatrix(Grid1.Row, 1) <> "" And Grid1.TextMatrix(Grid1.Row, 2) <> "" Then 'No parece vacía...
              If Grid1.Rows > 1 And Grid1.Col = 0 Then
                  If Trim(Grid1.TextMatrix(Grid1.RowSel, 0)) <> "" Then
                      Grid1.TextMatrix(Grid1.RowSel, 0) = ""
                      Set Grid1.CellPicture = Me.SinCheck(0).Image
                  Else
                      Set Grid1.CellPicture = Me.ConCheck(0).Image
                      Grid1.CellAlignment = 4
                      Grid1.TextMatrix(Grid1.RowSel, 0) = Space(100) + "X"
                  End If
            
              End If
          End If
      Case 46   '???
      Dim i
          If Grid1.CellBackColor = vbYellow Then
             For i = 0 To Grid1.cols - 1
                 Grid1.Col = i
                 Grid1.CellBackColor = vbRed
             Next
             Exit Sub
          End If
          If Grid1.CellBackColor = vbRed Then
             For i = 0 To Grid1.cols - 1
                 Grid1.Col = i
                 Grid1.CellBackColor = vbYellow
             Next
             Exit Sub
         End If
          
   End Select
End Sub

