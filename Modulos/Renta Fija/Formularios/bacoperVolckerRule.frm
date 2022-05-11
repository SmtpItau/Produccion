VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form bacOperVolckerRule 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Actualización Volcker Rule"
   ClientHeight    =   7125
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   13920
   Icon            =   "bacoperVolckerRule.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Picture         =   "bacoperVolckerRule.frx":0442
   ScaleHeight     =   7125
   ScaleWidth      =   13920
   Visible         =   0   'False
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   1
      Left            =   90
      Picture         =   "bacoperVolckerRule.frx":205084
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
      Left            =   540
      Picture         =   "bacoperVolckerRule.frx":409CC6
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
      Left            =   90
      Picture         =   "bacoperVolckerRule.frx":409E20
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
      Width           =   13875
      _ExtentX        =   24474
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
            Object.ToolTipText     =   "Grabar Operaciones Marcadas"
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
      Left            =   30
      TabIndex        =   1
      Top             =   1620
      Width           =   13875
      _ExtentX        =   24474
      _ExtentY        =   9446
      _Version        =   393216
      Cols            =   24
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
      Left            =   0
      TabIndex        =   5
      Top             =   480
      Width           =   13935
      Begin VB.TextBox TxtCodConceptoBloqueo 
         Height          =   345
         Left            =   11700
         TabIndex        =   9
         Top             =   330
         Visible         =   0   'False
         Width           =   645
      End
      Begin VB.TextBox Txt_descTipoBloqueo 
         Enabled         =   0   'False
         Height          =   345
         Left            =   5280
         Locked          =   -1  'True
         TabIndex        =   7
         Top             =   330
         Visible         =   0   'False
         Width           =   6285
      End
      Begin VB.ComboBox Cmb_CodigoBloqueo 
         Height          =   315
         Left            =   1980
         TabIndex        =   6
         Top             =   330
         Width           =   3105
      End
      Begin VB.Label Lbl_conceptoBloqueo 
         Caption         =   "Sub-Cartera"
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
         TabIndex        =   8
         Top             =   360
         Width           =   1575
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
            Picture         =   "bacoperVolckerRule.frx":409F7A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacoperVolckerRule.frx":40A294
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacoperVolckerRule.frx":40A6E6
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacoperVolckerRule.frx":40AB38
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacoperVolckerRule.frx":40AE52
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacoperVolckerRule.frx":40B16C
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacoperVolckerRule.frx":40B5BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacoperVolckerRule.frx":40B8D8
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
Attribute VB_Name = "bacOperVolckerRule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim datos()
Dim objTipSubCar   As New clsCodigos
   


'Private Sub Cmb_CodigoBloqueo_Click()
'Dim I As Integer
'Dim X As Integer
'X = 1
'I = 1 + Cmb_CodigoBloqueo.ListIndex
'    For X = 1 To I
'        Txt_descTipoBloqueo.text = Arreglo(I).descrip
'        TxtCodConceptoBloqueo.text = Arreglo(I).Numero
'    Next
'
'End Sub

Private Sub Form_Load()
Me.Top = 1
Me.Left = 16


    Dim Conta As Integer
    Dim I As Integer
    
        Call objTipSubCar.LeerCodVPVI(206)
        Call objTipSubCar.Coleccion2Control(Cmb_CodigoBloqueo)
        Cmb_CodigoBloqueo.ListIndex = IIf(Cmb_CodigoBloqueo.ListCount > 0, 0, -1)
        Cmb_CodigoBloqueo.Enabled = True
        
        Desplegar_instrumentos
        
End Sub

