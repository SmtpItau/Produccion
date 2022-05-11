VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacImpresiones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Impresión de Papeletas"
   ClientHeight    =   7620
   ClientLeft      =   420
   ClientTop       =   720
   ClientWidth     =   11565
   FillStyle       =   0  'Solid
   Icon            =   "bacimpres.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7620
   ScaleWidth      =   11565
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
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacimpres.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacimpres.frx":0326
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacimpres.frx":1200
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacimpres.frx":20DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bacimpres.frx":2FB4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel2 
      Height          =   5610
      Left            =   60
      TabIndex        =   5
      Top             =   1980
      Width           =   11460
      _Version        =   65536
      _ExtentX        =   20214
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
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   5490
         Left            =   0
         TabIndex        =   2
         Top             =   45
         Width           =   11400
         _ExtentX        =   20108
         _ExtentY        =   9684
         _Version        =   393216
         Cols            =   23
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
      Picture         =   "bacimpres.frx":32CE
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
      Picture         =   "bacimpres.frx":3428
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
      TabIndex        =   27
      Top             =   0
      Width           =   11565
      _ExtentX        =   20399
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Marcar/Desmarcar Todo"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Refrescar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Pantalla"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
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
      ForeColor       =   &H80000002&
      Height          =   1545
      Left            =   30
      TabIndex        =   11
      Top             =   450
      Width           =   11505
      Begin VB.ComboBox Cmb_Modulo 
         Height          =   315
         ItemData        =   "bacimpres.frx":3582
         Left            =   1785
         List            =   "bacimpres.frx":3584
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   165
         Width           =   3015
      End
      Begin VB.ComboBox Cmb_Usuarios 
         Height          =   315
         Left            =   1785
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   870
         Width           =   3015
      End
      Begin VB.ComboBox Cmb_T_Operacion 
         Height          =   315
         Left            =   1785
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   510
         Width           =   3015
      End
      Begin VB.ComboBox Cmb_Estatus_Operacion 
         Height          =   315
         Left            =   6690
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   510
         Width           =   3195
      End
      Begin VB.ComboBox Cmb_Pagamos 
         Height          =   315
         Left            =   6690
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   870
         Visible         =   0   'False
         Width           =   3195
      End
      Begin VB.ComboBox Cmb_Monedas 
         Height          =   315
         Left            =   6690
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   165
         Width           =   3195
      End
      Begin VB.Label Lbl_Mercado 
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
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   75
         TabIndex        =   24
         Top             =   225
         Width           =   630
      End
      Begin VB.Label Lbl_Usuario 
         AutoSize        =   -1  'True
         Caption         =   "Operador"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   75
         TabIndex        =   23
         Top             =   960
         Width           =   795
      End
      Begin VB.Label L_Estatus_Operacion 
         AutoSize        =   -1  'True
         Caption         =   "Estatus Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   4845
         TabIndex        =   22
         Top             =   585
         Width           =   1575
      End
      Begin VB.Label Lbl_Tipos_de_operacion 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   75
         TabIndex        =   21
         Top             =   585
         Width           =   1590
      End
      Begin VB.Label Lbl_Pagamos 
         AutoSize        =   -1  'True
         Caption         =   "Entregamos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   4845
         TabIndex        =   20
         Top             =   960
         Visible         =   0   'False
         Width           =   1005
      End
      Begin VB.Label Lbl_Formas_de_Pago 
         Caption         =   "Formas de pago :"
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
         Left            =   6690
         TabIndex        =   19
         Top             =   1230
         Width           =   2115
      End
      Begin VB.Label Lbl_Monedas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   4845
         TabIndex        =   18
         Top             =   225
         Width           =   690
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   585
      Index           =   0
      Left            =   30
      TabIndex        =   6
      Top             =   465
      Visible         =   0   'False
      Width           =   11490
      _Version        =   65536
      _ExtentX        =   20267
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
      Begin BACControles.TXTFecha Txt_Fecha_Termino 
         Height          =   285
         Left            =   7155
         TabIndex        =   7
         Top             =   105
         Width           =   1215
         _ExtentX        =   2143
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
         Text            =   "05/06/2001"
      End
      Begin BACControles.TXTFecha Txt_Fecha_Inicio 
         Height          =   285
         Left            =   1575
         TabIndex        =   8
         Top             =   105
         Width           =   1215
         _ExtentX        =   2143
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
      Begin VB.Label Lbl_Fecha_Inicio 
         Caption         =   "Fecha de Inicio"
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
         TabIndex        =   10
         Top             =   255
         Width           =   1425
      End
      Begin VB.Label Lbl_Fecha_Termino 
         Caption         =   "Fecha de Término"
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
         Height          =   225
         Left            =   5490
         TabIndex        =   9
         Top             =   255
         Width           =   1590
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   750
      Index           =   1
      Left            =   11550
      TabIndex        =   25
      Top             =   435
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
         TabIndex        =   26
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
      Picture         =   "bacimpres.frx":3586
      Stretch         =   -1  'True
      Top             =   7845
      Width           =   480
   End
   Begin VB.Image ImgCheck 
      Height          =   480
      Left            =   90
      Picture         =   "bacimpres.frx":3890
      Top             =   7740
      Width           =   480
   End
