VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Baccorrespon 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Corresponsales"
   ClientHeight    =   3750
   ClientLeft      =   2445
   ClientTop       =   2265
   ClientWidth     =   7770
   Icon            =   "Baccorrespon.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3750
   ScaleWidth      =   7770
   Begin VB.TextBox txtgrilla2 
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
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   50
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   2130
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox TXTGRILLA 
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
      Height          =   315
      Left            =   3630
      MaxLength       =   15
      TabIndex        =   17
      TabStop         =   0   'False
      Top             =   3105
      Width           =   1500
   End
   Begin VB.ComboBox cmb_plaza 
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
      Height          =   330
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   2130
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.ComboBox cmb_pais 
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
      Height          =   330
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   3105
      Visible         =   0   'False
      Width           =   1500
   End
   Begin BACControles.TXTFecha txtFecha1 
      Height          =   315
      Left            =   2130
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   2460
      Visible         =   0   'False
      Width           =   1500
      _ExtentX        =   2646
      _ExtentY        =   556
      BackColor       =   8388608
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
      ForeColor       =   16777215
      MaxDate         =   2958465
      MinDate         =   -328716
      Text            =   "20/02/2001"
   End
   Begin VB.ComboBox cmb_Moneda 
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
      Height          =   330
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   1815
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.ComboBox cmbBANCE 
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
      Height          =   330
      ItemData        =   "Baccorrespon.frx":2EFA
      Left            =   2130
      List            =   "Baccorrespon.frx":2F04
      Style           =   2  'Dropdown List
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   2775
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtgrilla3 
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
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   20
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   1830
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtgrilla4 
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
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   11
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   2460
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   3630
      TabIndex        =   16
      TabStop         =   0   'False
      Top             =   2775
      Visible         =   0   'False
      Width           =   1500
   End
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
      ForeColor       =   &H00800000&
      Height          =   915
      Left            =   15
      TabIndex        =   1
      Top             =   525
      Width           =   7725
      Begin VB.TextBox TxtDv 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2520
         TabIndex        =   20
         Top             =   210
         Width           =   285
      End
      Begin BACControles.TXTNumero txtCODIGO 
         Height          =   315
         Left            =   6300
         TabIndex        =   2
         Top             =   210
         Width           =   990
         _ExtentX        =   1746
         _ExtentY        =   556
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
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TXTRUT 
         Height          =   315
         Left            =   945
         TabIndex        =   0
         Top             =   210
         Width           =   1440
         _ExtentX        =   2540
         _ExtentY        =   556
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "999999999"
      End
      Begin VB.TextBox txtnombre 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   945
         TabIndex        =   4
         Top             =   540
         Width           =   6345
      End
      Begin VB.Line Line1 
         X1              =   2415
         X2              =   2475
         Y1              =   345
         Y2              =   345
      End
      Begin VB.Label Label6 
         Caption         =   "Nombre"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   165
         TabIndex        =   19
         Top             =   570
         Width           =   840
      End
      Begin VB.Label Label1 
         Caption         =   "Rut"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   330
         Left            =   150
         TabIndex        =   15
         Top             =   255
         Width           =   705
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Codigo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   210
         Left            =   5535
         TabIndex        =   12
         Top             =   240
         Width           =   585
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   2175
      Left            =   60
      TabIndex        =   3
      Top             =   1500
      Width           =   7605
      _ExtentX        =   13414
      _ExtentY        =   3836
      _Version        =   393216
      Rows            =   3
      FixedRows       =   2
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483638
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483634
      BackColorSel    =   8388608
      BackColorBkg    =   12632256
      GridColor       =   0
      FocusRect       =   0
      GridLines       =   2
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
   Begin VB.Frame Frame2 
      Height          =   2355
      Left            =   15
      TabIndex        =   13
      Top             =   1365
      Width           =   7725
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   7770
      _ExtentX        =   13705
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   8
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "Baccorrespon.frx":2F10
      OLEDropMode     =   1
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   6420
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccorrespon.frx":322A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccorrespon.frx":3691
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccorrespon.frx":3B87
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccorrespon.frx":401A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Baccorrespon.frx":4502
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Baccorrespon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public BUS
Public Pais
Public Escape
Public paisactivo
Public SWGRA
Dim OptLocal As String
Dim colpress As Long
Dim rowpress, Cont As Long
Dim inicio, i, SW2, CmbKey As Integer

 Private Sub Buscar()
  
  Dim Datos(), Datos1()
  Dim i As Integer
  Dim SW As Integer
  Dim Sql As String
  
  
   var1 = CDbl(txtRut.Text)
   VAR2 = Val(txtCodigo.Text)
   
   Sql = "sp_corresponsales_buscar " & var1 & "," & VAR2
   SW = 0
     
   Toolbar1.Buttons(4).Enabled = False
   txtRut.Enabled = False
   txtCodigo.Enabled = False
   TxtNombre.Enabled = False

   
With Grid
    
   .Enabled = True
   .Rows = 3
   .Row = 2
   
   
   Envia = Array()
   AddParam Envia, CDbl(txtRut.Text)
   AddParam Envia, Val(txtCodigo.Text)
   
   .Rows = 2
   
   If BAC_SQL_EXECUTE("sp_corresponsales_buscar ", Envia) And SW = 0 Then
     .Enabled = True
     
     Do While BAC_SQL_FETCH(Datos())
         SW = 1
         TxtNombre.Text = Datos(13)
         .Rows = .Rows + 1
         .TextMatrix(.Rows - 1, 1) = Datos(10) + Space(50) + Datos(1)
         .TextMatrix(.Rows - 1, 2) = Datos(11) + Space(50) + Datos(2)
         .TextMatrix(.Rows - 1, 3) = Datos(12) + Space(50) + Datos(3)
         .TextMatrix(.Rows - 1, 4) = Datos(4)
         .TextMatrix(.Rows - 1, 5) = Datos(5)
         .TextMatrix(.Rows - 1, 6) = Datos(6)
         .TextMatrix(.Rows - 1, 7) = Datos(7)
         .TextMatrix(.Rows - 1, 8) = IIf(Datos(8) = "N", "NO", "SI")
         .TextMatrix(.Rows - 1, 9) = Datos(9)
         .TextMatrix(.Rows - 1, 10) = IIf(Datos(14) = "N", "NO", "SI")
         .TextMatrix(.Rows - 1, 11) = Datos(15)
         
         Toolbar1.Buttons(3).Enabled = True
      Loop
                 
  End If
  
End With
 
If SW = 0 Then
     If BUS = 1 Then
         SWGRA = 1
         txtRut.Enabled = False
         txtCodigo.Enabled = False
         TxtNombre.Enabled = False


         Grid.Rows = 3
         Grid.Enabled = True
         Grid.Col = 1
         On Error Resume Next
         Grid.SetFocus
         On Error GoTo 0
     Else
        Dim f As Integer
          Call Limpiar
          txtRut.Enabled = True
          On Error Resume Next
          txtRut.SetFocus
          On Error GoTo 0
          txtCodigo.Enabled = False

        
    End If
Else
    SWGRA = 2
     
      Grid.Col = 1
      Grid.Row = Grid.FixedRows
      On Error Resume Next
      Grid.SetFocus
      On Error GoTo 0
      
      
      
  End If
  
If KeyCode = 46 Then
  Toolbar1.Buttons(4).Enabled = True
  Call Eliminar
End If

