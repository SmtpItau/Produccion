VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacModificacionCarterasFinancieras 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Modificación de las Carteras Financieras"
   ClientHeight    =   4245
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11235
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4245
   ScaleWidth      =   11235
   Begin VB.Frame Frame1 
      Caption         =   "Operaciones"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3705
      Left            =   105
      TabIndex        =   1
      Top             =   495
      Width           =   11040
      Begin VB.CommandButton Boton_Ayuda 
         Caption         =   "?"
         Height          =   255
         Left            =   6120
         TabIndex        =   29
         Top             =   600
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.CheckBox Check1 
         Height          =   315
         Left            =   5520
         TabIndex        =   27
         Top             =   600
         Width           =   495
      End
      Begin BACControles.TXTNumero txt_NumOper 
         Height          =   315
         Left            =   4080
         TabIndex        =   24
         Top             =   585
         Width           =   1080
         _ExtentX        =   1905
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Max             =   "999999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Frame Frame2 
         Caption         =   "Carteras Financieras"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3705
         Left            =   6675
         TabIndex        =   20
         Top             =   0
         Width           =   4365
         Begin VB.ListBox ListCartera_Finan 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   3375
            Left            =   150
            TabIndex        =   21
            Top             =   240
            Width           =   3975
         End
      End
      Begin VB.ComboBox Cmb_Modulo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   195
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   600
         Width           =   900
      End
      Begin VB.Frame Frame4 
         Caption         =   "Flujos Pasivos de Swap"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1095
         Left            =   150
         TabIndex        =   2
         Top             =   2520
         Width           =   6450
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Monto"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   1470
            TabIndex        =   8
            Top             =   360
            Width           =   540
         End
         Begin VB.Label LblMontoFP_Oper 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   120
            TabIndex        =   7
            Top             =   600
            Width           =   1935
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Moneda"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   2115
            TabIndex        =   6
            Top             =   360
            Width           =   675
         End
         Begin VB.Label LblMonedaFP_Oper 
            Alignment       =   2  'Center
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   2085
            TabIndex        =   5
            Top             =   600
            Width           =   975
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Financiera"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   3075
            TabIndex        =   4
            Top             =   360
            Width           =   1560
         End
         Begin VB.Label LblIndicadorTasaP_Oper 
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   3075
            TabIndex        =   3
            Top             =   600
            Width           =   3255
         End
      End
      Begin VB.Label Mensaje 
         Caption         =   "Novación requiere modificar operación en el sistema Origen"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   1440
         TabIndex        =   28
         Top             =   960
         Visible         =   0   'False
         Width           =   5175
      End
      Begin VB.Label Label4 
         Caption         =   "Novación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   5280
         TabIndex        =   26
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Descripción"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   1170
         TabIndex        =   23
         Top             =   360
         Width           =   1020
      End
      Begin VB.Label LblModulo 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1155
         TabIndex        =   22
         Top             =   585
         Width           =   2745
      End
      Begin VB.Label LblGlosa 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "BALANCE"
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
         Left            =   3330
         TabIndex        =   19
         Top             =   1980
         Width           =   3225
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Cartera Financiera"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   3570
         TabIndex        =   18
         Top             =   1740
         Width           =   1560
      End
      Begin VB.Label Label20 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   2460
         TabIndex        =   17
         Top             =   1740
         Width           =   675
      End
      Begin VB.Label LblMoneda_01 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "USD"
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
         Left            =   2325
         TabIndex        =   16
         Top             =   1980
         Width           =   975
      End
      Begin VB.Label Label19 
         AutoSize        =   -1  'True
         Caption         =   "Monto"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   15
         Top             =   1740
         Width           =   540
      End
      Begin VB.Label LblMonto_01 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "10000000"
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
         Left            =   195
         TabIndex        =   14
         Top             =   1980
         Width           =   2100
      End
      Begin VB.Label Label14 
         AutoSize        =   -1  'True
         Caption         =   "N° Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   4080
         TabIndex        =   13
         Top             =   360
         Width           =   1200
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Modulo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   12
         Top             =   360
         Width           =   630
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   11
         Top             =   1080
         Width           =   585
      End
      Begin VB.Label LblCliente 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "BANCO DEL DESARROLLO"
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
         Left            =   195
         TabIndex        =   10
         Top             =   1290
         Width           =   6360
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11235
      _ExtentX        =   19817
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   11355
      Top             =   540
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
            Picture         =   "BacModificacionCarterasFinancieras.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacModificacionCarterasFinancieras.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacModificacionCarterasFinancieras.frx":11F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacModificacionCarterasFinancieras.frx":20CE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6000
      Left            =   120
      TabIndex        =   25
      Top             =   4320
      Width           =   10995
      _ExtentX        =   19394
      _ExtentY        =   10583
      _Version        =   393216
      BackColor       =   -2147483633
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483636
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483642
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      AllowUserResizing=   1
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
Attribute VB_Name = "BacModificacionCarterasFinancieras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim swGraba     As Integer
Dim swLimpiaGrilla As Integer
Dim nExiste As Integer

