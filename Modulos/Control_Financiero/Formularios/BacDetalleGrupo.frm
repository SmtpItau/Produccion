VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacDetalleGrupo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Detalle Grupal"
   ClientHeight    =   5880
   ClientLeft      =   2460
   ClientTop       =   1800
   ClientWidth     =   8730
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5880
   ScaleWidth      =   8730
   Begin VB.ComboBox CmbTipoEmi 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2160
      Style           =   2  'Dropdown List
      TabIndex        =   24
      TabStop         =   0   'False
      Top             =   4440
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox TextCodCorr 
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000009&
      Height          =   285
      Left            =   5160
      MaxLength       =   8
      TabIndex        =   17
      Top             =   3180
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000009&
      Height          =   285
      Left            =   2160
      MaxLength       =   20
      TabIndex        =   16
      Top             =   2220
      Visible         =   0   'False
      Width           =   1215
   End
   Begin BACControles.TXTFecha TXTFecha1 
      Height          =   255
      Left            =   2040
      TabIndex        =   15
      Top             =   3120
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   450
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
      MaxDate         =   2958465
      MinDate         =   -328716
      Text            =   "08/09/2001"
   End
   Begin VB.TextBox TextCodCont 
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000009&
      Height          =   285
      Left            =   5160
      MaxLength       =   4
      TabIndex        =   14
      Top             =   2880
      Width           =   1215
   End
   Begin VB.TextBox txtgrilla2 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
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
      TabIndex        =   13
      TabStop         =   0   'False
      Top             =   2865
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox TXTGRILLA 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
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
      MaxLength       =   11
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   3840
      Width           =   1500
   End
   Begin VB.ComboBox CmbMonCon 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   2865
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.ComboBox CmbInstrumento 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   3840
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.ComboBox CmbEmisor 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   2550
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.ComboBox cmbBANCE 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   3510
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtgrilla3 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
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
      MaxLength       =   30
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   2565
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtgrilla4 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
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
      MaxLength       =   10
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   3195
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   3630
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   3510
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
      Height          =   1455
      Left            =   15
      TabIndex        =   0
      Top             =   525
      Width           =   8700
      Begin VB.TextBox TxtModulo 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1125
         TabIndex        =   23
         Top             =   1080
         Width           =   3975
      End
      Begin VB.TextBox TxtGlosa 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1125
         TabIndex        =   19
         Top             =   660
         Width           =   5895
      End
      Begin BACControles.TXTNumero TxtCodigo 
         Height          =   300
         Left            =   1125
         TabIndex        =   18
         Top             =   240
         Width           =   1995
         _ExtentX        =   3519
         _ExtentY        =   529
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label LblGlosa 
         AutoSize        =   -1  'True
         Caption         =   "Glosa"
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
         Height          =   195
         Left            =   240
         TabIndex        =   22
         Top             =   720
         Width           =   495
      End
      Begin VB.Label LblCodigo 
         AutoSize        =   -1  'True
         Caption         =   "Codigo"
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
         Height          =   195
         Left            =   240
         TabIndex        =   21
         Top             =   270
         Width           =   600
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Módulo"
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
         Height          =   195
         Left            =   240
         TabIndex        =   20
         Top             =   1125
         Width           =   630
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   3735
      Left            =   0
      TabIndex        =   1
      Top             =   2055
      Width           =   8700
      _ExtentX        =   15346
      _ExtentY        =   6588
      _Version        =   393216
      Rows            =   3
      FixedRows       =   2
      FixedCols       =   0
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
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame Frame2 
      Height          =   3975
      Left            =   15
      TabIndex        =   9
      Top             =   1920
      Width           =   8715
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   8730
      _ExtentX        =   15399
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   "2"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            Object.Tag             =   "3"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            Object.Tag             =   "4"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "5"
            ImageIndex      =   5
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
      OLEDropMode     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3600
         Top             =   -45
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
               Picture         =   "BacDetalleGrupo.frx":0000
               Key             =   "Guardar"
               Object.Tag             =   "1"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacDetalleGrupo.frx":0EDC
               Key             =   "Buscar"
               Object.Tag             =   "2"
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacDetalleGrupo.frx":1DB8
               Key             =   "Eliminar"
               Object.Tag             =   "3"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacDetalleGrupo.frx":2C94
               Key             =   "Limpiar"
               Object.Tag             =   "4"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacDetalleGrupo.frx":30E8
               Key             =   "Salir"
               Object.Tag             =   "6"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacDetalleGrupo.frx":3404
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Label Label3 
         Caption         =   "Label3"
         Height          =   135
         Left            =   3960
         TabIndex        =   8
         Top             =   240
         Width           =   15
      End
   End
