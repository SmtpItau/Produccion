VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacParVencimiento 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Paridad de Vencimiento"
   ClientHeight    =   5355
   ClientLeft      =   510
   ClientTop       =   1545
   ClientWidth     =   11220
   Icon            =   "Bacparve.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5355
   ScaleWidth      =   11220
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   390
      Top             =   3630
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
            Picture         =   "Bacparve.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacparve.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacparve.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacparve.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   11220
      _ExtentX        =   19791
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
            Key             =   "CmdLimpiar"
            Description     =   "CmdLimpiar"
            Object.ToolTipText     =   "Limpiar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdBuscar"
            Description     =   "CmdBuscar"
            Object.ToolTipText     =   "Buscar Operaciones"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdGrabar"
            Description     =   "CmdGrabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdSalir"
            Description     =   "CmdSalir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame frame 
      Height          =   3660
      Index           =   1
      Left            =   0
      TabIndex        =   0
      Top             =   1695
      Width           =   11220
      _Version        =   65536
      _ExtentX        =   19791
      _ExtentY        =   6456
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
      Begin VB.TextBox Txt_Ingreso 
         BackColor       =   &H00800000&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   270
         Left            =   4125
         TabIndex        =   5
         Top             =   1860
         Visible         =   0   'False
         Width           =   1185
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   3480
         Left            =   45
         TabIndex        =   4
         Top             =   120
         Width           =   11115
         _ExtentX        =   19606
         _ExtentY        =   6138
         _Version        =   393216
         Cols            =   12
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         GridLines       =   2
         GridLinesFixed  =   0
         Appearance      =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin Threed.SSFrame frame 
      Height          =   465
      Index           =   0
      Left            =   0
      TabIndex        =   1
      Top             =   1215
      Width           =   11220
      _Version        =   65536
      _ExtentX        =   19791
      _ExtentY        =   820
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
      Begin BACControles.TXTFecha TxtFecha 
         Height          =   288
         Left            =   60
         TabIndex        =   6
         Top             =   120
         Width           =   1176
         _ExtentX        =   2064
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
   End
   Begin Threed.SSFrame frame 
      Height          =   735
      Index           =   3
      Left            =   0
      TabIndex        =   2
      Top             =   495
      Width           =   11220
      _Version        =   65536
      _ExtentX        =   19791
      _ExtentY        =   1296
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
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         BackColor       =   &H00800000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "INGRESO DE PARIDADES DE VENCIMIENTO"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   105
         TabIndex        =   3
         Top             =   225
         Width           =   11040
      End
   End
End
Attribute VB_Name = "BacParVencimiento"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim sql   As String
Dim Datos()

Sub Dibuja_Grilla()
 
   With Table1
   
      .TextMatrix(0, 0) = ""
      .TextMatrix(0, 1) = "Operacion"
      .TextMatrix(0, 2) = "Nombre del Cliente"
      .TextMatrix(0, 3) = "Tipo"
      .TextMatrix(0, 4) = "Fecha Ini."
      .TextMatrix(0, 5) = "Fecha Vcto."
      .TextMatrix(0, 6) = "Monto M/X"
      .TextMatrix(0, 7) = "Monto USD"
      .TextMatrix(0, 8) = "Paridad Vcto."
      .TextMatrix(0, 9) = "Paridad Spot"
      .TextMatrix(0, 10) = "Paridad Forward"
      .TextMatrix(0, 11) = ""
       
      .RowHeight(0) = 500
      
      .ColAlignment(0) = 0:   .ColWidth(0) = 0
      .ColAlignment(1) = 7:   .ColWidth(1) = 1000
      .ColAlignment(2) = 1:   .ColWidth(2) = 3000
      .ColAlignment(3) = 4:   .ColWidth(3) = 450
      .ColAlignment(4) = 4:   .ColWidth(4) = 1500
      .ColAlignment(5) = 4:   .ColWidth(5) = 1500
      .ColAlignment(6) = 7:   .ColWidth(6) = 1500
      .ColAlignment(7) = 7:   .ColWidth(7) = 1500
      .ColAlignment(8) = 7:   .ColWidth(8) = 1500
      .ColAlignment(9) = 7:   .ColWidth(9) = 1500
      .ColAlignment(10) = 7:  .ColWidth(10) = 1500
      .ColAlignment(11) = 7:  .ColWidth(11) = 0
      
   End With
End Sub


