VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Fax_Confirmacion 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Fax de Confirmación"
   ClientHeight    =   5145
   ClientLeft      =   1830
   ClientTop       =   2265
   ClientWidth     =   10995
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5145
   ScaleWidth      =   10995
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   1560
      Top             =   2790
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Fax_Confirmacion.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Fax_Confirmacion.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Fax_Confirmacion.frx":1DB4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool_menu 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   10995
      _ExtentX        =   19394
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar Operaciones"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Description     =   "Imprimir"
            Object.ToolTipText     =   "Interfaz Sinacofi"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   555
      Index           =   0
      Left            =   -15
      TabIndex        =   0
      Top             =   450
      Width           =   11010
      _Version        =   65536
      _ExtentX        =   19420
      _ExtentY        =   979
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
      Begin BACControles.TXTFecha txtFecInicio 
         Height          =   300
         Left            =   1995
         TabIndex        =   7
         Top             =   150
         Width           =   1440
         _ExtentX        =   2540
         _ExtentY        =   529
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "13/02/2001"
      End
      Begin VB.Label Label 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Fecha Consulta"
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
         Height          =   315
         Index           =   60
         Left            =   75
         TabIndex        =   1
         Top             =   150
         Width           =   1875
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   4185
      Index           =   1
      Left            =   -15
      TabIndex        =   2
      Top             =   960
      Width           =   11010
      _Version        =   65536
      _ExtentX        =   19420
      _ExtentY        =   7382
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
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   3990
         Left            =   60
         TabIndex        =   8
         Top             =   120
         Width           =   10875
         _ExtentX        =   19182
         _ExtentY        =   7038
         _Version        =   393216
         Cols            =   18
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         FocusRect       =   2
         HighLight       =   2
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
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
   Begin Threed.SSFrame Frame 
      Height          =   1680
      Index           =   3
      Left            =   3600
      TabIndex        =   3
      Top             =   6405
      Visible         =   0   'False
      Width           =   3450
      _Version        =   65536
      _ExtentX        =   6085
      _ExtentY        =   2963
      _StockProps     =   14
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   885
         Left            =   315
         ScaleHeight     =   825
         ScaleWidth      =   2760
         TabIndex        =   9
         Top             =   645
         Width           =   2820
      End
      Begin VB.Label lblLabel 
         Caption         =   "lblLabel(1)"
         Height          =   345
         Index           =   1
         Left            =   1815
         TabIndex        =   5
         Top             =   300
         Width           =   1305
      End
      Begin VB.Label lblLabel 
         BackColor       =   &H0080FFFF&
         Caption         =   "lblLabel(0)"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   0
         Left            =   315
         TabIndex        =   4
         Top             =   240
         Width           =   1305
      End
   End
End
Attribute VB_Name = "Fax_Confirmacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Function VerificaDia()
'--- Homologado el 08-09-2008 ---
   Tool_Menu.Buttons(3).Enabled = True 'False map 20080709 -- Para poder SALIR SIEMPRE
'--- Homologado el 08-09-2008 ---
   If Grd_Datos.Row <> 0 Then
      If Grd_Datos.TextMatrix(Grd_Datos.Row, 4) <> "" Then
         If CDate((Grd_Datos.TextMatrix(Grd_Datos.Row, 4))) = CDate((gsBAC_Fecp)) Then
            Tool_Menu.Buttons.Item(2).Enabled = True
         Else
'--- Homologado el 08-09-2008 ---
            Tool_Menu.Buttons.Item(2).Enabled = True 'map 20080709 -- Para poder generar igual
'--- Homologado el 08-09-2008 ---
         End If
         If CDate(Grd_Datos.TextMatrix(Grd_Datos.Row, 4)) = CDate(gsBAC_Fecp) Then
            Tool_Menu.Buttons(3).Enabled = True
         End If
      End If

    End If