End
Attribute VB_Name = "BacImpresiones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim c1$, c2$, c3$, c4$, Impre$, mens1$, SQL$
Dim I&, j&, a1&, Vcol%, nPos%
Dim DATOS()

Private Sub Carga_Combos()
Dim intContador As Integer
   
   ' Combo Modulos
   intContador = 0
   intContador = Carga_Listas_Impresion("MODULOS", Cmb_Modulo, intContador)
   Cmb_Modulo.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
   Cmb_Modulo.ItemData(Cmb_Modulo.NewIndex) = 0
   Cmb_Modulo.Tag = "0"
   Cmb_Modulo.ListIndex = intContador
   
   
   ' Combo Usuarios
   intContador = 0
   intContador = Carga_Listas_Impresion("USUARIOS", Cmb_Usuarios, intContador)
   Cmb_Usuarios.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
   Cmb_Usuarios.ItemData(Cmb_Usuarios.NewIndex) = 0
   Cmb_Usuarios.Tag = "0"
   Cmb_Usuarios.ListIndex = intContador
   
   ' Combo Tipos de Operacion
   intContador = 0
   intContador = Carga_Listas_Impresion("T_OPERACION", Cmb_T_Operacion, intContador)
   Cmb_T_Operacion.AddItem " << TODAS >> " + Space(70) + "CODIGO" + Space(5) + ""
   Cmb_T_Operacion.ItemData(Cmb_T_Operacion.NewIndex) = 0
   Cmb_T_Operacion.Tag = "0"
   Cmb_T_Operacion.ListIndex = intContador
   
   ' Combo Estatus de Operación
   intContador = 0
   intContador = Carga_Listas_Impresion("S_OPERACION", Cmb_Estatus_Operacion, intContador)
   Cmb_Estatus_Operacion.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
   Cmb_Estatus_Operacion.ItemData(Cmb_Estatus_Operacion.NewIndex) = 0
   Cmb_Estatus_Operacion.Tag = "0"
   Cmb_Estatus_Operacion.ListIndex = intContador
   
   ' Combo Monedas
   intContador = 0
   intContador = Carga_Listas_Impresion("MONEDAS", Cmb_Monedas, intContador)
   Cmb_Monedas.AddItem " << TODAS >> " + Space(70) + "CODIGO" + Space(5) + ""
   Cmb_Monedas.ItemData(Cmb_Monedas.NewIndex) = 0
   Cmb_Monedas.Tag = "0"
   Cmb_Monedas.ListIndex = intContador
   
   ' Combo Formas de Pago Entregamos
   intContador = 0
   intContador = Carga_Listas_Impresion("FORMASP", Cmb_Pagamos, intContador)
   Cmb_Pagamos.AddItem " << TODAS >> " + Space(70) + "CODIGO" + Space(5) + ""
   Cmb_Pagamos.ItemData(Cmb_Pagamos.NewIndex) = 0
   Cmb_Pagamos.Tag = "0"
   Cmb_Pagamos.ListIndex = intContador
   
   ' Combo Formas de Pago Recibimos
   intContador = 0
   intContador = Carga_Listas_Impresion("FORMASP", Cmb_Recibimos, intContador)
   Cmb_Recibimos.AddItem " << TODAS >> " + Space(70) + "CODIGO" + Space(5) + ""
   Cmb_Recibimos.ItemData(Cmb_Recibimos.NewIndex) = 0
   Cmb_Recibimos.Tag = "0"
   Cmb_Recibimos.ListIndex = intContador

End Sub