Private Sub Boton_Ayuda_Click()
If Me.Check1.Value = 1 Then
    BacAyuda_Novaciones.Sistema = Trim(Left(Cmb_Modulo.Text, 3))
    If Cmb_Modulo.ListIndex <> -1 Then
        BacAyuda_Novaciones.Show 1
    End If
    
    If giAceptar Then
        Let txt_NumOper.Text = Operacion_DRV 'Operacion_Novacion 'Numero Operacion
        LblCliente.Caption = Clie_Operacion_Midd 'Nombre_Cliente_Destino
    End If
End If
End Sub

Private Sub Check1_Click()
   Dim sql     As String
   Dim Datos()
   
    If Me.Check1.Value = 1 Then
        Mensaje.Visible = True
        Call LimpiarOper
        Boton_Ayuda.Visible = True
        Me.txt_NumOper.Enabled = False
    End If
    If Me.Check1.Value = 0 Then
        Mensaje.Visible = False
        Boton_Ayuda.Visible = False
        Me.txt_NumOper.Enabled = True
    End If
    
   If Not Bac_Sql_Execute("SP_BUSCAR_SISTEMAS_CF " & Me.Check1.Value) Then
        Call MsgBox("E - Error en procedimiento ...", vbExclamation, App.Title)
        Exit Sub
   End If
   
   Call Cmb_Modulo.Clear
   Do While Bac_SQL_Fetch(Datos())
      Cmb_Modulo.AddItem Datos(1) & Space(50) & Datos(2)
   Loop
   If Cmb_Modulo.ListCount > 0 Then
      Let Cmb_Modulo.ListIndex = 0
   End If

End Sub

Private Sub Cmb_Modulo_Click()
   LblModulo.Caption = Trim(Right(Cmb_Modulo.Text, 8))
   Let txt_NumOper.Text = 0
   Call LimpiarOper
    Call Nombres_Grilla
    Let ListCartera_Finan.Enabled = False
End Sub

Private Sub Cmb_Modulo_KeyDown(KeyCode As Integer, Shift As Integer)
   LblModulo.Caption = Trim(Right(Cmb_Modulo.Text, 8))
   Call Nombres_Grilla
   'Call FuncLimpiarLado(True)
End Sub

Private Function FuncLoadModulos()
   Dim sql     As String
   Dim Datos()

   '--> Esto Debiese ser un SP, pero dejemos así
   Let sql = ""
   Let sql = "SELECT nombre_sistema, id_sistema  FROM BacParamSuda..SISTEMA_CNT WHERE operativo = 'S' AND gestion = 'N' and id_sistema IN ('PCS', 'BFW', 'OPT')"
   
   Envia = Array()
   AddParam Envia, 0  'No debe cargar OPT
   If Not Bac_Sql_Execute("SP_BUSCAR_SISTEMAS_CF", Envia) Then
        Call MsgBox("E - Error en procedimiento ...", vbExclamation, App.Title)
        Exit Function
   End If

   Call Cmb_Modulo.Clear
   Do While Bac_SQL_Fetch(Datos())
      Cmb_Modulo.AddItem Datos(1) & Space(50) & Datos(2)
   Loop
   If Cmb_Modulo.ListCount > 0 Then
      Let Cmb_Modulo.ListIndex = 0
   End If

End Function


Private Sub Form_Load()
   Dim sql     As String
   Dim Datos()
   
   Let swLimpiaGrilla = 0
   Me.Icon = BacControlFinanciero.Icon
   
   Call FuncLoadModulos
   Call Carga_Lista_CarteraFinanciera
    Let ListCartera_Finan.Enabled = False
    Call Nombres_Grilla
End Sub


Private Sub Label18_Click()

End Sub

Private Sub ListCartera_Finan_Click()
   
   If Cmb_Modulo.ListIndex >= 0 Then
      If Left(Trim(Cmb_Modulo.List(Cmb_Modulo.ListIndex)), 3) = "PCS" Then
         Grid.TextMatrix(17, 2) = ListCartera_Finan.List(ListCartera_Finan.ListIndex)
         
         Grid.Row = 15: Grid.Col = 2:  Grid.CellForeColor = vbBlack
         If Grid.TextMatrix(17, 1) = Grid.TextMatrix(17, 2) Then
            Grid.Row = 17: Grid.Col = 2:  Grid.CellForeColor = vbBlack
         Else
            Grid.Row = 17: Grid.Col = 2: Grid.CellForeColor = vbRed
         End If
      
      Else
         Grid.TextMatrix(15, 2) = ListCartera_Finan.List(ListCartera_Finan.ListIndex)
         
         Grid.Row = 17: Grid.Col = 2:  Grid.CellForeColor = vbBlack
         If Grid.TextMatrix(15, 1) = Grid.TextMatrix(15, 2) Then
            Grid.Row = 15: Grid.Col = 2: Grid.CellForeColor = vbBlack
         Else
            Grid.Row = 15: Grid.Col = 2: Grid.CellForeColor = vbRed
         End If
      End If
      Grid.Col = 0
   End If
   
End Sub

Private Sub txt_NumOper_KeyPress(KeyAscii As Integer)
Let nExiste = 0
   If KeyAscii = vbKeyReturn Then
      Let txt_NumOper.Tag = txt_NumOper.Text
      Call LimpiarOper
      Call Carga_Datos_Operacion
         If nExiste = 0 Then
               Call FuncLeeOperacion(CDbl((Me.txt_NumOper.Text)))
         Else
               FuncLimpiarLado (True)
               Exit Sub
         End If
   End If
End Sub

Private Sub Carga_Datos_Operacion()
   Dim Datos()
   Dim Conta            As Integer
   Dim origen           As String
   Dim Proced           As String
   Dim oPrecedimiento   As String
   Dim oOrigen          As String
   
   Let Conta = 1: Let origen = "O"

   If Len(txt_NumOper.Text) = 0 Then
      Exit Sub
   End If
   If txt_NumOper.Text = "" Then
      Exit Sub
   End If

   Let oOrigen = Left(Cmb_Modulo.List(Cmb_Modulo.ListIndex), 3)
   If oOrigen = "BFW" Then
      Let oPrecedimiento = "SP_BUSCA_OPER_FORWARD"
   End If
   If oOrigen = "PCS" Then
      Let oPrecedimiento = "SP_BUSCA_OPER_SWAP"
   End If

   Envia = Array()
   AddParam Envia, CDbl(Me.txt_NumOper.Text)
   If Not Bac_Sql_Execute(oPrecedimiento, Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intenter validar el tipo de moneda", vbCritical, TITSISTEMA
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos())
      
      If oOrigen = "BFW" Then
         If Datos(1) = -1 Then
            Call MsgBox(Datos(2), vbExclamation + vbOKOnly, App.Title)
            Call LimpiarOper
            Call Carga_Lista_CarteraFinanciera
            If txt_NumOper.Enabled = True Then
               Call txt_NumOper.SetFocus
            End If
            ListCartera_Finan.Enabled = False
            nExiste = 1
            Call FuncLimpiarLado(True)
         Else
            If Conta = 1 Then
               Me.LblCliente.Caption = Datos(1)
               Me.LblMonto_01.Caption = Format(Datos(2), IIf(Datos(3) = "CLP", FEntero, FDecimal))
               Me.LblMoneda_01.Caption = Datos(3)
               Me.LblGlosa.Caption = Datos(4)
            End If
            Conta = Conta + 1
            Call Carga_Lista_CarteraFinanciera
            ListCartera_Finan.Enabled = True
         End If
      End If

      If oOrigen = "PCS" Then
         If Datos(1) = -1 Then
            MsgBox Datos(2), vbExclamation + vbOKOnly
            Call LimpiarOper
            If txt_NumOper.Enabled = True Then
               'txt_NumOper.SetFocus
            End If
            ListCartera_Finan.Enabled = False
            nExiste = 1
            Call FuncLimpiarLado(True)
         Else
            If Conta = 1 Then
               Me.LblCliente.Caption = Datos(1)
               Me.LblMonto_01.Caption = Format(Datos(2), IIf(Datos(3) = "CLP", FEntero, FDecimal))
               Me.LblMoneda_01.Caption = Datos(3)
               Me.LblGlosa.Caption = Datos(4)
            Else
               Me.LblMontoFP_Oper.Caption = Format(Datos(2), IIf(Datos(3) = "CLP", FEntero, FDecimal))
               Me.LblMonedaFP_Oper.Caption = Datos(3)
               Me.LblIndicadorTasaP_Oper.Caption = Datos(4)
            End If
            Conta = Conta + 1
            ListCartera_Finan.Enabled = True
         End If
      End If
   
   Loop

Exit Sub


   If Trim(Right(Cmb_Modulo.Text, 7)) = "FORWARD" Then
      If Not Bac_Sql_Execute("SP_BUSCA_OPER_FORWARD", Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intenter validar el tipo de moneda", vbCritical, TITSISTEMA
         Exit Sub
      Else
      
      Do While Bac_SQL_Fetch(Datos())
         If Datos(1) = -1 Then
            Call MsgBox(Datos(2), vbExclamation + vbOKOnly, App.Title)
            Call LimpiarOper
            Call Carga_Lista_CarteraFinanciera
            If txt_NumOper.Enabled = True Then Call txt_NumOper.SetFocus
            ListCartera_Finan.Enabled = False
         Else
            If Conta = 1 Then
               Me.LblCliente.Caption = Datos(1)
               Me.LblMonto_01.Caption = Datos(2)
               Me.LblMoneda_01.Caption = Datos(3)
               Me.LblGlosa.Caption = Datos(4)
            End If
            Conta = Conta + 1
            Call Carga_Lista_CarteraFinanciera
            ListCartera_Finan.Enabled = True
         End If
      Loop
   End If
   
Else
      If Not Bac_Sql_Execute("SP_BUSCA_OPER_SWAP", Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intenter validar", vbCritical, TITSISTEMA
         Exit Sub
      Else
            Do While Bac_SQL_Fetch(Datos())
                  If Datos(1) = -1 Then
                     MsgBox Datos(2), vbExclamation + vbOKOnly
                     Call LimpiarOper
                     ListCartera_Finan.Enabled = False
                  Else
                     If Conta = 1 Then
                        Me.LblCliente.Caption = Datos(1)
                        Me.LblMonto_01.Caption = Datos(2)
                        Me.LblMoneda_01.Caption = Datos(3)
                        Me.LblGlosa.Caption = Datos(4)
                     Else
                        Me.LblMontoFP_Oper.Caption = Datos(2)
                        Me.LblMonedaFP_Oper.Caption = Datos(3)
                        Me.LblIndicadorTasaP_Oper.Caption = Datos(4)
                     End If
                     Conta = Conta + 1
                     ListCartera_Finan.Enabled = True
                  End If
            Loop
      End If
End If
'If Conta > 1 Then
   'Call Carga_Lista_CarteraFinanciera
'End If

End Sub

Private Sub LimpiarOper()
            Me.LblCliente.Caption = ""
            Me.LblMonto_01.Caption = ""
            Me.LblMoneda_01.Caption = ""
            Me.LblGlosa.Caption = ""
            Me.LblMonedaFP_Oper.Caption = ""
            Me.LblMontoFP_Oper.Caption = ""
            Me.LblIndicadorTasaP_Oper.Caption = ""
            'ListCartera_Finan.Clear
            'Me.txt_NumOper.Text = ""
            
            
            
End Sub


Private Sub Carga_Lista_CarteraFinanciera()
Dim Datos()
         
    Screen.MousePointer = vbHourglass
   If Not Bac_Sql_Execute("SP_BUSCA_CARTERAS") Then
      Exit Sub
   Else
      ListCartera_Finan.Clear
      Do While Bac_SQL_Fetch(Datos())
         ListCartera_Finan.AddItem Trim(Datos(2))
         ListCartera_Finan.ItemData(ListCartera_Finan.NewIndex) = Datos(1)
      Loop
   End If
    
   Screen.MousePointer = vbDefault
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Let nExiste = 0
   Select Case Button.Index
      Case 1   'Buscar

          Let txt_NumOper.Tag = txt_NumOper.Text
         Call LimpiarOper
         Call Carga_Datos_Operacion
         If nExiste = 0 Then
               Call FuncLeeOperacion(CDbl((Me.txt_NumOper.Text)))
         Else
               FuncLimpiarLado (True)
               Exit Sub
         End If
      Case 2   'Imprimir
         Let swModulo = 0
         Let BacInformeModificaciones.bDesdeReemplazo = False
         Call BacInformeModificaciones.Show(vbModal)
      Case 3   'Grabar
         Call FuncSavedata
      Case 4   'Salir
         Call Unload(Me)
   End Select

End Sub

Private Function FuncLeeOperacion(ByVal nOperacion As Long)
   Dim SqlDatos()
   
   
   If Trim(Left(Me.Cmb_Modulo, 3)) = "PCS" Then
      'Call FuncLimpiarLado(True)

      Envia = Array()
      AddParam Envia, nOperacion
      AddParam Envia, "O"
      If Not Bac_Sql_Execute("SP_BUSCA_OPER_COT", Envia) Then
         Exit Function
      End If
      If Bac_SQL_Fetch(SqlDatos()) Then
         Grid.TextMatrix(1, 1) = SqlDatos(3)    '--> Rut Cliente
         Grid.TextMatrix(2, 1) = SqlDatos(4)    '--> Nombre Cliente
         Grid.TextMatrix(3, 1) = SqlDatos(8)    '--> Moneda
         Grid.TextMatrix(4, 1) = SqlDatos(9)    '--> Nocionales
         Grid.TextMatrix(5, 1) = SqlDatos(10)   '--> Frecuencia de Pago
         Grid.TextMatrix(6, 1) = SqlDatos(11)   '--> Frecuencia de Capital
         Grid.TextMatrix(7, 1) = SqlDatos(12)   '--> Indicador
         Grid.TextMatrix(8, 1) = SqlDatos(13)   '--> Tasa
         Grid.TextMatrix(9, 1) = SqlDatos(14)   '--> Spread         --Conteo de Dias
         Grid.TextMatrix(10, 1) = SqlDatos(6)  '--> Fecha Efectiva
         Grid.TextMatrix(11, 1) = SqlDatos(7)  '--> Fecha Madurez
         Grid.TextMatrix(12, 1) = SqlDatos(16)  '--> Moneda de Pago
         Grid.TextMatrix(13, 1) = SqlDatos(19)   '--> Cartera Normativa
         Grid.TextMatrix(14, 1) = SqlDatos(15)  '--> Conteo de Dias --Fecha Efectiva
         Grid.TextMatrix(15, 1) = SqlDatos(17)  '--> Medio de Pago
         Grid.TextMatrix(16, 1) = SqlDatos(23)  '--> Modalidad de Pago
         Grid.TextMatrix(17, 1) = SqlDatos(18)  '--> Cartera Financiera
         Grid.TextMatrix(18, 1) = SqlDatos(20)  '--> Sub Cartera Normativa
         Grid.TextMatrix(19, 1) = SqlDatos(21)  '--> Libro de Negociacion
         Grid.TextMatrix(20, 1) = SqlDatos(24)  '--> Tipo Swap
         Grid.TextMatrix(21, 1) = SqlDatos(25)  '--> Operador
         Grid.TextMatrix(22, 1) = SqlDatos(26)  '--> MTM Valor Razonable
      
         Grid.TextMatrix(1, 2) = SqlDatos(3)    '--> Rut Cliente
         Grid.TextMatrix(2, 2) = SqlDatos(4)    '--> Nombre Cliente
         Grid.TextMatrix(3, 2) = SqlDatos(8)    '--> Moneda
         Grid.TextMatrix(4, 2) = SqlDatos(9)    '--> Nocionales
         Grid.TextMatrix(5, 2) = SqlDatos(10)   '--> Frecuencia de Pago
         Grid.TextMatrix(6, 2) = SqlDatos(11)   '--> Frecuencia de Capital
         Grid.TextMatrix(7, 2) = SqlDatos(12)   '--> Indicador
         Grid.TextMatrix(8, 2) = SqlDatos(13)   '--> Tasa
         Grid.TextMatrix(9, 2) = SqlDatos(14)   '--> Spread         --Conteo de Dias
         Grid.TextMatrix(10, 2) = SqlDatos(6)  '--> Fecha Efectiva
         Grid.TextMatrix(11, 2) = SqlDatos(7)  '--> Fecha Madurez
         Grid.TextMatrix(12, 2) = SqlDatos(16)  '--> Moneda de Pago
         Grid.TextMatrix(13, 2) = SqlDatos(19)   '--> Cartera Normativa
         Grid.TextMatrix(14, 2) = SqlDatos(15)  '--> Conteo de Dias --Fecha Efectiva
         Grid.TextMatrix(15, 2) = SqlDatos(17)  '--> Medio de Pago
         Grid.TextMatrix(16, 2) = SqlDatos(23)  '--> Modalidad de Pago
         Grid.TextMatrix(17, 2) = SqlDatos(18)  '--> Cartera Financiera
         Grid.TextMatrix(18, 2) = SqlDatos(20)  '--> Sub Cartera Normativa
         Grid.TextMatrix(19, 2) = SqlDatos(21)  '--> Libro de Negociacion
         Grid.TextMatrix(20, 2) = SqlDatos(24)  '--> Tipo Swap
         Grid.TextMatrix(21, 2) = SqlDatos(25)  '--> Operador
         Grid.TextMatrix(22, 2) = SqlDatos(26)  '--> MTM Valor Razonable
      End If
   ElseIf Trim(Left(Me.Cmb_Modulo, 3)) = "BFW" Then ' tenia "FWD"
      '*******
      Envia = Array()
      AddParam Envia, nOperacion
      If Not Bac_Sql_Execute("SP_BUSCA_OPER_FORWARD", Envia) Then
         Exit Function
      End If
      If Bac_SQL_Fetch(SqlDatos()) Then
         Grid.TextMatrix(1, 1) = SqlDatos(5)           '--> Rut Cliente
         Grid.TextMatrix(2, 1) = SqlDatos(1)           '--> Nombre Cliente
         Grid.TextMatrix(3, 1) = UCase(SqlDatos(6))    '--> Tipo Operacion
         Grid.TextMatrix(4, 1) = SqlDatos(7)   '--> Moneda
         Grid.TextMatrix(5, 1) = Format(SqlDatos(2), FDecimal)    '--> Monto en USD
         Grid.TextMatrix(6, 1) = Format(SqlDatos(8), FDecimal)    '--> Precio Futuro
         Grid.TextMatrix(7, 1) = Format(SqlDatos(9), FDecimal)    '--> Dolar Observado
         Grid.TextMatrix(8, 1) = Format(SqlDatos(10), "DD-MM-YYYY")  '--> Fecha Cierre
         Grid.TextMatrix(9, 1) = Format(SqlDatos(11), "DD-MM-YYYY")   '--> Fecha de Inicio
         Grid.TextMatrix(10, 1) = Format(SqlDatos(12), "DD-MM-YYYY")  '--> Fecha Vencimiento
         Grid.TextMatrix(11, 1) = SqlDatos(13)  '--> Dias
         Grid.TextMatrix(12, 1) = SqlDatos(14)  '--> Pago M/N
         Grid.TextMatrix(13, 1) = UCase(SqlDatos(15))  '--> Pago M/X
         Grid.TextMatrix(14, 1) = SqlDatos(16)  '--> Modalidad
         Grid.TextMatrix(15, 1) = SqlDatos(4)  '--> Cartera Financiera
         Grid.TextMatrix(16, 1) = SqlDatos(18)  '--> Cartera Super
         Grid.TextMatrix(17, 1) = SqlDatos(19)  '--> Sub Cartera  Super
         Grid.TextMatrix(18, 1) = SqlDatos(17)  '--> Libro
         Grid.TextMatrix(19, 1) = SqlDatos(20)  '--> Area Responsable

         Grid.TextMatrix(1, 2) = Grid.TextMatrix(1, 1)
         Grid.TextMatrix(2, 2) = Grid.TextMatrix(2, 1)
         Grid.TextMatrix(3, 2) = Grid.TextMatrix(3, 1)
         Grid.TextMatrix(4, 2) = Grid.TextMatrix(4, 1)
         Grid.TextMatrix(5, 2) = Grid.TextMatrix(5, 1)
         Grid.TextMatrix(6, 2) = Grid.TextMatrix(6, 1)
         Grid.TextMatrix(7, 2) = Grid.TextMatrix(7, 1)
         Grid.TextMatrix(8, 2) = Grid.TextMatrix(8, 1)
         Grid.TextMatrix(9, 2) = Grid.TextMatrix(9, 1)
         Grid.TextMatrix(10, 2) = Grid.TextMatrix(10, 1)
         Grid.TextMatrix(11, 2) = Grid.TextMatrix(11, 1)
         Grid.TextMatrix(12, 2) = Grid.TextMatrix(12, 1)
         Grid.TextMatrix(13, 2) = Grid.TextMatrix(13, 1)
         Grid.TextMatrix(14, 2) = Grid.TextMatrix(14, 1)
         Grid.TextMatrix(15, 2) = Grid.TextMatrix(15, 1)
         Grid.TextMatrix(16, 2) = Grid.TextMatrix(16, 1)
         Grid.TextMatrix(17, 2) = Grid.TextMatrix(17, 1)
         Grid.TextMatrix(18, 2) = Grid.TextMatrix(18, 1)
         Grid.TextMatrix(19, 2) = Grid.TextMatrix(19, 1)
         

      End If
      '*******
   End If
   Grid.Redraw = False

   'Call FuncPareo
   
   Grid.Redraw = True
   
End Function

Private Function FuncLimpiarLado(ByVal Opercion As Boolean)
   Dim nContador  As Long
   Dim nColumna   As Integer
   Dim nFila      As Integer
    Let nColumna = IIf(Opercion = True, 1, 2)
   If swLimpiaGrilla = 0 Then
         Let swLimpiaGrilla = 1
         Exit Function
   End If
  Let nFila = 1
  
  For nContador = 1 To Grid.Rows - 1
       Grid.TextMatrix(nFila, nColumna) = "":   Grid.TextMatrix(nFila, 2) = "": Grid.TextMatrix(nFila, 3) = ""
       nFila = nFila + 1
   Next nContador

End Function

Private Function FuncSavedata() As Boolean
   Dim Datos()
   Dim Numoper       As Long
   Dim CodCartera    As Integer
   Dim Sistema       As String
   Dim nOperacion    As Long
   
   Let nOperacion = CDbl(txt_NumOper.Text)
    If Me.Check1.Value = 0 Then
        If txt_NumOper.Tag <> txt_NumOper.Text Then
            Call MsgBox("Favor revisar los datos de la operación", vbExclamation, App.Title)
            Exit Function
        End If
        
        If Cmb_Modulo.Text = "" Or LblModulo.Caption = "" Or Me.txt_NumOper.Text = "" Or Me.txt_NumOper.Text = 0 Or Me.LblCliente.Caption = "" Then
            MsgBox "Faltan datos por ingresar. Favor revizar", vbExclamation, TITSISTEMA
            Exit Function
        End If
        If Me.ListCartera_Finan.ListIndex = -1 Then
            MsgBox "Debe seleccionar un tipo de Cartera Financiera", vbExclamation, TITSISTEMA
            Exit Function
        End If
    End If
   If MsgBox("¿Esta Ud. seguro que desea grabar ?", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
      Exit Function
   End If
   
   Numoper = Me.txt_NumOper.Text
   If Me.Check1.Value = 0 Then
    CodCartera = Me.ListCartera_Finan.ItemData(Me.ListCartera_Finan.ListIndex)
   End If
   Sistema = Trim(Left(Me.Cmb_Modulo.Text, 3))
   
   Envia = Array()
   AddParam Envia, Numoper
   AddParam Envia, CodCartera
   AddParam Envia, Sistema
    If Me.Check1.Value = 1 Then
        AddParam Envia, Rut_Origen
        AddParam Envia, Nombre_Origen
        AddParam Envia, Rut_Destino
        AddParam Envia, Nombre_Destino
        AddParam Envia, Me.Check1.Value
    End If
   If Not Bac_Sql_Execute("SP_CAMBIO_CARTERA", Envia) Then
      MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = -1 Then
         Call MsgBox(Datos(2), vbExclamation + vbOKOnly, App.Title)
         Exit Function
      Else
         GoTo GrabaLog
      End If
   End If
   
    
GrabaLog:
         Call FuncGrabarRegistro(nOperacion, nOperacion)
         Call MsgBox("La grabación ha finalizado exitosamente.", vbInformation, App.Title)
         Call LimpiarOper
         Exit Function

End Function


Private Function FuncGrabarRegistro(ByVal nFolioContrato As Long, ByVal nFolioCotizacion As Long)
   Dim SqlDatos()
   Dim nFolioModificacion  As Long
   Dim nContador           As Long
   
   Let nFolioModificacion = 0
   
   If Me.Check1.Value = 0 Then
        For iContador = 1 To Grid.Rows - 1
           
           Envia = Array()
           AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
           AddParam Envia, Left(Cmb_Modulo.List(Cmb_Modulo.ListIndex), 3)
           AddParam Envia, nFolioContrato
           AddParam Envia, nFolioCotizacion
           AddParam Envia, nFolioModificacion
           AddParam Envia, Grid.TextMatrix(iContador, 0)
           AddParam Envia, Grid.TextMatrix(iContador, 1)
           AddParam Envia, Grid.TextMatrix(iContador, 2)
           AddParam Envia, CDbl(iContador)
           If Not Bac_Sql_Execute("SP_GRABA_REGISTRO_MODIFICAIONES", Envia) Then
              Exit Function
           End If
           If Bac_SQL_Fetch(SqlDatos()) Then
              Let nFolioModificacion = SqlDatos(3)
           End If
        
        Next iContador
End If
End Function

Sub Nombres_Grilla()
   Dim nAltoFila  As Integer
   Let nAltoFila = 260
   If swLimpiaGrilla > 0 Then
      Call FuncLimpiarLado(True)
   Else
      Call FuncLimpiarLado(False)
   End If
   If Trim(Left(Cmb_Modulo.Text, 3)) = "PCS" Then
         Grid.Rows = 23:       Grid.Cols = 4
         Grid.Font.Name = "Thaoma": Grid.Font.Size = 8:  Grid.Font.Bold = False
         Grid.FocusRect = flexFocusNone
   
         'Grid.FixedRows = 2:  Grid.FixedCols = 0
         Grid.ColWidth(0) = 3000:   Grid.ColAlignment(0) = flexAlignLeftCenter
         Grid.ColWidth(1) = 3500:   Grid.ColAlignment(1) = flexAlignLeftCenter
         Grid.ColWidth(2) = 3500:   Grid.ColAlignment(2) = flexAlignLeftCenter
         Grid.ColWidth(3) = 750:    Grid.ColAlignment(3) = flexAlignCenterCenter
   
         Grid.TextMatrix(0, 0) = "I T E M S":                  Grid.TextMatrix(0, 1) = "DATOS OPERACION":   Grid.TextMatrix(0, 2) = "DATOS COTIZACION"
   
         Grid.TextMatrix(1, 0) = "RUT":                       Grid.RowHeight(1) = nAltoFila '-->RUT
         Grid.TextMatrix(2, 0) = "NOMBRE":                    Grid.RowHeight(2) = nAltoFila '-->NOMBRE CLIENTE
         Grid.TextMatrix(3, 0) = "MONEDAS":                   Grid.RowHeight(3) = nAltoFila
         Grid.TextMatrix(4, 0) = "NOCIONALES":                Grid.RowHeight(4) = nAltoFila
         Grid.TextMatrix(5, 0) = "FRECUENCIA PAGO":           Grid.RowHeight(5) = nAltoFila
         Grid.TextMatrix(6, 0) = "FRECUENCIA CAPITAL":        Grid.RowHeight(6) = nAltoFila
         Grid.TextMatrix(7, 0) = "INDICADOR":                 Grid.RowHeight(7) = nAltoFila
         Grid.TextMatrix(8, 0) = "TASA":                      Grid.RowHeight(8) = nAltoFila
         Grid.TextMatrix(9, 0) = "SPREAD":                    Grid.RowHeight(9) = nAltoFila
   
         Grid.TextMatrix(10, 0) = "FECHA EFECTIVA":            Grid.RowHeight(10) = nAltoFila
         Grid.TextMatrix(11, 0) = "FECHA MADUREZ":             Grid.RowHeight(11) = nAltoFila
         Grid.TextMatrix(12, 0) = "MONEDA DE PAGO":            Grid.RowHeight(12) = nAltoFila

         Grid.TextMatrix(13, 0) = "CARTERA NORMATIVA":         Grid.RowHeight(13) = nAltoFila
         Grid.TextMatrix(14, 0) = "CONTEO DE DIAS":            Grid.RowHeight(14) = nAltoFila
         Grid.TextMatrix(15, 0) = "MEDIO DE PAGO":             Grid.RowHeight(15) = nAltoFila
         Grid.TextMatrix(16, 0) = "MODALIDAD DE PAGO":        Grid.RowHeight(16) = nAltoFila
         Grid.TextMatrix(17, 0) = "CARTERA FINANCIERA":       Grid.RowHeight(17) = nAltoFila
         Grid.TextMatrix(18, 0) = "SUB CARTERA NORMATIVA":    Grid.RowHeight(18) = nAltoFila
         Grid.TextMatrix(19, 0) = "LIBRO NEGOCIACION":        Grid.RowHeight(19) = nAltoFila
         Grid.TextMatrix(20, 0) = "TIPO SWAP":                Grid.RowHeight(20) = nAltoFila
         Grid.TextMatrix(21, 0) = "OPERADOR":                 Grid.RowHeight(21) = nAltoFila
         Grid.TextMatrix(22, 0) = "VALOR RAZONABLE":          Grid.RowHeight(22) = nAltoFila
    Else
         Grid.Rows = 20:       Grid.Cols = 4
         Grid.Font.Name = "Thaoma": Grid.Font.Size = 8:  Grid.Font.Bold = False
         Grid.FocusRect = flexFocusNone
   
         'Grid.FixedRows = 2:  Grid.FixedCols = 0
         Grid.ColWidth(0) = 3000:   Grid.ColAlignment(0) = flexAlignLeftCenter
         Grid.ColWidth(1) = 3500:   Grid.ColAlignment(1) = flexAlignLeftCenter
         Grid.ColWidth(2) = 3500:   Grid.ColAlignment(2) = flexAlignLeftCenter
         Grid.ColWidth(3) = 750:    Grid.ColAlignment(3) = flexAlignCenterCenter
   
         Grid.TextMatrix(0, 0) = "I T E M S":                  Grid.TextMatrix(0, 1) = "DATOS OPERACION":   Grid.TextMatrix(0, 2) = "DATOS COTIZACION"
   
         Grid.TextMatrix(1, 0) = "RUT":                        Grid.RowHeight(1) = nAltoFila '-->RUT
         Grid.TextMatrix(2, 0) = "NOMBRE":                     Grid.RowHeight(2) = nAltoFila '-->NOMBRE CLIENTE
         Grid.TextMatrix(3, 0) = "TIPO OPERACION":             Grid.RowHeight(3) = nAltoFila
         Grid.TextMatrix(4, 0) = "MONEDAS":                    Grid.RowHeight(4) = nAltoFila
         Grid.TextMatrix(5, 0) = "MONTO EN USD":               Grid.RowHeight(5) = nAltoFila
         Grid.TextMatrix(6, 0) = "PRECIO FUTURO":              Grid.RowHeight(6) = nAltoFila
         Grid.TextMatrix(7, 0) = "DOLAR OBSERVADO":            Grid.RowHeight(7) = nAltoFila
         Grid.TextMatrix(8, 0) = "FECHA CIERRE":               Grid.RowHeight(8) = nAltoFila
         Grid.TextMatrix(9, 0) = "FECHA INICIO":               Grid.RowHeight(9) = nAltoFila
   
         Grid.TextMatrix(10, 0) = "FECHA VENCIMIENTO":         Grid.RowHeight(10) = nAltoFila
         Grid.TextMatrix(11, 0) = "DIAS":                      Grid.RowHeight(11) = nAltoFila
         Grid.TextMatrix(12, 0) = "PAGO M/N":                  Grid.RowHeight(12) = nAltoFila

         Grid.TextMatrix(13, 0) = "PAGO M/X":                  Grid.RowHeight(13) = nAltoFila
         Grid.TextMatrix(14, 0) = "MODALIDAD":                 Grid.RowHeight(14) = nAltoFila
         
         Grid.TextMatrix(15, 0) = "CARTERA FINANCIERA":        Grid.RowHeight(15) = nAltoFila
         Grid.TextMatrix(16, 0) = "CARTERA SUPER":             Grid.RowHeight(16) = nAltoFila
         
         Grid.TextMatrix(17, 0) = "SUB CARTERA SUPER":         Grid.RowHeight(17) = nAltoFila
         Grid.TextMatrix(18, 0) = "LIBRO":                     Grid.RowHeight(18) = nAltoFila
         Grid.TextMatrix(19, 0) = "AREA RESPONSABLE":          Grid.RowHeight(19) = nAltoFila
    
    
         
    End If
End Sub
