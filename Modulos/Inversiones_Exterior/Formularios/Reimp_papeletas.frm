VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Reimp_papeletas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reimpresión De Papeletas De Operación"
   ClientHeight    =   5340
   ClientLeft      =   240
   ClientTop       =   2355
   ClientWidth     =   11535
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5340
   ScaleWidth      =   11535
   Begin VB.Frame frm_detalles 
      Caption         =   "Detalles"
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
      Height          =   3870
      Left            =   30
      TabIndex        =   3
      Top             =   1425
      Width           =   11460
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3570
         Left            =   105
         TabIndex        =   4
         Top             =   210
         Width           =   11280
         _ExtentX        =   19897
         _ExtentY        =   6297
         _Version        =   393216
         Rows            =   1
         Cols            =   13
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         BackColorSel    =   8388608
         ForeColorSel    =   12582912
         BackColorBkg    =   8421376
         GridColor       =   64
         Enabled         =   0   'False
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
         MouseIcon       =   "Reimp_papeletas.frx":0000
      End
   End
   Begin VB.Frame frm_numro_ope 
      Caption         =   "Fecha De Operación"
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
      Height          =   690
      Left            =   30
      TabIndex        =   0
      Top             =   675
      Width           =   11460
      Begin BACControles.TXTFecha txt_fec_pro 
         Height          =   300
         Left            =   330
         TabIndex        =   1
         Top             =   240
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   529
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "26/10/2001"
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   630
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   1111
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar Registros"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Imprimir Por Pantalla"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Imprimir "
            ImageIndex      =   10
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Fax De Confirmación"
            ImageIndex      =   16
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   11175
      Top             =   6075
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
            Picture         =   "Reimp_papeletas.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":1010
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":132A
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":1A96
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":2494
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":27AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":2AC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":34C6
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":37E0
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":3AFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Reimp_papeletas.frx":3E14
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Reimp_papeletas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Printe As Double
Dim Tipo_oper As String
Dim sw_busca As Integer
Function buscar_datos(Operacion, tipo)

    Dim DATOS()
    Dim i As Integer

    If Not IsDate(Operacion) Then
        txt_fec_pro.SetFocus
        Exit Function
    End If
    
    Call dibuja_grilla
    
    envia = Array()
    AddParam envia, txt_fec_pro.Text
    
    i = 0
    grilla.Rows = 1
    
    If Bac_Sql_Execute("SVC_RPA_BUS_CAR_IM", envia) Then
    
        Do While Bac_SQL_Fetch(DATOS)
        
            grilla.Rows = grilla.Rows + 1
            grilla.RowHeight(grilla.Rows - 1) = 300
            i = i + 1
            If DATOS(1) = "NO" Then
                MsgBox DATOS(2), vbExclamation, gsBac_Version
                Call Clear_Objetos
                Exit Function
            End If
            
            grilla.TextMatrix(i, 0) = DATOS(1)
            
'JBH, 29-10-2009
'            If datos(2) = "CP" Or datos(2) = "VCP" Then
'                grilla.TextMatrix(i, 1) = "COMPRA"
'            Else
'                grilla.TextMatrix(i, 1) = "VENTA"
'            End If
            Select Case DATOS(2)
                Case "CP"
                grilla.TextMatrix(i, 1) = "COMPRA"
                Case "VCP"
                    grilla.TextMatrix(i, 1) = "COMPRA"
                Case "VP"
                grilla.TextMatrix(i, 1) = "VENTA"
                Case "CPI"
                    grilla.TextMatrix(i, 1) = "COMPRA IM"
                Case "VPI"
                    grilla.TextMatrix(i, 1) = "VENTA IM"
            End Select
            
            
            grilla.TextMatrix(i, 2) = DATOS(3)
            grilla.TextMatrix(i, 3) = DATOS(4)
            grilla.TextMatrix(i, 4) = Format(DATOS(5), "DD/MM/YYYY")
            grilla.TextMatrix(i, 5) = Format(DATOS(6), "DD/MM/YYYY")
            grilla.TextMatrix(i, 6) = Format(DATOS(7), "0.0000")
            grilla.TextMatrix(i, 7) = Format(DATOS(8), "0,0.0000")
            grilla.TextMatrix(i, 8) = Format(DATOS(9), "0,0.0000")
            grilla.TextMatrix(i, 9) = DATOS(10)
            grilla.TextMatrix(i, 10) = DATOS(11)
            grilla.TextMatrix(i, 11) = DATOS(12)
            grilla.TextMatrix(i, 12) = DATOS(2)
            
        Loop
        
        Toolbar1.Buttons(3).Enabled = True
        Toolbar1.Buttons(4).Enabled = True
        Toolbar1.Buttons(1).Enabled = False
        txt_fec_pro.Enabled = False
        grilla.Enabled = True
        
       Call Marcar
        
    End If

End Function

Function Clear_Objetos()

    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = False
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(5).Enabled = False
    txt_fec_pro.Enabled = True
    txt_fec_pro.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_pro.SetFocus
    grilla.Rows = 1
    grilla.Enabled = False
End Function

Private Sub Form_Activate()

    If sw_busca = True Then
        Call buscar_datos(txt_fec_pro.Text, Tipo_oper)
    End If

End Sub

Private Sub Form_Load()
    Move 0, 0
    Me.Icon = BAC_INVERSIONES.Icon
    txt_fec_pro.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    Call dibuja_grilla
    sw_busca = False
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla de Reimpresión de Papeletas de Operaciones")
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Salida de Pantalla de Reimpresión de Papeletas de Operaciones")