Private Function Carga_Listas_Impresion(strSP As String, obj As Object, intContador As Integer) As Integer
   Dim Mouse%
    
   Mouse = Screen.MousePointer
   Screen.MousePointer = 11
    
   SQL = "SP_BUSCA_DATOS_COMBOS"
   Envia = Array()
    
   Select Case UCase(strSP)
      Case "MODULOS"
         AddParam Envia, "MODU"
      Case "USUARIOS"
         AddParam Envia, "USUA"
      Case "PRODUCTOS"
         AddParam Envia, "PROD"
      Case "S_OPERACION"
         AddParam Envia, "S_OP"
      Case "T_OPERACION"
         AddParam Envia, "T_OP"
         AddParam Envia, Right(Cmb_Modulo.Text, 3)
      Case "MONEDAS"
         AddParam Envia, "MONE"
      Case "FORMASP"
         AddParam Envia, "PAGO"
      Case Else
         AddParam Envia, "NADA"
    End Select
    
    If Not Bac_Sql_Execute(SQL, Envia) Then
        SQL = "No"
        Screen.MousePointer = Mouse
        Exit Function
    End If
    obj.Clear
    Do While Bac_SQL_Fetch(DATOS())
      obj.AddItem DATOS(1) + Space(70) + "CODIGO" + Space(5) + DATOS(3)
      If UCase(strSP) = "USUARIOS" Then
         obj.ItemData(obj.NewIndex) = intContador + 1
      Else
         obj.ItemData(obj.NewIndex) = Val(DATOS(2))
      End If
      intContador = intContador + 1
    Loop
    
    If obj.ListCount - 1 < 0 Then
      'obj.AddItem "(Sin Datos)"
      'obj.ItemData(obj.NewIndex) = -1
    Else
      obj.ListIndex = 0
    End If
    
    Carga_Listas_Impresion = intContador
    Screen.MousePointer = Mouse
End Function

Public Function validaelimi()
    validaelimi = True
    
    If Trim(Grid1.Text) = "" Then
        validaelimi = False
        Exit Function
    End If
    Grid1.Col = 1
    
    For I = 1 To Grid1.Cols - 1
        
        Grid1.Col = I
        
        If Trim(Grid1.Text) = "" Then
            MsgBox "Datos en blanco" & " del Registro No." & Str(Grid1.Row), vbExclamation, TITSISTEMA
            validaelimi = False
            Exit For
        End If
        
        Select Case I
            Case 1
                c1 = Grid1.Text
            Case 2
                c2 = Grid1.Text
            Case 3
                c3 = Grid1.Text
        End Select
    Next I
    
End Function


Private Sub Cmb_Mercado_Change()

End Sub

Private Sub Cmb_Modulo_Click()
Dim intContador As Integer

    intContador = Carga_Listas_Impresion("T_OPERACION", Cmb_T_Operacion, 0)
    Cmb_T_Operacion.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
    Cmb_T_Operacion.ItemData(Cmb_T_Operacion.NewIndex) = 0
    Cmb_T_Operacion.Tag = "0"
    Cmb_T_Operacion.ListIndex = intContador
End Sub

Private Sub Form_Activate()
    BacControlFinanciero.MousePointer = 0
   
   Call Privilegios.ACTUALIZADOR(gsBAC_User)

   If Privilegios.objPrivilegios.Impresion_Papeletas = 0 Then
      Let Frame1.Enabled = False
      Let Toolbar1.Enabled = False
      Let Me.Caption = "Impresión de Papeletas.- OPCION NO HABILITADA POR [PERFILES DE ACCESO ALINEAS].-"
   Else
      Let Frame1.Enabled = True
      Let Toolbar1.Enabled = True
      Let Me.Caption = "Impresión de Papeletas.-"
      Call Privilegios.CARGAR_SISTEMAS_HABILITADOS(gsBAC_User, Me.Cmb_Modulo, 0)
   End If

End Sub

