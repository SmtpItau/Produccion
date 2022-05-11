VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Analisis_voucher 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Analisis Voucher"
   ClientHeight    =   7185
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10005
   Icon            =   "Analisis_Voucher.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7185
   ScaleWidth      =   10005
   Begin VB.Frame Frame2 
      Caption         =   "Detalles "
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
      Height          =   5160
      Left            =   0
      TabIndex        =   16
      Top             =   1950
      Width           =   9990
      Begin VB.Frame Frame3 
         Height          =   2490
         Left            =   75
         TabIndex        =   17
         Top             =   165
         Width           =   9810
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   2295
            Left            =   45
            TabIndex        =   19
            Top             =   135
            Width           =   9720
            _ExtentX        =   17145
            _ExtentY        =   4048
            _Version        =   393216
            Rows            =   6
            Cols            =   4
            FixedRows       =   2
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            GridColorFixed  =   16777215
            Enabled         =   -1  'True
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            SelectionMode   =   1
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin VB.Frame Frame4 
         Height          =   2475
         Left            =   75
         TabIndex        =   18
         Top             =   2595
         Width           =   9810
         Begin MSFlexGridLib.MSFlexGrid Grilla2 
            Height          =   2280
            Left            =   60
            TabIndex        =   20
            Top             =   135
            Width           =   9690
            _ExtentX        =   17092
            _ExtentY        =   4022
            _Version        =   393216
            Rows            =   6
            Cols            =   5
            FixedRows       =   2
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            GridColorFixed  =   16777215
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            SelectionMode   =   1
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4275
      Top             =   30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Analisis_Voucher.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Analisis_Voucher.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Analisis_Voucher.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Analisis_Voucher.frx":0D90
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   10005
      _ExtentX        =   17648
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Busca"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprime"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   1440
      Left            =   -15
      TabIndex        =   0
      Top             =   510
      Width           =   10005
      Begin Threed.SSPanel SSPanel2 
         Height          =   1170
         Left            =   5025
         TabIndex        =   9
         Top             =   165
         Width           =   4875
         _Version        =   65536
         _ExtentX        =   8599
         _ExtentY        =   2064
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
         Begin BACControles.TXTNumero TxtNVoucher 
            Height          =   300
            Left            =   1680
            TabIndex        =   6
            Top             =   720
            Width           =   780
            _ExtentX        =   1376
            _ExtentY        =   529
            ForeColor       =   8388608
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
            Max             =   "9999999"
         End
         Begin VB.ComboBox CmbProducto 
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
            Height          =   315
            Left            =   1680
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   390
            Width           =   3105
         End
         Begin BACControles.TXTFecha TxtFechaHasta 
            Height          =   315
            Left            =   1680
            TabIndex        =   4
            Top             =   60
            Width           =   1875
            _ExtentX        =   3307
            _ExtentY        =   556
            Enabled         =   -1  'True
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
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "19/02/2001"
         End
         Begin VB.Label Label6 
            Caption         =   "Numero Voucher"
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
            Height          =   315
            Left            =   195
            TabIndex        =   15
            Top             =   735
            Width           =   1755
         End
         Begin VB.Label Label5 
            Caption         =   "Producto"
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
            Height          =   345
            Left            =   195
            TabIndex        =   14
            Top             =   420
            Width           =   2385
         End
         Begin VB.Label Label4 
            Caption         =   "Hasta"
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
            Height          =   300
            Left            =   195
            TabIndex        =   13
            Top             =   90
            Width           =   1575
         End
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   1170
         Left            =   90
         TabIndex        =   8
         Top             =   165
         Width           =   4890
         _Version        =   65536
         _ExtentX        =   8625
         _ExtentY        =   2064
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
         Begin VB.TextBox TxtCuenta 
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
            Height          =   330
            Left            =   1020
            MouseIcon       =   "Analisis_Voucher.frx":10AA
            MousePointer    =   99  'Custom
            TabIndex        =   3
            Top             =   750
            Width           =   3750
         End
         Begin VB.ComboBox CmbSistema 
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
            Height          =   315
            Left            =   1020
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   405
            Width           =   3780
         End
         Begin BACControles.TXTFecha TxtFechaDesde 
            Height          =   315
            Left            =   1035
            TabIndex        =   1
            Top             =   75
            Width           =   1950
            _ExtentX        =   3440
            _ExtentY        =   556
            Enabled         =   -1  'True
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
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "19/02/2001"
         End
         Begin VB.Label Label3 
            Caption         =   "Cuenta"
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
            Height          =   300
            Left            =   150
            TabIndex        =   12
            Top             =   780
            Width           =   1470
         End
         Begin VB.Label Label2 
            Caption         =   "Sistema"
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
            Height          =   345
            Left            =   150
            TabIndex        =   11
            Top             =   465
            Width           =   1515
         End
         Begin VB.Label Label1 
            Caption         =   "Desde"
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
            Left            =   165
            TabIndex        =   10
            Top             =   120
            Width           =   1410
         End
      End
   End
