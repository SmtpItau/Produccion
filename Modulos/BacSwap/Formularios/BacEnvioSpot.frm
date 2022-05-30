VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacEnvioSpot 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Pantalla Envío a Spot"
   ClientHeight    =   7650
   ClientLeft      =   420
   ClientTop       =   720
   ClientWidth     =   14790
   FillStyle       =   0  'Solid
   Icon            =   "BacEnvioSpot.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7650
   ScaleWidth      =   14790
   Begin VB.CommandButton EnviarSpot 
      Caption         =   "ENVIAR A SPOT"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   840
      TabIndex        =   12
      Top             =   6960
      Width           =   2055
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   10575
      Top             =   480
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEnvioSpot.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEnvioSpot.frx":0326
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEnvioSpot.frx":1200
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEnvioSpot.frx":20DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEnvioSpot.frx":2FB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEnvioSpot.frx":3E8E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel2 
      Height          =   5610
      Left            =   60
      TabIndex        =   5
      Top             =   1140
      Width           =   14700
      _Version        =   65536
      _ExtentX        =   25929
      _ExtentY        =   9895
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox CmbEstadoEnvia 
         BackColor       =   &H8000000F&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   315
         ItemData        =   "BacEnvioSpot.frx":41A8
         Left            =   7080
         List            =   "BacEnvioSpot.frx":41AA
         TabIndex        =   13
         Top             =   3600
         Width           =   1335
      End
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   5490
         Left            =   0
         TabIndex        =   2
         Top             =   45
         Width           =   14640
         _ExtentX        =   25823
         _ExtentY        =   9684
         _Version        =   393216
         Cols            =   24
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483633
         HighLight       =   2
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
      End
   End
   Begin VB.ComboBox Cmb_Recibimos 
      ForeColor       =   &H80000002&
      Height          =   315
      Left            =   6600
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   2415
      Visible         =   0   'False
      Width           =   3195
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   0
      Left            =   1590
      Picture         =   "BacEnvioSpot.frx":41AC
      ScaleHeight     =   315
      ScaleWidth      =   345
      TabIndex        =   1
      Top             =   7800
      Visible         =   0   'False
      Width           =   345
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   0
      Left            =   2175
      Picture         =   "BacEnvioSpot.frx":4306
      ScaleHeight     =   315
      ScaleWidth      =   345
      TabIndex        =   0
      Top             =   7800
      Visible         =   0   'False
      Width           =   345
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   14790
      _ExtentX        =   26088
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Marcar/Desmarcar Todo"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Reporte"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cargar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Pantalla"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar Estado Envío"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   585
      Index           =   0
      Left            =   0
      TabIndex        =   6
      Top             =   465
      Width           =   14730
      _Version        =   65536
      _ExtentX        =   25982
      _ExtentY        =   1032
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
      Begin BACControles.TXTFecha Txt_Fecha 
         Height          =   285
         Left            =   1575
         TabIndex        =   7
         Top             =   225
         Width           =   1200
         _ExtentX        =   2117
         _ExtentY        =   503
         Enabled         =   -1  'True
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
         ForeColor       =   -2147483646
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "05/06/2002"
      End
      Begin VB.Label Lbl_Fecha 
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   210
         Left            =   120
         TabIndex        =   8
         Top             =   255
         Width           =   1425
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   750
      Index           =   1
      Left            =   11550
      TabIndex        =   9
      Top             =   1395
      Width           =   1425
      _Version        =   65536
      _ExtentX        =   2514
      _ExtentY        =   1323
      _StockProps     =   14
      Caption         =   "Color"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      Begin VB.Label lblImpresas 
         BackColor       =   &H00FFC0C0&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Impresas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   375
         Left            =   105
         TabIndex        =   10
         Top             =   330
         Width           =   1215
      End
   End
   Begin VB.Label Lbl_Recibimos 
      Caption         =   "Recibimos"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   240
      Left            =   5160
      TabIndex        =   3
      Top             =   2460
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Image ImgChk 
      Height          =   375
      Left            =   960
      Picture         =   "BacEnvioSpot.frx":4460
      Stretch         =   -1  'True
      Top             =   7845
      Width           =   480
   End
   Begin VB.Image ImgCheck 
      Height          =   480
      Left            =   90
      Picture         =   "BacEnvioSpot.frx":476A
      Top             =   7740
      Width           =   480
   End