End Sub
Sub Cargar_Grilla()
    
    SW = 0
    Grid.Clear
    Grid.Rows = 3
    Grid.Cols = 12
    Grid.FixedRows = 2
    Grid.FixedCols = 0
    Grid.TextMatrix(0, 1) = "Moneda"
    Grid.TextMatrix(0, 2) = "Pais"
    Grid.TextMatrix(0, 3) = "Plaza "
    Grid.TextMatrix(0, 4) = "Codigo"
    Grid.TextMatrix(1, 4) = "Swift"
    Grid.TextMatrix(0, 5) = "Nombre"
    Grid.TextMatrix(0, 6) = "Cuenta "
    Grid.TextMatrix(1, 6) = "Corriente "
    Grid.TextMatrix(0, 7) = "Swift"
    Grid.TextMatrix(1, 7) = "Santiago"
    Grid.TextMatrix(0, 8) = "Banco"
    Grid.TextMatrix(1, 8) = "Central"
    Grid.TextMatrix(0, 9) = "Fecha"
    Grid.TextMatrix(1, 9) = "Venci."
    Grid.TextMatrix(0, 10) = "Defecto"
    Grid.TextMatrix(0, 11) = "Código Contable"
    
    Grid.ColWidth(0) = 0
    
    Grid.ColWidth(1) = 1000
    Grid.ColWidth(2) = 2500
    Grid.ColWidth(3) = 1300
    Grid.ColWidth(4) = 1300
    Grid.ColWidth(5) = 4000
    Grid.ColWidth(6) = 2000
    Grid.ColWidth(7) = 1300
    Grid.ColWidth(8) = 1300
    Grid.ColWidth(9) = 1300
    Grid.ColWidth(10) = 1100
    Grid.ColWidth(11) = 1500
    Grid.ColAlignment(11) = 1
    Grid.FixedRows = 2
    Grid.RowHeightMin = 315
   
End Sub

Function FUNC_Chequea_Repetido(sTipo As String) As Boolean
Dim nContador   As Long
Dim nValida     As Integer

With Grid
    
    For nContador = 1 To .Rows - 1
        If UCase(Grid.TextMatrix(nContador, 10)) = "SI" And UCase(Grid.TextMatrix(nContador, 1)) = sTipo Then
            nValida = nValida + 1
        End If
    Next
    
    FUNC_Chequea_Repetido = (nValida < 1)
    
End With

End Function

Private Sub Cmb_Moneda_DblClick()
   
    cmb_Moneda_KeyPress 13
    CmbKey = 0

End Sub

Private Sub cmb_Moneda_GotFocus()

    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TxtGrilla.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub cmb_Moneda_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode

End Sub

Private Sub cmb_Moneda_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And cmb_Moneda <> "" Then
   
   Dim Ind, Sub_ind As Integer
   Dim Busq As String
     
   Text1.Text = ""
   Text1.Text = cmb_Moneda
   Busq = Text1.Text
      
  
   If Grid.Rows > 3 Then
          
          Grid.Text = Busq
          
          If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                
                MsgBox "Moneda No se Puede Repetir", vbCritical
                cmb_Moneda_KeyPress (27)
                
                Exit Sub
          Else
            
                cmb_Moneda.Tag = cmb_Moneda.Text
          
          End If
          

   End If
  
  
End If


    If KeyAscii = 27 Then
         
         cmb_Moneda.Visible = False
         On Error Resume Next
         Grid.SetFocus
         On Error GoTo 0
         
    End If
    
    If KeyAscii = 13 Then
    On Error GoTo fin
        Grid.Text = cmb_Moneda.Text
        cmb_Moneda.Visible = False

        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
    End If
    
fin:
End Sub


Private Sub cmb_Moneda_LostFocus()

    If cmb_Moneda.Visible = True Then
        
        cmb_Moneda.Visible = False
         
    
    End If
    
End Sub


Private Sub cmb_pais_DblClick()

    cmb_pais_KeyPress (13)
    CmbKey = 0

End Sub

Private Sub cmb_pais_GotFocus()

    paisactivo = 1
    
    
    Pais = 0
    Escape = 0
    cmb_Moneda.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TxtGrilla.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub


Private Sub cmb_pais_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode

End Sub

Private Sub cmb_pais_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And cmb_pais <> "" Then

  Dim Ind1, Sub_ind1 As Integer

  Dim Busq1 As String
     
   Grid.TextMatrix(Grid.Row, Grid.Col + 1) = ""
   Text1.Text = ""
   Text1.Text = cmb_pais
   Busq1 = Text1.Text
   Grid.Text = ""
   If Grid.Rows > 3 Then
        
          Cont = 1
            
          Grid.Text = Busq1
        
          If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                
                MsgBox "Pais No se Puede Repetir", vbCritical
                cmb_pais_KeyPress (27)
                
                Exit Sub

          End If
        
   End If

         Grid.Text = cmb_pais + Space(50) + Trim(right(cmb_pais.Text, 50))
            
         If BAC_SQL_EXECUTE("Sp_corresponsales_cmbplaza") Then
         
            cmb_plaza.Clear
            
            Do While BAC_SQL_FETCH(Datos())
             
             If Trim(right(Grid.TextMatrix(Grid.Row, Grid.Col), 50)) = Datos(3) Then 'cmb_pais.ItemData(cmb_pais.ListIndex) = datos(3)
                
                cmb_plaza.AddItem Datos(2) + Space(50) + Datos(1)
                cmb_plaza.ItemData(cmb_plaza.NewIndex) = Datos(1)
                
             End If
            
            Loop
          
          End If
        

End If

If KeyAscii = 27 Then
  
   cmb_pais.Visible = False
   On Error Resume Next
   Grid.SetFocus
   On Error GoTo 0
 End If



If KeyAscii = 13 Then


    If Grid.Col = 2 Or Grid.Col = 3 Then
        
        If cmb_plaza.ListCount = 0 And Escape <> 1 Then
          
          MsgBox "Pais No contiene Plazas,Seleccione otro Pais", vbExclamation
           
          SW2 = 1
          Pais = 1
          Grid.Col = 3
          Grid.Text = ""
    
           On Error Resume Next
           Grid.SetFocus
           On Error GoTo 0
           
           Grid.Col = 2
           cmb_pais.Visible = True
           On Error Resume Next
           cmb_pais.SetFocus
           On Error GoTo 0
        Else
            
           cmb_pais.Tag = Grid.Text
           Grid.Text = cmb_pais.Text
           cmb_pais.Visible = False

           Grid.SetFocus
            
        End If
    
    End If


End If

On Error Resume Next
Grid.SetFocus
On Error GoTo 0
End Sub

Private Sub cmb_pais_LostFocus()
  
If cmb_pais.Visible = True Then
   
   cmb_pais.Visible = False
   Grid.Col = 2
   Grid.Text = cmb_pais.Tag
   On Error Resume Next
   Grid.SetFocus
   On Error GoTo 0
End If

End Sub

Private Sub cmb_plaza_DblClick()

    cmb_plaza_KeyPress (13)
    
    CmbKey = 0

End Sub

Private Sub cmb_plaza_GotFocus()
  
    If Grid.Col = 2 And Grid.Text = "" And cmb_plaza.ListCount = 0 Then
         
       MsgBox "Se Requiere de un Pais ", vbInformation
       On Error Resume Next
       Grid.SetFocus
       On Error GoTo 0
       cmb_plaza.Visible = False
    
    End If
    
    cmb_pais.Visible = False
    cmb_Moneda.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TxtGrilla.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub cmb_plaza_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode
   CmbKey = 0

End Sub

Private Sub cmb_plaza_KeyPress(KeyAscii As Integer)
 
    If KeyAscii = 27 Then
       
       cmb_plaza.Visible = False
       On Error Resume Next
       Grid.SetFocus
       On Error GoTo 0
    End If

   If KeyAscii = 13 Then
        
        Grid.Text = cmb_plaza.Text
        
        If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then

            MsgBox "No se puede repetir la plaza", vbExclamation
            cmb_plaza_KeyPress (27)
            
        Else
            
            cmb_plaza.Tag = Grid.Text
            cmb_plaza.Visible = False
            Grid.Text = cmb_plaza + Space(50) + Trim(right(cmb_plaza.Text, 50))
            On Error Resume Next
            Grid.SetFocus
            On Error GoTo 0
        End If

        On Error Resume Next

        Grid.SetFocus
        On Error GoTo 0
        
    End If
 
End Sub


Private Sub cmb_plaza_LostFocus()

    If cmb_plaza.Visible = True Then
    
        cmb_plaza.Visible = False
    
    End If

End Sub

Private Sub cmbBANCE_DblClick()

    cmbBANCE_KeyPress (13)
    CmbKey = 0