End
Attribute VB_Name = "Analisis_voucher"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim colpress As Long
Dim rowpress As Long
Dim Product As Integer
Dim Sistema As Integer

Private Sub CmbProducto_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo fin:

   If KeyCode = 13 Then TxtNVoucher.SetFocus  'Or KeyCode = 40
      
   'If KeyCode = 38 Then TxtFechaHasta.SetFocus
   
   'If KeyCode = 40 Then TxtNVoucher.SetFocus
   
   If KeyCode = 27 Then CmbProducto.ListIndex = Val(CmbProducto.Tag)
   
   If KeyCode = vbKeyF4 Then Busca
     
fin:
End Sub

Private Sub CmbProducto_LostFocus()

   CmbProducto.Tag = CmbProducto.ListIndex

End Sub

Private Sub CmbSistema_Click()
Dim Datos()

   If CmbSistema.Text <> "" Then
        CmbProducto.Clear
'         Sql = "SP_ANALISIS_VOUCHER_LLENA_DATOS 'Producto'," & "'" & Right(CmbSistema.Text, 3) & "'"
        Envia = Array("Producto", Right(CmbSistema.Text, 3))
        If Bac_Sql_Execute("SP_ANALISIS_VOUCHER_LLENA_DATOS", Envia) Then
            Do While Bac_SQL_Fetch(Datos())
                CmbProducto.AddItem (Datos(2) & Space(80) & Datos(1))
            Loop
         End If
    End If

    grilla.Enabled = False
    Grilla2.Enabled = False

End Sub

Private Sub CmbSistema_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 13 Then TxtCuenta.SetFocus 'Or KeyCode = 40

   'If KeyCode = 38 Then TxtFechaDesde.SetFocus
   
   If KeyCode = 27 Then CmbSistema.ListIndex = Val(CmbSistema.Tag)

End Sub

Private Sub CmbSistema_LostFocus()

   CmbSistema.Tag = CmbSistema.ListIndex

End Sub

Private Sub Form_Load()

   
   Me.Top = 0
   Me.Left = 0
   Carga_Grilla1
   Carga_Grilla2
   grilla.Enabled = False
   Grilla2.Enabled = False
   Carga_Combos
   TxtFechaHasta.Text = Date
   TxtFechaDesde.Text = Date
   TxtFechaDesde.Tag = TxtFechaDesde.Text
   CmbSistema.Tag = CmbSistema.Text
   TxtCuenta.Tag = CmbSistema.Text
   TxtFechaHasta.Tag = TxtFechaHasta.Text
   CmbProducto.Tag = CmbProducto.Text
   TxtNVoucher.Tag = TxtNVoucher.Text

End Sub

Private Sub grilla_Click()
   
   Busca_Detalle_Voucher
   
End Sub

Private Sub Grilla_EnterCell()

   Busca_Detalle_Voucher

End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

      colpress = grilla.Col
      rowpress = grilla.Row
      grilla.ColSel = grilla.cols - 1
      
      If KeyCode = 38 Then Unload Me
            
End Sub

Private Sub Grilla_KeyUp(KeyCode As Integer, Shift As Integer)
    
      grilla.Col = colpress
      grilla.Row = rowpress
      grilla.ColSel = grilla.cols - 1

End Sub

Private Sub Grilla2_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 27 Then Unload Me

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index

      Case Is = 1: Busca
      
      Case Is = 2: Limpia
      
      Case Is = 3:
      
      Case Is = 4: Unload Me
      
   End Select

End Sub

Private Sub TxtCuenta_DblClick()
   
   BacAyuda.Tag = "CUENTAS VOUCHER"
   BacAyuda.Show 1

   If giAceptar = True Then
      
      TxtCuenta.Text = Analisis_voucher.Tag
   
   End If
   
   grilla.Enabled = False
   Grilla2.Enabled = False
   
End Sub

Private Sub TxtCuenta_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyF3 Then TxtCuenta_DblClick
   
   If KeyCode = 13 Or KeyCode = 40 Then TxtFechaHasta.SetFocus

   If KeyCode = 38 Then CmbSistema.SetFocus
   
   If KeyCode = 27 Then TxtCuenta.Text = TxtCuenta.Tag

