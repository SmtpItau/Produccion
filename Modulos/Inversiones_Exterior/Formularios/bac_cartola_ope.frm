VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{15EBA0D5-0F67-11D6-A40D-00C04F5AA80A}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Cartola 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cartola de Operación"
   ClientHeight    =   5835
   ClientLeft      =   135
   ClientTop       =   2610
   ClientWidth     =   11385
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5835
   ScaleWidth      =   11385
   Begin VB.Frame Frame2 
      Height          =   1215
      Left            =   60
      TabIndex        =   3
      Top             =   720
      Width           =   11265
      Begin BacControles.txtFecha txt_fecha 
         Height          =   300
         Left            =   270
         TabIndex        =   4
         Top             =   525
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   529
         Text            =   "14/12/2001"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MinDate         =   -328716
         MaxDate         =   2958465
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3855
      Left            =   60
      TabIndex        =   1
      Top             =   1905
      Width           =   11265
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3570
         Left            =   90
         TabIndex        =   2
         Top             =   180
         Width           =   11115
         _ExtentX        =   19606
         _ExtentY        =   6297
         _Version        =   393216
         Rows            =   1
         Cols            =   9
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         BackColorSel    =   8388608
         ForeColorSel    =   12632256
         BackColorBkg    =   8421376
         GridColor       =   64
         Enabled         =   -1  'True
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
         MouseIcon       =   "bac_cartola_ope.frx":0000
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11385
      _ExtentX        =   20082
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Imprimir en pantalla"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar "
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   13920
      Top             =   5220
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
            Picture         =   "bac_cartola_ope.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":1010
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":132A
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":1A96
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":2494
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":27AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":2AC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":34C6
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":37E0
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":3AFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_cartola_ope.frx":3E14
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Cartola"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function buscar_datos()

    Call dibuja_grilla

    Dim datos()
    envia = Array()
    AddParam envia, txt_fecha.Text
    grilla.Rows = 1
    If Bac_Sql_Execute("SVC_CTL_BUS_CAR", envia) Then
        I = 1
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "NO" Then
                MsgBox datos(2), vbExclamation, gsBac_Version
                Clear_Objetos
                Exit Function
            End If
            
            grilla.Rows = CDbl(datos(10)) + 1
            grilla.RowHeight(I) = 350
            grilla.Rows = datos(10) + 1
            grilla.TextMatrix(I, 0) = CDbl(datos(1))
            If datos(2) = "2000" Then
                grilla.TextMatrix(I, 1) = "BONOEX"
            ElseIf datos(2) = "2001" Then
                grilla.TextMatrix(I, 1) = "CD"
            ElseIf datos(2) = "2002" Then
                grilla.TextMatrix(I, 1) = "NOTEX"
            ElseIf datos(2) = "2001" Then
                grilla.TextMatrix(I, 1) = "DEPEX"
            End If
            grilla.TextMatrix(I, 2) = datos(3)
            grilla.TextMatrix(I, 3) = datos(4)
            grilla.TextMatrix(I, 4) = Format(datos(5), "DD/MM/YYYY")
            grilla.TextMatrix(I, 5) = Format(CDbl(datos(6)), "###,###,###,###,##0.0000000")
            grilla.TextMatrix(I, 6) = Format(CDbl(datos(7)), "###,###,###,###,##0.0000")
            grilla.TextMatrix(I, 7) = Format(CDbl(datos(8)), "###,###,###,###,##0.0000")
            grilla.TextMatrix(I, 8) = datos(9)
            I = I + 1
        Loop
    End If
    grilla.Enabled = True
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = False
    txt_fecha.Enabled = False
    
    Call Marcar
End Function

Function Clear_Objetos()
    grilla.Rows = 1
    grilla.Enabled = False
    txt_fecha.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = True
    txt_fecha.Enabled = True
End Function

Function dibuja_grilla()
grilla.Rows = grilla.FixedRows

grilla.ForeColorFixed = vbWhite
grilla.RowHeight(0) = 400

grilla.TextMatrix(0, 0) = "Numero"
grilla.TextMatrix(0, 1) = "Familia"
grilla.TextMatrix(0, 2) = "Instrumento"
grilla.TextMatrix(0, 3) = "Emisión"
grilla.TextMatrix(0, 4) = "Vcto"
grilla.TextMatrix(0, 5) = "TIR"
grilla.TextMatrix(0, 6) = "Nominal"
grilla.TextMatrix(0, 7) = "Monto"
grilla.TextMatrix(0, 8) = "Emisor"