End Sub

Private Sub cmbBANCE_GotFocus()

cmb_pais.Visible = False
cmb_plaza.Visible = False
cmb_Moneda.Visible = False
txtFecha1.Visible = False
TxtGrilla.Visible = False
txtgrilla2.Visible = False
txtgrilla3.Visible = False
txtgrilla4.Visible = False

End Sub

Private Sub cmbBANCE_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode

End Sub

Private Sub cmbBANCE_KeyPress(KeyAscii As Integer)
Dim i As Integer
Dim lSw     As Boolean

    If KeyAscii = 13 And cmbBANCE <> "" Then
       
       cmbBANCE.Visible = False
             
             
       If IIf(UCase(cmbBANCE.Text) = "SI", FUNC_Chequea_Repetido(Grid.TextMatrix(Grid.Row, 1)), True) Then
                   Grid.TextMatrix(Grid.Row, Grid.Col) = cmbBANCE.Text
       Else
           MsgBox "No pueden existir dos corresponsales por defecto", vbExclamation
       End If
       
       On Error Resume Next
       Grid.SetFocus
       On Error GoTo 0
    End If

   If KeyAscii = 27 Then
        
        cmbBANCE.Visible = False
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
   End If
End Sub


Private Sub cmbBANCE_LostFocus()

    If cmbBANCE.Visible = True Then

        cmbBANCE.Visible = False
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
    End If


End Sub


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer

   opcion = 0

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode

           Case vbKeyLimpiar:
                              opcion = 1
   
            Case vbKeyGrabar:
                              opcion = 2
            Case vbKeyEliminar:
                              opcion = 3
            Case vbKeyBuscar:
                              opcion = 4
                              
            Case vbKeySalir:
                           If left(UCase(Me.ActiveControl.Name), 9) <> "TXTGRILLA" And _
                           UCase(Me.ActiveControl.Name) <> "TXTFECHA1" Then
                              opcion = 5
                           End If
                      
      End Select

      If opcion <> 0 Then
            If Toolbar1.Buttons(opcion).Enabled Then
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
            End If
   
            KeyCode = 0
      End If
    
      
   End If
Exit Sub
err:
  Resume Next


End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Grid_EnterCell()
 
 
If Grid.Col = 3 Then
 
  cmb_plaza.Clear
 
     If BAC_SQL_EXECUTE("Sp_corresponsales_cmbplaza") Then
        
        Do While BAC_SQL_FETCH(Datos())
         
         If Trim(right(Grid.TextMatrix(Grid.Row, Grid.Col - 1), 50)) = Datos(3) Then 'cmb_pais.ItemData(cmb_pais.ListIndex) = datos(3)
            
            cmb_plaza.AddItem Datos(2) + Space(50) + Datos(1)
            cmb_plaza.ItemData(cmb_plaza.NewIndex) = Datos(1)
            
         End If
        
        Loop
      
      End If
   
 
End If
 
End Sub

Private Sub Grid_DblClick()

    Toolbar1.Buttons(2).Enabled = True

    If Grid.Col = 1 Then
         cmb_Moneda.top = Grid.CellTop + Grid.top
         cmb_Moneda.left = Grid.CellLeft + Grid.left + 20
         cmb_Moneda.Width = Grid.CellWidth - 20
         Call Valor_Combo(cmb_Moneda)
         cmb_Moneda.Visible = True
         On Error Resume Next
         cmb_Moneda.SetFocus
         On Error GoTo 0
    End If
   If Grid.Col = 2 Then
         cmb_pais.top = Grid.CellTop + Grid.top
         cmb_pais.left = Grid.CellLeft + Grid.left + 20
         cmb_pais.Width = Grid.CellWidth - 20
         Call Valor_Combo(cmb_pais)
         cmb_pais.Visible = True
         On Error Resume Next
         cmb_pais.SetFocus
         On Error GoTo 0
   End If
    If Grid.Col = 3 Then
        cmb_plaza.top = Grid.CellTop + Grid.top
        cmb_plaza.left = Grid.CellLeft + Grid.left + 20
        cmb_plaza.Width = Grid.CellWidth - 20
        Call Valor_Combo(cmb_plaza)
        cmb_plaza.Visible = True
        On Error Resume Next
        cmb_plaza.SetFocus
        On Error GoTo 0
    End If
   If Grid.Col = 4 Then
         
         
         TxtGrilla.Height = Grid.CellHeight
         TxtGrilla.top = Grid.CellTop + Grid.top
         TxtGrilla.left = Grid.CellLeft + Grid.left + 20
         TxtGrilla.Width = Grid.CellWidth - 20
         TxtGrilla.Visible = True
         On Error Resume Next
         TxtGrilla.SetFocus
         On Error GoTo 0
   End If
   If Grid.Col = 5 Then
        txtgrilla2.Height = Grid.CellHeight
         txtgrilla2.top = Grid.CellTop + Grid.top
         txtgrilla2.left = Grid.CellLeft + Grid.left + 20
         txtgrilla2.Width = Grid.CellWidth - 20
         txtgrilla2.Visible = True
         On Error Resume Next
         txtgrilla2.SetFocus
         On Error GoTo 0
   End If
      If Grid.Col = 6 Then
         txtgrilla3.Height = Grid.CellHeight
         txtgrilla3.top = Grid.CellTop + Grid.top
         txtgrilla3.left = Grid.CellLeft + Grid.left + 20
         txtgrilla3.Width = Grid.CellWidth - 20
         txtgrilla3.Visible = True
         On Error Resume Next
         txtgrilla3.SetFocus
         On Error GoTo 0
    End If

   If Grid.Col = 7 Then
    txtgrilla4.Height = Grid.CellHeight
         txtgrilla4.top = Grid.CellTop + Grid.top
         txtgrilla4.left = Grid.CellLeft + Grid.left + 20
         txtgrilla4.Width = Grid.CellWidth - 20
         txtgrilla4.Visible = True
         On Error Resume Next
         txtgrilla4.SetFocus
         On Error GoTo 0
   End If
   If Grid.Col = 8 Then
        cmbBANCE.top = Grid.CellTop + Grid.top
         cmbBANCE.left = Grid.CellLeft + Grid.left + 20
         cmbBANCE.Width = Grid.CellWidth - 20
         cmbBANCE = "NO"
         cmbBANCE.Visible = True
         On Error Resume Next
         cmbBANCE.SetFocus
         On Error GoTo 0
   End If
   If Grid.Col = 9 Then

         txtFecha1.Height = Grid.CellHeight
        txtFecha1.top = Grid.CellTop + Grid.top
         txtFecha1.left = Grid.CellLeft + Grid.left + 20
         txtFecha1.Width = Grid.CellWidth - 20
         txtFecha1.Visible = True
         On Error Resume Next
         txtFecha1.SetFocus
         On Error GoTo 0
   End If

   If Grid.Col = 10 Then
   
         cmbBANCE.top = Grid.CellTop + Grid.top
         cmbBANCE.left = Grid.CellLeft + Grid.left + 20
         cmbBANCE.Width = Grid.CellWidth - 20
         cmbBANCE.Visible = True
         On Error Resume Next
         cmbBANCE.SetFocus
         On Error GoTo 0
         cmbBANCE.Text = IIf(Grid.Text = "" Or Grid.Text = "NO", "NO", "SI")
         
   End If


End Sub

Private Sub Grid_GotFocus()
    
    
    Toolbar1.Buttons(4).Enabled = False
    
End Sub

Private Sub Grid_KeyUp(KeyCode As Integer, Shift As Integer)
On Error GoTo ErrorF:
    If inicio = 1 Then
    
        Grid.Col = colpress
        Grid.Row = rowpress
        Grid.ColSel = colpress

    End If

    inicio = 1
ErrorF:
End Sub

Private Sub Grid_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    If inicio = 1 Then
    
        colpress = Grid.Col
        rowpress = Grid.Row
        Grid.ColSel = colpress
    
    End If

End Sub

Private Sub Grid_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Error GoTo fin:
    If inicio = 1 Then
    
        Grid.Col = colpress
        Grid.Row = rowpress
        Grid.ColSel = colpress
    
    End If
    
    inicio = 1
    