End
Attribute VB_Name = "BacDetalleGrupo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public BUS
Public pais
Public Escape
Public paisactivo
Public SWGRA
Dim colpress As Long
Dim rowpress, Cont As Long
Dim inicio, I, SW2, CmbKey As Integer

 Private Sub BuscarDetalle()
  
  Dim datos(), datos1()
  Dim I As Integer
  Dim SW As Integer
  Dim Sql As String
  

   SW = 0
     
   Toolbar1.Buttons(2).Enabled = False
   TxtCodigo.BackColor = &H8000000E
   TxtCodigo.ForeColor = &H80000008

   TxtCodigo.Enabled = False

     
   Call Cargar_Grilla
   
   Grid.Enabled = True
   Grid.AddItem ("")
   Grid.RowHeight(2) = 315
   Grid.Row = 2
    
     
    Envia = Array()
    AddParam Envia, "B"
    AddParam Envia, Format(TxtCodigo.Text, "00")
    AddParam Envia, Right(TxtModulo.Text, 3)
    
    If Not Bac_Sql_Execute("SP_MTN_DETALLE_GRUPAL", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    I = 2
    Grid.Enabled = True
     
     Do While Bac_SQL_Fetch(datos())
     
     
         If datos(1) = "NO" Then
            
                MsgBox "No Existen Registros", vbCritical, TITSISTEMA
                Toolbar1.Buttons(4).Enabled = True
                Exit Sub
        
         End If
        
         SW = 1
         Grid.Rows = I + 1
         Grid.RowHeight(Grid.Rows - 1) = 315
         Grid.RowHeight(I) = 315
         
         Grid.TextMatrix(I, 1) = datos(12) + Space(50) + datos(5)  ' pais
         Grid.TextMatrix(I, 2) = datos(11) + Space(50) + datos(6)  ' plaza
         Grid.TextMatrix(I, 3) = IIf(datos(13) = "", "", datos(13) + Space(50) + datos(4)) ' moneda
         Grid.TextMatrix(I, 4) = IIf(datos(9) = "", "", datos(9) + Space(50) + datos(3)) ' moneda
         Grid.TextMatrix(I, 5) = IIf(datos(14) = "", "", datos(14))
         
         I = I + 1
        
         Toolbar1.Buttons(3).Enabled = True
         
      Loop
                 

 If SW = 0 Then
     
     If BUS = 1 Then
      SWGRA = 1
      txtRut.Enabled = False
      TxtCodigo.Enabled = False
      txtNombre.Enabled = False
      
      Grid.Row = Grid.FixedRows
      Grid.Row = 2
      Grid.RowHeight(2) = 315
      Grid.Enabled = True
      Grid.Col = 1
      Grid.SetFocus
     
     Else
     
        Dim F As Integer
        F = MsgBox("Grupo no tiene Registros,¿Desea Ingresar? ", vbOKCancel, TITSISTEMA)

        If F = 1 Then
            SWGRA = 1
        Else
            Call Limpiar
        End If
    End If
     
  Else
      SWGRA = 2
      DoEvents
      DoEvents
      Grid.Col = 1
      Grid.Row = Grid.FixedRows
      Grid.SetFocus
      Toolbar1.Buttons(4).Enabled = True
  End If
  
If KEYCODE = vbKeyDelete Then
  Toolbar1.Buttons(2).Enabled = True
  Call EliminarRegistro
End If

End Sub
Sub Cargar_Grilla()
    
    SW = 0
    Grid.Clear
    Grid.Rows = 3
    Grid.Cols = 6
    Grid.FixedRows = 2
    Grid.FixedCols = 0
    
    Grid.TextMatrix(0, 1) = "Instrumento"
    Grid.TextMatrix(0, 2) = "Moneda"
    Grid.TextMatrix(0, 3) = "Tipo Emisor"
    Grid.TextMatrix(0, 4) = "Emisor"
    Grid.TextMatrix(0, 5) = "Condicion"
    Grid.TextMatrix(1, 5) = "Especial"
          
    Grid.ColWidth(0) = 0
    
    Grid.ColWidth(1) = 1500
    Grid.ColWidth(2) = 2000
    Grid.ColWidth(3) = 2500
    Grid.ColWidth(4) = 3000
    Grid.ColWidth(5) = 1500
    
    
    For m = 0 To Grid.Rows - 2
        Grid.RowHeight(m) = 227
    Next m
    
    For m = 0 To Grid.Rows - 1
        For mm = 0 To Grid.Cols - 1
            Grid.Col = mm
            Grid.Row = m
            Grid.CellFontBold = True
            Grid.GridLinesFixed = flexGridNone
        Next mm
   Next m
   
   Grid.CellFontBold = False
   Grid.Rows = Grid.Rows - 1
   
   If Grid.Rows > 2 Then
      Grid.Col = 0
      Grid.ColSel = Grid.Cols - 1
   Else
      Grid.Col = 0
      Grid.ColSel = 0
   End If
   
   Grid.Enabled = False
  
 
End Sub

Private Sub Cmb_Moneda_Click()
   
    cmb_Moneda_KeyPress 13
    CmbKey = 0

End Sub

Private Sub cmb_Moneda_GotFocus()
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub cmb_Moneda_KeyDown(KEYCODE As Integer, Shift As Integer)
   CmbKey = KEYCODE

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
                    
                    MsgBox "Moneda No se Puede Repetir", vbCritical, TITSISTEMA
                    cmb_Moneda_KeyPress (27)
                    Exit Sub
                    
              Else
                    cmb_Moneda.Tag = cmb_Moneda.Text
              
              End If
    
       End If
        
    End If


    If KeyAscii = 27 Then
         
         cmb_Moneda.Visible = False
         Grid.Text = cmb_Moneda.Tag
      
         Grid.SetFocus
    
    End If
    
    If KeyAscii = 13 Then
    On Error GoTo fin

        Grid.Text = cmb_Moneda.Text
        cmb_Moneda.Visible = False
        Grid.SetFocus
    
    End If
    
fin:
End Sub


Private Sub cmb_Moneda_LostFocus()

    If cmb_Moneda.Visible = True Then
        
      
        cmb_Moneda.Visible = False
    
    End If
    
End Sub

Private Sub cmb_pais_Click()

'''    cmb_pais_KeyPress (13)
'''    CmbKey = 0

End Sub

Private Sub cmb_pais_GotFocus()

    paisactivo = 1
    
    pais = 0
    Escape = 0
    cmb_Moneda.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub cmb_pais_KeyDown(KEYCODE As Integer, Shift As Integer)

   CmbKey = KEYCODE

End Sub

Private Sub cmb_pais_LostFocus()
  
If cmb_pais.Visible = True Then
   
   cmb_pais.Visible = False
   Grid.Col = 2
   Grid.Text = cmb_pais.Tag
   Grid.SetFocus

End If

End Sub

Private Sub cmb_plaza_Click()

    cmb_plaza_KeyPress (13)
    
    CmbKey = 0

End Sub

Private Sub cmb_plaza_GotFocus()
     
    If Grid.Col = 2 And Grid.Text = "" And cmb_plaza.ListCount = 0 Then
         
       MsgBox "Se Requiere de un Pais ", vbInformation, TITSISTEMA
       Grid.SetFocus
       cmb_plaza.Visible = False
   
    End If
    
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub cmb_plaza_KeyDown(KEYCODE As Integer, Shift As Integer)

   CmbKey = KEYCODE
   CmbKey = 0

End Sub

Private Sub cmb_plaza_KeyPress(KeyAscii As Integer)
 
    If KeyAscii = 27 Then
       
       cmb_plaza.Visible = False
       Grid.Text = ""
       Grid.SetFocus
    
    End If

   If KeyAscii = 13 Then
        
        Grid.Text = cmb_plaza.Text
        
        If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then

            MsgBox "No se puede repetir la plaza", vbExclamation, TITSISTEMA
            cmb_plaza_KeyPress (27)
            
        Else
            
            cmb_plaza.Tag = Grid.Text
            cmb_plaza.Visible = False
            Grid.Text = cmb_plaza + Space(50) + Trim(Right(cmb_plaza.Text, 50))
            Grid.SetFocus
       
        End If

        Grid.SetFocus
    
    End If
 
End Sub


Private Sub cmb_plaza_LostFocus()

    If cmb_plaza.Visible = True Then
        cmb_plaza.Visible = False
    
    End If

End Sub

Private Sub cmbBANCE_Click()

    'cmbBANCE_KeyPress (13)
    'CmbKey = 0

End Sub

Private Sub cmbBANCE_GotFocus()

    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmb_Moneda.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub cmbBANCE_KeyDown(KEYCODE As Integer, Shift As Integer)

   CmbKey = KEYCODE

End Sub

Private Sub cmbBANCE_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn And cmbBANCE <> "" Then
       Grid.Col = 8
       cmbBANCE.Tag = Grid.Text
       cmbBANCE.Visible = False
       Grid.Text = cmbBANCE.Text
       Grid.SetFocus
    End If

   If KeyAscii = vbKeyEscape And Grid.Col = 8 Then
        Grid.Col = 8
        Grid.Text = cmbBANCE.Tag
        cmbBANCE.Visible = False
        Grid.Text = cmbBANCE.Text
        Grid.SetFocus
 
   End If
End Sub


Private Sub cmbBANCE_LostFocus()

    'If cmbBANCE.Visible = True Then

        'Grid.Col = 8
        'Grid.Text = cmbBANCE.Tag
        cmbBANCE.Visible = False
        Grid.SetFocus
    
    'End If


End Sub

Private Sub CmbEmisor_Click()
    'CmbEmisor_KeyPress vbKeyReturn
    'CmbKey = 0
End Sub

Private Sub CmbEmisor_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn And cmb_Moneda <> "" Then
       
       Dim Ind, Sub_ind As Integer
       Dim Busq As String
         
       Text1.Text = ""
       Text1.Text = CmbEmisor
       Busq = Text1.Text
      
       If Grid.Rows > 3 Then
              
              Grid.Text = Busq
              
              If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                    MsgBox "Moneda No se Puede Repetir", vbExclamation, TITSISTEMA
                    CmbEmisor_KeyPress vbKeyEscape
                    Exit Sub
              Else
                    CmbEmisor.Tag = CmbEmisor.Text
              End If
       End If
    End If

    If KeyAscii = vbKeyEscape Then
         CmbEmisor.Visible = False
         Grid.Text = CmbEmisor.Tag
         'Grid.Col = 2
         Grid.SetFocus
    End If
    
    If KeyAscii = vbKeyReturn Then
        On Error GoTo fin
        Grid.Text = CmbEmisor.Text
        CmbEmisor.Visible = False
        Grid.SetFocus
    End If
    
fin:

End Sub

Private Sub CmbEmisor_LostFocus()
    CmbEmisor.Visible = False
    Grid.SetFocus
End Sub

Private Sub CmbInstrumento_Click()
    'CmbInstrumento_KeyPress (13)
    'CmbKey = 0
End Sub

Private Sub CmbInstrumento_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = vbKeyReturn And cmb_Moneda <> "" Then
       
       Dim Ind, Sub_ind As Integer
       Dim Busq As String
         
       Text1.Text = ""
       Text1.Text = CmbInstrumento
       Busq = Text1.Text
      
       If Grid.Rows > 3 Then
              Grid.Text = Busq
              
              If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                    MsgBox "Moneda No se Puede Repetir", vbExclamation, TITSISTEMA
                    CmbInstrumento_KeyPress vbKeyReturn
                    Exit Sub
              Else
                    CmbInstrumento.Tag = CmbInstrumento.Text
              End If
       End If
    End If

    If KeyAscii = vbKeyEscape Then
         CmbInstrumento.Visible = False
         Grid.Text = CmbInstrumento.Tag
         Grid.SetFocus
    End If
    
    If KeyAscii = vbKeyReturn Then
        On Error GoTo fin
        Grid.Text = CmbInstrumento.Text
        CmbInstrumento.Visible = False
        Grid.SetFocus
    End If
    
fin:
End Sub

Private Sub CmbInstrumento_LostFocus()
    CmbInstrumento.Visible = False
End Sub

Private Sub CmbMonCon_Click()
    'CmbMonCon_KeyPress (13)
    'CmbKey = 0
End Sub

Private Sub CmbMonCon_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn And CmbMonCon <> "" Then
       
       Dim Ind, Sub_ind As Integer
       Dim Busq As String
         
       Text1.Text = ""
       Text1.Text = CmbMonCon
       Busq = Text1.Text
      
       If Grid.Rows > 3 Then
              Grid.Text = Busq
              
              If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                    MsgBox "Moneda No se Puede Repetir", vbExclamation, TITSISTEMA
                    CmbMonCon_KeyPress vbKeyEscape
                    Exit Sub
              Else
                    CmbMonCon.Tag = CmbMonCon.Text
              End If
       End If
    End If


    If KeyAscii = vbKeyEscape Then
         CmbMonCon.Visible = False
         Grid.Text = CmbMonCon.Tag
         Grid.SetFocus
    End If
    
    If KeyAscii = vbKeyReturn Then
        On Error GoTo fin
        Grid.Text = CmbMonCon.Text
        CmbMonCon.Visible = False
        Grid.SetFocus
    End If
    
fin:

End Sub

Private Sub Combo1_Change()

End Sub

Private Sub CmbMonCon_LostFocus()
    CmbMonCon.Visible = False
    Grid.SetFocus
End Sub

Private Sub CmbTipoEmi_Click()
    'CmbTipoEmi_KeyPress (13)
    'CmbKey = 0
End Sub

Private Sub CmbTipoEmi_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 And cmb_Moneda <> "" Then
       Dim Ind, Sub_ind As Integer
       Dim Busq As String
         
       Text1.Text = ""
       Text1.Text = CmbTipoEmi
       Busq = Text1.Text
      
       If Grid.Rows > 3 Then
              Grid.Text = Busq
              
              If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                    MsgBox "Moneda No se Puede Repetir", vbExclamation, TITSISTEMA
                    CmbTipoEmi_KeyPress vbKeyEscape
                    Exit Sub
              Else
                    CmbTipoEmi.Tag = CmbTipoEmi.Text
              End If
       End If
    End If


    If KeyAscii = vbKeyEscape Then
         CmbTipoEmi.Visible = False
         Grid.Text = CmbTipoEmi.Tag
         Grid.SetFocus
    End If
    
    If KeyAscii = vbKeyReturn Then
        On Error GoTo fin
        Grid.Text = CmbTipoEmi.Text
        CmbTipoEmi.Visible = False
        Grid.SetFocus
    End If
    
fin:
End Sub

Private Sub CmbTipoEmi_LostFocus()
    CmbTipoEmi.Visible = False
    Grid.SetFocus
End Sub

Private Sub Grid_Click()

Dim datos()
    If Right(TxtModulo.Text, 3) = "BEX" Then
        Envia = Array()
        Envia = Array("1")
        If Not Bac_Sql_Execute("SP_BUSCA_INST_BEX", Envia) Then
            MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
        Exit Sub
        End If
       
        CmbInstrumento.Clear
        Do While Bac_SQL_Fetch(datos())
            CmbInstrumento.AddItem (datos(2) & Space(100) & datos(1))
        Loop
    
        CmbInstrumento.ListIndex = -1
    
    End If
    
    
End Sub

Private Sub Grid_DblClick()

Toolbar1.Buttons(1).Enabled = True

   If Grid.Col = 1 Then
         CmbInstrumento.Top = Grid.CellTop + Grid.Top
         CmbInstrumento.Left = Grid.CellLeft + Grid.Left + 20
         CmbInstrumento.Width = Grid.CellWidth - 20
         CmbInstrumento.Visible = True
         CmbInstrumento.SetFocus
   End If
    
    If Grid.Col = 2 Then
       
       
        CmbMonCon.Top = Grid.CellTop + Grid.Top
        CmbMonCon.Left = Grid.CellLeft + Grid.Left + 20
        CmbMonCon.Width = Grid.CellWidth - 20
        CmbMonCon.Visible = True
        CmbMonCon.SetFocus
       
    End If
    
    If Grid.Col = 3 Then
    
         CmbTipoEmi.Top = Grid.CellTop + Grid.Top
         CmbTipoEmi.Left = Grid.CellLeft + Grid.Left + 20
         CmbTipoEmi.Width = Grid.CellWidth - 20
         CmbTipoEmi.Visible = True
         CmbTipoEmi.SetFocus
    End If
    
    If Grid.Col = 4 Then
    
         CmbEmisor.Top = Grid.CellTop + Grid.Top
         CmbEmisor.Left = Grid.CellLeft + Grid.Left + 20
         CmbEmisor.Width = Grid.CellWidth - 20
         CmbEmisor.Visible = True
         CmbEmisor.SetFocus
    End If
    
    
    
   If Grid.Col = 5 Then
        Text2.Height = Grid.CellHeight
        Text2.Top = Grid.CellTop + Grid.Top
        Text2.Left = Grid.CellLeft + Grid.Left + 20
        Text2.Width = Grid.CellWidth - 20
        Text2.Visible = True
        Text2.SetFocus

   End If
      If Grid.Col = 6 Then
         txtgrilla3.Height = Grid.CellHeight
         txtgrilla3.Top = Grid.CellTop + Grid.Top
         txtgrilla3.Left = Grid.CellLeft + Grid.Left + 20
         txtgrilla3.Width = Grid.CellWidth - 20
         txtgrilla3.Visible = True
         txtgrilla3.SetFocus

    End If


  If Grid.Col = 10 Then
  TextCodCont.Height = Grid.CellHeight
  TextCodCont.Top = Grid.CellTop + Grid.Top
  TextCodCont.Left = Grid.CellLeft + Grid.Left + 20
  TextCodCont.Width = Grid.CellWidth - 20
  TextCodCont.Visible = True
  TextCodCont.SetFocus
  End If

  If Grid.Col = 12 Then
  TextCodCorr.Height = Grid.CellHeight
  TextCodCorr.Top = Grid.CellTop + Grid.Top
  TextCodCorr.Left = Grid.CellLeft + Grid.Left + 20
  TextCodCorr.Width = Grid.CellWidth - 20
  TextCodCorr.Visible = True
  TextCodCorr.SetFocus
  End If

End Sub

Private Sub Grid_GotFocus()
    
    Toolbar1.Buttons(4).Enabled = True
    Toolbar1.Buttons(2).Enabled = False
    
End Sub

Private Sub Grid_KeyUp(KEYCODE As Integer, Shift As Integer)
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
'    If inicio = 1 Then
'
'        Grid.Col = colpress
'        Grid.Row = rowpress
'        Grid.ColSel = colpress
'
'    End If
'
'    inicio = 1
'
fin:
End Sub

Private Sub Grid_Scroll()
    

    CmbMonCon.Visible = False
    CmbInstrumento.Visible = False
    CmbEmisor.Visible = False
    CmbTipoEmi.Visible = False
    Text2.Visible = False
    
    
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False
End Sub

Private Sub Text2_Change()
''''    Text2_KeyPress (13)
''''    CmbKey = 0
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
   
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))