End Sub

Private Sub grilla_Click()
    
    Call Marcar
End Sub

Sub Marcar()
   Dim f, C, R, v As Integer
   Dim lrow As Integer

   If grilla.Rows = grilla.FixedRows Then
      Exit Sub
   End If

   Let grilla.FixedCols = 3

   FilaSeleccionada = grilla.RowSel
   
   lrow = grilla.TopRow
   
   With grilla
      f = .RowSel

      .FocusRect = flexFocusHeavy
      .Redraw = False

      For R = 1 To .Rows - 1
         For C = 3 To .Cols - 1
            .row = R
            .Col = C
            
            If R <> f Then
               If grilla.TextMatrix(grilla.row, 10) = "A" Then
                  'BackColorSel = &HC0C0C0
                  .BackColorFixed = &H808000
                  .ForeColorFixed = &H80000005
                  .CellBackColor = &HC0C0C0
                  .CellForeColor = vbRed
               Else
                  .BackColorSel = &HC0C0C0
                  .BackColorFixed = &H808000
                  .ForeColorFixed = &H80000005
                  .CellBackColor = &HC0C0C0
                  .CellForeColor = vbBlue
               End If
            End If
                  
            If f = R Then
               If grilla.TextMatrix(grilla.row, 10) = "A" Then
                  '.BackColorSel = &H800000
                  .BackColorFixed = &H808000
                  .ForeColorFixed = &H80000005
                  .CellBackColor = vbBlue
                  .CellForeColor = vbRed
               Else
                  'BackColorSel = &H800000
                  .BackColorFixed = &H808000
                  .ForeColorFixed = &H80000005
                  .CellBackColor = vbBlue
                  .CellForeColor = vbWhite
               End If
           End If
         Next C
      Next R

      .row = f
      .Col = 3
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
   
   
    If lrow > 1 Then
        grilla.TopRow = lrow
    End If
    If grilla.TextMatrix(grilla.row, 11) = "1" Then
        Toolbar1.Buttons(5).Enabled = True
    Else
        Toolbar1.Buttons(5).Enabled = False
    End If
End Sub

Sub dibuja_grilla()


grilla.Rows = grilla.FixedRows

grilla.ForeColorFixed = vbWhite
grilla.RowHeight(0) = 400

grilla.FixedCols = 3


grilla.TextMatrix(0, 0) = "Num.ope"
grilla.TextMatrix(0, 1) = "Movim."
grilla.TextMatrix(0, 2) = "Familia"
grilla.TextMatrix(0, 3) = "Instrumento"
grilla.TextMatrix(0, 4) = "Efectivo"
grilla.TextMatrix(0, 5) = "Vcto"
grilla.TextMatrix(0, 6) = "TIR"
grilla.TextMatrix(0, 7) = "Nominal"
grilla.TextMatrix(0, 8) = "Monto"
grilla.TextMatrix(0, 9) = "Cliente"
grilla.TextMatrix(0, 10) = "Estado"
grilla.TextMatrix(0, 11) = "Confirmacion"
grilla.TextMatrix(0, 12) = ""



grilla.ColWidth(0) = 1000
grilla.ColWidth(1) = 1100  '900
grilla.ColWidth(2) = 1200
grilla.ColWidth(3) = 0 '2500
grilla.ColWidth(4) = 1200
grilla.ColWidth(5) = 0 '1200
grilla.ColWidth(6) = 0
grilla.ColWidth(7) = 2000
grilla.ColWidth(8) = 2000
grilla.ColWidth(9) = 4500
grilla.ColWidth(10) = 0
grilla.ColWidth(11) = 0
grilla.ColWidth(12) = 0


grilla.ColAlignment(0) = 1
grilla.ColAlignment(1) = 1
grilla.ColAlignment(2) = 1
grilla.ColAlignment(3) = 1
grilla.ColAlignment(4) = 1
grilla.ColAlignment(5) = 1
grilla.ColAlignment(6) = 7
grilla.ColAlignment(7) = 7
grilla.ColAlignment(8) = 7
grilla.ColAlignment(9) = 1
grilla.ColAlignment(10) = 1
grilla.ColAlignment(11) = 1



End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index

        Case 1

            If IsDate(txt_fec_pro.Text) Then
                Screen.MousePointer = 11
                Call buscar_datos(txt_fec_pro.Text, Tipo_oper)
                sw_busca = True
                
                Screen.MousePointer = 0
            Else
                txt_fec_pro.Text = "  /  /    "
                txt_fec_pro.SetFocus
            End If

        Case 2
            Screen.MousePointer = 11
            
            Call Clear_Objetos
            sw_busca = False
            Screen.MousePointer = 0
        Case 3
            Screen.MousePointer = 11
            Call Imprimir_Papeletas(grilla.TextMatrix(grilla.row, 12), grilla.TextMatrix(grilla.row, 0), 0, "")
            Screen.MousePointer = 0
            
        Case 4
            Screen.MousePointer = 11
            Call Imprimir_Papeletas(grilla.TextMatrix(grilla.row, 12), grilla.TextMatrix(grilla.row, 0), 1, "")
            Screen.MousePointer = 0

        Case 5
            Bac_Fax.Show 1
            Call imp_fax(grilla.TextMatrix(grilla.row, 0), grilla.TextMatrix(grilla.row, 12))

        Case 6
            Unload Me
    End Select
End Sub


Private Sub txt_num_ope_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Call buscar_datos(CDbl(txt_num_ope.Text), Tipo_oper)
    End If
End Sub