End
Attribute VB_Name = "BacEnvioSpot"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim c1$, Impre$, SQL$
Dim i&, j&, a1&, Vcol%, nPos%
Dim Datos()

Private Sub Combo1_Change()

End Sub



Private Sub CmbEstadoEnvia_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode
        Case vbKeyReturn
            With Grid1
        
                .TextMatrix(.Row, 18) = Trim(CmbEstadoEnvia.Text)
                .TextMatrix(.Row, 18) = Trim(CmbEstadoEnvia.Text)
                
                CmbEstadoEnvia.Visible = False
           
            End With
            
        Case vbKeyEscape
            CmbEstadoEnvia.Visible = False
            Grid1.SetFocus
    End Select
End Sub

Private Sub CmbEstadoEnvia_LostFocus()
    CmbEstadoEnvia.Visible = False
    Call GrabaEstadoEnvio
End Sub

Private Sub EnviarSpot_Click()

   Call EnviaSpot
   
End Sub


Private Sub EstadoEnvia_Change()

End Sub

Private Sub Form_Activate()
    BACSwap.MousePointer = 0

End Sub

Sub Nombres_Grilla()
    
    Grid1.BackColor = &H8000000F
    Grid1.ForeColor = &H80000008
    
    Grid1.BackColorFixed = &H80000002
    Grid1.ForeColorFixed = &H80000009
    
    Me.Grid1.Font.Size = 8
    Me.Grid1.Font.Name = "Arial"
    
    Me.Grid1.ColAlignment(21) = flexAlignRightCenter
    Me.Grid1.ColAlignment(22) = flexAlignRightCenter
    
    Grid1.Rows = 3
    Grid1.FixedRows = 2
    
    Grid1.TextMatrix(0, 0) = "Flujo":        Grid1.TextMatrix(1, 0) = "Enviado":       Grid1.ColWidth(0) = 800
    Grid1.TextMatrix(0, 1) = "Nº de ":       Grid1.TextMatrix(1, 1) = "Operación":     Grid1.ColWidth(1) = 950
    Grid1.TextMatrix(0, 2) = "Tipo de ":     Grid1.TextMatrix(1, 2) = "Operación":     Grid1.ColWidth(2) = 980
    Grid1.TextMatrix(0, 3) = "Tipo de ":     Grid1.TextMatrix(1, 3) = "Producto":      Grid1.ColWidth(3) = 980
    Grid1.TextMatrix(0, 4) = "Nombre":       Grid1.TextMatrix(1, 4) = "Cliente":       Grid1.ColWidth(4) = 3500
    Grid1.TextMatrix(0, 5) = "Moneda":       Grid1.TextMatrix(1, 5) = "Operación":     Grid1.ColWidth(5) = 810
    Grid1.TextMatrix(0, 6) = "Monto":        Grid1.TextMatrix(1, 6) = "Operación":     Grid1.ColWidth(6) = 1500
    Grid1.TextMatrix(0, 7) = "Moneda":       Grid1.TextMatrix(1, 7) = "Conversion":    Grid1.ColWidth(7) = 810
    Grid1.TextMatrix(0, 8) = "Monto":        Grid1.TextMatrix(1, 8) = "Conversion":    Grid1.ColWidth(8) = 1500
    Grid1.TextMatrix(0, 9) = "Tipo":         Grid1.TextMatrix(1, 9) = "Cambio":        Grid1.ColWidth(9) = 900
    Grid1.TextMatrix(0, 10) = "Paridad":     Grid1.TextMatrix(1, 10) = "":             Grid1.ColWidth(10) = 800
    Grid1.TextMatrix(0, 11) = "Forma Pago":  Grid1.TextMatrix(1, 11) = "Entre":        Grid1.ColWidth(11) = 1000
    Grid1.TextMatrix(0, 12) = "Forma Pago":  Grid1.TextMatrix(1, 12) = "Recibe":       Grid1.ColWidth(12) = 1000
    Grid1.TextMatrix(0, 13) = "Fecha":       Grid1.TextMatrix(1, 13) = "Inicio":       Grid1.ColWidth(13) = 1000
    Grid1.TextMatrix(0, 14) = "Fecha":       Grid1.TextMatrix(1, 14) = "Vcto.":        Grid1.ColWidth(14) = 1000
    Grid1.TextMatrix(0, 15) = "Fecha":       Grid1.TextMatrix(1, 15) = "Liquidación":  Grid1.ColWidth(15) = 1000
    Grid1.TextMatrix(0, 16) = "Operador":    Grid1.TextMatrix(1, 16) = "":             Grid1.ColWidth(16) = 1000
    Grid1.TextMatrix(0, 17) = "Estado":      Grid1.TextMatrix(1, 17) = "":             Grid1.ColWidth(17) = 0
    Grid1.TextMatrix(0, 18) = "Estado":      Grid1.TextMatrix(1, 18) = "Envío":        Grid1.ColWidth(18) = 1500
    Grid1.TextMatrix(0, 19) = "Cod. Estado": Grid1.TextMatrix(1, 19) = "Envío":        Grid1.ColWidth(19) = 1000
    Grid1.TextMatrix(0, 20) = "Fecha ":      Grid1.TextMatrix(1, 20) = "Proceso":      Grid1.ColWidth(20) = 1000
    Grid1.TextMatrix(0, 21) = "N° Oper.":    Grid1.TextMatrix(1, 21) = "Spot":         Grid1.ColWidth(21) = 1000
    Grid1.TextMatrix(0, 22) = "":            Grid1.TextMatrix(1, 22) = "":             Grid1.ColWidth(22) = 1000
    Grid1.TextMatrix(0, 23) = "":            Grid1.TextMatrix(1, 23) = "":             Grid1.ColWidth(23) = 0
    

    Grid1.SelectionMode = flexSelectionFree
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   Me.Top = 1: Me.Left = 16
    
   Vcol = 7
   Impre = "N"
       
   CmbEstadoEnvia.Visible = False
   Txt_Fecha.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
   
      
   CmbEstadoEnvia.AddItem " "
   CmbEstadoEnvia.AddItem "EN ESPERA"
   CmbEstadoEnvia.AddItem "NO SE ENVIARA"
  
   Call Nombres_Grilla
   Call Toolbar1_ButtonClick(Toolbar1.Buttons.Item(3))