Char = "'&()?¿%·*+$""@!¡{}¨Ç"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then
        SW2 = 1
        Exit For
    End If

Next I

If SW2 = 1 Then

    KeyAscii = 0

End If


  If KEYCODE = 45 Then
      
      If Campos_Blancos = 0 Then
          
          Grid.Col = 1
          Grid.SetFocus
          Grid.AddItem ("")
          Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
          Grid.SetFocus
     
     Else
        
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
     
     End If
 
 End If
 
        If KeyAscii = 27 Then
             
             Text2.Visible = False
             Text2.Text = ""
             Text2.Text = Grid.Text
             Grid.Text = Text2.Text
             'Grid.Col = 7
             Grid.SetFocus
         
        End If
            
  If KeyAscii = 13 Then  ''And Grid.Col = 6 Then
     Text2.Visible = False
     Text2.Tag = Grid.Text
     Grid.Text = Text2.Text
           
 
     Grid.SetFocus
  End If
   
End Sub

Private Sub Text2_LostFocus()
    Text2.Visible = False
    Grid.SetFocus
End Sub

Private Sub TextCodCont_GotFocus()
If Grid.Text <> "" Then
  TextCodCont.Text = Grid.Text
End If
 cmb_pais.Visible = False
 cmb_plaza.Visible = False
 cmbBANCE.Visible = False
 TXTFecha1.Visible = False
 TXTGRILLA.Visible = False
 txtgrilla2.Visible = False
 txtgrilla3.Visible = False
 cmb_Moneda.Visible = False
 TextCodCorr.Visible = False