Private Sub Nombres_Grilla_cartera()
    Call Formato_Grilla(Grid1)
    With Grid1
        .Rows = 3
        .cols = 24
        .FixedRows = 2
        .FixedCols = 0
        
        .TextMatrix(0, 0) = "Marcar     ": .TextMatrix(1, 0) = ""
        .TextMatrix(0, 1) = "Serie      ": .TextMatrix(1, 1) = ""
        .TextMatrix(0, 2) = "Holding    ": .TextMatrix(1, 2) = "Period"
        .TextMatrix(0, 3) = "UM         ": .TextMatrix(1, 3) = ""
        .TextMatrix(0, 4) = "Nominal    ": .TextMatrix(1, 4) = ""
        .TextMatrix(0, 5) = "%Tir       ": .TextMatrix(1, 5) = ""
        .TextMatrix(0, 6) = "%Vpar      ": .TextMatrix(1, 6) = ""
        .TextMatrix(0, 7) = "Valor      ": .TextMatrix(1, 7) = "Presente"
        .TextMatrix(0, 8) = "Custodia   ": .TextMatrix(1, 8) = ""
        .TextMatrix(0, 9) = "Clave DCV   ": .TextMatrix(1, 9) = ""
        .TextMatrix(0, 10) = "%Tir C.    ": .TextMatrix(1, 10) = ""
        .TextMatrix(0, 11) = "%Vpar C.   ": .TextMatrix(1, 11) = ""
        .TextMatrix(0, 12) = "Valor      ": .TextMatrix(1, 12) = "de Compra"
        .TextMatrix(0, 13) = "Tipo   ": .TextMatrix(1, 13) = "Cartera"
        'para grabar
        .TextMatrix(0, 14) = "numeroOpe  ": .TextMatrix(1, 14) = ""
        .TextMatrix(0, 15) = "correlativo": .TextMatrix(1, 15) = ""
        .TextMatrix(0, 16) = "Usuario    ": .TextMatrix(1, 16) = ""
        .TextMatrix(0, 17) = "tipoBloqueo": .TextMatrix(1, 17) = ""
        .TextMatrix(0, 18) = "fecha       ": .TextMatrix(1, 18) = ""
        .TextMatrix(0, 19) = "Rutcartera": .TextMatrix(1, 19) = ""
        .TextMatrix(0, 20) = "tipoExceso": .TextMatrix(1, 20) = ""
        .TextMatrix(0, 21) = "tipocliente": .TextMatrix(1, 21) = ""
        .TextMatrix(0, 22) = "Tipo  ": .TextMatrix(1, 22) = "Cartera"
        .TextMatrix(0, 23) = "Sub-Tipo ": .TextMatrix(1, 22) = "Cartera"
        
        '---jcamposd a petición de usuario se reformula grilla
        
        .ColWidth(0) = 1000
        .ColWidth(1) = 1200
        .ColWidth(2) = 700
        .ColWidth(3) = 500
        .ColWidth(4) = 1800
        .ColWidth(5) = 800
        .ColWidth(6) = 800
        .ColWidth(7) = 0 '1500
        .ColWidth(8) = 1000
        .ColWidth(9) = 0
        .ColWidth(10) = 800
        .ColWidth(11) = 800
        .ColWidth(12) = 0 '1500
        .ColWidth(13) = 0
        .ColWidth(14) = 1200
        .ColWidth(15) = 0
        .ColWidth(16) = 0
        .ColWidth(17) = 0
        .ColWidth(18) = 0
        .ColWidth(19) = 0
        .ColWidth(20) = 0
        .ColWidth(21) = 0
        .ColWidth(22) = 2000
        .ColWidth(23) = 2000
        
        .RowHeight(0) = 260
        .RowHeight(1) = 260
    End With
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
      Dim I
          If Grid1.CellBackColor = vbYellow Then
             For I = 0 To Grid1.cols - 1
                 Grid1.Col = I
                 Grid1.CellBackColor = vbRed
             Next
             Exit Sub
          End If
          If Grid1.CellBackColor = vbRed Then
             For I = 0 To Grid1.cols - 1
                 Grid1.Col = I
                 Grid1.CellBackColor = vbYellow
             Next
             Exit Sub
         End If
          
   End Select
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
    Case 1
        Desplegar_instrumentos
    Case 2
        Grabar_Operacion
    Case 3
         Unload Me
    End Select
End Sub
Private Sub Grabar_Operacion()
    Grabar_ActVoucker
    Screen.MousePointer = 0
End Sub

Private Function Desplegar_instrumentos()

Dim c1 As String
Dim Cartera As Integer

Call Nombres_Grilla_cartera



Me.MousePointer = 11

    
If Not Bac_Sql_Execute("sp_trae_cartera_propia") Then
    Me.MousePointer = 0
    MsgBox "Ha ocurrido un error en Operaciones pendientes de autorización", 16, TITSISTEMA
    Unload Me
    Exit Function
End If
  