Sub Nombres_Grilla()
    Call Formato_Grilla(Grid1)
    
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
    
    Grid1.TextMatrix(0, 0) = "Imprimir":     Grid1.TextMatrix(1, 0) = "Operación":     Grid1.ColWidth(0) = 980
    Grid1.TextMatrix(0, 1) = "Módulo ":      Grid1.TextMatrix(1, 1) = "":              Grid1.ColWidth(1) = 950
    Grid1.TextMatrix(0, 2) = "Nº de ":       Grid1.TextMatrix(1, 2) = "Operación":     Grid1.ColWidth(2) = 980
    Grid1.TextMatrix(0, 3) = "Nº de ":       Grid1.TextMatrix(1, 3) = "Documento":     Grid1.ColWidth(3) = 0
    Grid1.TextMatrix(0, 4) = "Correlativo ": Grid1.TextMatrix(1, 4) = "":              Grid1.ColWidth(4) = 0
    Grid1.TextMatrix(0, 5) = "Tipo de ":     Grid1.TextMatrix(1, 5) = "Operación":     Grid1.ColWidth(5) = 3000
    Grid1.TextMatrix(0, 6) = "Moneda":       Grid1.TextMatrix(1, 6) = "Operación":     Grid1.ColWidth(6) = 1050
    Grid1.TextMatrix(0, 7) = "Nombre de ":   Grid1.TextMatrix(1, 7) = "Cliente":       Grid1.ColWidth(7) = 3800
    Grid1.TextMatrix(0, 8) = "Monto":        Grid1.TextMatrix(1, 8) = "Operación ":    Grid1.ColWidth(8) = 2000
    Grid1.TextMatrix(0, 9) = "Tasa":         Grid1.TextMatrix(1, 9) = "":              Grid1.ColWidth(9) = 1050
    Grid1.TextMatrix(0, 10) = "Precio":      Grid1.TextMatrix(1, 10) = "":             Grid1.ColWidth(10) = 1050
    Grid1.TextMatrix(0, 11) = "Estado":      Grid1.TextMatrix(1, 11) = "":             Grid1.ColWidth(11) = 1300
    Grid1.TextMatrix(0, 12) = "Operador":    Grid1.TextMatrix(1, 12) = "":             Grid1.ColWidth(12) = 0 ''1300
    Grid1.TextMatrix(0, 13) = "Forma/Pago":  Grid1.TextMatrix(1, 13) = "Entregamos":   Grid1.ColWidth(13) = 3000
    Grid1.TextMatrix(0, 14) = "Forma/Pago":  Grid1.TextMatrix(1, 14) = "Recibimos":    Grid1.ColWidth(14) = 3000
    Grid1.TextMatrix(0, 15) = "Fecha":       Grid1.TextMatrix(1, 15) = "":             Grid1.ColWidth(15) = 1300
    Grid1.TextMatrix(0, 16) = "Operador":    Grid1.TextMatrix(1, 16) = "":             Grid1.ColWidth(16) = 1300
    Grid1.TextMatrix(0, 17) = "Mercado":     Grid1.TextMatrix(1, 17) = "":             Grid1.ColWidth(17) = 0
    Grid1.TextMatrix(0, 18) = "Rut":         Grid1.TextMatrix(1, 18) = "Cartera":      Grid1.ColWidth(18) = 0
    Grid1.TextMatrix(0, 19) = "Tipo":        Grid1.TextMatrix(1, 19) = "Operación":    Grid1.ColWidth(19) = 0
    Grid1.TextMatrix(0, 20) = "Impresión":                                             Grid1.ColWidth(20) = 0
    Grid1.TextMatrix(0, 21) = "1º Firma":    Grid1.TextMatrix(1, 20) = "":             Grid1.ColWidth(21) = 1300
    Grid1.TextMatrix(0, 22) = "2º Firma":    Grid1.TextMatrix(1, 21) = "":             Grid1.ColWidth(22) = 1300

    Grid1.SelectionMode = flexSelectionFree