End Sub

Private Sub TxtCuenta_LostFocus()

   TxtCuenta.Tag = TxtCuenta.Text

End Sub

Private Sub TxtFechaDesde_Change()

   If Mid$(TxtFechaDesde.Text, 1, 2) >= Mid$(TxtFechaHasta.Text, 1, 2) And Mid$(TxtFechaDesde.Text, 4, 2) >= Mid$(TxtFechaHasta.Text, 4, 2) And Mid$(TxtFechaDesde.Text, 7, 4) >= Mid$(TxtFechaHasta.Text, 7, 4) Then TxtFechaDesde.Text = TxtFechaHasta.Text
   
   grilla.Enabled = False
   Grilla2.Enabled = False
   
End Sub

Private Sub TxtFechaDesde_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 13 Or KeyCode = 40 Then CmbSistema.SetFocus
   
   If KeyCode = 38 Then TxtNVoucher.SetFocus
   
   If KeyCode = 27 And TxtFechaDesde.Text <> TxtFechaDesde.Tag Then
      
      TxtFechaDesde.Text = TxtFechaDesde.Tag
      
   Else
      
      Unload Me
      
   End If
   
End Sub

Private Sub TxtFechaDesde_LostFocus()

   TxtFechaDesde.Tag = TxtFechaDesde.Text

End Sub

Private Sub TxtFechaHasta_Change()

   If Mid$(TxtFechaDesde.Text, 1, 2) >= Mid$(TxtFechaHasta.Text, 1, 2) And Mid$(TxtFechaDesde.Text, 4, 2) >= Mid$(TxtFechaHasta.Text, 4, 2) And Mid$(TxtFechaDesde.Text, 7, 4) >= Mid$(TxtFechaHasta.Text, 7, 4) Then TxtFechaHasta.Text = TxtFechaDesde.Text

   grilla.Enabled = False
   Grilla2.Enabled = False

End Sub

Sub Carga_Grilla1()

   With grilla
               
         .Rows = 2
         .Row = 0
         .Col = 1
         .CellFontBold = True
         .Col = 2
         .CellFontBold = True
         .Col = 3
         .CellFontBold = True
         
         .ColWidth(1) = 1000
         .TextMatrix(0, 1) = "Numero"
         
         .ColWidth(2) = 4000
         .TextMatrix(0, 2) = "Glosa"
         
         .ColWidth(3) = 2000
         .TextMatrix(0, 3) = "Tipo"
         
         .ColWidth(0) = 0
         .Col = 0
         .Row = 0
   
   End With
   
End Sub

Sub Carga_Grilla2()

   With Grilla2
               
         .Rows = 2
         .Row = 0
         .Col = 1
         .CellFontBold = True
         .Col = 2
         .CellFontBold = True
         .Col = 3
         .CellFontBold = True
         .Col = 4
         .CellFontBold = True
         .Row = 1
         .Col = 1
         .CellFontBold = True
         .Col = 2
         .CellFontBold = True
         .Col = 3
         .CellFontBold = True
         .Col = 4
         .CellFontBold = True
         
         .ColWidth(1) = 1500
         .TextMatrix(0, 1) = "Fecha"
         .TextMatrix(1, 1) = "Ingreso"
         
         .ColWidth(2) = 1000
         .TextMatrix(0, 2) = "Numero"
         .TextMatrix(1, 2) = "Voucher"
         
         .ColWidth(3) = 2000
         .TextMatrix(0, 3) = "Cuenta"
                  
         .ColWidth(4) = 1500
         .TextMatrix(0, 4) = "Monto"
   
         .ColWidth(0) = 0
         .Col = 0
         .Row = 0
      
   End With

End Sub

Sub Carga_Combos()
Dim Datos()

   CmbSistema.Clear