End Sub

Public Function Refre_Grilla()
   On Error Resume Next
   Dim MArca()
   Dim Carta      As Integer
   Dim nCol       As Integer
   Dim Fila%
   ReDim MArca(Grid1.Rows)
   Dim i%
   
   
   For Fila = 2 To Grid1.Rows - 1
      If Trim(Grid1.TextMatrix(Fila, 0)) = "X" Then
         MArca(Fila) = 1
      End If
   Next Fila
   Grid1.Redraw = False
    
   Envia = Array()
   AddParam Envia, Txt_Fecha.Text
   If Not Bac_Sql_Execute("SP_CARGA_VCTOS_FLUJOS_SWAP", Envia) Then
      Grid1.Redraw = True
      Exit Function
   End If

   Grid1.Enabled = False
   Grid1.Clear
   Call Nombres_Grilla

   Do While Bac_SQL_Fetch(Datos())
      c1 = "1"
      With Grid1
         Grid1.Rows = Grid1.Rows + 1
         Grid1.Row = Grid1.Rows - 2
         Grid1.Col = 0: Grid1.Text = " "
         Grid1.CellPictureAlignment = 4
            
            
         Grid1.Col = 1:    Grid1.Text = Datos(1)
         Grid1.Col = 2:    Grid1.Text = Datos(2)
         Grid1.Col = 3:    Grid1.Text = Datos(3)
         Grid1.Col = 4:    Grid1.Text = Datos(4)
         Grid1.Col = 5:    Grid1.Text = Datos(5)
         Grid1.Col = 6:    Grid1.Text = Datos(6)
         Grid1.Col = 7:    Grid1.Text = Datos(7)
         Grid1.Col = 8:    Grid1.Text = Format(Datos(8), FDecimal)
         Grid1.Col = 9:    Grid1.Text = Format(Datos(9), FDecimal)
         Grid1.Col = 10:   Grid1.Text = Format(Datos(10), FDecimal)
         Grid1.Col = 11:   Grid1.Text = Datos(11)
         Grid1.Col = 12:   Grid1.Text = Datos(12)
         Grid1.Col = 13:   Grid1.Text = Datos(13)
         Grid1.Col = 14:   Grid1.Text = Datos(14)
         Grid1.Col = 15:   Grid1.Text = Datos(15)
         Grid1.Col = 16:   Grid1.Text = Datos(16)
         Grid1.Col = 17:   Grid1.Text = Datos(17)
         Grid1.Col = 18:   Grid1.Text = Datos(18)
         Grid1.Col = 19:   Grid1.Text = Datos(19)
         Grid1.Col = 20:   Grid1.Text = Datos(20)
         Grid1.Col = 21:   Grid1.Text = Datos(21)
         Grid1.Col = 22:   Grid1.Text = CDbl(Datos(22)) + CDbl(Datos(23))
         Grid1.RowHeight(Grid1.Rows - 2) = 300
      End With

      If Datos(17) = 1 Then
        Grid1.Col = 0
        Set Grid1.CellPicture = Me.ConCheck(0).Image
         Me.ConCheck(0).Enabled = False
         Grid1.Text = Space(100) & "X"
         For nCol = 0 To 23
            Grid1.Col = nCol
            Grid1.CellBackColor = lblImpresas.BackColor
           
         Next nCol
      Else