Private Sub cmdBuscar()
   Dim cFecha As String
   
   Table1.Redraw = False
 
   cFecha = Format(TxtFecha.Text, FEFecha)
   
   If Not Bac_Sql_Execute("sp_cargaarbvcto", Array(cFecha)) Then
      
      MsgBox "Problemas al leer ", vbCritical, "MENSAJE"
      Exit Sub
   
   End If
   
   With Table1
      
      .Rows = 1
      
      Do While Bac_SQL_Fetch(Datos())
      
         BacControlWindows 100
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 1: .Text = Val(Datos(1))
         .Col = 2: .Text = Datos(2)
         .Col = 3: .Text = Datos(3)
         .Col = 4: .Text = Datos(4)                'Fecha Inicio
         .Col = 5: .Text = Datos(5)                'Fecha Vencimiento
         .Col = 6: .Text = BacFormatoMonto(CDbl(Datos(6)), 2)      'Monto M/X
         .Col = 7: .Text = BacFormatoMonto(CDbl(Datos(7)), 2)      'Monto USD
         .Col = 8: .Text = BacFormatoMonto(CDbl(Datos(8)), 6)      'Paridad Vencimiento
         .Col = 9: .Text = BacFormatoMonto(CDbl(Datos(9)), 6)      'Paridad Spot
         .Col = 10: .Text = BacFormatoMonto(CDbl(Datos(10)), 6)    'Paridad Forward
         .Col = 11: .Text = Datos(11)              'Moneda
         
      Loop
      
   End With
 
   If Table1.Rows < 2 Then
   
      Call CmdLimpiar
      MsgBox "No Hay Vencimientos de Arbitrajes para esa fecha", vbCritical, "MENSAJE"
      
   Else
   
      frame(1).Enabled = True
      Toolbar1.Buttons(3).Enabled = True
   
   End If
   
   Table1.Redraw = True

End Sub

Private Sub cmdGrabar()
   Dim sCadena As String
   Dim x
   MousePointer = 11
   
   sCadena = ""
   
   For x = 1 To Table1.Rows - 1
     
      Envia = Array( _
                     CDbl(Table1.TextMatrix(x, 1)), _
                     CDbl(Table1.TextMatrix(x, 8)) _
                   )

      sCadena = "Operación : " & Table1.TextMatrix(x, 1)
      sCadena = sCadena & " ,Paridad Vcto. : " & Table1.TextMatrix(x, 8)
      
      If Not Bac_Sql_Execute("sp_grabaparvcto", Envia) Then
         MsgBox "Error en la grabación", vbCritical, "MENSAJE"
         Call Graba_Log_Auditoria("Opc_50300", "09", "Problemas Procedimiento", "", "", sCadena)
         Exit Sub
         
      End If
      
      Call Graba_Log_Auditoria("Opc_50300", "01", "Grabar Paridad Vcto.", "", "", sCadena)
      
   Next
   
   MsgBox "Registros grabados en forma correcta", vbOKOnly + vbInformation
   
   MousePointer = 0

End Sub

Private Sub CmdLimpiar()
   
   Table1.Clear
   Table1.Rows = 2
   TxtFecha.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
   Toolbar1.Buttons(3).Enabled = False
   frame(1).Enabled = False
   
   Dibuja_Grilla
   
End Sub

Private Sub cmdSalir()
   Unload Me
End Sub


Private Sub Form_Load()
 
   Me.Icon = BACForward.Icon
   frame(1).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   TxtFecha.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
   
   Call Graba_Log_Auditoria("Opc_50300", "07", "Ingreso a Opción", "", "", "")
   
   Call Dibuja_Grilla
 
End Sub

Private Sub Form_Unload(Cancel As Integer)
        Call Graba_Log_Auditoria("Opc_50300", "08", "Salida de Opción", "", "", "")
        
End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)

   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii = 13 And KeyAscii = 8 Then
      KeyAscii = 0
   End If

   If Table1.Col = 8 And IsNumeric(Chr(KeyAscii)) Then

      Txt_Ingreso.Text = ""
      
      PROC_POSICIONA_TEXTO Table1, Txt_Ingreso
      
      Txt_Ingreso.Text = Chr(KeyAscii)
      Txt_Ingreso.Visible = True
      Txt_Ingreso.SetFocus
      Txt_Ingreso.SelStart = 1
      'SendKeys "{END}"

   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
   
      Case 1      '"CmdLimpiar"
         Call CmdLimpiar
      
      Case 2          '"cmdBuscar"
         Call cmdBuscar
         
      Case 3          '"cmdGrabar"
         Call cmdGrabar
      
      Case 4          '"cmdSalir"
         Call cmdSalir
   
   End Select
End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)

If KeyAscii = 27 Then
    
    Txt_Ingreso.Visible = False
    
    Table1.SetFocus
     
End If


KeyAscii = BacPunto(Txt_Ingreso, KeyAscii, 6, 6)

If KeyAscii = 13 Then
  
    If Trim(Txt_Ingreso.Text) = "" Then Exit Sub
   
    'table1.Text = bacformatomontot(val(Txt_Ingreso.Text), "#0.0000")
    Table1.Text = BacFormatoMonto(Val(Txt_Ingreso.Text), 6)
    
    Txt_Ingreso.Visible = False
    
    Table1.SetFocus
    
End If

End Sub

Private Sub TxtFecha_Change()

If TxtFecha.Text = "" Then
   TxtFecha.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
End If

End Sub

