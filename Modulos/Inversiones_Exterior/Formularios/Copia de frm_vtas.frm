VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Ventas_Filtro 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ventas "
   ClientHeight    =   5730
   ClientLeft      =   -615
   ClientTop       =   3465
   ClientWidth     =   11235
   Icon            =   "frm_vtas.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5730
   ScaleWidth      =   11235
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000014&
      Height          =   705
      Left            =   4005
      TabIndex        =   6
      Top             =   705
      Width           =   4350
      Begin VB.Label lbl_unidad 
         BackColor       =   &H80000014&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " "
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
         Height          =   285
         Left            =   225
         TabIndex        =   7
         Top             =   270
         Width           =   3870
      End
   End
   Begin VB.Frame frm_nemo 
      Height          =   705
      Left            =   45
      TabIndex        =   4
      Top             =   705
      Width           =   3645
      Begin VB.ComboBox box_familia 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1080
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   195
         Width           =   2340
      End
      Begin VB.Label Label2 
         Caption         =   "Familia"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   165
         TabIndex        =   5
         Top             =   255
         Width           =   975
      End
   End
   Begin VB.Frame Frame3 
      Height          =   4245
      Left            =   30
      TabIndex        =   2
      Top             =   1410
      Width           =   11130
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3930
         Left            =   90
         TabIndex        =   3
         Top             =   195
         Width           =   10965
         _ExtentX        =   19341
         _ExtentY        =   6932
         _Version        =   393216
         Rows            =   3
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   -2147483635
         BackColorFixed  =   8421376
         ForeColorSel    =   -2147483638
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
         MouseIcon       =   "frm_vtas.frx":030A
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11235
      _ExtentX        =   19817
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Datos Instrumento"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   390
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
            Picture         =   "frm_vtas.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":131A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":1634
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":194E
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":1DA0
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":1EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":234C
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":279E
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":2AB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":2DD2
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":2F2C
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":337E
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":37D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":3AEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":3E04
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":411E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Ventas_Filtro"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim total_ope As Double
Dim FilaSeleccionada As Integer
Dim Arreglo As Double


Const Btn_Limpiar = 1
Const Btn_Buscar = 2
Const Btn_Aceptar = 3
Const Btn_Emision = 4
Const Btn_Salir = 5
Function buscar_unidad(Unidad)
    Dim datos()
    envia = Array()
    AddParam envia, Unidad
    If Bac_Sql_Execute("Svc_Vnt_bus_uni", envia) Then
        Do While Bac_SQL_Fetch(datos)
            lbl_unidad.Caption = "Unidad : " & datos(1)
        Loop
    End If
    
End Function

Sub dibuja_grilla()

grilla.Rows = grilla.FixedRows

grilla.TextMatrix(0, 0) = "Instrumento"
grilla.TextMatrix(0, 1) = "Vcto"
grilla.TextMatrix(0, 2) = "Nominal"
grilla.TextMatrix(0, 3) = "TIR"
grilla.TextMatrix(0, 4) = "% V.Compra"
grilla.TextMatrix(0, 5) = "Monto"
grilla.TextMatrix(0, 6) = "RutCartera"
grilla.TextMatrix(0, 7) = "Numdocu"

grilla.ColWidth(0) = 2000
grilla.ColWidth(1) = 1200
grilla.ColWidth(2) = 2500
grilla.ColWidth(3) = 1100
grilla.ColWidth(4) = 1200
grilla.ColWidth(5) = 2500
grilla.ColWidth(6) = 0
grilla.ColWidth(7) = 0

End Sub
Function existen_datos()
    Dim datos()
    existen_datos = 0
    If Bac_Sql_Execute("Svc_Vnt_bus_car ") Then
        Do While Bac_SQL_Fetch(datos)
            existen_datos = Val(datos(1))
        Loop
    End If
End Function

