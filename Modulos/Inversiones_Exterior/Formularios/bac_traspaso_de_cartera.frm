VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Traspaso_de_Cartera 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Traspaso De Cartera"
   ClientHeight    =   5355
   ClientLeft      =   255
   ClientTop       =   1725
   ClientWidth     =   11145
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5355
   ScaleWidth      =   11145
   Begin VB.Frame frm_fecha 
      Caption         =   "Traspaso"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   4515
      Left            =   60
      TabIndex        =   1
      Top             =   765
      Width           =   11025
      Begin VB.ComboBox CmbTipoInv 
         BackColor       =   &H00FFFFFF&
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   3840
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   2700
         Visible         =   0   'False
         Width           =   2100
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3930
         Left            =   120
         TabIndex        =   2
         Top             =   495
         Width           =   10815
         _ExtentX        =   19076
         _ExtentY        =   6932
         _Version        =   393216
         Rows            =   1
         Cols            =   12
         FixedCols       =   3
         BackColor       =   -2147483644
         ForeColor       =   16711680
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483643
         BackColorSel    =   12582912
         ForeColorSel    =   12632256
         BackColorBkg    =   8421376
         GridColor       =   64
         HighLight       =   2
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "bac_traspaso_de_cartera.frx":0000
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11145
      _ExtentX        =   19659
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   10665
      Top             =   6060
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":1010
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":132A
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":1A96
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":2494
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":27AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":2AC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":34C6
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":37E0
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":3AFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_traspaso_de_cartera.frx":3E14
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Traspaso_de_Cartera"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function buscar_datos()
    Dim datos()
    Dim I As Double
    Dim sw As Double
    i = 0
    If Bac_Sql_Execute("SVC_TRA_BUS_CAR") Then
        Do While Bac_SQL_Fetch(DATOS)
        If DATOS(1) = "NO" Then
            MsgBox "No Se Registran Datos Para Traspaso", vbInformation, gsBac_Version
            sw = 1
            Exit Function
            Call Clear_Objetos
        End If
            sw = 1
            grilla.Rows = grilla.Rows + 1
            I = I + 1
            grilla.RowHeight(I) = 350
            grilla.TextMatrix(I, 0) = Format(datos(1), "0,0")
            grilla.TextMatrix(I, 1) = datos(2)
            grilla.TextMatrix(I, 2) = datos(3)
            grilla.TextMatrix(I, 3) = Format(datos(4), "DD/MM/YYYY")
            grilla.TextMatrix(I, 4) = Format(datos(5), "###,###,###,##0.0000")
            grilla.TextMatrix(I, 5) = Format(datos(6), "###,###,###,##0.0000")
            grilla.TextMatrix(I, 6) = Format(datos(7), "###,###,###,##0.0000")
            grilla.TextMatrix(I, 7) = Format(datos(8), "###,###,###,##0.0000")
            grilla.TextMatrix(I, 8) = Format(datos(9), "###,###,###,##0.0000")
            grilla.TextMatrix(I, 9) = Format(datos(10), "###,###,###,##0.0000")
            grilla.TextMatrix(I, 10) = Format(datos(11), "###,###,###,##0.0000")
            grilla.TextMatrix(I, 11) = datos(12)
            
            
            
            
        Loop
        If sw = 0 Then
            MsgBox "No hay datos para traspaso de cartera", vbExclamation, gsBac_Version
            Exit Function
        End If
        grilla.Enabled = True
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = False
         
    End If
End Function

Function Clear_Objetos()
    grilla.Rows = 1
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = True
    CmbTipoInv.Visible = False
    grilla.Enabled = False
End Function

Function dibuja_grilla()
   
    grilla.Rows = grilla.FixedRows
    grilla.ForeColorFixed = vbWhite
    grilla.RowHeight(0) = 400
    
    grilla.Rows = 1
    grilla.TextMatrix(0, 0) = "Nº. Ope."
    grilla.TextMatrix(0, 1) = "Familia"
    grilla.TextMatrix(0, 2) = "Instrumento"
    grilla.TextMatrix(0, 3) = "Vcto"
    grilla.TextMatrix(0, 4) = "Nominal"
    grilla.TextMatrix(0, 5) = "TIR Compra"
    grilla.TextMatrix(0, 6) = "% VC"
    grilla.TextMatrix(0, 7) = "VAlor Presente"
    grilla.TextMatrix(0, 8) = "Tir Merc."
    grilla.TextMatrix(0, 9) = "% VC Merc."
    grilla.TextMatrix(0, 10) = "Valor Merc."
    grilla.TextMatrix(0, 11) = "Tipo Cartera"

    grilla.ColWidth(0) = 1000
    grilla.ColWidth(1) = 1300
    grilla.ColWidth(2) = 1500
    grilla.ColWidth(3) = 1200
    grilla.ColWidth(4) = 2000
    grilla.ColWidth(5) = 1500
    grilla.ColWidth(6) = 1500
    grilla.ColWidth(7) = 2000
    grilla.ColWidth(8) = 1500
    grilla.ColWidth(9) = 1500
    grilla.ColWidth(10) = 2000
    grilla.ColWidth(11) = 2000
    
    grilla.ColAlignment(0) = 7
    grilla.ColAlignment(1) = 1
    grilla.ColAlignment(2) = 1
    grilla.ColAlignment(3) = 1
    grilla.ColAlignment(4) = 7
    grilla.ColAlignment(5) = 7
    grilla.ColAlignment(6) = 7
    grilla.ColAlignment(7) = 7
    grilla.ColAlignment(8) = 7
    grilla.ColAlignment(9) = 7
    grilla.ColAlignment(10) = 7
    grilla.ColAlignment(11) = 7
     