''''           Set Grid1.CellPicture = Me.SinCheck(0).Image
''''           Grid1.Text = Space(100) & "X"    OJO
      End If
   Loop
   


   Grid1.Rows = Grid1.Rows - 1
   Grid1.Enabled = True
   Grid1.Redraw = True
    
End Function

Private Sub grid1_Click()
   
    If Grid1.Rows > 1 And Grid1.Col = 0 Then
    
        If Trim(Grid1.TextMatrix(Grid1.Row, 0)) = "X" And (Grid1.TextMatrix(Grid1.Row, 17)) = "1" Then
            Set Grid1.CellPicture = Me.ConCheck(0).Image
        Else
        If Trim(Grid1.TextMatrix(Grid1.Row, 0)) = "X" Then
            Grid1.TextMatrix(Grid1.Row, 0) = ""
            Set Grid1.CellPicture = Me.SinCheck(0).Image
        Else
            Set Grid1.CellPicture = Me.ConCheck(0).Image
            Grid1.CellAlignment = 4
            Grid1.TextMatrix(Grid1.Row, 0) = Space(100) + "X"
        End If
        End If
    End If
 
End Sub

Private Sub Grid1_DblClick()
Dim nContador1 As Integer

    With Grid1

        If .Enabled = False Then
            Exit Sub
        End If
               
        If .Col = 18 And Txt_Fecha.Text = gsBAC_Fecp Then
            If CmbEstadoEnvia.ListCount > 0 And Trim(.TextMatrix(.Row, 17)) <> "1" And (.TextMatrix(.Row, 22) <> 13) Then
                For nContador1 = 0 To CmbEstadoEnvia.ListCount - 1
                    If Trim(Right(CmbEstadoEnvia.List(nContador1), 10)) = Trim(.TextMatrix(.Row, 18)) Then
                        CmbEstadoEnvia.ListIndex = nContador1
                       
                        Exit For
                    End If
                    
                Next nContador1

                CmbEstadoEnvia.Visible = True
                CmbEstadoEnvia.Width = .ColWidth(.Col)
                CmbEstadoEnvia.Left = .Left + .CellLeft
                CmbEstadoEnvia.Top = .Top + .CellTop
'''                CmbEstadoEnvia.SetFocus
            End If
        End If
        
        
                
    End With

End Sub

Private Sub Grid1_KeyDown(KeyCode As Integer, Shift As Integer)

   Select Case KeyCode
      Case vbKeySpace
              If Grid1.Rows > 1 And Grid1.Col = 0 Then
                  If Trim(Grid1.TextMatrix(Grid1.RowSel, 0)) = "X" Then
                      Grid1.TextMatrix(Grid1.RowSel, 0) = ""
                      Set Grid1.CellPicture = Me.SinCheck(0).Image
                  Else
                      Set Grid1.CellPicture = Me.ConCheck(0).Image
                      Grid1.CellAlignment = 4
                      Grid1.TextMatrix(Grid1.RowSel, 0) = Space(100) + "X"
                  End If
            
              End If

   End Select

End Sub

Private Sub grid1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

Me.Grid1.MousePointer = flexDefault

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim nCont As Integer
   Dim strOk As String
   
   
   Select Case Button.Index
      Case 1
         Me.MousePointer = 11
         If Toolbar1.Buttons(1).ToolTipText = "&Marcar Todos" Then
            Set Grid1.CellPicture = Me.ConCheck(0).Image
         End If
    
         strOk = IIf(Left(Toolbar1.Buttons(1).ToolTipText, 2) = "&M" Or Left(Toolbar1.Buttons(1).ToolTipText, 2) = "Ma", "X", " ")
         Grid1.Redraw = False
         For nCont = 2 To Grid1.Rows - 1
            Grid1.Row = nCont
            Grid1.Col = 0
            Grid1.CellAlignment = 4
            Grid1.Text = Space(100) + strOk
            If strOk = "X" Then
            
                If Trim(Grid1.TextMatrix(Grid1.Row, 0)) = "X" And (Grid1.TextMatrix(Grid1.Row, 17)) = "1" Then
                    Set Grid1.CellPicture = Me.ConCheck(0).Image
                Else
                    If Trim(Grid1.TextMatrix(Grid1.Row, 0)) = "X" Then
                        Set Grid1.CellPicture = Me.ConCheck(0).Image
                    Else
                        Set Grid1.CellPicture = Me.SinCheck(0).Image
                    End If
                End If
            Else
            
                    If (Grid1.TextMatrix(Grid1.Row, 17)) = "1" Then
                        Set Grid1.CellPicture = Me.ConCheck(0).Image
                    Else
                        Set Grid1.CellPicture = Me.SinCheck(0).Image
                    End If

            End If
         Next nCont
         Grid1.Redraw = True
         Toolbar1.Buttons(1).ToolTipText = IIf(strOk = "X", "&Desm", "&M") & "arcar Todos"
         Me.MousePointer = 0
      Case 2
             Call InformeVctoFujos(Txt_Fecha.Text)
      Case 3
         Call Refre_Grilla
        

         If Txt_Fecha.Text <> gsBAC_Fecp Then
             EnviarSpot.Enabled = False
         Else
             EnviarSpot.Enabled = True
         End If
         
         
         If Toolbar1.Buttons(3).ToolTipText = "Cargar" Then
            For nCont = 2 To Grid1.Rows - 1
               Grid1.Row = nCont
               Grid1.Col = 0
               Grid1.CellAlignment = 4


              If Trim(Grid1.TextMatrix(nCont, 0)) = "X" And (Grid1.TextMatrix(nCont, 17)) = "1" Then
                 Set Grid1.CellPicture = Me.ConCheck(0).Image
              Else
                 Set Grid1.CellPicture = Me.SinCheck(0).Image
              End If
                 
            Next nCont
            
            
         Else
            strOk = IIf(Left(Toolbar1.Buttons(1).ToolTipText, 2) = "Ma" Or Left(Toolbar1.Buttons(1).ToolTipText, 2) = "&M", "X", " ")
            For nCont = 2 To Grid1.Rows - 1
               Grid1.Row = nCont
               Grid1.Col = 0
               Grid1.CellAlignment = 4
               Grid1.Text = Space(100) & "X" 'strOk
               Set Grid1.CellPicture = Me.ConCheck(0).Image

               If Toolbar1.Buttons(1).ToolTipText = "&Desmarcar Todos" Then
                  Toolbar1.Buttons(1).ToolTipText = "&Marcar Todos"
               End If
            Next nCont
            
            Me.MousePointer = 0
         End If
      Case 4


      Case 5
             Call GrabaEstadoEnvio
             
      Case 6
         
         SQL = "No"
         Unload Me
   End Select
End Sub

Private Function ChkFechas(StrFecha_Inicio, StrFecha_Termino, IntInicio_Termino) As Boolean
    ChkFechas = False
   Dim A As Variant
    
    If DateDiff("d", CDate(StrFecha_Inicio), CDate(StrFecha_Termino)) < 0 Then
       If IntInicio_Termino = 1 Then
          MsgBox "Fecha de Inicio debe ser menor o igual a la de Término", 16, "Error"
       Else
          MsgBox "Fecha de Término debe ser mayor o igual a la de Inicio", 16, "Error"
       End If
    Else
       ChkFechas = True
    End If

End Function

Private Sub Txt_Fecha_Change()
    Dim Boo_Resultado As Boolean
    Boo_Resultado = ChkFechas(Txt_Fecha.Text, Txt_Fecha.Text, 1)
    If Not Boo_Resultado Then
        Txt_Fecha.Text = Txt_Fecha.Text
    End If

End Sub


Public Function EnviaSpot()
  Dim iCadena As String
  Dim nCont   As Integer
  Dim nCol    As Integer
  Dim cMsj   As String
   
  MousePointer = vbHourglass
  '''Grid1.Redraw = False
  cMsj = ""
   
  For nCont = 2 To Grid1.Rows - 1
   
   If Trim(Grid1.TextMatrix(nCont, 0)) = "X" And (Grid1.TextMatrix(nCont, 17)) <> "1" And (Grid1.TextMatrix(nCont, 19)) = "0" And (Grid1.TextMatrix(nCont, 22) <> 13) Then
      Envia = Array()
      AddParam Envia, CDbl(Grid1.TextMatrix(nCont, 1))
      If Not Bac_Sql_Execute("SP_ENVIAR_SWAP_A_SPOT", Envia) Then
         MousePointer = vbDefault
         MsgBox "Error en envío de operación a Spot" & vbCrLf & "SP_ENVIAR_SWAP_A_SPOT", vbCritical, TITSISTEMA
         Exit Function
         
      Else
         Grid1.Col = 0
         Grid1.TextMatrix(nCont, 17) = "1"
         Grid1.TextMatrix(nCont, 18) = "ENVIADA"
         Grid1.TextMatrix(nCont, 19) = "1"
         Me.ConCheck(0).Enabled = False
         
         For nCol = 0 To 22
            Grid1.Col = nCol
            Grid1.Row = nCont
            Grid1.CellBackColor = lblImpresas.BackColor
           
         Next nCol
         
      End If
   Else
       If (Grid1.TextMatrix(nCont, 19)) = "2" Then
        cMsj = cMsj + Grid1.TextMatrix(nCont, 1) + " - "
       End If
   End If
  Next nCont
        
       If cMsj <> "" Then
            cMsj = " Existen  Vctos.  de Flujos con  Estado envío NO SE ENVIARA (" + cMsj + " )"
            MsgBox "Información: " & cMsj, vbOKOnly + vbInformation, TITSISTEMA
       End If

   MousePointer = vbDefault
  

    
End Function


Public Function GrabaEstadoEnvio()
  Dim iCadena           As String
  Dim nCont             As Integer
  Dim nCol              As Integer
  Dim nEstadoEnvia      As Integer
   
  MousePointer = vbHourglass
   
  For nCont = 2 To Grid1.Rows - 1
  
   If (Grid1.TextMatrix(nCont, 18)) = "EN ESPERA" Then
      Grid1.TextMatrix(nCont, 19) = "0"
      nEstadoEnvia = 0
   Else
        If (Grid1.TextMatrix(nCont, 18)) = "ENVIADA" Then
             nEstadoEnvia = 1
        Else
             nEstadoEnvia = 2
             Grid1.TextMatrix(nCont, 19) = "2"
        End If
   End If
   
   If (Grid1.TextMatrix(nCont, 17)) <> "1" Then
      Envia = Array()
      AddParam Envia, CDbl(Grid1.TextMatrix(nCont, 1))
      AddParam Envia, CDbl(nEstadoEnvia)
      If Not Bac_Sql_Execute("SP_GRABA_ESTADO_ENVIO_SPOT", Envia) Then
         MousePointer = vbDefault
         MsgBox "Error al grabar Estado de Envío Spot" & vbCrLf & "SP_GRABA_ESTADO_ENVIO_SPOT", vbCritical, TITSISTEMA
         Exit Function
      End If
      
   End If
  Next nCont
    
   MousePointer = vbDefault
  

    
End Function

Private Sub InformeVctoFujos(miFecha As Date)
   On Error GoTo ErrPrint

   Call BacLimpiaParamCrw
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Informe_Vcto_Flujos_Spot.rpt"
   BACSwap.Crystal.WindowTitle = "Resumen Moviminetos Swap"
   BACSwap.Crystal.StoredProcParam(0) = Format(miFecha, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.Destination = crptToWindow
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1

Exit Sub
ErrPrint:
   MsgBox "Error al imprimir." & vbCrLf & vbCrLf & err.Description, vbExclamation, TITSISTEMA
End Sub