Function Func_Aceptar()

    gsBac_VarDouble = CDbl(grilla.TextMatrix(FilaSeleccionada, 6))
    gsBac_VarDouble2 = CDbl(grilla.TextMatrix(FilaSeleccionada, 7))
    giAceptar% = True
    
    Unload Me


End Function

Function Func_Limpiar()

    Call dibuja_grilla
    
    box_familia.Enabled = True
    
    Toolbar1.Buttons(Btn_Limpiar).Enabled = True
    Toolbar1.Buttons(Btn_Buscar).Enabled = True
    Toolbar1.Buttons(Btn_Aceptar).Enabled = False
    Toolbar1.Buttons(Btn_Emision).Enabled = False
    Toolbar1.Buttons(Btn_Salir).Enabled = True
    
    Call llena_combo_familia
    
    FilaSeleccionada = 0
    
End Function

Function llena_grilla()
    
    Dim datos()
    Dim I
    
    If box_familia.ListIndex = -1 Then
        MsgBox "No ha Selecionado Familia de Instrumentos", vbExclamation, gsBac_Version
        box_familia.SetFocus
        Exit Function
    End If
    
    enviar = Array()
    AddParam enviar, box_familia.ItemData(box_familia.ListIndex)
    AddParam enviar, Bac_Usr_ofi
    
    I = 0
    
    If Bac_Sql_Execute("Svc_Vnt_fil_car", enviar) Then
    
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = 0 Then
                MsgBox datos(2), vbExclamation, gsBac_Version
                Exit Function
            End If
            If datos(6) <> 0 Then
                grilla.Rows = grilla.Rows + 1
                
                    grilla.TextMatrix(grilla.Rows - 1, 0) = datos(1)
                    grilla.TextMatrix(grilla.Rows - 1, 1) = Format(datos(2), "DD/MM/YYYY")
                    grilla.TextMatrix(grilla.Rows - 1, 2) = Format(CDbl(datos(3)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 3) = Format(CDbl(datos(4)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 4) = Format(CDbl(datos(5)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 5) = Format(CDbl(datos(6)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 6) = CDbl(datos(7))
                    grilla.TextMatrix(grilla.Rows - 1, 7) = CDbl(datos(8))
                    Toolbar1.Buttons(3).Enabled = True
                    Toolbar1.Buttons(4).Enabled = True
            End If
        Loop
        Call Marcar
    End If
    
    box_familia.Enabled = False
    Toolbar1.Buttons(Btn_Buscar).Enabled = False
    
End Function

Private Sub Form_Load()

    Move 0, 0
    
    giAceptar% = False
    
    Call Func_Limpiar
    'lbl_unidad.Caption = "Unidad : " &
    Call buscar_unidad(Bac_Usr_ofi)

End Sub




Sub Marcar()

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
      .Row = f
      .Col = 0
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
   
   
    If lrow > 1 Then
        grilla.TopRow = lrow
    End If
   
End Sub



Function llena_combo_familia()
    Dim datos()
    box_familia.Clear
    If Bac_Sql_Execute("Svc_Gen_fam_ins") Then
        Do While Bac_SQL_Fetch(datos)
            box_familia.AddItem datos(2)
            box_familia.ItemData(box_familia.NewIndex) = Val(datos(1))
        Loop
    End If
End Function




Private Sub grilla_Click()
    Call Marcar
    
    If FilaSeleccionada > 0 Then
        Toolbar1.Buttons(Btn_Aceptar).Enabled = True
        Toolbar1.Buttons(Btn_Emision).Enabled = True
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case Btn_Limpiar
            Call Func_Limpiar
            
        Case Btn_Buscar
            Call llena_grilla
            
        Case Btn_Aceptar
            Call Func_Aceptar
        
        Case Btn_Emision
            instru = grilla.TextMatrix(grilla.Row, 6)
            Num_Docu = CDbl(grilla.TextMatrix(grilla.Row, 7))
            Bac_Ventas_DetalleInst.Show vbModal
        
        Case Btn_Salir
            Unload Me
    End Select
End Sub