End Sub

Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   Me.Top = 1: Me.Left = 16
   
   Vcol = 7
   Impre = "N"

   Txt_Fecha_Termino.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
   Txt_Fecha_Inicio.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")

   Call Carga_Combos
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
   Dim I%

   If Mid(Trim(Cmb_Modulo), 1, 11) <> "<< TODOS >>" Then
      If Trim(Mid(Cmb_Modulo, InStr(1, Cmb_Modulo, "CODIGO") + Len("CODIGO"), 70)) = "-" Then
         Call MsgBox("No tiene sistemas habilitados para seleccionar información.", vbInformation, App.Title)
         Exit Function
      End If
   End If


   For Fila = 2 To Grid1.Rows - 1
      If Trim(Grid1.TextMatrix(Fila, 0)) = "X" Then
         MArca(Fila) = 1
      End If
   Next Fila
   Grid1.Redraw = False
    
   Envia = Array()
   If Mid(Trim(Cmb_Modulo), 1, 11) = "<< TODOS >>" Then
      AddParam Envia, " "
   Else
      AddParam Envia, Trim(Mid(Cmb_Modulo, InStr(1, Cmb_Modulo, "CODIGO") + Len("CODIGO"), 70))
   End If
   
   AddParam Envia, Trim(Right(Cmb_T_Operacion, 5)) '.ItemData(Cmb_T_Operacion.ListIndex)
   If Mid(Trim(Cmb_Estatus_Operacion), 1, 11) = "<< TODOS >>" Then
      AddParam Envia, "T"
   ElseIf Mid(Trim(Cmb_Estatus_Operacion), 1, 8) = "APROBADA" Then
      AddParam Envia, " "
   Else
      AddParam Envia, Trim(Mid$(Cmb_Estatus_Operacion, 1, 1)) '.ItemData(Cmb_Estatus_Operacion.ListIndex)
   End If
   AddParam Envia, Trim(Mid(Cmb_Usuarios, InStr(1, Cmb_Usuarios, "CODIGO") + Len("CODIGO"), 70)) 'Cmb_Usuarios.Text
   AddParam Envia, Trim(Mid(Cmb_Monedas, InStr(1, Cmb_Monedas, "CODIGO") + Len("CODIGO"), 70)) 'Cmb_Monedas.ItemData(Cmb_Monedas.ListIndex)
   AddParam Envia, Cmb_Recibimos.ItemData(Cmb_Recibimos.ListIndex)
   AddParam Envia, Cmb_Pagamos.ItemData(Cmb_Pagamos.ListIndex)

   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("SP_FILTRO_GRILLA_IMP_PAPELETA", Envia) Then
      Grid1.Redraw = True
      Exit Function
   End If

   Grid1.Enabled = False
   Grid1.Clear
   Call Nombres_Grilla

   Do While Bac_SQL_Fetch(DATOS())
      c1 = "1"
      With Grid1
         Grid1.Rows = Grid1.Rows + 1
         Grid1.Row = Grid1.Rows - 2
         Grid1.Col = 0: Grid1.Text = " "
         Grid1.CellPictureAlignment = 4
            
         Set Grid1.CellPicture = Me.SinCheck(0).Image
            
         Grid1.Col = 1:    Grid1.Text = DATOS(1)
         Grid1.Col = 2:    Grid1.Text = DATOS(2)
         Grid1.Col = 3:    Grid1.Text = DATOS(3)
         Grid1.Col = 4:    Grid1.Text = DATOS(4)
         Grid1.Col = 5:    Grid1.Text = DATOS(5)
         Grid1.Col = 6:    Grid1.Text = DATOS(6)
         Grid1.Col = 7:    Grid1.Text = DATOS(7)
         Grid1.Col = 8:    Grid1.Text = Format(DATOS(8), FDecimal)
         Grid1.Col = 9:    Grid1.Text = Format(DATOS(10), FDecimal)
         Grid1.Col = 10:   Grid1.Text = Format(DATOS(11), FDecimal)
         Grid1.Col = 11:   Grid1.Text = DATOS(12)
         Grid1.Col = 12:   Grid1.Text = DATOS(13)
         Grid1.Col = 13:   Grid1.Text = DATOS(14)
         Grid1.Col = 14:   Grid1.Text = DATOS(15)
         Grid1.Col = 15:   Grid1.Text = DATOS(16)
         Grid1.Col = 16:   Grid1.Text = DATOS(17)
         Grid1.Col = 17:   Grid1.Text = DATOS(18)
         Grid1.Col = 18:   Grid1.Text = DATOS(19)
         Grid1.Col = 20:   Grid1.Text = DATOS(20)
         Grid1.Col = 21:   Grid1.Text = DATOS(22)
         Grid1.Col = 22:   Grid1.Text = DATOS(23)
         Grid1.RowHeight(Grid1.Rows - 2) = 300
      End With

      If DATOS(20) = 1 Then
         For nCol = 0 To 22
            Grid1.Col = nCol
            Grid1.CellBackColor = lblImpresas.BackColor
         Next nCol
      End If
   Loop

   If UBound(MArca) > 2 Then
      For Fila = 2 To Grid1.Rows - 1
         If MArca(Fila) = 1 Then
            Grid1.TextMatrix(Fila, 0) = Space(100) & "X"
            Grid1.Row = Fila
            Grid1.Col = 0
            Set Grid1.CellPicture = Me.SinCheck(0).Image
         End If
      Next Fila
   End If

   Grid1.Rows = Grid1.Rows - 1
   Grid1.Enabled = True
   Grid1.Redraw = True
    
End Function

Private Sub grid1_Click()
   
    If Grid1.Rows > 1 And Grid1.Col = 0 Then
        If Trim(Grid1.TextMatrix(Grid1.Row, 0)) = "X" Then
            Grid1.TextMatrix(Grid1.Row, 0) = ""
            Set Grid1.CellPicture = Me.SinCheck(0).Image
        Else
            Set Grid1.CellPicture = Me.ConCheck(0).Image
            Grid1.CellAlignment = 4
            Grid1.TextMatrix(Grid1.Row, 0) = Space(100) + "X"
        End If
    End If
 
End Sub

Private Sub Grid1_DblClick()
   BacPantOperaciones Grid1, 1
End Sub