fin:
End Sub

Private Sub Grid_Scroll()
    
    cmb_Moneda.Visible = False
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TxtGrilla.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub txtCodigo_DblClick()

   Call txtRut_DblClick

End Sub

Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyAyuda Then
      Call txtRut_DblClick
      Exit Sub
   
   End If
   
   
   If KeyCode = 13 And txtCodigo.Text <> "" Then

      Envia = Array()
      
      AddParam Envia, CDbl(Me.txtRut.Text)
      AddParam Envia, ""
      AddParam Envia, CDbl(Me.txtCodigo.Text)
      
            
      If Not BAC_SQL_EXECUTE("sp_mdclleerrut", Envia) Then
          
          MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical
          Exit Sub
      
      End If
         
          
      If BAC_SQL_FETCH(Datos()) Then
         Me.TxtNombre.Text = Datos(4)
         BUS = 1
         Call Buscar
         TxtNombre.Enabled = False
      Else
         MsgBox "Cliente No Existe", vbInformation
         Me.txtRut.Text = ""
         Me.txtCodigo.Text = ""
         TxtDv.Text = ""
         Me.txtRut.SetFocus
               
      End If
   End If
End Sub

Private Sub TXTFecha1_Change()

          On Error GoTo fin:
          Grid.Col = 9
          txtFecha1.Tag = Grid.Text
          Grid.Text = txtFecha1.Text
            
          Cont = 0

          If Format(Grid.Text, "yyyy") > Format(Date, "yyyy") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") = Format(Date, "mm") And Format(Grid.Text, "dd") >= Format(Date, "dd") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") > Format(Date, "mm") Then Cont = 1
          
          If Cont = 0 Then
                
                Grid.Text = txtFecha1.Tag
                txtFecha1.Text = txtFecha1.Tag
                
          End If
 

 
fin:


End Sub

Private Sub txtFecha1_GotFocus()

    If Grid.Text <> "" Then
    
        txtFecha1.Text = Grid.Text
    
    End If
    
    
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    cmb_Moneda.Visible = False
    TxtGrilla.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub txtFecha1_KeyPress(KeyAscii As Integer)

If KeyAscii = 45 Then
      If Campos_Blancos = 0 Then
        Grid.Col = 1
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
      Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
      End If
Else
  
      If KeyAscii = 27 And Grid.Col = 9 Then
           Grid.Col = 9
             txtFecha1.Visible = False
           On Error Resume Next
           Grid.SetFocus
           On Error GoTo 0
                          
      End If
      If KeyAscii = 13 Then
      On Error GoTo fin:
          Grid.Col = 9
          txtFecha1.Tag = Grid.Text
          txtFecha1.Visible = False
          Grid.Text = txtFecha1.Text
          On Error Resume Next
          Grid.SetFocus
          On Error GoTo 0
          Cont = 0

          If Format(Grid.Text, "yyyy") > Format(Date, "yyyy") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") = Format(Date, "mm") And Format(Grid.Text, "dd") >= Format(Date, "dd") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") > Format(Date, "mm") Then Cont = 1
          
            
          If Cont <> 1 Then
              MsgBox "Error Fecha de Vencimiento Debe ser Mayor o Igual a la Fecha Actual", vbInformation
              txtFecha1.Visible = True
              Grid.Text = txtFecha1.Tag
              On Error Resume Next
              txtFecha1.SetFocus
              On Error GoTo 0
          End If
          
       End If
  
 End If

 
fin:
End Sub

Private Sub txtFecha1_LostFocus()

    
    txtFecha1.Text = Grid.TextMatrix(Grid.Row, 9)
    
    If txtFecha1.Visible = True Then
    
        txtFecha1.Visible = False
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
    End If
    

End Sub

Private Sub TXTGRILLA_GotFocus()

    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    cmb_Moneda.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub TxtGrilla_LostFocus()
       
If TxtGrilla.Visible = True Then

       TxtGrilla.Visible = False
       TxtGrilla.Tag = TxtGrilla.Text
  
      On Error Resume Next
      Grid.SetFocus
      On Error GoTo 0
End If

End Sub

Private Sub txtgrilla2_GotFocus()

    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TxtGrilla.Visible = False
    cmb_Moneda.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub txtgrilla2_LostFocus()
 
  If txtgrilla2.Visible = True Then
        
        txtgrilla2.Visible = False
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
  End If

End Sub

Private Sub txtgrilla3_GotFocus()

    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TxtGrilla.Visible = False
    txtgrilla2.Visible = False
    cmb_Moneda.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub txtgrilla3_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
KeyAscii = Caracter(KeyAscii)

If SW2 = 1 Then

    KeyAscii = 0

End If


  If KeyCode = 45 Then
      
      If Campos_Blancos = 0 Then
          
          Grid.Col = 1
          On Error Resume Next
          Grid.SetFocus
          On Error GoTo 0
          Grid.AddItem ("")
          Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
          On Error Resume Next
          Grid.SetFocus
          On Error GoTo 0
     Else
        
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
     End If
 
 End If
 
        If KeyAscii = 27 Then
             
             txtgrilla3.Visible = False
             txtgrilla3.Text = ""
             txtgrilla3.Text = Grid.Text
             Grid.Text = txtgrilla3.Text
             'Grid.Col = 7
             On Error Resume Next
             Grid.SetFocus
             On Error GoTo 0
        End If
            
  
 

        If KeyAscii = 13 And Grid.Col = 6 Then
            
            txtgrilla3.Visible = False
            txtgrilla3.Tag = Grid.Text
            Grid.Text = txtgrilla3.Text
           
            'Grid.Col = 7
            On Error Resume Next
            Grid.SetFocus
            On Error GoTo 0
        End If

End Sub


Private Sub txtgrilla3_LostFocus()
    
    If txtgrilla3.Visible = True Then
                
        txtgrilla3.Visible = False
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
    End If

End Sub

Private Sub txtgrilla4_GotFocus()

    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    txtFecha1.Visible = False
    TxtGrilla.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    cmb_Moneda.Visible = False

End Sub

Private Sub txtgrilla4_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
KeyAscii = Caracter(KeyAscii)

If SW2 = 1 Then

    KeyAscii = 0

End If

    If KeyAscii = 45 Then
         
         If Campos_Blancos = 0 Then
              
              Grid.Col = 1
              On Error Resume Next
              Grid.SetFocus
              On Error GoTo 0
              Grid.AddItem ("")
              Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
              On Error Resume Next
              Grid.SetFocus
              On Error GoTo 0
         Else
            
            MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly
            On Error Resume Next
            Grid.SetFocus
            On Error GoTo 0
         End If
     Else
     
        If KeyAscii = 27 Then
             
             txtgrilla4.Visible = False
             txtgrilla4.Text = ""
             txtgrilla4.Text = Grid.Text
             Grid.Text = txtgrilla4.Text
             'Grid.Col = 8
             On Error Resume Next
             Grid.SetFocus
             On Error GoTo 0
        End If
            
        If KeyAscii = 13 And Grid.Col = 7 Then
            
             txtgrilla4.Visible = False
             Grid.Text = txtgrilla4.Text
             'Grid.Col = 8
             On Error GoTo 0
             Grid.SetFocus
             On Error GoTo 0
        End If
      
     
    End If

End Sub


Private Sub txtgrilla4_LostFocus()
 
If txtgrilla4.Visible = True Then
    txtgrilla4.Visible = False
    'Grid.Col = 8
    On Error Resume Next
    Grid.SetFocus
    On Error GoTo 0
End If

End Sub

Private Sub TxtNombre_DblClick()

   Call txtRut_DblClick

End Sub

Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyAyuda Then
      Call txtRut_DblClick
      Exit Sub
   
   End If

End Sub

Private Sub txtRut_DblClick()
       
    BUS = 3
    Call llamarayuda
    If Grid.Rows > 2 Then
    
      Grid.Col = 1
      
    End If
End Sub

Function llamarayuda()
  
   'MiTag = "MDCL_BANCOS"
   MiTag = "MDCL"
   BacAyuda.Show 1
   
   
   If giAceptar% = True Then
    
     
        'Toolbar1.Buttons(2).Enabled = False
        BUS = 1
        txtRut.Text = gsrut$
        txtCodigo.Text = gsValor$
        TxtNombre.Text = gsDescripcion$
        TxtDv.Text = FUNC_DevuelveDig(txtRut.Text)
        Call Buscar
        Toolbar1.Buttons(4).Enabled = True
        'Grid.RemoveItem (Grid.Row)
        'Call Eliminar
        Grid.Row = 2
        Grid.Col = 1
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
   Else
        
        Call Limpiar
        Grid.Enabled = False
        txtRut.Enabled = True
        On Error Resume Next
        txtRut.SetFocus
        On Error GoTo 0
        Grid.Row = 1
        Grid.Col = 0
        
   End If

   Grid.Col = 0
   
End Function

Private Sub txtrut_GotFocus()

    Toolbar1.Buttons(4).Enabled = True
    

End Sub


Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 And txtRut.Text <> "0" Then
         txtCodigo.Enabled = True
         On Error Resume Next
         txtCodigo.SetFocus
         On Error GoTo 0
    End If
    
    If KeyCode = vbKeyF3 Then
         Call llamarayuda
    End If
    
    If KeyCode = 27 Then
        Unload Baccorrespon
    End If

End Sub

Private Sub Form_Load()
    OptLocal = Opt
    Me.top = 0
    Me.left = 0
    inicio = 0
    SWGRA = 0
          paisactivo = 0
          BUS = 0
     
     Call Limpiar
     Call Formato_Grilla(Me.Grid)
     Call Cargar_Grilla

     'Toolbar1.Buttons(4).Visible = False
     SW2 = 0
     
     Grid.Rows = 2
     Grid.Enabled = False
     
     Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
     
End Sub

Sub Limpiar()
        
     CmbKey = 0
     Toolbar1.Buttons(2).Enabled = False
                    
     cmb_Moneda.Visible = False
     cmb_pais.Visible = False
     cmb_plaza.Visible = False
     cmbBANCE.Visible = False
     txtFecha1.Visible = False
     TxtGrilla.Visible = False
     txtgrilla2.Visible = False
     txtgrilla3.Visible = False
     txtgrilla4.Visible = False
     txtFecha1.Text = Date
     TxtGrilla.Text = ""
     txtgrilla2.Text = ""
     txtgrilla3.Text = ""
     txtgrilla4.Text = ""
        
     TxtDv.Text = ""
     
     Grid.Rows = 2
     Grid.Col = 0
     
     Call Correspon_Limpia
     Call Correspon_Carga_Datos
     Grid.Col = 0
     Grid.Rows = 2
     Grid.Enabled = False


End Sub

Sub Correspon_Limpia()
     
     txtRut.Text = "000000000"
     txtCodigo.Text = ""
     TxtNombre.Text = ""
     txtCodigo.Enabled = False
     TxtNombre.Enabled = False

End Sub
Sub Correspon_Carga_Datos()
Dim Datos()

         
     If BAC_SQL_EXECUTE("SP_corresponsales_cmbmoneda") Then
          
          cmb_Moneda.Clear
          
          Do While BAC_SQL_FETCH(Datos())
               
               cmb_Moneda.AddItem Datos(1) + Space(50) + Datos(2)
               cmb_Moneda.ItemData(cmb_Moneda.NewIndex) = Datos(2)
          
          Loop
          
     End If

     Sql = "Sp_corresponsales_cmbpais"
     
     If BAC_SQL_EXECUTE("Sp_corresponsales_cmbpais") Then
          
          cmb_pais.Clear
          
          Do While BAC_SQL_FETCH(Datos())
               
               cmb_pais.AddItem Datos(1) + Space(50) + Datos(2)
               cmb_pais.ItemData(cmb_pais.NewIndex) = Datos(2)
          
          Loop
     
     End If

cmb_Moneda.ListIndex = 0
'cmb_pais.ListIndex = 0

End Sub
Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
Dim SW3 As Integer
Dim Y As Integer
Dim G As Integer
Dim K As Integer
Dim i As Integer

    Toolbar1.Buttons(2).Enabled = True
    
    If KeyCode = 45 Then
       
       SWGRA = 1
       TxtGrilla.Text = ""
       txtgrilla2.Text = ""
       txtgrilla3.Text = ""
       txtgrilla4.Text = ""
     
     If Campos_Blancos = 1 Then
          
          MsgBox "Deben haber datos antes de Insertar Otra fila", vbInformation
          On Error Resume Next
          Grid.SetFocus
          On Error GoTo 0
     Else
         
         Grid.Col = 1
         On Error Resume Next
         Grid.SetFocus
         On Error GoTo 0
         Grid.AddItem ("")
         Grid.TextMatrix(Grid.Row + 1, 8) = "NO"
         Grid.TextMatrix(Grid.Row + 1, 9) = Date
         Grid.TextMatrix(Grid.Row + 1, 10) = "NO"
         Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
         Grid.Col = 1
         Grid.Row = Grid.Rows - 1
         On Error Resume Next
         Grid.SetFocus
         On Error GoTo 0
     End If
    
    End If
    
    If KeyCode = 46 Then
        On Error GoTo Fin2:
        Cont = 0
        
        For i = 1 To Grid.Cols - 1
            
            If Grid.TextMatrix(Grid.Row, i) = "" Then
                Cont = Cont + 1
                    
            End If
            
        Next i
        
        If Cont >= 1 Then
        
            Grid.RemoveItem (Grid.Row)
            Limpia
        Else
            
            Call Eliminar
            Limpia
            Grid.SetFocus
            Exit Sub
                   
        End If
        
    End If

    If inicio = 1 Then
    
        colpress = Grid.Col
        rowpress = Grid.Row
        Grid.ColSel = colpress
    
    End If

    On Error Resume Next
    Grid.SetFocus
    On Error GoTo 0

    Exit Sub

Fin2:

    'Colpress = 1
    'Rowpress = 2
    'Grid.ColSel = Colpress
    
    For i = 1 To Grid.Cols - 1
    
        Grid.TextMatrix(Grid.Row, i) = ""
        
    Next i
    
    If Grid.Rows > 3 Then
    
        Grid.Col = 1
        Grid.Row = 2
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
    Else
        
        Grid.Col = 0
        Grid.Row = 0
            
    End If
    Limpia
    
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim i As Integer
   Dim var1 As String
   Dim SW As Integer
   Dim VAR2 As Integer
   Dim Datos()
   
   If TxtGrilla.Visible = True Then
   
        TxtGrilla_KeyPress (13)
   
   End If
   If txtgrilla2.Visible = True Then
   
        txtgrilla2_KeyPress (13)
   
   End If
   If txtgrilla3.Visible = True Then
   
        txtgrilla3_KeyPress (13)
   
   End If
   If txtgrilla4.Visible = True Then
   
        txtgrilla4_KeyPress (13)
   
   End If
   
   If cmb_Moneda.Visible = True Then
   
        cmb_Moneda_KeyPress (13)
   
   End If
   If cmb_plaza.Visible = True Then
   
        cmb_plaza_KeyPress (13)
   
   End If
   If cmb_pais.Visible = True Then
   
        cmb_pais_KeyPress (13)
   
   End If
   If cmbBANCE.Visible = True Then
   
        cmb_pais_KeyPress (13)
   
   End If
   If txtFecha1.Visible = True Then
   
        txtFecha1_KeyPress (13)
   
   End If
   
   
   Select Case Button.Index
       Case 2

            
             If Campos_Blancos = 0 Then
              If DUPLICADOS Then
                  Call guardar
                  Call Limpiar
                  txtRut.Enabled = True
                  cmb_Moneda.Enabled = True
                  On Error Resume Next
                  txtRut.SetFocus
                  On Error GoTo 0
              Else

                  Grid.SetFocus
                  Exit Sub
              End If
             Else

               MsgBox "Información Incompleta", vbExclamation
               On Error Resume Next
               Grid.SetFocus
               On Error GoTo 0
             End If

       Case 4
'                If TXTRUT.Text <> "0" And txtCODIGO.Text <> "0" Then

                    Call TxtCodigo_KeyDown(13, 0)
                              
                     If (Not Grid.Rows = Grid.FixedRows) And Grid.Enabled Then
                        Grid.Row = Grid.FixedRows
                        Grid.ColSel = 0
                        Grid.SetFocus
                     End If

                'Else

                  'MsgBox "Se Requiere un Cliente ", vbInformation, "Información"
'                    Call llamarayuda
                
'                End If
      
      Case 3
          
                'Call Eliminar
                 'On Error GoTo fin2:
                 'Toolbar1.Buttons(2).Enabled = True
                 'Grid.RemoveItem (Grid.Row)
                 Call Eliminar_Todo
                 'Toolbar1.Buttons(1).Enabled = True

          
      Case 1
         
         
                
                Call Limpiar
                txtRut.Enabled = True
                On Error Resume Next
                txtRut.SetFocus
                On Error GoTo 0
                Toolbar1.Buttons(3).Enabled = False
      
         
      Case 5
           
           Unload Me
      
   End Select
 
    Exit Sub
 
'fin2:
'
'    Colpress = 1
'    Rowpress = 2
'    Grid.ColSel = Colpress
'
'    For I = 1 To Grid.Cols - 1
'
'        Grid.TextMatrix(Grid.Row, I) = ""
'
'    Next I
'
'    Grid.Col = 1
'    Grid.Row = 2
'    Grid.SetFocus
'
End Sub

Private Sub guardar()
Dim SW As Integer
Dim i As Long
Dim Datos()
Dim Y As Integer
Dim Mensaje, eStilo, Título, Respuesta
Dim Rut As Double
  
  SWGRA = 1
  If SWGRA = 1 Then

    Rut = txtRut.Text
    Sql = "SP_corresponsales_ELIMINAR " & Rut
    Sql = Sql & "," & Val(txtCodigo.Text)
     
    Envia = Array(Rut, CDbl(txtCodigo.Text))

    If BAC_SQL_EXECUTE("SP_corresponsales_ELIMINAR ", Envia) Then
    
    End If
    
    For i = Grid.FixedRows To Grid.Rows - 1
        
'        Grid.Row = i

        Sql = "SP_corresponsales_grabar" & " " & txtRut.Text & " "
        Sql = Sql & "," & Val(txtCodigo.Text)
        Sql = Sql & "," & Val(Trim(right(Grid.TextMatrix(i, 1), 50))) 'cmb_Moneda.ItemData(cmb_Moneda.ListIndex)
        Sql = Sql & "," & Val(Trim(right(Grid.TextMatrix(i, 2), 50))) 'cmb_pais.ItemData(cmb_pais.ListIndex)

        'If cmb_plaza.ListIndex >= 0 Then

        Sql = Sql & "," & Val(Trim(right(Grid.TextMatrix(i, 3), 50))) '& cmb_plaza.ItemData(cmb_plaza.ListIndex) '
        
        'End If
        
        var1 = Grid.TextMatrix(i, 4) 'codigo swift
        VAR2 = Grid.TextMatrix(i, 5) 'nombre
        VAR3 = Grid.TextMatrix(i, 6) 'cuenta corriente
        var4 = Grid.TextMatrix(i, 7) 'swift santiago
        var5 = Mid(Grid.TextMatrix(i, 8), 1, 1) 'banco central
        var6 = Grid.TextMatrix(i, 9) 'fecha venci.
        Sql = Sql & ",'" & var1 & "'"
        Sql = Sql & ",'" & VAR2 & "'"
        Sql = Sql & ",'" & VAR3 & "'"
        Sql = Sql & ",'" & var4 & "'"
        Sql = Sql & ",'" & var5 & "'"
        Sql = Sql & ",'" & var6 & "'"
       
        Envia = Array(CDbl(txtRut.Text), _
                     Val(txtCodigo.Text), _
                     Val(Trim(right(Grid.TextMatrix(i, 1), 50))), _
                     Val(Trim(right(Grid.TextMatrix(i, 2), 50))), _
                     Val(Trim(right(Grid.TextMatrix(i, 3), 50))), _
                     var1, _
                     VAR2, _
                     VAR3, _
                     var4, _
                     var5, _
                     var6, _
                     left(Grid.TextMatrix(i, 10), 1), _
                     Trim(Grid.TextMatrix(i, 11)))
                     
         If BAC_SQL_EXECUTE("SP_corresponsales_grabar", Envia) Then
            
            If BAC_SQL_FETCH(Datos()) Then
                
                Select Case Datos(1)
                   
                   Case Is = "ok"
                        SW = 1
                        Call LogAuditoria("01", OptLocal, Me.Caption, "", "RUT: " & txtRut.Text & " Codigo: " & txtCodigo.Text & " Moneda: " & Mid(Grid.TextMatrix(i, 1), 1, 6) & " Pais: " & Grid.TextMatrix(i, 2))
                End Select
             
             End If
          
          Else
            

'               With Grid
'                  Call LogAuditoria("01", OptLocal, Me.Caption & " Error al Grabar " & "RUT: " & txtRut.Text & " Codigo: " & txtCodigo.Text & " Moneda: " & Mid(.TextMatrix(I, 1), 1, 6) & " Pais: " & .TextMatrix(I, 2))
'               end with
             On Error Resume Next
             Grid.SetFocus
             On Error GoTo 0
          End If
        
      Next i
 
 End If

    If SW = 1 Then
       Toolbar1.Buttons(2).Enabled = True
       MsgBox "La información ha sido Grabada", vbInformation + vbOKOnly
       Grid.SetFocus
     End If
 
   If SW = 2 Then
      MsgBox "La información ha sido Modificada", vbInformation + vbOKOnly
      Grid.SetFocus
   End If
   
       Toolbar1.Buttons(3).Enabled = False
       Toolbar1.Buttons(4).Enabled = False
       

'Toolbar1.Buttons(1).Enabled = False
 
  If KeyCode = 46 Then
   Toolbar1.Buttons(4).Enabled = True
  Call Eliminar
 End If

End Sub

Private Function DUPLICADOS() As Boolean
Dim P, X As Integer
Dim Moneda As String
Dim Pais As String
Dim PLAZA As String
Dim Swift As String
DUPLICADOS = False
For P = 2 To Grid.Rows - 1

   Moneda = Grid.TextMatrix(P, 1)
   Pais = Grid.TextMatrix(P, 2)
   PLAZA = Grid.TextMatrix(P, 3)
   Swift = UCase(Grid.TextMatrix(P, 4))

   For X = P + 1 To Grid.Rows - 1
        If Grid.TextMatrix(X, 1) = Moneda And _
           Grid.TextMatrix(X, 2) = Pais And _
           Grid.TextMatrix(X, 3) = PLAZA And _
           Grid.TextMatrix(X, 4) = Swift Then
            MsgBox "DATOS DUPLICADOS", vbInformation
            DUPLICADOS = False
            Exit Function
         End If

   Next X
   
Next P
DUPLICADOS = True
End Function