End Function
Sub Dibuja_Grilla()

   With Grd_Datos
      .TextMatrix(0, 0) = ""
      .TextMatrix(0, 1) = "Producto"
      .TextMatrix(0, 2) = "Tipo Oper."
      .TextMatrix(0, 3) = "Operacion"
      .TextMatrix(0, 4) = "Fecha Oper."
      .TextMatrix(0, 5) = "Plazo"
      .TextMatrix(0, 6) = "Residual"
      .TextMatrix(0, 7) = "Fecha Vcto."
      .TextMatrix(0, 8) = "Mon Orig."
      .TextMatrix(0, 9) = "Monto Orig."
      .TextMatrix(0, 10) = "Precio"
      .TextMatrix(0, 11) = "Monto Conv."
      .TextMatrix(0, 12) = "Mon Conv."
      .TextMatrix(0, 13) = "Cliente"
      .TextMatrix(0, 14) = ""
      .TextMatrix(0, 15) = ""
      .TextMatrix(0, 16) = ""
      .TextMatrix(0, 17) = ""
      
      .RowHeight(0) = 500
      
      .ColAlignment(0) = 0:      .ColWidth(0) = 0
      .ColAlignment(1) = 1:      .ColWidth(1) = 2000
      .ColAlignment(2) = 1:      .ColWidth(2) = 0
      .ColAlignment(3) = 7:      .ColWidth(3) = 1000
      .ColAlignment(4) = 4:      .ColWidth(4) = 1500
      .ColAlignment(5) = 7:      .ColWidth(5) = 0
      .ColAlignment(6) = 7:      .ColWidth(6) = 0
      .ColAlignment(7) = 4:      .ColWidth(7) = 1500
      .ColAlignment(8) = 4:      .ColWidth(8) = 0
      .ColAlignment(9) = 7:      .ColWidth(9) = 0
      .ColAlignment(10) = 7:     .ColWidth(10) = 0
      .ColAlignment(11) = 7:     .ColWidth(11) = 0
      .ColAlignment(12) = 4:     .ColWidth(12) = 0
      .ColAlignment(13) = 1:     .ColWidth(13) = 5000
      .ColAlignment(14) = 1:     .ColWidth(14) = 0
      .ColAlignment(15) = 1:     .ColWidth(15) = 0
      .ColAlignment(16) = 1:     .ColWidth(16) = 0
      .ColAlignment(17) = 1:     .ColWidth(17) = 0
      .Rows = 1
   End With

End Sub

Sub PoVenLimpiar()
   
   Grd_Datos.Rows = 2
   
End Sub

Function PoVenHabilitarControles(valor As Boolean)

   txtFecInicio.Enabled = Not valor

End Function

Public Function LeerOperacionesSinacofi(cfecinicio As String) As Boolean

   'prd 19111 ini
    Dim nContFila       As Long
    Dim nContador       As Long
    Dim nColorCaja      As Variant
    Dim nColorFuente    As Variant
    Dim nColumna        As Long
    Dim C As Integer, r As Integer
   'prd 19111 fin
   
   Dim nPosicion     As Integer
   Dim nMoneda       As Integer
   Dim nRut          As Long
   Dim nOperacion    As Long
   Dim sTipOper      As String
   Dim i             As Integer
   Dim sPlaResi      As Integer
   Dim Datos()

   LeerOperacionesSinacofi = False
   Envia = Array()
   AddParam Envia, cfecinicio
   
   If Not Bac_Sql_Execute("SP_DATOS_FAX_CONFIRMA", Envia) Then
   
      MsgBox "Error en la lectura de Posicion por Vencimiento", vbExclamation, "MENSAJE"
      Exit Function

   End If

   With Grd_Datos
      .Rows = 1

      Do While Bac_SQL_Fetch(Datos())

         .Rows = .Rows + 1
         i = .Rows - 1

         .TextMatrix(i, 0) = ""
         .TextMatrix(i, 1) = Datos(1)                    ' Producto
         

         .TextMatrix(i, 2) = Datos(2)                    ' Tipo operación
         .TextMatrix(i, 3) = Datos(3)                    ' Nro Operacion
         .TextMatrix(i, 4) = Datos(4)                    ' Fecha Operacion
         .TextMatrix(i, 5) = Datos(5)  ' Plazo

         .TextMatrix(i, 6) = Datos(6)  ' Plazo Residual
         .TextMatrix(i, 7) = Datos(7)  'Format(Datos(4), "ddd, " + gsc_FechaDMA) ' Fecha de Vencimiento

         .TextMatrix(i, 13) = Datos(8)                ' Nombre Cliente
                           
         LeerOperacionesSinacofi = True
         
      Loop

      If LeerOperacionesSinacofi Then
      
         .Row = 1
         .Col = 1
      
      End If
     
   End With
   
         With Grd_Datos
            .Redraw = False
             For r = 1 To .Rows - 1 Step 1
             If BuscaComder(.TextMatrix(r, 3)) Then
             
                For C = 0 To .Cols - 1
                   .Col = C
                   .Row = r
                   .CellBackColor = vbCyan
                 Next C
             
             End If
             
             Next r
             .Redraw = True
             
         End With
   