Private Sub Grid1_KeyDown(KeyCode As Integer, Shift As Integer)

   Select Case KeyCode
      Case vbKeySpace
       '   If Grid1.TextMatrix(Grid1.Row, 1) <> "" And Grid1.TextMatrix(Grid1.Row, 2) <> "" Then 'No parece vacía...
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
       '   End If
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
               Set Grid1.CellPicture = Me.ConCheck(0).Image
            Else
               Set Grid1.CellPicture = Me.SinCheck(0).Image
            End If
         Next nCont
         Grid1.Redraw = True
         Toolbar1.Buttons(1).ToolTipText = IIf(strOk = "X", "&Desm", "&M") & "arcar Todos"
         Me.MousePointer = 0
      Case 2
         Call BacLeeOperaciones(Grid1, 1)
      Case 3
         Call Refre_Grilla
         ''''If Toolbar1.Buttons(1).ToolTipText = "Marcar/Desmarcar Todo" Then
         If Toolbar1.Buttons(3).ToolTipText = "Refrescar" Then
            For nCont = 2 To Grid1.Rows - 1
               Grid1.Row = nCont
               Grid1.Col = 0
               Grid1.CellAlignment = 4
               Grid1.Text = Space(100) & " " 'strOk
               Set Grid1.CellPicture = Me.SinCheck(0).Image
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
            'Toolbar1.Buttons(1).ToolTipText = IIf(strOk = "X", "&Desm", "&M") & "arcar Todos"
            Me.MousePointer = 0
         End If
      Case 4
         Call BacLeeOperaciones(Grid1, 1)
      Case 5
         
         SQL = "No"
         Unload Me
   End Select
End Sub

Private Function ChkFechas(StrFecha_Inicio, StrFecha_Termino, IntInicio_Termino) As Boolean
    ChkFechas = False
   Dim a As Variant
    'If DateDiff("d", CDate(StrFecha_Termino), CDate(StrFecha_Inicio)) < 0 Then
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

Private Sub Txt_Fecha_Inicio_Change()
    Dim Boo_Resultado As Boolean
    Boo_Resultado = ChkFechas(Txt_Fecha_Inicio.Text, Txt_Fecha_Termino.Text, 1)
    If Not Boo_Resultado Then
        Txt_Fecha_Inicio.Text = Txt_Fecha_Termino.Text
    End If

End Sub

Private Sub Txt_Fecha_Termino_Change()
    Dim Boo_Resultado As Boolean
    Boo_Resultado = ChkFechas(Txt_Fecha_Inicio.Text, Txt_Fecha_Termino.Text, 2)
    If Not Boo_Resultado Then
        Txt_Fecha_Termino.Text = Txt_Fecha_Inicio.Text
    End If

End Sub

Private Function BacLeeOperaciones(Grid1 As Object, nTipo As Integer)
   On Error GoTo Errores
   
   Dim nNumOpe          As Long
   Dim nCont            As Integer
   Dim c1               As Variant
   Dim Destino          As Integer
   Dim destino1         As Integer 'para Papeleta
   Dim Cual             As Integer
   Dim nCol             As Integer
   Dim Papel            As String
   Dim m
   Dim lMxClp           As Boolean
   Dim sTipOper         As String
            
   Destino = IIf(True, crptToWindow, crptToPrinter)
   destino1 = IIf(True, 1, 0)
   c1 = "X"
    
   SwImprimir = 0
   If nTipo = 3 Then
      Call Bac_Sql_Execute("TRUNCATE TABLE MOVIMIENTOS_IMPRESION")
   End If
    
   For nCont = 2 To Grid1.Rows - 1
      Grid1.Row = nCont
      Grid1.Col = 0
      
      If Trim(Grid1.TextMatrix(nCont, 0)) = "X" Then
         c1 = "p"
         Grid1.Col = 1
         nNumOpe = Val(Grid1.Text)
         Papel = Grid1.TextMatrix(nCont, 1)
         Call Limpiar_Cristal
         If Grid1.TextMatrix(nCont, 1) = "BCC" Then
            If Grid1.TextMatrix(nCont, 17) = "PTAS" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "bacpuntaspot.rpt", 0, Destino)
            ElseIf Grid1.TextMatrix(nCont, 17) = "EMPR" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "bacempresa.rpt", 0, Destino)
            ElseIf Grid1.TextMatrix(nCont, 17) = "ARBI" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "bacarbitrajes.rpt", 0, Destino)
            ElseIf Grid1.TextMatrix(nCont, 17) = "OVER" Or Grid1.TextMatrix(nCont, 2) = "WEEK" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "bacmesadin.rpt", 0, Destino)
            ElseIf Grid1.TextMatrix(nCont, 17) = "CANJ" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "baccupoarr.rpt", 0, Destino)
            ElseIf Grid1.TextMatrix(nCont, 17) = "VB2" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "bacrpapefur.rpt", 0, Destino)
            ElseIf Grid1.TextMatrix(nCont, 17) = "FUTU" Or Grid1.TextMatrix(nCont, 2) = "1446" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "bacrpapefur.rpt", 0, Destino)
            ElseIf Grid1.TextMatrix(nCont, 17) = "ARRI" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "bacarriposi.rpt", 0, Destino)
            ElseIf Grid1.TextMatrix(nCont, 17) = "CUPO" Then
               Call BacImprimpapeletas(Grid1.TextMatrix(nCont, 2), "baccupovb2.rpt", 0, Destino)
            End If
         ElseIf Grid1.TextMatrix(nCont, 1) = "BFW" Then
            nNumOpe = Grid1.TextMatrix(nCont, 2)
            lMxClp = IsMxClp(nNumOpe)
            sTipOper = Grid1.TextMatrix(nCont, 17)
            '
            '   Si es una operación Mx-Clp le asigna el codigo de producto 12 (Mx-Clp)
            '   para la impresion correcta de la papeleta
            '
            If lMxClp Then
                sTipOper = 12
            End If
            Call ImprimirPapeletaBFW(Grid1.TextMatrix(nCont, 2), 0, sTipOper)   ' 20 Ene. 2011
            
         ElseIf Grid1.TextMatrix(nCont, 1) = "BEX" Then
            Call Imprimir_PapeletasBonex(Grid1.TextMatrix(nCont, 5), Grid1.TextMatrix(nCont, 2), 0, "")
         ElseIf Grid1.TextMatrix(nCont, 1) = "PCS" Then
            Select Case Grid1.TextMatrix(nCont, 17)
               Case "TASA":   Cual = 1
               Case "MONEDA": Cual = 2
               Case "PROM.C": Cual = 4
               Case Else:     Cual = 3
            End Select
            Call GeneraNuevasPapeletas(CDbl(Grid1.TextMatrix(nCont, 2)), Cual)
         ElseIf Grid1.TextMatrix(nCont, 1) = "BTR" Then
            Call ImprimePapeletaBTR(Grid1.TextMatrix(nCont, 19), Grid1.TextMatrix(nCont, 2), IIf(Grid1.TextMatrix(nCont, 19) = "AIC", "AC", Grid1.TextMatrix(nCont, 18)), "N", Grid1.TextMatrix(nCont, 4))
         ElseIf Grid1.TextMatrix(nCont, 1) = "OPT" Then
            Call ImprimirPapeletaOPT(Grid1.TextMatrix(nCont, 2), 0, Grid1.TextMatrix(nCont, 17))  ' 19 Oct. 2009
         Else
            MsgBox "No se ha marcado operación(es) a Imprimir", 16, TITSISTEMA
         End If
         
         If SwImprimir <> 1 Then
            For nCol = 0 To 20
               Grid1.Col = nCol
               Grid1.CellBackColor = lblImpresas.BackColor
            Next nCol
             
            Envia = Array()
            AddParam Envia, Grid1.TextMatrix(nCont, 1)
            AddParam Envia, Grid1.TextMatrix(nCont, 2)
            AddParam Envia, 1
            If Not Bac_Sql_Execute("SP_GRABA_SW_IMPRESION", Envia) Then
               Exit Function
            End If
         Else
            Exit Function
         End If
      End If
   Next nCont

   If c1 = "X" Then
      MsgBox "No Hay Operaciones marcadas a Imprimir", 16, TITSISTEMA
      Exit Function
   End If

   On Error GoTo 0
Exit Function
Errores:
   MsgBox Err.Description, , TITSISTEMA
End Function


Private Sub GeneraNuevasPapeletas(NumOpeer As Double, TiposSwap As Integer)
   On Error GoTo PrinterError
   Dim cPapeleta As String
   
   cPapeleta = "PAPELETA_SWAP.RPT"     ' --> Store Procedure : "dbo.SP_PAPELETA_SWAP"
   
   If TiposSwap = 3 Then
      cPapeleta = "PAPELETA_FRA.RPT"   ' --> Store Procedure : "dbo.SP_PAPELETA_SWAP"
   End If
   
   Call Limpiar_Cristal
   
   BacControlFinanciero.CryFinanciero.ReportTitle = "Papeleta de Derivados Swap."
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathPCS & cPapeleta
   BacControlFinanciero.CryFinanciero.WindowTitle = "Papeleta Swap de Tasas"
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Val(NumOpeer)
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(gsBAC_User)
   BacControlFinanciero.CryFinanciero.Destination = crptToWindow
   BacControlFinanciero.CryFinanciero.Connect = swConeccionPCS
   BacControlFinanciero.CryFinanciero.Action = 1
   
   On Error GoTo 0
Exit Sub
PrinterError:
   MsgBox "Se ha producido un error al imprimir papeleta" & vbCrLf & BacControlFinanciero.CryFinanciero.LastErrorString, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub


Private Function BacPantOperaciones(Grid1 As Object, nTipo As Integer)
   On Error GoTo Errores

   Dim sModulo       As String
   Dim stipoper      As String
   Dim nNumOpe       As Long
   Dim nrutcart      As String
   Dim nNumOpeRF     As String
   Dim Cual          As Integer
   Dim stipoperBEX   As String
   Dim nCorrelaRF     As String
   Dim lMxClp        As Boolean
      
   Dim nRow          As Integer
   Dim cTipMercado   As String
   Dim nOperacion    As Long
   Dim Operador_Origen As String
   
   With Grid1
      sModulo = .TextMatrix(.Row, 1)
      nNumOpe = .TextMatrix(.Row, 2)
      stipoper = .TextMatrix(.Row, 17)
      nNumOpeRF = .TextMatrix(.Row, 2)
      stipoperBEX = .TextMatrix(.Row, 5)
      nCorrelaRF = .TextMatrix(.Row, 4)
      
            If sModulo = "BCC" Then
               
                    If stipoper = "PTAS" Then
                        Call BacImprimpapeletas(nNumOpe, "bacpuntaspot.rpt", 0, 1)
                    ElseIf stipoper = "EMPR" Then
                        Call BacImprimpapeletas(nNumOpe, "bacempresa.rpt", 0, 1)
                    ElseIf stipoper = "ARBI" Then
                        Call BacImprimpapeletas(nNumOpe, "bacarbitrajes.rpt", 0, 1)
                    ElseIf stipoper = "OVER" Or nNumOpe = "WEEK" Then
                        Call BacImprimpapeletas(nNumOpe, "bacmesadin.rpt", 0, 1)
                    ElseIf stipoper = "CANJ" Then
                      Call BacImprimpapeletas(nNumOpe, "baccupoarr.rpt", 0, 1)
                    ElseIf stipoper = "VB2" Then
                        Call BacImprimpapeletas(nNumOpe, "bacrpapefur.rpt", 0, 1)
                    ElseIf stipoper = "FUTU" Or nNumOpe = "1446" Then
                        Call BacImprimpapeletas(nNumOpe, "bacrpapefur.rpt", 0, 1)
                    ElseIf stipoper = "ARRI" Then
                        Call BacImprimpapeletas(nNumOpe, "bacarriposi.rpt", 0, 1)
                    ElseIf stipoper = "CUPO" Then
                        Call BacImprimpapeletas(nNumOpe, "baccupovb2.rpt", 0, 1)
                    End If
                    
               
               
            ElseIf sModulo = "BFW" Then
                lMxClp = IsMxClp(nNumOpe)

                '
                '   Si es una operación Mx-Clp le asigna el codigo de producto 12 (Mx-Clp)
                '   para la impresion correcta de la papeleta
                '
                If lMxClp Then
                    sTipOper = 12
                End If
                Call ImprimirPapeletaBFW(nNumOpe, 1, stipoper)

            ElseIf sModulo = "BEX" Then

                Call Imprimir_PapeletasBonex(stipoperBEX, nNumOpe, 1, "")



            ElseIf sModulo = "PCS" Then
            
                Select Case stipoper
                    Case "TASA"
                        Cual = 1
                    Case "MONEDA"
                        Cual = 2
                    Case "PROM.C"
                        Cual = 4
                    Case Else
                        Cual = 3
                End Select

                Call ImprimePapeletaSwap(nNumOpe, 1, "Pantalla", Cual)
                
            ElseIf sModulo = "BTR" Then
                 stipoper = .TextMatrix(.Row, 18)
                 Call ImprimePapeletaBTR("", nNumOpeRF, IIf(stipoper = "AIC", "AC", stipoper), "S", nCorrelaRF)
            
            ElseIf sModulo = "OPT" Then
                 Call ImprimirPapeletaOPT(nNumOpe, 1, stipoper)  ' 26 Oct. 2009
            
            End If
 
 End With
 
 'Grid1.TextMatrix(Grid1.Row, 0) = ""
 'Set Grid1.CellPicture = Me.SinCheck(0).Image
   
On Error GoTo 0
Exit Function

Errores:
    MsgBox Err.Description, , TITSISTEMA
End Function

Function IsMxClp(nOperacion As Long) As Boolean
    Dim sSql    As String
    Dim DATOS()
    Dim OperacionRel As Long

        Envia = Array()
        AddParam Envia, nOperacion
        If Not Bac_Sql_Execute("BacFwdSuda..SP_VERIFICA_MXCLP", Envia) Then
            Exit Function
        End If
        Do While Bac_SQL_Fetch(DATOS())
            OperacionRel = DATOS(1)
        Loop
        IsMxClp = (OperacionRel > 0)

End Function