End Sub

Private Sub TextCodCont_KeyPress(KeyAscii As Integer)
If KeyAscii = 45 Then
      If Campos_Blancos = 0 Then
        Grid.Col = 1
        Grid.SetFocus
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
        Grid.SetFocus
      Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
      End If
Else
  
 If KeyAscii = 27 Then
    Grid.Col = 10
    TextCodCont.Visible = False
    Grid.SetFocus
 End If
      
 If KeyAscii = 13 And Grid.Col = 10 Then
 
   TextCodCont.Visible = False
   Grid.Text = TextCodCont.Text
   TextCodCont.Tag = Grid.Text
   Grid.Text = TextCodCont.Text
   Grid.SetFocus
 End If
 
 End If

End Sub

Private Sub TextCodCont_LostFocus()
 If TextCodCont.Visible = True Then
    TextCodCont.Visible = False
    Grid.SetFocus
 End If
End Sub


Private Sub TextCodCorr_GotFocus()
If Grid.Text <> "" Then
  TextCodCorr.Text = Grid.Text
End If
 cmb_pais.Visible = False
 cmb_plaza.Visible = False
 cmbBANCE.Visible = False
 TXTFecha1.Visible = False
 TXTGRILLA.Visible = False
 txtgrilla2.Visible = False
 txtgrilla3.Visible = False
 cmb_Moneda.Visible = False
 TextCodCont.Visible = False
End Sub

Private Sub TextCodCorr_KeyPress(KeyAscii As Integer)
If KeyAscii = 45 Then
      If Campos_Blancos = 0 Then
        Grid.Col = 1
        Grid.SetFocus
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
        Grid.SetFocus
      Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
      End If
Else
  
 If KeyAscii = 27 Then
    Grid.Col = 10
    TextCodCorr.Visible = False
    Grid.SetFocus
 End If
      
 If KeyAscii = 13 And Grid.Col = 12 Then
 
   TextCodCorr.Visible = False
   Grid.Text = TextCodCorr.Text
   TextCodCorr.Tag = Grid.Text
   Grid.Text = TextCodCorr.Text
   Grid.SetFocus
 End If
 
 End If


End Sub

Private Sub TextCodCorr_LostFocus()
 If TextCodCorr.Visible = True Then
    TextCodCorr.Visible = False
    Grid.SetFocus
 End If
End Sub












Private Sub TxtCodigo_DblClick()
    BacAyuda.Tag = "PosGrupal"
    BacAyuda.Show 1
    If giAceptar = True Then
        TxtCodigo.Text = RetornoAyuda
        Call Buscar
        Call BuscarDetalle
        DoEvents
        DoEvents
        DoEvents
        Grid.Row = 2
        Grid.Col = 1
        Grid.Refresh
    End If
    Toolbar1.Buttons(1).Enabled = True
End Sub

Private Sub txtFecha1_Change()

          On Error GoTo fin:
          Grid.Col = 9
          TXTFecha1.Tag = Grid.Text
          Grid.Text = TXTFecha1.Text
                   
          Cont = 0

          If Format(Grid.Text, "yyyy") > Format(Date, "yyyy") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") = Format(Date, "mm") And Format(Grid.Text, "dd") >= Format(Date, "dd") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") > Format(Date, "mm") Then Cont = 1
          
          If Cont = 0 Then
                
                Grid.Text = TXTFecha1.Tag
                TXTFecha1.Text = TXTFecha1.Tag
                
          End If
 

 
fin:


End Sub

Private Sub TXTFecha1_GotFocus()

    If Grid.Text <> "" Then
    
        TXTFecha1.Text = Grid.Text
    
    End If
    
    
    TXTFecha1.BackColor = &H8000000D
    TXTFecha1.ForeColor = &H8000000E
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    cmb_Moneda.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub TXTFecha1_KeyPress(KeyAscii As Integer)

If KeyAscii = 45 Then
      If Campos_Blancos = 0 Then
        Grid.Col = 1
        Grid.SetFocus
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
        Grid.SetFocus
      Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
      End If
Else
  
      If KeyAscii = 27 And Grid.Col = 9 Then
           Grid.Col = 9
             TXTFecha1.Visible = False
             Grid.SetFocus
           
                          
      End If
      If KeyAscii = 13 Then
      On Error GoTo fin:
          Grid.Col = 9
          TXTFecha1.Tag = Grid.Text
          TXTFecha1.Visible = False
          Grid.Text = TXTFecha1.Text
          Grid.SetFocus
            
          Cont = 0

          If Format(Grid.Text, "yyyy") > Format(Date, "yyyy") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") = Format(Date, "mm") And Format(Grid.Text, "dd") >= Format(Date, "dd") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") > Format(Date, "mm") Then Cont = 1
            
          If Cont <> 1 Then
              MsgBox "Error Fecha de Vencimiento Debe ser Mayor o Igual a la Fecha Actual", vbInformation, TITSISTEMA
              TXTFecha1.Visible = True
              Grid.Text = TXTFecha1.Tag
              TXTFecha1.SetFocus
            
          End If
          
       End If
  
 End If

 
fin:
End Sub

Private Sub TXTFecha1_LostFocus()

    TXTFecha1.BackColor = &H8000000E
    TXTFecha1.ForeColor = &H80000008
    
    TXTFecha1.Text = Grid.TextMatrix(Grid.Row, 9)
    
    If TXTFecha1.Visible = True Then
    
        TXTFecha1.Visible = False
        Grid.SetFocus
        
    End If
    

End Sub

Private Sub TXTGRILLA_GotFocus()

    If Grid.Text <> "" Then
    
        TXTGRILLA.Text = Grid.Text
    
    End If
    'cmb_pais.Visible = False
    'cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    'cmb_Moneda.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub TxtGrilla_LostFocus()
       
If TXTGRILLA.Visible = True Then

       TXTGRILLA.Visible = False
       TXTGRILLA.Tag = TXTGRILLA.Text
  

      Grid.SetFocus

End If

End Sub

Private Sub txtgrilla2_GotFocus()

    If Grid.Text <> "" Then
        
        txtgrilla2.Text = Grid.Text
    
    End If
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    cmb_Moneda.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub txtgrilla2_LostFocus()
 
  If txtgrilla2.Visible = True Then
        
        txtgrilla2.Visible = False
        'Grid.Col = 6
        Grid.SetFocus
        
  End If

End Sub

Private Sub txtgrilla3_GotFocus()

    If Grid.Text <> "" Then
    
        txtgrilla3.Text = Grid.Text
    
    End If
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    cmb_Moneda.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False
End Sub

Private Sub txtgrilla3_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))

Char = "'&()?¿%·*+=$<>""@!¡{}¨Ç"
SW2 = 0

For I = 1 To Len(Char)
    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then
        SW2 = 1
        Exit For
    End If
Next I

If SW2 = 1 Then
    KeyAscii = 0
End If


  If KEYCODE = vbKeyInsert Then
      
      If Campos_Blancos = 0 Then
          Grid.Col = 1
          Grid.SetFocus
          Grid.AddItem ("")
          Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
          Grid.SetFocus
     Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
     End If
 
 End If
 
        If KeyAscii = vbKeyEscape Then
             txtgrilla3.Visible = False
             txtgrilla3.Text = ""
             txtgrilla3.Text = Grid.Text
             Grid.Text = txtgrilla3.Text
             'Grid.Col = 7
             Grid.SetFocus
        End If
            
  If KeyAscii = vbKeyReturn And Grid.Col = 6 Then
     txtgrilla3.Visible = False
     txtgrilla3.Tag = Grid.Text
     Grid.Text = txtgrilla3.Text
     Grid.SetFocus
  End If

End Sub


Private Sub txtgrilla3_LostFocus()
    
    If txtgrilla3.Visible = True Then
                

        txtgrilla3.Visible = False

        
        'Grid.Col = 7
        Grid.SetFocus
    
    End If

End Sub

Private Sub txtgrilla4_GotFocus()

   If Grid.Text <> "" Then
     txtgrilla4.Text = Grid.Text
   End If
   cmb_pais.Visible = False
   cmb_plaza.Visible = False
   cmbBANCE.Visible = False
   TXTFecha1.Visible = False
   TXTGRILLA.Visible = False
   txtgrilla2.Visible = False
   txtgrilla3.Visible = False
   cmb_Moneda.Visible = False
   TextCodCont.Visible = False
   TextCodCorr.Visible = False

End Sub

Private Sub txtgrilla4_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next I

If SW2 = 1 Then

    KeyAscii = 0

End If

    If KeyAscii = 45 Then
         
         If Campos_Blancos = 0 Then
              
              Grid.Col = 1
              Grid.SetFocus
              Grid.AddItem ("")
              Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
              Grid.SetFocus
         
         Else
            
            MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
            Grid.SetFocus
         
         End If
     Else
     
        If KeyAscii = 27 Then
             
             txtgrilla4.Visible = False
             txtgrilla4.Text = ""
             txtgrilla4.Text = Grid.Text
             Grid.Text = txtgrilla4.Text
             'Grid.Col = 8
             Grid.SetFocus
        
        End If
            
        If KeyAscii = 13 And Grid.Col = 7 Then
            
             txtgrilla4.Visible = False
             Grid.Text = txtgrilla4.Text
 
             Grid.SetFocus
        
        End If
      
     
    End If

End Sub


Private Sub txtgrilla4_LostFocus()
 If txtgrilla4.Visible = True Then
    txtgrilla4.Visible = False
    Grid.SetFocus
 End If
End Sub

Private Sub txtNombre_GotFocus()
  txtNombre.BackColor = &H8000000D
  txtNombre.ForeColor = &H8000000E
End Sub

Private Sub txtNombre_LostFocus()

    txtNombre.BackColor = &H8000000E
    txtNombre.ForeColor = &H80000008

End Sub



Private Sub TxtRut_DblClick()
   
End Sub

Private Sub TxtRut_GotFocus()

    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(4).Enabled = False
    txtRut.BackColor = &H8000000D
    txtRut.ForeColor = &H8000000E

End Sub




Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    inicio = 0
    SWGRA = 0
    paisactivo = 0
    BUS = 0
    
     
     Call Limpiar
     
     Call Cargar_Grilla
     
     Toolbar1.Buttons(2).Visible = False
     SW2 = 0
     
     
End Sub

Sub Limpiar()
        
     CmbKey = 0
        Toolbar1.Buttons(1).Enabled = False
                    
     
     CmbEmisor.Visible = False
     CmbInstrumento.Visible = False
     CmbMonCon.Visible = False
     CmbTipoEmi.Visible = False
     Text2.Visible = False
     
     
     TxtCodigo.Text = ""
     TxtGlosa.Text = ""
     TxtModulo.Text = ""
     cmbBANCE.Visible = False
     TXTFecha1.Visible = False
     TXTGRILLA.Visible = False
     txtgrilla2.Visible = False
     txtgrilla3.Visible = False
     txtgrilla4.Visible = False
     TXTFecha1.Text = Date
     TXTGRILLA.Text = ""
     txtgrilla2.Text = ""
     txtgrilla3.Text = ""
     txtgrilla4.Text = ""
     TextCodCont.Text = ""
     TextCodCorr.Text = ""
     TextCodCorr.Visible = False
     TextCodCont.Visible = False
     Grid.Rows = 2
     Grid.Col = 0
     
     Call Correspon_Limpia
     Call Carga_Datos

    TxtCodigo.Enabled = True

End Sub

Sub Correspon_Limpia()
     
    

    

End Sub
Sub Carga_Datos()
Dim datos()

     
    Envia = Array()
    Envia = Array("3")
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Sub
    End If
   
    CmbEmisor.Clear
    Do While Bac_SQL_Fetch(datos())
      CmbEmisor.AddItem (datos(1) & Space(100) & datos(2)) ''(datos(1) & Space(60 - Len(datos(1))) & datos(3) & Space(4 - Len(datos(3))) & datos(5) & Space(6 - Len(datos(5))) & datos(2) & Space(11 - Len(datos(2))) & datos(4) & Space(30 - Len(datos(4))))
    Loop
    
    CmbEmisor.ListIndex = -1
    
    
    Envia = Array()
    Envia = Array("5")
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Sub
    End If
   
    CmbInstrumento.Clear
    Do While Bac_SQL_Fetch(datos())
      CmbInstrumento.AddItem (datos(3) & Space(100) & datos(1))
    Loop
    
    CmbInstrumento.ListIndex = -1
    
    Envia = Array()
    Envia = Array("1")
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Sub
    End If
   
    
    CmbMonCon.Clear
    Do While Bac_SQL_Fetch(datos())
      CmbMonCon.AddItem (datos(3) & Space(100) & datos(1))
    Loop
    
    CmbMonCon.ListIndex = -1
    
    Envia = Array()
    Envia = Array("6")
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Sub
    End If
   
    CmbTipoEmi.Clear
    Do While Bac_SQL_Fetch(datos())
      CmbTipoEmi.AddItem (datos(2) & Space(100) & datos(1))
    Loop
    
    CmbTipoEmi.ListIndex = -1





End Sub
Private Sub Grid_KeyDown(KEYCODE As Integer, Shift As Integer)
Dim SW3 As Integer
Dim Y As Integer
Dim G As Integer
Dim k As Integer
Dim I As Integer

Toolbar1.Buttons(1).Enabled = True
    
    If KEYCODE = vbKeyInsert Then
        SWGRA = 1
        TXTGRILLA.Text = ""
        txtgrilla2.Text = ""
        txtgrilla3.Text = ""
        txtgrilla4.Text = ""
     
        If Campos_Blancos = 1 Then
            MsgBox "Deben haber datos antes de Insertar Otra fila", vbExclamation + vbOKOnly, TITSISTEMA
            Grid.SetFocus
        Else
            Grid.Col = 1
            Grid.SetFocus
            Grid.AddItem ("")
            Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
            Grid.SetFocus
        End If
    
    End If
    
    If KEYCODE = vbKeyDelete Then
        On Error GoTo Fin2:
        Cont = 0
        
        For I = 1 To Grid.Cols - 1
            If Grid.TextMatrix(Grid.Row, I) = "" Then
                Cont = Cont + 1
            End If
        Next I
        
        If Cont >= 1 Then
            Grid.RemoveItem (Grid.Row)
            Limpia
        Else
            Call EliminarRegistro
            Limpia
            Exit Sub
        End If
    End If

    If inicio = 1 Then
        colpress = Grid.Col
        rowpress = Grid.Row
        Grid.ColSel = colpress
    End If

    Grid.SetFocus
    Exit Sub

Fin2:
    For I = 1 To Grid.Cols - 1
        Grid.TextMatrix(Grid.Row, I) = ""
    Next I
    
    If Grid.Rows > 3 Then
        Grid.Col = 1
        Grid.Row = 2
        Grid.SetFocus
    Else
        Grid.Col = 0
        Grid.Row = 0
    End If
    
    Limpia
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim I As Integer
   Dim var1 As String
   Dim SW As Integer
   Dim VAR2 As Integer
   Dim datos()
   
   If TXTGRILLA.Visible = True Then
   
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
   
   If CmbEmisor.Visible = True Then
   
        CmbEmisor_KeyPress (13)
   
   End If
   If CmbInstrumento.Visible = True Then
   
        CmbInstrumento_KeyPress (13)
   
   End If
   If CmbMonCon.Visible = True Then
   
        CmbMonCon_KeyPress (13)
   
   End If
   If TXTFecha1.Visible = True Then
   
        TXTFecha1_KeyPress (13)
   
   End If
   
   If TextCodCont.Visible = True Then
       TextCodCont_KeyPress (13)
   End If

   If TextCodCorr.Visible = True Then
       TextCodCorr_KeyPress (13)
   End If

   
   Select Case Button.Index
       Case 1
       

             Call guardarDetalle
             CmbEmisor.Enabled = True
       
       Case 2
           
      
      Case 3
          
          Call EliminarRegistro


          
      Case 4
           Call Limpiar
           Toolbar1.Buttons(3).Enabled = False
      
         
      Case 5
           Unload Me
      
   End Select
 
    Exit Sub
 
End Sub
Private Sub guardarDetalle()

On Error GoTo fin:

Dim SW As Integer
Dim I As Long
Dim datos()
Dim Y As Integer
Dim Mensaje, Estilo, Título, Respuesta
Dim Rut As Double

Screen.MousePointer = vbHourglass
  
  SWGRA = 1
  If SWGRA = 1 Then
        'Call Bac_Sql_Execute("BEGIN TRANSACTION")
        Envia = Array("B")
        If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
            Screen.MousePointer = vbDefault
            MsgBox "Error en Begin Transaction", vbCritical, TITSISTEMA
            Exit Sub
        End If
        
             Envia = Array()
             AddParam Envia, "I"
             AddParam Envia, Trim(Format(TxtCodigo.Text, "00"))
             AddParam Envia, ""
             AddParam Envia, 0
             AddParam Envia, 0
             AddParam Envia, 0
             AddParam Envia, ""
             AddParam Envia, 0
             AddParam Envia, ""  ''Left(CmbTipoEmi.Text, 50)
             AddParam Envia, ""
             AddParam Envia, "E"
        
             If Not Bac_Sql_Execute("SP_MTN_DETALLE_GRUPAL", Envia) Then
                 Envia = Array("R")
                 Call Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia)
                 Screen.MousePointer = vbDefault
                 MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
                 Exit Sub
             End If

             For I = 2 To Grid.Rows - 1
                'Grid.Row = I
            
                Envia = Array()
                AddParam Envia, "I"
                AddParam Envia, Trim(Format(TxtCodigo.Text, "00"))
                AddParam Envia, Trim(Right(TxtModulo.Text, 3))
                AddParam Envia, IIf(Right(Grid.TextMatrix(I, 4), 9) = "", 0, Right(Grid.TextMatrix(I, 4), 9))
                AddParam Envia, Right(Grid.TextMatrix(I, 1), 5) ''CDbl(Trim(Right(Left(CmbEmisor.Text, 80), 15)))
                AddParam Envia, Right(Grid.TextMatrix(I, 2), 4) ''CDbl(Trim(Right(CmbInstrumento.Text, 5)))
                AddParam Envia, Trim(TxtGlosa.Text)
                AddParam Envia, Right(Grid.TextMatrix(I, 3), 4)  ''Right(CmbTipoEmi.Text, 4)
                AddParam Envia, Left(Grid.TextMatrix(I, 3), 30)  ''Left(CmbTipoEmi.Text, 50)
                AddParam Envia, Grid.TextMatrix(I, 5)
                
                If Right(Grid.TextMatrix(I, 1), 9) = "" Then
                    Envia = Array("R")
                    Call Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia)
                    Screen.MousePointer = vbDefault
                    MsgBox "Existen Datos Vacíos", vbCritical, TITSISTEMA
                    Grid.Col = 1
                    Grid.Row = I
                    Exit Sub
                End If
                
                If Right(Grid.TextMatrix(I, 2), 4) = "" Then
                    Envia = Array("R")
                    Call Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia)
                    Screen.MousePointer = vbDefault
                    MsgBox "Existen Datos Vacíos", vbCritical, TITSISTEMA
                    Grid.Col = 2
                    Grid.Row = I
                    Exit Sub
                End If
                
                If Right(Grid.TextMatrix(I, 3), 5) = "" Then
                    Envia = Array("R")
                    Call Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia)
                    Screen.MousePointer = vbDefault
                    MsgBox "Existen Datos Vacíos", vbCritical, TITSISTEMA
                    Grid.Row = I
                    Grid.Col = 3
                    Exit Sub
                End If
                
                If Not Bac_Sql_Execute("SP_MTN_DETALLE_GRUPAL", Envia) Then
                    Envia = Array("R")
                    Call Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia)
                    Screen.MousePointer = vbDefault
                    MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
                    Exit Sub
                Else
                       SW = 1
                End If
            Next I
 
 End If
  
 If SW = 1 Then
    Toolbar1.Buttons(1).Enabled = True
    Envia = Array("C")
    Call Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia)
    Screen.MousePointer = vbDefault
    MsgBox "La información ha sido Grabada", vbInformation + vbOKOnly, TITSISTEMA
    Grid.SetFocus
 End If
 
 If SW = 2 Then
      Envia = Array("C")
      Call Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia)
      Screen.MousePointer = vbDefault
      MsgBox "La información ha sido Modificada", vbInformation + vbOKOnly, TITSISTEMA
      Grid.SetFocus
 End If
   
 Toolbar1.Buttons(3).Enabled = False
 Toolbar1.Buttons(2).Enabled = False
 Toolbar1.Buttons(4).Enabled = True

If KEYCODE = 46 Then
   Toolbar1.Buttons(2).Enabled = True
   Screen.MousePointer = vbDefault
   Call Eliminar
End If
fin:
    Screen.MousePointer = vbDefault
End Sub
Private Sub TxtGrilla_KeyPress(KeyAscii As Integer)

Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next I

If SW2 = 1 Then

    KeyAscii = 0

End If

If Chr(KeyAscii) = "-" Then GoTo fin:
    


    If KeyAscii = 45 Then
          
          If Campos_Blancos = 0 Then
              
              Grid.Col = 1
              Grid.SetFocus
              Grid.AddItem ("")
              Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
              Grid.SetFocus
         
         Else
            
            MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
            Grid.SetFocus
         
         End If
    Else
      If KeyAscii = 27 Then
          
          TXTGRILLA.Visible = False
          TXTGRILLA.Text = ""

          Grid.Text = TXTGRILLA.Tag

          Grid.SetFocus
       
       End If
       
       If KeyAscii = 13 Then
       
            Dim Ind2, Sub_ind2 As Integer
            Dim Busq2 As String
            Text1.Text = ""
            Text1.Text = TXTGRILLA.Text
            Busq2 = Text1.Text
          
      
    
            
            Grid.Text = Busq2
            
            If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
            
                MsgBox "Codigo Swift No se Puede Repetir ", vbInformation, TITSISTEMA
                TXTGRILLA.Text = ""
                TxtGrilla_KeyPress (27)
                Exit Sub
            
            End If
            
            TXTGRILLA.Tag = TXTGRILLA.Text
            Grid.Text = TXTGRILLA.Text
            TXTGRILLA.Text = ""
            TXTGRILLA.Visible = False
         
          
         

            Grid.SetFocus
    
       End If
       
     
       If KeyAscii = 13 And Grid.Col = 9 Then
          
          TXTGRILLA.Visible = False
          Grid.Text = TXTGRILLA.Text
          TXTGRILLA.Text = ""
       
       End If
     
     End If
     
     If KEYCODE = 46 Then
      
        Toolbar1.Buttons(2).Enabled = True
        Call Eliminar
     
     End If
 
fin:
 
End Sub
Private Sub Grid_KeyPress(KeyAscii As Integer)

Toolbar1.Buttons(1).Enabled = True
 
If KeyAscii = vbKeyInsert Then
    SWGRA = 1
    TXTGRILLA.Text = ""
    txtgrilla2.Text = ""
    txtgrilla3.Text = ""
    txtgrilla4.Text = ""
    TextCodCont.Text = ""
    
    If Campos_Blancos = 0 Then
        Grid.Col = 1
        Grid.SetFocus
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
        Limpia
        Grid.SetFocus
    Else
        MsgBox "Debe Existir datos antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
    End If
Else

    If KeyAscii = vbKeyEscape Then
        MsgBox "Operacion Invalida ", vbExclamation + vbOKOnly, TITSISTEMA
        Grid.SetFocus
    Else
        If Grid.Col = 1 Then
            CmbInstrumento.Tag = Grid.Text
            CmbInstrumento.Top = Grid.CellTop + Grid.Top
            CmbInstrumento.Left = Grid.CellLeft + Grid.Left + 20
            CmbInstrumento.Width = Grid.CellWidth - 20
            CmbInstrumento.Visible = True
            CmbInstrumento.SetFocus
        End If
        
        If Grid.Col = 2 Then
            CmbMonCon.Tag = Grid.Text
            CmbMonCon.Top = Grid.CellTop + Grid.Top
            CmbMonCon.Left = Grid.CellLeft + Grid.Left + 20
            CmbMonCon.Width = Grid.CellWidth - 20
            CmbMonCon.Visible = True
            CmbMonCon.SetFocus
        End If
    
        If Grid.Col = 3 Then
            CmbTipoEmi.Tag = Grid.Text
            CmbTipoEmi.Top = Grid.CellTop + Grid.Top
            CmbTipoEmi.Left = Grid.CellLeft + Grid.Left + 20
            CmbTipoEmi.Width = Grid.CellWidth - 20
            CmbTipoEmi.Visible = True
            CmbTipoEmi.SetFocus
        End If
    
        If Grid.Col = 4 Then
            CmbEmisor.Tag = Grid.Text
            CmbEmisor.Top = Grid.CellTop + Grid.Top
            CmbEmisor.Left = Grid.CellLeft + Grid.Left + 20
            CmbEmisor.Width = Grid.CellWidth - 20
            CmbEmisor.Visible = True
            CmbEmisor.SetFocus
        End If
    
        If Grid.Col = 5 Then
             Text2.Height = Grid.CellHeight
             Text2.Top = Grid.CellTop + Grid.Top
             Text2.Left = Grid.CellLeft + Grid.Left + 20
             Text2.Width = Grid.CellWidth - 20
             Text2.Visible = True
             Text2.Text = ""
             Text2.SetFocus
        End If
        
        If Grid.Col = 6 Then
            txtgrilla3.Height = Grid.CellHeight
            txtgrilla3.Top = Grid.CellTop + Grid.Top
            txtgrilla3.Left = Grid.CellLeft + Grid.Left + 20
            txtgrilla3.Width = Grid.CellWidth - 20
            txtgrilla3.Visible = True
            txtgrilla3.SetFocus
        End If

        If Grid.Col = 10 Then
            TextCodCont.Height = Grid.CellHeight
            TextCodCont.Top = Grid.CellTop + Grid.Top
            TextCodCont.Left = Grid.CellLeft + Grid.Left + 20
            TextCodCont.Width = Grid.CellWidth - 20
            TextCodCont.Visible = True
            TextCodCont.SetFocus
        End If

        If Grid.Col = 12 Then
            TextCodCorr.Height = Grid.CellHeight
            TextCodCorr.Top = Grid.CellTop + Grid.Top
            TextCodCorr.Left = Grid.CellLeft + Grid.Left + 20
            TextCodCorr.Width = Grid.CellWidth - 20
            TextCodCorr.Visible = True
            TextCodCorr.SetFocus
        End If
    End If
    
    If KEYCODE = vbKeyDelete Then
        Toolbar1.Buttons(2).Enabled = True
    End If
End If

End Sub
Private Sub txtgrilla2_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For I = 1 To Len(Char)

    If Mid(Char, I, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next I

If SW2 = 1 Then

    KeyAscii = 0

End If

If KeyAscii = 45 Then
   
   If Campos_Blancos = 0 Then
     
       Grid.Col = 1
       Grid.SetFocus
       Grid.AddItem ("")
       Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
       Grid.SetFocus
    
    Else
      
       MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
       Grid.SetFocus
  
  End If

Else
  
    If KeyAscii = 27 Then
        
        txtgrilla2.Visible = False
        txtgrilla2.Text = ""
        txtgrilla2.Text = Grid.Text
        Grid.Text = txtgrilla2.Text

        Grid.SetFocus
     
     End If
     
     If KeyAscii = 13 Then
        
        txtgrilla2.Visible = False
        Grid.Text = txtgrilla2.Text
        txtgrilla2.Text = ""
        
        Grid.SetFocus

     End If


End If

If KEYCODE = 46 Then
 
    Toolbar1.Buttons(2).Enabled = True
    Call Eliminar

End If

End Sub

Sub Eliminar()
On Error GoTo fin:
Dim datos()
Dim Y As Integer
Dim SW As Integer
Dim I As Long
       Grid.SetFocus
 
     If Grid.RowSel >= 2 Then
       If MsgBox("¿Seguro de eliminar Registro?", vbYesNo, TITSISTEMA) = vbYes Then
            
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
                     

                  
                  End If
               End If
               

     
               a = Grid.Rows - 1
            
          End If
    End If
    
    Grid.SetFocus
 
fin:
End Sub

Function Campos_Blancos() As Integer
Dim Y As Integer
Dim G As Integer
    Y = Grid.Rows - 1
        Campos_Blancos = 0
      For k = 1 To 3
        If k = 7 Then
           Grid.TextMatrix(Y, k) = 0
        ElseIf k = 4 And Grid.TextMatrix(Y, k) = "" Then
           Grid.TextMatrix(Y, k) = " "
           ElseIf k = 11 And Grid.TextMatrix(Y, 3) = "" Then
            Grid.TextMatrix(Y, 11) = 0
         End If
        
      If Grid.TextMatrix(Y, k) = "" Or Grid.TextMatrix(Y, k) = "." Then
        Campos_Blancos = 1
      End If
    Next k
  
End Function



Private Sub txtRut_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     SendKeys "{tab}"
  End If
End Sub

Private Sub TxtRut_LostFocus()
  txtRut.BackColor = &H8000000E
  txtRut.ForeColor = &H80000008
End Sub



Sub Limpia()

     TXTFecha1.Text = Date
     TXTGRILLA.Text = ""
     txtgrilla2.Text = ""
     txtgrilla3.Text = ""
     txtgrilla4.Text = ""
        
     TXTFecha1.Tag = Date
     TXTGRILLA.Tag = ""
     txtgrilla2.Tag = ""
     txtgrilla3.Tag = ""
     txtgrilla4.Tag = ""

End Sub


Function Verifica_Existencia(Moneda, pais, plaza, TipoCli As String) As Boolean
Dim I As Long
Dim ContV As Integer

    Verifica_Existencia = False
    
    ContV = 0
    
    For I = 1 To Grid.Rows - 1
    
        If Mid(Grid.TextMatrix(I, 1), 1, 50) = Mid(Moneda, 1, 50) And Mid(Grid.TextMatrix(I, 2), 1, 50) = Mid(pais, 1, 50) _
           And Mid(Grid.TextMatrix(I, 3), 1, 50) = Mid(plaza, 1, 50) And Mid(Grid.TextMatrix(I, 4), 1, 50) = Mid(TipoCli, 1, 50) Then
            
            ContV = ContV + 1
            If ContV > 1 Then
                
                Verifica_Existencia = True
                Exit Function
                
            End If
           
        
        End If
    
    Next I

End Function

Private Function Buscar()
    Dim datos()
    
    
    
   Call Cargar_Grilla
   
   Grid.Enabled = True
   Grid.AddItem ("")
   Grid.RowHeight(2) = 315
   Grid.Row = 2
   
   TxtGlosa.Text = ""
    
    Envia = Array()
    AddParam Envia, "B"
    AddParam Envia, Format(TxtCodigo.Text, "00")
    If Not Bac_Sql_Execute("SP_MTN_GLOSA_GRUPAL_POSICION", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(datos())
        TxtGlosa.Text = datos(2)
        TxtModulo.Text = datos(4) + Space(50) + datos(3)
        TxtCodigo.Enabled = False
        
    Loop
    
    
    
End Function

Private Sub TXTNumero1_Change()

End Sub

Private Function EliminarRegistro()

    
    If MsgBox("¿ Esta seguro que desea Eliminar ?", vbYesNo + vbQuestion, TITSISTEMA) = vbNo Then
        Exit Function
    End If
    

    
    Envia = Array()
    AddParam Envia, "E"
    AddParam Envia, Format(TxtCodigo.Text, "00")
    AddParam Envia, Trim(Right(TxtModulo.Text, 3))
    AddParam Envia, IIf(Right(Grid.TextMatrix(Grid.Row, 4), 9) = "", 0, Right(Grid.TextMatrix(Grid.Row, 4), 9))
    AddParam Envia, Right(Grid.TextMatrix(Grid.Row, 1), 5)
    AddParam Envia, Right(Grid.TextMatrix(Grid.Row, 2), 4)
    AddParam Envia, Trim(TxtGlosa.Text)
    AddParam Envia, Right(Grid.TextMatrix(Grid.Row, 3), 5)
    AddParam Envia, Left(Grid.TextMatrix(Grid.Row, 3), 30)
    AddParam Envia, Grid.TextMatrix(Grid.Row, 5)
    
    If Not Bac_Sql_Execute("SP_MTN_DETALLE_GRUPAL", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
       
       Call BuscarDetalle
    
    MsgBox "La eliminación de los datos fué correcta", vbInformation, TITSISTEMA

End Function