End Function

Public Function BuscaComder(numope As Integer) As Boolean

'Dim numope As Integer
Dim EstadoOperComder As String

    'BuscaComder = False
    
    
             'numope = Grd_Datos.TextMatrix(Grd_Datos.Row, 3)
          
             Envia = Array()
             AddParam Envia, numope
             AddParam Envia, "PCS"
            If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_EstadoOperacion", Envia) Then
                MsgBox ("Error busca estado operacion")
            End If
            
            If Bac_SQL_Fetch(Datos()) Then
                EstadoOperComder = Datos(3)
            End If
            
            '--> Valida si es operacion Comder
            If UCase(EstadoOperComder) = "NO" Then
               BuscaComder = True
            Else
                BuscaComder = False
            End If


    
    
End Function
Private Sub cmdBuscar()

If LeerOperacionesSinacofi(txtFecInicio.Text) = False Then
   PoVenLimpiar
   MsgBox "No existen datos para esta fecha.", vbCritical
   'cmdImprimir.Enabled = False
Else
   Grd_Datos.SetFocus
   Tool_Menu.Buttons(2).Enabled = True
End If

End Sub

Private Sub cmdImprimir()

Call BacLimpiaParamCrw
  
BACSwap.Crystal.WindowTitle = "Confirmación Operaciones SWAP"
BACSwap.Crystal.ReportFileName = gsRPT_Path & "Confirmacion_SWAP_PROMEDIO_CAMARA.rpt"
                '--> Store Procedure : dbo.SP_CONFIRMA_SWAP_ICP
BACSwap.Crystal.StoredProcParam(0) = Grd_Datos.TextMatrix(Grd_Datos.Row, 3)
BACSwap.Crystal.StoredProcParam(1) = gsBAC_User
BACSwap.Crystal.Destination = crptToWindow
BACSwap.Crystal.Connect = swConeccion
BACSwap.Crystal.Action = 1
  
End Sub

Private Sub Form_Load()

   Dim nCol    As Integer
   
   Me.Icon = BACSwap.Icon
   Dibuja_Grilla
   
   Screen.MousePointer = 11

   Me.Move 0, 0

   '********************************************************
   '* Seteo de la fecha de inicio
   '********************************************************

   txtFecInicio.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)

   '********************************************************
   '* Proceso para Cargar Cartera Vigente
   '********************************************************
   txtFecInicio.Enabled = True
   Tool_Menu.Buttons(2).Enabled = False
   
   txtFecInicio.Text = gsc_Parametros.fechaproc
   
   Screen.MousePointer = 0
   
End Sub

Private Sub Grd_Datos_EnterCell()
 VerificaDia
End Sub

Private Sub Tool_menu_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim numope As Integer
Dim EstadoOperComder As String
Select Case Button.Key
    Case "Buscar"
        Call cmdBuscar
    Case "Imprimir"
        'prd19111 ini
            numope = Grd_Datos.TextMatrix(Grd_Datos.Row, 3)
      
             Envia = Array()
             AddParam Envia, numope
             AddParam Envia, "PCS"
            If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_EstadoOperacion", Envia) Then
                MsgBox ("Error busca estado operacion")
            End If
            
            If Bac_SQL_Fetch(Datos()) Then
                EstadoOperComder = Datos(3)
            End If
        
            '--> Valida si es operacion Comder
            If UCase(EstadoOperComder) = "NO" Then
               MsgBox ("Operacion Comder , no Aplica Confirmación")
               Exit Sub
            End If
        'prd19111 fin
        Call cmdImprimir
    Case "Salir"
        Unload Me
    End Select
  End Sub

Private Sub txtFecInicio_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub

