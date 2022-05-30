VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_RECALCULO_LINEAS 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Recalculo de Líneas de Crédito."
   ClientHeight    =   2430
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5520
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2430
   ScaleWidth      =   5520
   ShowInTaskbar   =   0   'False
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   1245
      Left            =   5505
      TabIndex        =   12
      Top             =   465
      Width           =   7125
      _ExtentX        =   12568
      _ExtentY        =   2196
      _Version        =   393216
      Cols            =   6
      FixedCols       =   0
   End
   Begin Threed.SSPanel Pnlprogress 
      Align           =   2  'Align Bottom
      Height          =   495
      Left            =   0
      TabIndex        =   4
      Top             =   1935
      Width           =   5520
      _Version        =   65536
      _ExtentX        =   9737
      _ExtentY        =   873
      _StockProps     =   15
      ForeColor       =   -2147483643
      BackColor       =   14215660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelInner      =   1
      FloodType       =   1
      FloodColor      =   -2147483647
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5520
      _ExtentX        =   9737
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Procesar Recalculo de Lineas"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3990
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RECALCULO_LINEAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RECALCULO_LINEAS.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1350
      Left            =   30
      TabIndex        =   1
      Top             =   375
      Width           =   5475
      Begin VB.Frame Frame2 
         BorderStyle     =   0  'None
         Enabled         =   0   'False
         Height          =   600
         Left            =   45
         TabIndex        =   5
         Top             =   120
         Width           =   2850
         Begin VB.TextBox TxtDv 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Left            =   1740
            TabIndex        =   8
            Top             =   225
            Width           =   360
         End
         Begin BACControles.TXTNumero TxtRut 
            Height          =   300
            Left            =   30
            TabIndex        =   7
            Top             =   225
            Width           =   1710
            _ExtentX        =   3016
            _ExtentY        =   529
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
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero TxtCodigo 
            Height          =   300
            Left            =   2115
            TabIndex        =   9
            Top             =   225
            Width           =   630
            _ExtentX        =   1111
            _ExtentY        =   529
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
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Código"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   2
            Left            =   2130
            TabIndex        =   11
            Top             =   15
            Width           =   495
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Dv"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   1
            Left            =   1755
            TabIndex        =   10
            Top             =   15
            Width           =   195
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Rut Cliente"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   0
            Left            =   45
            TabIndex        =   6
            Top             =   0
            Width           =   795
         End
      End
      Begin VB.TextBox Txtnombre 
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
         Left            =   60
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   3
         Top             =   945
         Width           =   5325
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Nombre Cliente"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   90
         TabIndex        =   2
         Top             =   750
         Width           =   1095
      End
   End
   Begin VB.Label ClienteEnproceso 
      Alignment       =   2  'Center
      Caption         =   "Actualizando Cliente: BANCO DEL DESARROLLO"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   45
      TabIndex        =   13
      Top             =   1725
      Width           =   5430
   End
End
Attribute VB_Name = "FRM_RECALCULO_LINEAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub NombresGrilla()
   Let Grid.Rows = 2
   Let Grid.Cols = 4
   
   Let Grid.TextMatrix(0, 0) = "Rut"
   Let Grid.TextMatrix(0, 1) = "Codigo"
   Let Grid.TextMatrix(0, 2) = "Nombre"
   Let Grid.TextMatrix(0, 3) = "Puntero"

End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwap.Icon
   Let Me.Top = 0: Let Me.Left = 0
   
   Call NombresGrilla
   Let ClienteEnproceso.Caption = ""
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call ProcesarLineas
      Case 3
         Unload Me
   End Select
End Sub

Private Function ProcesarLineas()
   On Error Resume Next
   Dim iRut       As Long
   Dim iCodigo    As Long
   Dim cNombre    As String
   Dim iContador  As Long
   Dim iRegistros As Long
   Dim Switch     As Integer
   Dim DATOS()
   
   Let iRut = CDbl(TxtRut.Text)
   Let iCodigo = CDbl(TxtCodigo.Text)
   
   Let Toolbar1.Buttons(2).Enabled = False
   Let Toolbar1.Buttons(3).Enabled = False

   Let Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, iRut
   AddParam Envia, iCodigo
   If Not Bac_Sql_Execute("dbo.SP_LEER_CLIENTES_LINEAS", Envia) Then
      Let Screen.MousePointer = vbDefault
      Let Toolbar1.Buttons(2).Enabled = True
      Let Toolbar1.Buttons(3).Enabled = True
      MsgBox "Actualizacion de Lineas" & vbCrLf & vbCrLf & "Error en la carga de clientes.", vbExclamation, App.Title
      On Error GoTo 0
      Exit Function
   End If
   Let Grid.Rows = 1
   Do While Bac_SQL_Fetch(DATOS())
      Let Grid.Rows = Grid.Rows + 1
      Let Grid.TextMatrix(Grid.Rows - 1, 0) = DATOS(1)
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = DATOS(2)
      Let Grid.TextMatrix(Grid.Rows - 1, 2) = DATOS(3)
      Let Grid.TextMatrix(Grid.Rows - 1, 3) = DATOS(4)
   Loop

   Let iRegistros = Grid.Rows - 1
   Let Pnlprogress.ForeColor = vbBlack
   Let ClienteEnproceso.Caption = ""
   
   For iContador = 1 To Grid.Rows - 1
      
      Let Switch = IIf(iContador = (Grid.Rows - 1), 1, 0)
      Let iRut = CDbl(Grid.TextMatrix(iContador, 0))
      Let iCodigo = CDbl(Grid.TextMatrix(iContador, 1))
      Let cNombre = Grid.TextMatrix(iContador, 2)
      Let ClienteEnproceso.Caption = "Actualizando Cliente: " & Trim(cNombre)
      DoEvents: DoEvents: DoEvents
      
      Envia = Array()
      AddParam Envia, iRut
      AddParam Envia, iCodigo
      AddParam Envia, CDbl(Switch)
      If Not Bac_Sql_Execute("dbo.SP_RECALCULO_LINEAS_SWAP", Envia) Then
         Let Screen.MousePointer = vbDefault
         Let Toolbar1.Buttons(2).Enabled = True
         Let Toolbar1.Buttons(3).Enabled = True
         MsgBox "Actualizacion de Lineas" & vbCrLf & vbCrLf & "Error en la carga de clientes.", vbExclamation, App.Title
         On Error GoTo 0
         Exit Function
      End If

      '--> Procentaje
      Let Pnlprogress.FloodPercent = ((iContador * 100#) / iRegistros)
      DoEvents: DoEvents: DoEvents
      
      If Pnlprogress.FloodPercent >= 49 Then
         Pnlprogress.ForeColor = vbWhite
      End If
   Next iContador
   
   Let Screen.MousePointer = vbDefault

   MsgBox "Actualizacion de Lineas" & vbCrLf & "Se ha completado en forma correcta la actualización.", vbInformation, App.Title

   Let Pnlprogress.FloodPercent = 0
   Let ClienteEnproceso.Caption = ""
   Let Toolbar1.Buttons(2).Enabled = True
   Let Toolbar1.Buttons(3).Enabled = True
   On Error GoTo 0
   
End Function


Private Sub Txtnombre_DblClick()
   Dim AyudaCli    As New clsCliente
   Dim oOperadores As New clsCliente
 
   If Not AyudaCli.Ayuda("") Then
      MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
      Exit Sub
   End If
  
'   BacAyudaSwap.Tag = "Cliente" -->original
'   BacAyudaSwap.Show 1
    
    BacAyudaCliente.Tag = "Cliente"
    BacAyudaCliente.Show 1

   If giAceptar Then
      If AyudaCli.LeerxRut(Val(gsCodigo), Val(gsCodCli)) Then
         Let TxtRut.Text = AyudaCli.clrut
         Let txtDV.Text = AyudaCli.cldv
         Let TxtCodigo.Text = AyudaCli.clcodigo
         Let Txtnombre.Text = AyudaCli.clnombre
      End If
   End If
End Sub


Private Sub Txtnombre_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Or KeyCode = vbKeyBack Then
      Let TxtRut.Text = 0
      Let TxtCodigo.Text = 0
      Let txtDV.Text = ""
      Let Grid.Rows = 1
   End If
End Sub
