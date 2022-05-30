VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacSinacofi 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Interfaz Sinacofi"
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
            Picture         =   "bacsinac.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacsinac.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacsinac.frx":1DB4
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
      Begin MSFlexGridLib.MSFlexGrid Table1 
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
Attribute VB_Name = "BacSinacofi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Sub Dibuja_Grilla()

   With Table1
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
      .ColAlignment(2) = 1:      .ColWidth(2) = 2000
      .ColAlignment(3) = 7:      .ColWidth(3) = 1000
      .ColAlignment(4) = 4:      .ColWidth(4) = 1500
      .ColAlignment(5) = 7:      .ColWidth(5) = 800
      .ColAlignment(6) = 7:      .ColWidth(6) = 800
      .ColAlignment(7) = 4:      .ColWidth(7) = 1500
      .ColAlignment(8) = 4:      .ColWidth(8) = 0
      .ColAlignment(9) = 7:      .ColWidth(9) = 0
      .ColAlignment(10) = 7:     .ColWidth(10) = 0
      .ColAlignment(11) = 7:     .ColWidth(11) = 0
      .ColAlignment(12) = 4:     .ColWidth(12) = 0
      .ColAlignment(13) = 1:     .ColWidth(13) = 3000
      .ColAlignment(14) = 1:     .ColWidth(14) = 0
      .ColAlignment(15) = 1:     .ColWidth(15) = 0
      .ColAlignment(16) = 1:     .ColWidth(16) = 0
      .ColAlignment(17) = 1:     .ColWidth(17) = 0
      .Rows = 1
   End With

End Sub

Sub PoVenLimpiar()
   
   Table1.Rows = 2
   
End Sub

Function PoVenHabilitarControles(Valor As Boolean)

   txtFecInicio.Enabled = Not Valor

End Function

Public Function LeerOperacionesSinacofi(cfecinicio As String) As Boolean

   Dim nPosicion     As Integer
   Dim nMoneda       As Integer
   Dim nRut          As Long
   Dim nOperacion    As Long
   Dim sTipOper      As String
   Dim I             As Integer
   Dim sPlaResi      As Integer
   Dim Datos()

   LeerOperacionesSinacofi = False
   Envia = Array()
   AddParam Envia, cfecinicio
   
   If Not Bac_Sql_Execute("SP_LEE_OPERACIONES", Envia) Then
   
      MsgBox "Error en la lectura de Posicion por Vencimiento", vbExclamation, "MENSAJE"
      Exit Function

   End If

   With Table1
      .Rows = 1

      Do While Bac_SQL_Fetch(Datos())

         .Rows = .Rows + 1
         I = .Rows - 1

         .TextMatrix(I, 0) = Datos(1)
         .TextMatrix(I, 1) = Datos(1)                    ' Producto
         
         
         .TextMatrix(I, 2) = Datos(2)                    ' Tipo operación
         .TextMatrix(I, 3) = Datos(3)                    ' Nro Operacion
         .TextMatrix(I, 4) = Datos(4)                    ' Fecha Operacion
         .TextMatrix(I, 5) = Datos(5)  ' Plazo

         .TextMatrix(I, 6) = Datos(6)  ' Plazo Residual
         .TextMatrix(I, 7) = Datos(7)  'Format(Datos(4), "ddd, " + gsc_FechaDMA) ' Fecha de Vencimiento

         .TextMatrix(I, 13) = Datos(8)                ' Nombre Cliente
                           
         LeerOperacionesSinacofi = True
         
      Loop

      If LeerOperacionesSinacofi Then
      
         .Row = 1
         .Col = 1
      
      End If
     
   End With
   
End Function


Private Sub cmdBuscar()

If LeerOperacionesSinacofi(txtFecInicio.Text) = False Then
   PoVenLimpiar
   MsgBox "No existen datos para esta fecha.", vbCritical
   'cmdImprimir.Enabled = False
Else
   Table1.SetFocus
   Tool_menu.Buttons(2).Enabled = True
End If

End Sub

Private Sub cmdImprimir()

   Dim iLin       As Integer
   Dim SQL        As String
  
  If Table1.Rows - 1 < 1 Then
      MsgBox ("No Existen Operaciones"), vbOKOnly + vbExclamation
  Else
      nNumoper = Table1.TextMatrix(Table1.Row, 3)
      BacInterfaces.Interfaz = "Interfaz Sinacofi"
      BacInterfaces.Tag = "Interfaz Sinacofi"
      BacInterfaces.Show vbNormal
  End If

End Sub

Private Sub Form_Activate()

MsgBox "Opcion en contruccion... ", vbCritical
Unload Me

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
   Tool_menu.Buttons(2).Enabled = False
   
   txtFecInicio.Text = gsc_Parametros.fechaproc
   
   Screen.MousePointer = 0
   
End Sub

Private Sub Tool_menu_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
    Case "Buscar"
        Call cmdBuscar
    Case "Imprimir"
    
        If Trim(Table1.TextMatrix(Table1.Row, 2)) <> "VARIABLE/FIJA" Then MsgBox "Esta operación No genera Mensaje para Sinacofi.", vbCritical: Exit Sub
        
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