'   Sql = "SP_ANALISIS_VOUCHER_LLENA_DATOS 'Sistema',''"
   
    Envia = Array("Sistema", "")
   If Bac_Sql_Execute("SP_ANALISIS_VOUCHER_LLENA_DATOS ", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            CmbSistema.AddItem (Datos(2) & Space(80) & Datos(1))
        Loop
    End If

End Sub



Sub Limpia()

   Form_Load
   TxtCuenta.Text = ""
   CmbProducto.Clear
   TxtNVoucher.Text = ""
   Habilitar
   TxtFechaDesde.SetFocus
   
End Sub

Sub Busca()
Dim Datos()
Dim Fila As Long

    DesHabilitar
'   Sql = "SP_ANALISIS_VOUCHER_LLENA_GRILLAVOUCHER " & "'" & TxtFechaDesde.Text & "',"
'   Sql = Sql & "'" & TxtFechaHasta.Text & "',"
'   Sql = Sql & "'" & Right(CmbSistema.Text, 3) & "',"
'   Sql = Sql & "'" & Trim(Right(CmbProducto.Text, 5)) & "',"
'   Sql = Sql & TxtNVoucher.Text

    Envia = Array(TxtFechaHasta.Text, _
            Right(CmbSistema.Text, 3), _
            Trim(Right(CmbProducto.Text, 5)), _
            CDbl(TxtNVoucher.Text))

    grilla.Rows = 2
    Grilla2.Rows = 2
    Fila = 2
    grilla.Col = 0
    grilla.Row = 0
    grilla.ColSel = 0
    grilla.Enabled = False

    If Bac_Sql_Execute("SP_ANALISIS_VOUCHER_LLENA_GRILLAVOUCHER", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            With grilla
                If Fila >= 2 Then
                    .AddItem ("")
                    grilla.Enabled = True
                    grilla.ColSel = grilla.cols - 1
                End If
                .TextMatrix(Fila, 1) = Datos(1)
                .TextMatrix(Fila, 2) = Datos(2)
                .TextMatrix(Fila, 3) = Datos(3)
                Fila = Fila + 1
            End With
        Loop
    End If

   Busca_Detalle_Voucher

End Sub


Sub Busca_Detalle_Voucher()
Dim Datos()
Dim Fila As Long

'   Sql = "SP_Analisis_Voucher_llena_grilla_DetalleVoucher " & "'" & Grilla.TextMatrix(Grilla.RowSel, 1) & "'"
   Envia = Array(grilla.TextMatrix(grilla.RowSel, 1))
   Carga_Grilla2
   Grilla2.Rows = 2
   Fila = 2
   
   If Bac_Sql_Execute("SP_ANALISIS_VOUCHER_LLENA_GRILLA_DETALLEVOUCHER", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "ERROR" Then
                With Grilla2
                    If Fila >= 2 Then
                        .AddItem ("")
                        Grilla2.Enabled = True
                    End If
                    .TextMatrix(Fila, 1) = Datos(4)
                    .TextMatrix(Fila, 2) = Datos(1)
                    .TextMatrix(Fila, 3) = Datos(2)
                    .TextMatrix(Fila, 4) = Datos(3)
                    Fila = Fila + 1
                End With
            End If
        Loop
    End If


End Sub


Sub DesHabilitar()

   TxtFechaDesde.Enabled = False
   TxtFechaHasta.Enabled = False
   CmbSistema.Enabled = False
   CmbProducto.Enabled = False
   TxtCuenta.Enabled = False
   TxtNVoucher.Enabled = False
   
End Sub

Sub Habilitar()

   TxtFechaDesde.Enabled = True
   TxtFechaHasta.Enabled = True
   CmbSistema.Enabled = True
   CmbProducto.Enabled = True
   TxtCuenta.Enabled = True
   TxtNVoucher.Enabled = True
   
End Sub

Private Sub TxtFechaHasta_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 13 Or KeyCode = 40 Then CmbProducto.SetFocus

   If KeyCode = 38 Then TxtCuenta.SetFocus

   If KeyCode = 27 Then TxtFechaHasta.Text = TxtFechaHasta.Tag

End Sub

Private Sub TxtFechaHasta_LostFocus()

   TxtFechaHasta.Tag = TxtFechaHasta.Text

End Sub

Private Sub TxtNVoucher_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 13 Or KeyCode = 40 Then TxtFechaDesde.SetFocus

   If KeyCode = 38 Then CmbProducto.SetFocus
   
   If KeyCode = 27 Then TxtNVoucher.Text = TxtNVoucher.Tag
   
End Sub

Private Sub Grilla_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
    
      grilla.Redraw = False
      colpress = grilla.Col
      rowpress = grilla.Row
      grilla.ColSel = grilla.cols - 1

End Sub

Private Sub Grilla_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
On Error GoTo fin:
    
      grilla.Redraw = True
      grilla.Col = colpress
      grilla.Row = rowpress
      grilla.ColSel = grilla.cols - 1
    
fin:
End Sub


Private Sub TxtNVoucher_LostFocus()

   TxtNVoucher.Tag = TxtNVoucher.Text

End Sub