grilla.FixedAlignment(0) = 1 '"Num.ope"
grilla.FixedAlignment(1) = 1 '"Familia"
grilla.FixedAlignment(2) = 1 ' "Instrumento"
grilla.FixedAlignment(3) = 1 ' "Emisión"
grilla.FixedAlignment(4) = 1 '"Vcto"
grilla.FixedAlignment(5) = 7 ' "TIR"
grilla.FixedAlignment(6) = 7 ' "Nominal"
grilla.FixedAlignment(7) = 7 ' "Monto"
grilla.FixedAlignment(8) = 1 '"Emisor"

grilla.ColWidth(0) = 1000
grilla.ColWidth(1) = 1300
grilla.ColWidth(2) = 2500
grilla.ColWidth(3) = 1300
grilla.ColWidth(4) = 1300
grilla.ColWidth(5) = 1500
grilla.ColWidth(6) = 2000
grilla.ColWidth(7) = 2000
grilla.ColWidth(8) = 4000

grilla.ColAlignment(0) = 1
grilla.ColAlignment(1) = 1
grilla.ColAlignment(2) = 1
grilla.ColAlignment(3) = 1
grilla.ColAlignment(4) = 1
grilla.ColAlignment(5) = 7
grilla.ColAlignment(6) = 7
grilla.ColAlignment(7) = 7
grilla.ColAlignment(8) = 1

End Function

Function imprimir_reporte(modi)
        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_de_cartola_operacion.rpt"
        BAC_INVERSIONES.BacRpt.WindowTitle = "CARTOLA DE OPERACIÓN"
        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = grilla.TextMatrix(grilla.Row, 2)
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(grilla.TextMatrix(grilla.Row, 4), "yyyymmdd")
        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = grilla.TextMatrix(grilla.Row, 0)
        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = Format(txt_fecha.Text, "YYYYMMDD")
        If modi = 1 Then
            BAC_INVERSIONES.BacRpt.Destination = crptToWindow
        Else
            BAC_INVERSIONES.BacRpt.Destination = crptToPrinter
        End If
        BAC_INVERSIONES.BacRpt.Connect = CONECCION
        BAC_INVERSIONES.BacRpt.Action = 1
    Call limpiar_cristal
End Function

Sub Marcar()
    
   Dim f, C, R, v As Integer

   Dim lrow As Integer

   grilla.FixedCols = 3

   FilaSeleccionada = grilla.RowSel
   
   lrow = grilla.TopRow
   
   With grilla
   
      f = .RowSel
  
      .FocusRect = flexFocusHeavy
      .Redraw = False

    For R = 1 To .Rows - 1
         
        For C = 3 To .Cols - 1
        
               .Row = R
               .Col = C
               
                  If R <> f Then
                        If grilla.TextMatrix(grilla.Row, 8) = "A" Then
                            .BackColorSel = &HC0C0C0
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
                    If grilla.TextMatrix(grilla.Row, 7) = "A" Then
                        .BackColorSel = &H800000
                        .BackColorFixed = &H808000
                        .ForeColorFixed = &H80000005
                        .CellBackColor = vbBlue
                        .CellForeColor = vbRed
                    Else
                        BackColorSel = &H800000
                        .BackColorFixed = &H808000
                        .ForeColorFixed = &H80000005
                        .CellBackColor = vbBlue
                        .CellForeColor = vbWhite
                    End If
               End If
        Next C
    Next R
    
      .Row = f
      .Col = 3
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
   
    If lrow > 1 Then
        grilla.TopRow = lrow
    End If
   
End Sub
Private Sub Form_Load()
    Move 0, 0
    Me.Icon = BAC_INVERSIONES.Icon
    Call dibuja_grilla
    txt_fecha.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    
End Sub

Private Sub grilla_Click()
    Call Marcar
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Screen.MousePointer = 11
            imprimir_reporte (1)
            Screen.MousePointer = 0
        Case 2
            Screen.MousePointer = 11
            imprimir_reporte (2)
            Screen.MousePointer = 0
        Case 3
            Call buscar_datos
        Case 4
            Call Clear_Objetos
        Case 5
            Unload Me
    End Select
End Sub