Private Sub TxtGrilla_KeyPress(KeyAscii As Integer)

Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For i = 1 To Len(Char)

    If Mid(Char, i, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next i

If SW2 = 1 Then

    KeyAscii = 0

End If

If Chr(KeyAscii) = "-" Then GoTo fin:
    


    If KeyAscii = 45 Then
          
          If Campos_Blancos = 0 Then
              
              Grid.Col = 1
              On Error Resume Next
              Grid.SetFocus
              On Error GoTo 0
              Grid.AddItem ("")
              Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
              On Error Resume Next
              Grid.SetFocus
              On Error GoTo 0
         Else
            
            MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly
            Grid.SetFocus
         
         End If
    Else
      If KeyAscii = 27 Then
          
          TxtGrilla.Visible = False
          TxtGrilla.Text = ""
          'TXTGRILLA.Text = Grid.Text
          Grid.Text = TxtGrilla.Tag
          'Grid.Col = 5
          On Error Resume Next
          Grid.SetFocus
          On Error GoTo 0
       End If
       
       If KeyAscii = 13 Then
       
            Dim Ind2, Sub_ind2 As Integer
            Dim Busq2 As String
            Text1.Text = ""
            Text1.Text = TxtGrilla.Text
            Busq2 = Text1.Text
          
      
    
            
            Grid.Text = Busq2
            
            If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
            
                MsgBox "Codigo Swift No se Puede Repetir ", vbInformation
                TxtGrilla.Text = ""
                TxtGrilla_KeyPress (27)
                Exit Sub
            
            End If
            
            TxtGrilla.Tag = TxtGrilla.Text
            Grid.Text = TxtGrilla.Text
            TxtGrilla.Text = ""
            TxtGrilla.Visible = False
         
          
         
            'Grid.Col = 5
            On Error Resume Next
            Grid.SetFocus
            On Error GoTo 0
       End If
       
     
       If KeyAscii = 13 And Grid.Col = 9 Then
          
          TxtGrilla.Visible = False
          Grid.Text = TxtGrilla.Text
          TxtGrilla.Text = ""
       
       End If
     
     End If
     
     If KeyCode = 46 Then
      
        Toolbar1.Buttons(4).Enabled = True
        Call Eliminar
     
     End If
 
fin:
 
End Sub
Private Sub Grid_KeyPress(KeyAscii As Integer)

Toolbar1.Buttons(2).Enabled = True
'Toolbar1.Buttons(3).Enabled = False
'Toolbar1.Buttons(4).Enabled = True
'Toolbar1.Buttons(5).Enabled = True

If KeyAscii = 45 Then
  
   SWGRA = 1
   TxtGrilla.Text = ""
   txtgrilla2.Text = ""
   txtgrilla3.Text = ""
   txtgrilla4.Text = ""
   
   If Campos_Blancos = 0 Then
     
     Grid.Col = 1
     On Error Resume Next
     Grid.SetFocus
     On Error GoTo 0
     Grid.AddItem ("")
      
     Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
     Limpia
     On Error Resume Next
     Grid.SetFocus
     On Error GoTo 0
    Else
      MsgBox "Debe Existir datos antes de Insertar una Nueva Fila", vbOKOnly
      Grid.SetFocus
  End If
Else
 If KeyAscii = 27 Then
'   MsgBox "Operacion Invalida ", vbOKOnly
   'Grid.SetFocus
  Else
    
  If Grid.Col = 1 Then
         'cmb_Moneda.Height = Grid.CellHeight
         cmb_Moneda.top = Grid.CellTop + Grid.top
         cmb_Moneda.left = Grid.CellLeft + Grid.left + 20
         cmb_Moneda.Width = Grid.CellWidth - 20
         Call Valor_Combo(cmb_Moneda)
         cmb_Moneda.Visible = True
         On Error Resume Next
         cmb_Moneda.SetFocus
         On Error GoTo 0
    End If
   If Grid.Col = 2 Then
       
        'cmb_pais.Height = Grid.CellHeight
         cmb_pais.Tag = Grid.Text
         cmb_pais.top = Grid.CellTop + Grid.top
         cmb_pais.left = Grid.CellLeft + Grid.left + 20
         cmb_pais.Width = Grid.CellWidth - 20
         Call Valor_Combo(cmb_pais)
         cmb_pais.Visible = True
         cmb_pais.SetFocus
   End If
    If Grid.Col = 3 Then
    'And KeyAscii <> 13'
       ' cmb_plaza.Height = Grid.CellHeight
        cmb_plaza.top = Grid.CellTop + Grid.top
        cmb_plaza.left = Grid.CellLeft + Grid.left + 20
        cmb_plaza.Width = Grid.CellWidth - 20
        Call Valor_Combo(cmb_plaza)
        cmb_plaza.Visible = True
        On Error Resume Next
        cmb_plaza.SetFocus
        On Error GoTo 0
    End If
   If Grid.Col = 4 Then
   'And KeyAscii <> 13'
         TxtGrilla.Tag = Grid.Text
         TxtGrilla.Text = Grid.Text
         If KeyAscii <> 13 And KeyAscii <> 27 And KeyAscii <> 9 Then
            KeyAscii = Caracter(KeyAscii)
            TxtGrilla.Text = UCase(Chr(KeyAscii))
            TxtGrilla.SelStart = 1
         End If
         
         TxtGrilla.Height = Grid.CellHeight
         TxtGrilla.top = Grid.CellTop + Grid.top
         TxtGrilla.left = Grid.CellLeft + Grid.left + 20
         TxtGrilla.Width = Grid.CellWidth - 20
         TxtGrilla.Visible = True
         On Error Resume Next
         TxtGrilla.SetFocus
         On Error GoTo 0
   End If
   If Grid.Col = 5 Or Grid.Col = 11 Then
         txtgrilla2.Text = Grid.Text
         If KeyAscii <> 13 And KeyAscii <> 27 And KeyAscii <> 9 Then
            KeyAscii = Caracter(KeyAscii)
            txtgrilla2.Text = UCase(Chr(KeyAscii))
            txtgrilla2.SelStart = 1
         End If
         If Grid.Col = 5 Then
           txtgrilla2.MaxLength = 50
         Else
           txtgrilla2.MaxLength = 5
         End If
         txtgrilla2.Height = Grid.CellHeight
         txtgrilla2.top = Grid.CellTop + Grid.top
         txtgrilla2.left = Grid.CellLeft + Grid.left + 20
         txtgrilla2.Width = Grid.CellWidth - 20
         txtgrilla2.Visible = True
         On Error Resume Next
         txtgrilla2.SetFocus
         On Error GoTo 0
   End If
      If Grid.Col = 6 Then
         txtgrilla3.Text = Grid.Text
         If KeyAscii <> 13 And KeyAscii <> 27 And KeyAscii <> 9 Then
            KeyAscii = Caracter(KeyAscii)
            txtgrilla3.Text = UCase(Chr(KeyAscii))
            txtgrilla3.SelStart = 1
         End If
         txtgrilla3.Height = Grid.CellHeight
         txtgrilla3.top = Grid.CellTop + Grid.top
         txtgrilla3.left = Grid.CellLeft + Grid.left + 20
         txtgrilla3.Width = Grid.CellWidth - 20
         txtgrilla3.Visible = True
         On Error Resume Next
         txtgrilla3.SetFocus
         On Error GoTo 0
    End If

   If Grid.Col = 7 Then
         txtgrilla4.Text = Grid.Text
         If KeyAscii <> 13 And KeyAscii <> 27 And KeyAscii <> 9 Then
            KeyAscii = Caracter(KeyAscii)
            txtgrilla4.Text = UCase(Chr(KeyAscii))
            txtgrilla4.SelStart = 1
         End If
         
         txtgrilla4.Height = Grid.CellHeight
         txtgrilla4.top = Grid.CellTop + Grid.top
         txtgrilla4.left = Grid.CellLeft + Grid.left + 20
         txtgrilla4.Width = Grid.CellWidth - 20
         txtgrilla4.Visible = True
         On Error Resume Next
         txtgrilla4.SetFocus
         On Error GoTo 0
   End If
   If Grid.Col = 8 Then
       'TXTGRILLA.Height = Grid.CellHeight
         cmbBANCE.top = Grid.CellTop + Grid.top
         cmbBANCE.left = Grid.CellLeft + Grid.left + 20
         cmbBANCE.Width = Grid.CellWidth - 20
         Call Valor_Combo(cmbBANCE)
         cmbBANCE.Visible = True
         On Error Resume Next
         cmbBANCE.SetFocus
         On Error GoTo 0
   End If
   If Grid.Col = 9 Then
         
         txtFecha1.Height = Grid.CellHeight
        txtFecha1.top = Grid.CellTop + Grid.top
         txtFecha1.left = Grid.CellLeft + Grid.left + 20
         txtFecha1.Width = Grid.CellWidth - 20
         txtFecha1.Visible = True
         On Error Resume Next
         txtFecha1.SetFocus
         On Error GoTo 0
   End If

   If Grid.Col = 10 Then
   
         cmbBANCE.top = Grid.CellTop + Grid.top
         cmbBANCE.left = Grid.CellLeft + Grid.left + 20
         cmbBANCE.Width = Grid.CellWidth - 20
         cmbBANCE.Visible = True
         On Error Resume Next
         cmbBANCE.SetFocus
         On Error GoTo 0
         cmbBANCE.Text = IIf(Grid.Text = "" Or Grid.Text = "NO", "NO", "SI")
   
   End If
            
  End If
   If KeyCode = 46 Then
       'Call Eliminar
       Toolbar1.Buttons(4).Enabled = True
   End If

End If
End Sub

Sub Valor_Combo(xCombo As ComboBox)
On Error Resume Next
   xCombo.ListIndex = -1
   If Grid.Text <> "" Then
      xCombo.Text = Grid.Text
   End If

End Sub



Private Sub txtgrilla2_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For i = 1 To Len(Char)

    If Mid(Char, i, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next i

If SW2 = 1 Then

    KeyAscii = 0

End If

If KeyAscii = 45 Then
   
   If Campos_Blancos = 0 Then
     
       Grid.Col = 1
       Grid.AddItem ("")
       Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
    
    Else
      
       MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly
  
  End If

Else
  
    If KeyAscii = 27 Then
        
        txtgrilla2.Visible = False
        txtgrilla2.Text = ""
        txtgrilla2.Text = Grid.Text
        Grid.Text = txtgrilla2.Text
        'Grid.Col = 6
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
     End If
     
     If KeyAscii = 13 Then
        
        txtgrilla2.Visible = False
        Grid.Text = txtgrilla2.Text
        txtgrilla2.Text = ""
        'Grid.Col = 6
        On Error Resume Next
        Grid.SetFocus
        On Error GoTo 0
     End If


End If

If KeyCode = 46 Then
 
    Toolbar1.Buttons(4).Enabled = True
    Call Eliminar

End If

End Sub

Sub Eliminar()
On Error GoTo fin:
Dim Datos()
Dim Y As Integer
Dim SW As Integer
Dim i As Long

 
     If Grid.RowSel >= 2 Then
       If MsgBox("¿Seguro de eliminar Corresponsal?", vbYesNo + vbInformation) = vbYes Then
            
          Dim Rut As Double
         
               If Grid.Rows > 3 Then
         
                  Grid.RemoveItem (Grid.Row)
                  Grid.Row = 2
                  Grid.Col = 1
                           
               Else
               
                  Grid.Rows = 2
                  Grid.AddItem ("")
                  Grid.Row = 1
                  Grid.Col = 0
                  
                  If Grid.Rows > 1 Then
                     
                     'Grid.RowHeight = 315
                  
                  End If
               End If
               
               Rut = txtRut.Text
     
               A = Grid.Rows - 1
            
               Envia = Array(Rut, CDbl(txtCodigo.Text))
            
          End If
      

    
    End If
    
 
fin:
End Sub

Sub Eliminar_Todo()
On Error GoTo fin:
Dim Datos()
Dim Y As Integer
Dim SW As Integer
Dim i As Long
 
     If Grid.RowSel >= 2 Then
       If MsgBox("¿Seguro de eliminar Todos Los Corresponsales Asociados a este Cliente?", vbYesNo + vbInformation) = vbYes Then
            
          Dim Rut As Double
         
               If Grid.Rows > 3 Then
         
                  Grid.RemoveItem (Grid.Row)
                  Grid.Row = 2
                  Grid.Col = 1
                           
               Else
               
                  Grid.Rows = 2
                  Grid.AddItem ("")
                  Grid.Row = 1
                  Grid.Col = 0
                  
                  If Grid.Rows > 1 Then
                     
                     'Grid.RowHeight = 315
                  
                  End If
               End If
               
               Rut = txtRut.Text
     
               A = Grid.Rows - 1
            
               Envia = Array(Rut, CDbl(txtCodigo.Text))
            
            If Not BAC_SQL_EXECUTE("SP_corresponsales_ELIMINAR ", Envia) Then

               MsgBox "PROBLEMAS EN sql", vbCritical
               Call LogAuditoria("03", OptLocal, Me.Caption & " Error al eliminar- Rut: " & txtRut.Text & " Codigo: " & txtCodigo.Text, "", "")
            Else

              Do While BAC_SQL_FETCH(Datos())

                    Select Case Datos(1)

                        Case "OK"
                             MsgBox "Corresponsal Eliminado", vbInformation
                             Call LogAuditoria("03", OptLocal, Me.Caption, "Rut: " & txtRut.Text & " Codigo: " & txtCodigo.Text, "")
            
                             Toolbar1.Buttons(3).Enabled = False
                             Grid.Rows = 2
'                             If Grid.Rows = 3 Then
'                              Call Me.Cargar_Grilla
'                             Else
'                              Grid.RemoveItem (Grid.RowSel)
'                              Grid.SetFocus
'                             End If
'
                              'Call Correspon_Limpia
                              'Call Correspon_Carga_Datos
                              'Call Cargar_Grilla
                              Call Limpiar
                              txtRut.Enabled = True
                              cmb_Moneda.Enabled = True
                              txtRut.SetFocus

                        Case "NO EXISTE"
                             'MsgBox "No Existe Corresponsal  "
                    End Select

                     '    MsgBox "Error", vbCritical, "Bac-Parametros"
                 Loop
             End If

          End If

    End If

fin:
End Sub


Function Campos_Blancos() As Integer
Dim Y As Integer
Dim G As Integer
    Y = Grid.Rows - 1
        Campos_Blancos = 0
    For K = 1 To 9
      If (Grid.TextMatrix(Y, K) = "" Or Grid.TextMatrix(Y, K) = ".") And (K <> 6 And K <> 7) Then
        Campos_Blancos = 1
      End If
    Next K
  
End Function



Sub Limpia()

     txtFecha1.Text = Date
     TxtGrilla.Text = ""
     txtgrilla2.Text = ""
     txtgrilla3.Text = ""
     txtgrilla4.Text = ""
        
     txtFecha1.Tag = Date
     TxtGrilla.Tag = ""
     txtgrilla2.Tag = ""
     txtgrilla3.Tag = ""
     txtgrilla4.Tag = ""

End Sub


Function Verifica_Existencia(Moneda, Pais, PLAZA, CodSwif As String) As Boolean
Dim i As Long
Dim ContV As Integer

    Verifica_Existencia = False
    
    ContV = 0
    
    For i = 1 To Grid.Rows - 1
    
        If Mid(Grid.TextMatrix(i, 1), 1, 50) = Mid(Moneda, 1, 50) And Mid(Grid.TextMatrix(i, 2), 1, 50) = Mid(Pais, 1, 50) _
           And Mid(Grid.TextMatrix(i, 3), 1, 50) = Mid(PLAZA, 1, 50) And Mid(Grid.TextMatrix(i, 4), 1, 50) = Mid(CodSwif, 1, 50) Then
            
            ContV = ContV + 1
            If ContV > 1 Then
                
                Verifica_Existencia = True
                Exit Function
                
            End If
           
        
        End If
    
    Next i

End Function


Private Function FUNC_DevuelveDig(Rut As String) As String

   Dim i          As Integer
   Dim D          As Integer
   Dim Divi       As Long
   Dim Suma       As Long
   Dim Digito     As String
   Dim Multi      As Double

   FUNC_DevuelveDig = ""

   Rut = Format(Rut, Mid$("00000000000", 1, Len(Rut)))

   D = 2

   For i = Len(Rut) To 1 Step -1
      Multi = Val(Mid$(Rut, i, 1)) * D
      Suma = Suma + Multi
      D = D + 1

      If D = 8 Then
         D = 2

      End If

   Next i

   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))

   If Digito = "10" Then
      Digito = "K"

   End If

   If Digito = "11" Then
      Digito = "0"

   End If

   FUNC_DevuelveDig = UCase(Digito)

End Function

Private Sub txtRut_LostFocus()

   TxtDv.Text = FUNC_DevuelveDig(txtRut.Text)

End Sub