c1 = ""
With Grid1
    .Redraw = False

    .Rows = 2
    Do While Bac_SQL_Fetch(datos())
    
        'No muestra los documentos ya bloqueados
        
        'If datos(42) = "" Then
            c1 = "1"
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .Col = 0: .Text = Space(100) '+ Datos(18) 'estado
            .CellPictureAlignment = 4
             Set .CellPicture = Me.SinCheck(0).Image
        
            .Col = 1: .Text = datos(12)  'serie
            .Col = 2: .Text = datos(51) 'Holding
            .Col = 3: .Text = datos(14) 'UM
            .Col = 4: .Text = Format(datos(15), "#,##0")  'Nomina
            .Col = 5: .Text = Format(datos(16), "#,##0.0000")  'tir
            .Col = 6: .Text = Format(datos(17), "#,##0.0000") 'vpar
            .Col = 7: .Text = Format(datos(18), "#,###,###,##0") 'valor presente
            
            Select Case Trim(datos(44)) 'custodia
            Case "C"
                .Col = 8: .Text = "CLIENTE"
            Case "D"
                .Col = 8: .Text = "DCV"
            Case Else
                .Col = 8: .Text = "PROPIA"
            End Select
            '.Col = 9: .text = Datos(5)         'clave dcv
            .Col = 10: .Text = Format(datos(16), "#,##0.0000")    'tir
            .Col = 11: .Text = Format(datos(17), "#,##0.0000")   'vpar c
            .Col = 12: .Text = Format(datos(18), "#,###,###,##0")    'valor compra
            Select Case Trim(datos(49)) 'tipo cartera
                Case Is = "T": .Col = 13: .Text = "TRANSABLE"
                Case Is = "P": .Col = 13: .Text = "PERMANENTE"
                Case Else: .Col = 13: .Text = ""
             End Select
                         
            .Col = 14: .Text = datos(6)    'numero de operacion
            .Col = 15: .Text = datos(7)    'correlativo
            .Col = 16: .Text = ""          'usuario
            .Col = 17: .Text = ""          'tipo bloqueo
            .Col = 18: .Text = ""          'fecha
            .Col = 19: .Text = datos(4)   'rutCartera
            .Col = 22: .Text = datos(52)   'tipo cartera
            .Col = 23: .Text = datos(53)   'Sub-tipo cartera
        
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

Private Function Grabar_ActVoucker()
On Error GoTo Err_Grb
Dim nNumOpe, nCont As Integer
Dim c1 As String
Dim cAccion As String
Dim Sigue As Boolean
Dim Correlativo As Integer
Dim estadoInst As String
Dim Cartera As Integer


Cartera = CDbl(Cmb_CodigoBloqueo.ItemData(Cmb_CodigoBloqueo.ListIndex))

Me.MousePointer = 11

Sigue = False

For nCont = 2 To Grid1.Rows - 1
    If Trim(Grid1.TextMatrix(nCont, 0)) <> "" Then
        Sigue = True
        Exit For
    End If
Next
If Not Sigue Then Exit Function
    Grid1.Redraw = False

    For nCont = 2 To Grid1.Rows - 1
        Grid1.Row = nCont
        Grid1.Col = 0
        If Trim(Grid1.TextMatrix(Grid1.Row, 0)) <> "" And Trim(Grid1.TextMatrix(Grid1.Row, 0)) <> "P" Then
            Envia = Array()
            AddParam Envia, CDbl(Grid1.TextMatrix(nCont, 14))   'numero operacion
            AddParam Envia, CDbl(Grid1.TextMatrix(nCont, 15))   'correlativo de la ope
            AddParam Envia, Cartera
                
            
            If Not Bac_Sql_Execute("sp_graba_act_Volcker_Rule", Envia) Then
                'Grid1.Redraw = True
                MsgBox "Error: Servidor SQL", 16, TITSISTEMA
                Desplegar_instrumentos
                Exit Function
            End If
        End If
    Next nCont

    Grid1.Redraw = True

        
    MsgBox "Registros actualizados en forma correcta", vbOKOnly + vbInformation

    Screen.MousePointer = 0

    Desplegar_instrumentos

Exit Function

Err_Grb:
Screen.MousePointer = 0
'Grid1.Redraw = True
MsgBox "Error: " & err.Description, 16, TITSISTEMA
End Function