End Function


Function grabar_datos()

    Dim I As Double
    Dim datos()
    Dim sw As Integer

    I = 0
    sw = 0

    For I = 1 To grilla.Rows - 1

        If grilla.TextMatrix(I, 11) = "PERMANENTE" Then
            sw = 1

            envia = Array()
            AddParam envia, CDbl(grilla.TextMatrix(I, 0))
            AddParam envia, Mid(grilla.TextMatrix(I, 11), 1, 1)
            AddParam envia, CDbl(grilla.TextMatrix(I, 8))
            AddParam envia, CDbl(grilla.TextMatrix(I, 9))
            AddParam envia, CDbl(grilla.TextMatrix(I, 10))
            If Bac_Sql_Execute("SVA_TRA_GRB_DAT", envia) Then
                Do While Bac_SQL_Fetch(datos)
                    If datos(1) <> "SI" Then
                        MsgBox "Problemas en el Traspaso de Cartera", vbExclamation, gsBac_Version
                        Exit Function
                    End If
                Loop
            End If
        End If
    Next


    If sw = 1 Then
        MsgBox "Proceso Realizado Exitosamente", vbInformation, gsBac_Version
    Else
        MsgBox "No Existen Instrumentos a Traspasar", vbExclamation, gsBac_Version
    End If

End Function

Function Marcar()
       Dim f, C, R, v As Integer
   
   Dim lrow As Integer
   
   FilaSeleccionada = grilla.RowSel
   
   lrow = grilla.TopRow
   
   With grilla
   
      f = .RowSel
      
      .FocusRect = flexFocusHeavy
      .Redraw = False

    For R = 1 To .Rows - 1
         
        For C = 0 To .Cols - 1
        
               .Row = R
               .Col = C
               

                  If R <> f Then
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbBlue
                  End If
                  
               If f = R Then
                    .BackColorSel = &H800000
                    .BackColorFixed = &H808000
                    .ForeColorFixed = &H80000005
                    .CellBackColor = vbBlue    ''vbRed
                    .CellForeColor = vbWhite
               End If
        Next C
    Next R
'      .Row = f
'      .Col = 0
'      .FocusRect = flexFocusLight
      .Redraw = True
   End With
   
   
    If lrow > 1 Then
        grilla.TopRow = lrow
    End If
End Function




Private Sub CmbTipoInv_Click()
'   grilla.TextMatrix(grilla.Row, 11) = CmbTipoInv.Text
    'grilla.TextMatrix(grilla.Row, 6) = Mid(CmbTipoInv.Text, 1, 1)
    'SendKeys "{TAB}"
'   CmbTipoInv.Visible = False
'   grilla.SetFocus
End Sub

Private Sub CmbTipoInv_GotFocus()
    'CmbTipoInv.ListIndex = 0
End Sub

Private Sub CmbTipoInv_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        grilla.TextMatrix(grilla.Row, 11) = CmbTipoInv.Text
        'SendKeys "{TAB}"
        CmbTipoInv.Visible = False
        grilla.SetFocus
    ElseIf KeyAscii = 27 Then
        CmbTipoInv.Visible = False
        grilla.SetFocus
    End If

End Sub

Private Sub CmbTipoInv_LostFocus()

'    grilla.TextMatrix(grilla.Row, 11) = CmbTipoInv.Text
'    CmbTipoInv.Visible = False
'    grilla.SetFocus

End Sub

Private Sub Form_Load()
    Move 0, 0
    Me.Icon = BAC_INVERSIONES.Icon
    Call dibuja_grilla
    Call Llena_Categoria_Super
    grilla.Enabled = False
    
End Sub

Sub Llena_Categoria_Super()

    Dim datos()

    If Not Bac_Sql_Execute("SVC_GEN_CAR_SUP") Then
      Exit Sub
    End If
    
    CmbTipoInv.Clear
    
    Do While Bac_SQL_Fetch(datos())
        CmbTipoInv.AddItem datos(1)
    Loop
    
End Sub



Private Sub grilla_Click()
    CmbTipoInv.Visible = False
End Sub

Private Sub grilla_DblClick()
    If grilla.Col = 11 Then
        CmbTipoInv.Visible = True
        CmbTipoInv.SetFocus
        CmbTipoInv.Top = grilla.CellTop + grilla.Top
        CmbTipoInv.Left = grilla.CellLeft + grilla.Left
        CmbTipoInv.Width = grilla.CellWidth
        For I = 0 To CmbTipoInv.ListCount - 1
                CmbTipoInv.ListIndex = I
                If CmbTipoInv.Text = grilla.TextMatrix(grilla.Row, 11) Then
                    Exit For
                End If
                CmbTipoInv.ListIndex = -1
        Next
    End If
 
 
End Sub


Private Sub grilla_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
         If grilla.Col = 11 Then
            CmbTipoInv.Visible = True
            CmbTipoInv.SetFocus
            CmbTipoInv.Top = grilla.CellTop + grilla.Top
            CmbTipoInv.Left = grilla.CellLeft + grilla.Left
            CmbTipoInv.Width = grilla.CellWidth

            For I = 0 To CmbTipoInv.ListCount - 1
                
                CmbTipoInv.ListIndex = I
                If CmbTipoInv.Text = grilla.Text Then
                    Exit For
                End If

            Next


        End If
 
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            'GRabar Datos
            Call grabar_datos
            Call Clear_Objetos
        Case 2
            'Buscar Datos
            Call buscar_datos
        Case 3
            'Limpiar pantalla
            Call Clear_Objetos
        Case 4
            Unload Me
    End Select
End Sub

