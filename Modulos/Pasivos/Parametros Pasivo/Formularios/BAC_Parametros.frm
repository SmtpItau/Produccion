VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.MDIForm BAC_Parametros 
   BackColor       =   &H80000004&
   Caption         =   "BAC-Parametros"
   ClientHeight    =   8310
   ClientLeft      =   1410
   ClientTop       =   2295
   ClientWidth     =   8880
   Icon            =   "BAC_Parametros.frx":0000
   LinkTopic       =   "BacTrd"
   Picture         =   "BAC_Parametros.frx":2EFA
   WindowState     =   2  'Maximized
   Begin MSComDlg.CommonDialog dlg_Principal 
      Left            =   8730
      Top             =   2460
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin Crystal.CrystalReport BacParam 
      Left            =   8760
      Top             =   1860
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   10000
      Left            =   8040
      Top             =   2580
   End
   Begin Threed.SSPanel PnlInfo 
      Align           =   2  'Align Bottom
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   7890
      Width           =   8880
      _Version        =   65536
      _ExtentX        =   15663
      _ExtentY        =   741
      _StockProps     =   15
      ForeColor       =   8421504
      BackColor       =   -2147483633
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RoundedCorners  =   0   'False
      Outline         =   -1  'True
      Alignment       =   8
      Begin Threed.SSPanel PnlEstado 
         Height          =   315
         Left            =   65
         TabIndex        =   1
         Top             =   60
         Width           =   4000
         _Version        =   65536
         _ExtentX        =   7056
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   1
      End
      Begin Threed.SSPanel Pnl_UF 
         Height          =   315
         Left            =   6765
         TabIndex        =   2
         Top             =   60
         Width           =   1980
         _Version        =   65536
         _ExtentX        =   3492
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
      End
      Begin Threed.SSPanel PnlUsuario 
         Height          =   315
         Left            =   4065
         TabIndex        =   3
         Top             =   60
         Width           =   2685
         _Version        =   65536
         _ExtentX        =   4736
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483639
         BackColor       =   -2147483646
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
      End
      Begin Threed.SSPanel PnlFecha 
         Height          =   315
         Left            =   10635
         TabIndex        =   4
         Top             =   60
         Width           =   1470
         _Version        =   65536
         _ExtentX        =   2593
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
      End
      Begin Threed.SSPanel Pnl_DO 
         Height          =   315
         Left            =   8760
         TabIndex        =   5
         Top             =   60
         Width           =   1860
         _Version        =   65536
         _ExtentX        =   3281
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
      End
   End
   Begin MSComctlLib.ImageList ILST_ImagenesMDI 
      Left            =   10770
      Top             =   1500
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BAC_Parametros.frx":9084
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BAC_Parametros.frx":F21E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   11760
      Top             =   1500
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BAC_Parametros.frx":153B8
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BAC_Parametros.frx":158F5
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BAC_Parametros.frx":15E0A
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BAC_Parametros.frx":16246
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BAC_Parametros.frx":166F7
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BAC_Parametros.frx":16BF3
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   1350
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   8880
      _ExtentX        =   15663
      _ExtentY        =   2381
      ButtonWidth     =   3016
      ButtonHeight    =   794
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   11
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clientes             "
            Object.ToolTipText     =   "Tipo Usuarios"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Feriados            "
            Object.ToolTipText     =   "Usuarios"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Emisores        "
            Object.ToolTipText     =   "Bloqueo de Usuarios"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Valor Moneda    "
            Object.Tag             =   "Privilegios de Usuario"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Perfi Contable  "
            Object.ToolTipText     =   "Cambiar Clave Administrador"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Generar UF        "
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.Menu OPC_20 
      Caption         =   "Clientes  "
      Begin VB.Menu OPC_21 
         Caption         =   "Clientes                           "
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_22 
         Caption         =   "Operadores"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_23 
         Caption         =   "Apoderados"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_30 
      Caption         =   "Monedas    "
      Begin VB.Menu OPC_31 
         Caption         =   "Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_32 
         Caption         =   "Monedas por Producto         "
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_33 
         Caption         =   "Valores Monedas"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu OPC_MONEDA_MERCADO 
         Caption         =   "Valores Monedas Mercado"
         HelpContextID   =   1
      End
      Begin VB.Menu Rayita 
         Caption         =   "-"
      End
      Begin VB.Menu OPC_700 
         Caption         =   "Generación Automática UF"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_740 
         Caption         =   "Generación Automática IVP"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_40 
      Caption         =   "Formas de Pago  "
      Begin VB.Menu OPC_41 
         Caption         =   "Formas de Pago"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_42 
         Caption         =   "Formas de Pago por Moneda      "
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_550 
      Caption         =   "Contabilidad"
      Begin VB.Menu OPC_551 
         Caption         =   "Perfiles Contables"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_552 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_553 
         Caption         =   "Valores a Contabilizar"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_554 
         Caption         =   "Plan de Cuentas"
         HelpContextID   =   1
      End
      Begin VB.Menu ProdporCam 
         Caption         =   "Productos por campos"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_556 
         Caption         =   "Porductos Por Campos Logicos"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_600 
      Caption         =   "Administracion"
      Begin VB.Menu OPC_610 
         Caption         =   "Tablas"
         HelpContextID   =   1
         Begin VB.Menu OPC_611 
            Caption         =   "Emisores"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_612 
            Caption         =   "Series"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu mnuNemotecnicoFFMM 
            Caption         =   "Nemotécnico Fondos Mutuos"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu OPC_614 
            Caption         =   "Feriado"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_615 
            Caption         =   "Familia de Instrumentos"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Mnt_Calidad_Juridica 
            Caption         =   "Calidad Jurídica"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Mnt_Categoria_Deudor 
            Caption         =   "Categoría Deudor"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Mnt_Tipo_Moneda 
            Caption         =   "Tipo Moneda"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_Relacion_Banco 
            Caption         =   "Relación Banco"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Mnt_Relacion_Inst_Fin 
            Caption         =   "Relación Instituciones Financieras"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_Tipo_Amort 
            Caption         =   "Tipo Amortización"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_Tipo_Base 
            Caption         =   "Tipo Base"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_Tipo_Basilea 
            Caption         =   "Tipo Basilea"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Mnt_Tipo_Clte 
            Caption         =   "Tipo Cliente"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_Tipo_Control 
            Caption         =   "Tipo Control"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Mnt_Tipo_Emision 
            Caption         =   "Tipo Emisión"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_Tipo_Fecha 
            Caption         =   "Tipo Fecha"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_Tipo_Intrum 
            Caption         =   "Tipo Instrumento"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Mnt_Tipo_Mercado 
            Caption         =   "Tipo Mercado"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Mnt_Var_Mon 
            Caption         =   "Variabilidad de Moneda"
            HelpContextID   =   2
         End
         Begin VB.Menu opc_780 
            Caption         =   "País y Plaza "
            HelpContextID   =   2
         End
         Begin VB.Menu opc_775 
            Caption         =   "Area"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu opc_777 
            Caption         =   "Tipo de Emisor"
            HelpContextID   =   2
         End
         Begin VB.Menu mnt_Ejecutivo 
            Caption         =   "Ejecutivo"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu mnu_plazo_informe 
            Caption         =   "Plazo Para Informe de Cartera"
            HelpContextID   =   2
            Visible         =   0   'False
         End
      End
      Begin VB.Menu OPC_730 
         Caption         =   "Clientes SINACOFI"
         Enabled         =   0   'False
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu opc_750 
         Caption         =   "Corresponsales"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu opc_760 
         Caption         =   "Cambio de Password"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_778 
         Caption         =   "Mantenedor de Interfaces"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Mnt_Control 
         Caption         =   "Mantenedor de Tablas de Control"
         HelpContextID   =   1
      End
      Begin VB.Menu Mnt_PComputable 
         Caption         =   "Porcentaje Computable"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Mnt_Gestion_Tes 
         Caption         =   "Mantenedor de Codigos Gestion Tesoreria"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Mnt_Relacion_Curvas 
         Caption         =   "Mantenedor de Relación para Curvas"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Mnt_Casillas_Transmision 
         Caption         =   "Mantenedor de Casillas de Transmision"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Mnt_Codigos_Transaccion_Swift 
         Caption         =   "Mantenedor de Codigos Transaccion Swift"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Mnt_Tipo_Operacion_Spot 
         Caption         =   "Mantenedor de Tipo Operación Spot"
         HelpContextID   =   1
         Visible         =   0   'False
      End
   End
   Begin VB.Menu OPC_800 
      Caption         =   "Informes"
      Begin VB.Menu OPC_810 
         Caption         =   "Clientes"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_820 
         Caption         =   "Emisores"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_850 
         Caption         =   "Valores Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_870 
         Caption         =   "Instrumentos"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_871 
         Caption         =   "Productos v/s Códigos de Comercio"
         HelpContextID   =   1
         Visible         =   0   'False
      End
   End
   Begin VB.Menu OPC_900 
      Caption         =   "Salir"
   End
End
Attribute VB_Name = "BAC_Parametros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim SW As Integer
Dim ContSw As Long

Dim clsWall As New CLS_Wallpaper

Sub DESHABILITA_MENU()
    Dim i%
    ' DESHABILITA TODAS LAS OPCIONES DEL MENU
    For i% = 0 To Me.Controls.Count - 1

        On Error Resume Next

        If TypeOf Me.Controls(i%) Is Menu Then
            
            If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" Then
                
                Me.Controls(i%).Enabled = False
                Me.Controls(i%).Visible = False
            
            End If
       
        End If
    
        If TypeOf Me.Controls(i%) Is SSCommand Then Me.Controls(i%).Enabled = False

    Next i%

End Sub

Sub MENU_TODOHABILITADO()

    Dim i%
    ' HABILITA TODAS LAS OPCIONES DEL MENU
    For i% = 0 To Me.Controls.Count - 1

        On Error Resume Next

        If TypeOf Me.Controls(i%) Is Menu Then
        
            If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "&Salir" Then
                If (Me.Controls(i%).Caption = "Clientes SINACOFI") Or (Me.Controls(i%).Caption = "Mantenedor de Tipo Operación Spot") _
                    Or (Me.Controls(i%).Caption = "Mantenedor de Codigos Transaccion Swift") Or (Me.Controls(i%).Caption = "Mantenedor de Casillas de Transmision") _
                    Or (Me.Controls(i%).Caption = "Mantenedor de Relación para Curvas") Or (Me.Controls(i%).Caption = "Mantenedor de Codigos Gestion Tesoreria") _
                    Or (Me.Controls(i%).Caption = "Porcentaje Computable") Or (Me.Controls(i%).Caption = "Mantenedor de Interfaces") Or (Me.Controls(i%).Caption = "Corresponsales") _
                    Or (Me.Controls(i%).Caption = "Plazo Para Informe de Cartera") Or (Me.Controls(i%).Caption = "Ejecutivo") Or (Me.Controls(i%).Caption = "Area") _
                    Or (Me.Controls(i%).Caption = "Tipo Mercado") Or (Me.Controls(i%).Caption = "Tipo Instrumento") Or (Me.Controls(i%).Caption = " Tipo Fecha") _
                    Or (Me.Controls(i%).Caption = "Tipo Emisión") Or (Me.Controls(i%).Caption = "Tipo Control") Or (Me.Controls(i%).Caption = "Tipo Basilea") _
                    Or (Me.Controls(i%).Caption = "Relación Banco") Or (Me.Controls(i%).Caption = "Categoría Deudor") Or (Me.Controls(i%).Caption = "Calidad Jurídica") _
                    Or (Me.Controls(i%).Caption = "Familia de Instrumentos") Or (Me.Controls(i%).Caption = "Nemotécnico Fondos Mutuos") _
                    Or (Me.Controls(i%).Caption = "Series") _
                    Or (Me.Controls(i%).Caption = "Productos v/s Códigos de Comercio") _
                    Or (Me.Controls(i%).Caption = "Valores Monedas Mercado") _
                    Then 'Or (Me.Controls(i%).Caption = "Valores Monedas")
                        
                        Me.Controls(i%).Enabled = False
                        Me.Controls(i%).Visible = False
                Else
                        Me.Controls(i%).Enabled = True
                        Me.Controls(i%).Visible = True
                End If
            End If

        End If
        
        If TypeOf Me.Controls(i%) Is SSCommand Then Me.Controls(i%).Enabled = True

    Next i%

End Sub

Function RevisarMensajes()

   Dim Sql           As String
   Dim nForms        As Integer
   Dim Datos()


End Function





Private Sub ForPag_Click()
BacMntFormaPago.Show vbNormal
End Sub



Private Sub CmdOPC_21_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
   
   opc_21_Click
   
End Sub


Private Sub CmdOPC_33_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

   opc_33_Click

End Sub

Private Sub CmdOPC_551_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

   opc_551_Click

End Sub

Private Sub CmdOPC_612_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

   opc_612_Click

End Sub

Private Sub CmdOPC_614_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

   opc_614_Click

End Sub

Private Sub MDIForm_Activate()
   Dim A As Integer
   Dim Sql As String
   Dim cPict As String
   Dim Datos()

   SW = 1
   ContSw = 0
   Screen.MousePointer = 0
   'Me.Caption = "BAC-PARAMETROS ( Sql Server ) " & gsSQL_Server & "/" & gsSQL_Database
   Me.Caption = App.Title & " ( Sql Server ) " & gsSQL_Server & "/" & gsSQL_Database
   
   PROC_CARGA_AYUDA Me, " "
   
   'Activa el Login a BacTrader.-
   If Not gbBac_Login Then
      If Not Proc_Carga_Parametros Then
         MsgBox "Error al cargar parámetros", vbCritical
         Call LogAuditoria("05", "", Me.Caption + " Error al cargar parámetros", "", "")
         End
         Exit Sub
      End If

      Call DESHABILITA_MENU
      Acceso_Usuario.Show 1

      If gsBAC_Login Then
         Screen.MousePointer = 11
         PROC_BUSCA_PRIVILEGIOS_USUARIO BAC_Parametros, "PCA"
         If Trim(gsBAC_User$) = "" Then
            Unload Me
            Exit Sub
         End If

         PROC_GUARDAR_REGISTRO "SISTEMAS BAC", "NET", "USER_NAME", gsBAC_User

         gbBac_Login = True
         Timer1.Enabled = True
      Else
         Unload Me
         Exit Sub
      End If
   End If

   Toolbar1.Buttons(1).Enabled = OPC_21.Enabled
   Toolbar1.Buttons(3).Enabled = OPC_614.Enabled
   Toolbar1.Buttons(5).Enabled = OPC_611.Enabled
   Toolbar1.Buttons(7).Enabled = OPC_33.Enabled
   Toolbar1.Buttons(9).Enabled = OPC_551.Enabled
   Toolbar1.Buttons(11).Enabled = OPC_700.Enabled
   

   Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
   Me.PnlFecha.Caption = Format(gsbac_fecp, gsc_FechaDMA)
   Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, FDecimal)
   Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, FDecimal)
   Me.PnlUsuario.Caption = gsBAC_User
   FechaSistema = Format(gsbac_fecp, gsc_FechaDMA)
          
             
   Screen.MousePointer = 0
 
End Sub

Private Function Proc_Carga_Parametros() As Boolean
   
   Dim Datos()
   
   Proc_Carga_Parametros = False
   
   If Not BAC_SQL_EXECUTE("sp_bacswapparametros_cargaparametros") Then
        
      Exit Function
      
   End If
     
   If BAC_SQL_FETCH(Datos()) Then
   
      gsbac_fecp = Datos(1)
      gsBAC_Clien = Datos(2)
   
      gsBac_FecAn = Datos(6)
      gsBAC_Fecpx = Datos(3)
   
   End If
     
   If Not BAC_SQL_EXECUTE("sp_bacswapparametros_traecartera") Then
   
      Exit Function
      
   End If
   
   
   If Not gsc_Parametros.DatosGenerales() Then
   
      Exit Function
      
   End If
      
   Proc_Carga_Parametros = True

End Function

Sub PROC_CARGA_PRIVILEGIOS()

'***************leo************

Dim Datos()
Dim i%
Dim Comando As String


If Trim(gsBAC_User) = "ADMINISTRADOR" Then Exit Sub

' DESHABILITA TODAS LAS OPCIONES DEL MENU

For i% = 0 To Me.Controls.Count - 1

    On Error Resume Next

    If TypeOf Me.Controls(i%) Is Menu Then

       If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" Then
          
          Me.Controls(i%).Enabled = True
          Me.Controls(i%).Visible = True
       
       End If

    End If

Next i%

Envia = Array()
AddParam Envia, "T"
AddParam Envia, "PCA"
AddParam Envia, gsBac_Tipo_Usuario

If Not BAC_SQL_EXECUTE("sp_busca_privilegios ", Envia) Then Exit Sub

' BUSCA LAS OPCIONES POR TIPO DE USUARIO

Do While BAC_SQL_FETCH(Datos())

   For i% = 0 To Me.Controls.Count - 1

       On Error Resume Next

       If TypeOf Me.Controls(i%) Is Menu Then
       
          If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
             
             Me.Controls(i%).Enabled = True
             Me.Controls(i%).Visible = True
          
          End If
       
       End If

   Next i%

Loop

' BUSCA LAS OPCIONES POR USUARIO

Envia = Array()
AddParam Envia, "U"
AddParam Envia, "PCA"
AddParam Envia, gsBac_Tipo_Usuario

If Not BAC_SQL_EXECUTE("SP_BUSCA_PRIVILEGIOS ", Envia) Then Exit Sub

' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA

Do While BAC_SQL_FETCH(Datos())

   For i% = 0 To Me.Controls.Count - 1

   On Error Resume Next

       If TypeOf Me.Controls(i%) Is Menu Then
       
          If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
             
             Me.Controls(i%).Enabled = True
             Me.Controls(i%).Visible = True
          
          End If
       
       End If

   Next i%

Loop

   For i% = 0 To Me.Controls.Count - 1

   On Error Resume Next

       If TypeOf Me.Controls(i%) Is Menu Then
       
          If Me.Controls(i%).Enabled = False Then
             
             Me.Controls(i%).Visible = False
          
          End If
       
       End If

   Next i%

End Sub



Private Sub MDIForm_Load()
   Screen.MousePointer = 11
   Call DetectarResolucion(Me, Form1)
   If App.PrevInstance Then
      Screen.MousePointer = 0
      MsgBox "Sistema está cargado en memoria.", vbExclamation
      End
   End If
   
   If Not Valida_Configuracion_Regional() Then
      Screen.MousePointer = 0
      MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical
      End
   
   End If
   

   PROC_ImagenFondo Me
   PROC_Wallpaper
   
   If Not BacInit Then ' Parametros de Inicio.-
      Screen.MousePointer = 0
      End
   End If
   

   If Not BAC_LOGIN(gsSQL_Login, gsSQL_Password) Then
      Screen.MousePointer = 0
      MsgBox "Problemas de Comunicación con el Servidor SQL", vbCritical
      End
   End If
   
'   Call PROC_GENERA_MENU("PCA")
   If Mid(Command, 1, 11) = "GENERA_MENU" Then
      PROC_GENERA_MENU "PCA"
      Call DesconectarSql
      Screen.MousePointer = 0
      End
   End If

    If Not gsc_Parametros.DatosGenerales() Then
        MsgBox "Error al Cargar Parametros", vbCritical, "MENSAJE"
        Unload Me
        Exit Sub
    End If

    Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
    Me.PnlFecha.Caption = Format(gsbac_fecp, gsc_FechaDMA)
    Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, FDecimal)
    Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, FDecimal)
    
    PROC_TITULO_MODULO "PCA", gsBac_Version
   
    BAC_Parametros.WindowState = 2
    Screen.MousePointer = 0

End Sub

Sub PROC_BUSCA_PRIVILEGIOS_USUARIO(forma_menu As Form, Entidad As String)
Dim i%
Dim Datos()

If Trim(gsBAC_User) = "ADMINISTRA" Then
   
   Call MENU_TODOHABILITADO
   Exit Sub

End If


' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA

Envia = Array()
AddParam Envia, "T"
AddParam Envia, Entidad
AddParam Envia, gsBac_Tipo_Usuario

If Not BAC_SQL_EXECUTE("SP_BUSCA_PRIVILEGIOS ", Envia) Then Exit Sub

Do While BAC_SQL_FETCH(Datos())

   For i% = 0 To forma_menu.Controls.Count - 1

   On Error Resume Next

       If TypeOf forma_menu.Controls(i%) Is Menu Then
       
          If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
             
             forma_menu.Controls(i%).Enabled = True
             forma_menu.Controls(i%).Visible = True
          
          End If
       
       End If

   Next i%
Loop

Envia = Array()
AddParam Envia, "U"
AddParam Envia, Entidad
AddParam Envia, Login_Usuario

If Not BAC_SQL_EXECUTE("SP_BUSCA_PRIVILEGIOS ", Envia) Then Exit Sub

Do While BAC_SQL_FETCH(Datos())

   For i% = 0 To forma_menu.Controls.Count - 1

       On Error Resume Next
       
       If TypeOf forma_menu.Controls(i%) Is Menu Then
          
          If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
             
             If Datos(2) = "N" Then
                
                forma_menu.Controls(i%).Enabled = False
                forma_menu.Controls(i%).Visible = False
             
             Else
                
                forma_menu.Controls(i%).Enabled = True
                forma_menu.Controls(i%).Visible = True
             
             End If
          
          End If
       
       End If

   Next i%
Loop

'Call Proc_Busca_privilegios_Especiales

End Sub

Sub PROC_GENERA_MENU(Entidad As String)
   
   Dim Sql         As String
   Dim Indice      As Integer: Indice = 1
   Dim Primera_Vez As String: Primera_Vez = "S"
   Dim i%
   Dim J%
   Dim TituloMenu As String
   Dim Interfaz        As Integer
   
   For i% = 0 To Me.Controls.Count - 1
   
      If TypeOf Me.Controls(i%) Is Menu Then
         
         TituloMenu = Me.Controls(i%).Caption
         J = InStr(1, TituloMenu, "&")
         
         If J > 0 Then
            TituloMenu = Mid(TituloMenu, 1, J - 1) & Mid(TituloMenu, J + 1)
         End If
         
         If TituloMenu <> "-" And TituloMenu <> "?" And TituloMenu <> "Salir" And Me.Controls(i%).Visible Then
            
            Envia = Array()
            AddParam Envia, Primera_Vez
            AddParam Envia, Entidad
            AddParam Envia, Str(Indice)
            AddParam Envia, TituloMenu
            AddParam Envia, Me.Controls(i%).Name
            AddParam Envia, Me.Controls(i%).HelpContextID
            On Error Resume Next
            Interfaz = Me.Controls(i%).Index
           
            AddParam Envia, Interfaz
            Indice = Indice + 1
             
            If Not BAC_SQL_EXECUTE("SP_CARGA_GEN_MENU", Envia) Then
            
               Exit Sub
            
            End If
             
            Primera_Vez = "N"
         
         End If
          
       End If
   
   Next i%
   Call DesconectarSql
   Screen.MousePointer = 0
   End

End Sub



Private Sub MDIForm_QueryUnload(Cancel As Integer, UnloadMode As Integer)
If gsBAC_Login Then
   SALIR = MsgBox("¿Seguro que desea Salir?", vbQuestion + vbYesNo)

   If SALIR <> 6 Then
    
       Cancel = True

   End If
End If
End Sub

Private Sub MDIForm_Resize()

    Dim strError As String
    Call clsWall.CreateFormPicture(Me, 4, strError)
    
End Sub


Private Function PROC_RunningInIde() As Boolean

    Dim sClassName As String
    Dim nStrLen    As Long

    sClassName = String$(260, vbNullChar)
    nStrLen = GetClassName(Me.hwnd, sClassName, Len(sClassName))
    If nStrLen Then sClassName = left$(sClassName, nStrLen)
    
    PROC_RunningInIde = (sClassName = "ThunderMDIForm")
  
End Function




Private Sub PROC_Wallpaper()

    Dim strError As String
    
    With clsWall
        .TransparentColor = vbGreen
        .ExeName = App.Path & "\" & App.ExeName & ".exe"
        .RunningInIDE = PROC_RunningInIde
        .MDIForm = Me
        Call .CreateFormPicture(Me, 4, strError)
    End With
    
End Sub




Private Sub MDIForm_Unload(Cancel As Integer)
        
   Envia = Array()
   AddParam Envia, gsUsuario
   If BAC_SQL_EXECUTE("Sp_Busca_Usuario", Envia) Then
      If BAC_SQL_FETCH(Datos()) Then
         Call LogAuditoria("06", "", "Sistema Parámetro (Usuario ha sido Bloqueado)", "", "")
      End If
   End If
    
End Sub

Private Sub Mnt_Calidad_Juridica_Click()
    FRM_MAN_CALIDAD_JURIDICA.Show
End Sub

Private Sub Mnt_Carga_Contabilidad_Click()
    FRM_MAN_CARGA_CONTABILIDAD.Show
End Sub

Private Sub Mnt_Casillas_Transmision_Click()
   Opt = "opc_778"
   FRM_MAN_CASILLAS.Show
End Sub

Private Sub Mnt_Categoria_Deudor_Click()
    FRM_MAN_CATEGORIA_DEUDOR.Show
End Sub

Private Sub Mnt_Codigos_Transaccion_Swift_Click()
    FRM_MAN_CODIGO_TRAN_SWIFT.Show
End Sub

Private Sub Mnt_Colores_Click()

Opt = "Mnt_Colores"
FRM_MAN_COLORES.Show

End Sub

Private Sub Mnt_Control_Click()
   Opt = "mnt_control"
   Bac_Mnt_Control.Show
End Sub


Private Sub mnt_Ejecutivo_Click()
FRM_MAN_EJECUTIVO.Show
End Sub

Private Sub Mnt_Gestion_Tes_Click()

Opt = "Mnt_Gestion_Tes"
Frm_Man_Gest_Tesor.Show

End Sub

Private Sub Mnt_Interfaz_P36_Click()
    Opt = "Mnt_Interfaz_P36"
    Mantenedor_P36.Show
End Sub

Private Sub Mnt_PComputable_Click()
   Opt = "mnt_pcomputable"
   BacPComputable.Show
End Sub

Private Sub Mnt_Relacion_Banco_Click()
    FRM_MAN_REL_BANCO.Show
End Sub

Private Sub Mnt_Relacion_Curvas_Click()
FRM_MAN_RELACION_CURVA.Show
End Sub

Private Sub Mnt_Relacion_Inst_Fin_Click()
    FRM_MAN_REL_INST_FINANCIERA.Show
End Sub

Private Sub Mnt_Tipo_Amort_Click()
    FRM_MAN_TIPO_AMORTIZACION.Show
End Sub

Private Sub Mnt_Tipo_Base_Click()
    FRM_MAN_TIPO_BASE.Show
End Sub

Private Sub Mnt_Tipo_Basilea_Click()
    FRM_MAN_TIPO_BASILEA.Show
End Sub

Private Sub Mnt_Tipo_Clte_Click()
    FRM_MAN_TIPO_CLIENTE.Show
End Sub

Private Sub Mnt_Tipo_Control_Click()
    FRM_MAN_TIPO_CONTROL.Show
End Sub

Private Sub Mnt_Tipo_Emision_Click()
    FRM_MAN_TIPO_EMISION.Show
End Sub

Private Sub Mnt_Tipo_Fecha_Click()
    FRM_MAN_TIPO_FECHA.Show
End Sub

Private Sub Mnt_Tipo_Intrum_Click()
    FRM_MAN_TIPO_INSTRUMENTO.Show
End Sub

Private Sub Mnt_Tipo_Mercado_Click()
    FRM_MAN_TIPO_MERCADO.Show
End Sub

Private Sub Mnt_Tipo_Moneda_Click()
    FRM_MAN_MONEDA_TIPO.Show
End Sub

Private Sub Mnt_Tipo_Operacion_Spot_Click()
    FRM_MAN_TIPO_OPERACION_SPOT.Show
End Sub
Private Sub Mnt_Var_Mon_Click()
    FRM_MAN_VARIABILIDAD_MON.Show
End Sub

Private Sub mnu_Contabilidad_Campos_Click()
  FRM_CAMPO_CONTABILIDAD.Show
End Sub



Private Sub mnu_Contabilidad_Cod_Oper_Click()
  FRM_CODIGO_OPERACION_CONTABILIDAD.Show
End Sub


Private Sub mnu_plazo_informe_Click()
FRM_PLAZO_INFORME_CARTERA.Show
End Sub

Private Sub mnuNemotecnicoFFMM_Click()
    frm_man_serie_fondos_mutuos.Show
End Sub

Private Sub opc_21_Click()
'- Cliente-'
   Opt = "opc_21"
 
    Screen.MousePointer = 11
    Centra_Form BacMntClie
    BacMntClie.Show vbNormal '------------- nuevo
    
    Screen.MousePointer = 0
   
End Sub

Private Sub opc_22_Click()

'- Operadores -'
   Opt = "opc_22"
     BacControlWindows 100
    
     Screen.MousePointer = 11
     Centra_Form BacMntOperador
     BacMntOperador.Show vbNormal
     Screen.MousePointer = 0
    
End Sub

Private Sub opc_23_Click()

'- Apoderados -'
   Opt = "opc_23"
    BacControlWindows 100
    
    Screen.MousePointer = 11
    Centra_Form BacMntApoderado
    BacMntApoderado.Show vbNormal
    Screen.MousePointer = 0
    
End Sub

Private Sub OPC_24_Click()

   Mant_TipoUsuario.Show

End Sub

Private Sub opc_31_Click()
   Opt = "opc_31"
    Screen.MousePointer = 11
    Centra_Form BacMntMn
    BacMntMn.Show vbNormal
    Screen.MousePointer = 0
     
End Sub

Private Sub opc_32_Click()

'- Monedas Por Producto -'
   Opt = "opc_32"
     BacControlWindows 100

     Screen.MousePointer = 11
     Centra_Form BacMntMP
     BacMntMP.Show vbNormal
     Screen.MousePointer = 0
     
End Sub

Private Sub opc_33_Click()
    On Error Resume Next
    Opt = "opc_33"
    BacMntVm.Show
    On Error GoTo 0
End Sub

Private Sub opc_34_Click()
 
 ' Guion '

End Sub

Private Sub opc_35_Click()

  '- Paridades y Libor -'
  
     'BacMntParLib.Show vbNormal
     
End Sub

Private Sub opc_41_Click()

 '- Formas de Pago -'
      Opt = "opc_41"
      BacControlWindows 100

      Screen.MousePointer = 11
      Centra_Form BacMntFormaPago
      BacMntFormaPago.Show vbNormal
      Screen.MousePointer = 0
    
End Sub

Private Sub opc_42_Click()

'- Forma de Pago por Moneda -'
    Opt = "opc_42"
    BacControlWindows 100
    mon = 1000
    Screen.MousePointer = 11
    Centra_Form BacMntMF
    BacMntMF.Show vbNormal

End Sub

Private Sub opc_551_Click()

    BacControlWindows 100
    Opt = "opc_551"
    Screen.MousePointer = 11
    Centra_Form Perfil_contable
    Perfil_contable.Show vbNormal
    Screen.MousePointer = 0
    
End Sub

Private Sub opc_553_Click()
    Opt = "opc_553"
    BacControlWindows 100
    
    Screen.MousePointer = 11
    Centra_Form bacMntCampos
    bacMntCampos.Show
    Screen.MousePointer = 0


End Sub

Private Sub OPC_552_Click()
   Opt = "opc_552"
   Perfil_Saldos_Contables.Show
End Sub

Private Sub opc_554_Click()
    Opt = "opc_554"
    BacControlWindows 100
    Screen.MousePointer = 11
    Centra_Form Plan_Cuentas
    Plan_Cuentas.Show
    Screen.MousePointer = 0
    
End Sub
Private Sub opc_80_Click()
 
        '- Salir -'
 
            Unload Me
End Sub

Private Sub OPC_556_Click()
    ProdxCampos.Tag = "V" ' mantenedor campo
    ProdxCampos.Caption = "Productos por Campo Logico"
    ProdxCampos.Show
End Sub

Private Sub OPC_557_Click()
   Opt = "opc_557"
   CuentasxProducto.Show
End Sub

Private Sub OPC_558_Click()
   Opt = "opc_558"
   FRM_CONCEPTO_CONTABLE.Show
End Sub

Private Sub OPC_559_Click()
   'Opt = "opc_559"
   'FRM_MANTENCION_RISTRAS.Show

End Sub

Private Sub OPC_560_Click()
   'Opt = "opc_560"
   'FRM_MNT_RISTRA_SUBPRODUCTO.Show

End Sub

Private Sub OPC_561_Click()
   Opt = "opc_561"
   FRM_PERFIL_CONTABLE.Show
End Sub

Private Sub opc_611_Click()
   Opt = "opc_611"
   BacMntEm.Show vbNormal
End Sub

Private Sub opc_612_Click()
   Opt = "opc_612"
   BacControlWindows 100
   Screen.MousePointer = 11
   On Error GoTo SALIR
   BacMntSe.Show vbNormal
   
   Screen.MousePointer = 0
SALIR:
   If err.Number = 364 Then err.Number = 0
   Screen.MousePointer = 0
End Sub

Private Sub opc_613_Click()
BacMntTb.Show
End Sub

Private Sub opc_614_Click()
   Opt = "opc_614"
   Frm_Man_Feriados.Show
End Sub

Private Sub opc_615_Click()
   Opt = "opc_615"
   BacMntFa.Show
End Sub

Private Sub opc_616_Click()
   Opt = "opc_616"
   Frm_Porc_Variacion.Show
End Sub

Private Sub opc_651_Click()
   Opt = "opc_651"
   BacMntOma.Show
End Sub

Private Sub opc_652_Click()
   Opt = "opc_652"
   BacMntComercioConcepto.Show
End Sub

Private Sub opc_653_Click()
   Opt = "opc_653"
   bacMntPlaOper.Show
End Sub

Private Sub opc_680_Click()
   Opt = "opc_680"
   BACMNTCR.Show
End Sub

Private Sub opc_690_Click()
   Opt = "opc_690"
   BacMntVe.Show
End Sub

Private Sub OPC_681_Click()
   Opt = "opc_681"
   BACMNTGRPCR.Show
End Sub

Private Sub opc_700_Click()
   Opt = "opc_700"
   BacGenUF.Show
End Sub

Private Sub opc_710_Click()
   Opt = "opc_710"
   BacMntPe.Show
End Sub


Private Sub opc_730_Click()
   Opt = "opc_730"
   BacMntClientesSinacofi.Show
End Sub

Private Sub opc_740_Click()
   Opt = "opc_740"
   BacGeniv.Show
End Sub

Private Sub opc_750_Click()
   Opt = "opc_750"
   Baccorrespon.Show
End Sub

Private Sub opc_760_Click()
   Opt = "opc_760"
   If Trim(gsBAC_User) = "ADMINISTRA" Then
     
     MsgBox "Clave de Administrador no puede ser cambiada desde el sistema", vbOKOnly + vbExclamation
     Exit Sub
   
   End If
   
   Cambio_Password.Tag = "Z"
   Cambio_Password.Show vbModal
       
End Sub

Private Sub opc_775_Click()
   Opt = "opc_775"
   BacMntArea.Show
End Sub

Private Sub opc_777_Click()
   Opt = "opc_777"
   BacFrmTipoCliente.Show
End Sub

Private Sub opc_778_Click()
   Opt = "opc_778"
   BacMntInterfazes.Show
End Sub

Private Sub opc_780_Click()
    Opt = "opc_780"
    TablaLocalidades.Show
End Sub



Private Sub OPC_802_Click()
   Opt = "opc_802"
   InterfacesTd.Show
End Sub

Private Sub OPC_810_Click()
   On Error GoTo Elpt
   Dim OptLocal As String

    Opt = "opc_820"
    OptLocal = Opt
    
'   Call Class_Reporte.FUNC_NewReport("Reporte_Cliente")
'   Call Class_Reporte.FUNC_SetFormulaFields("{@xUsuario}", "'" & gsBAC_User & "'")
'   Call Class_Reporte.FUNC_SetDatabase(gsSQL_Server$, gsSQL_Database)
'   Call Class_Reporte.FUNC_SetDatabaseSubReport("Repote_Encabezado.rpt", gsSQL_Server$, gsSQL_Database)
'   Call Class_Reporte.FUNC_ViewReport("V")

   Call limpiar_cristal

   With BAC_Parametros.BacParam
      .Destination = crptToWindow
      .ReportFileName = gsRPT_Path & "Clientes.rpt"
       Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
      .WindowTitle = "Reporte de Clientes"
      .Formulas(0) = "xUsuario='" & gsBAC_User & "'"
      .Connect = SwConeccion
      .Action = 1
   End With


   Call LogAuditoria("10", OptLocal, "Informe de Clientes", "", "")
   Exit Sub
'   Call LogAuditoria("08", OptLocal, "Informe de Clientes", "", "")

Elpt:
   
   Debug.Print err.Description
   Screen.MousePointer = vbDefault
   MsgBox "Problemas Al Emitir Informe", vbExclamation
   Call LogAuditoria("10", OptLocal, "Informe de Clientes- Error al emitir informe", "", "")
End Sub

Private Sub OPC_820_Click()
   On Error GoTo Elpt
    Dim OptLocal As String

    Opt = "opc_820"
    OptLocal = Opt
    
'   Call Class_Reporte.FUNC_NewReport("Informe_Emisores")
'   Call Class_Reporte.FUNC_SetFormulaFields("{@xUsuario}", "'" & gsBAC_User & "'")
'   Call Class_Reporte.FUNC_SetDatabase(gsSQL_Server$, gsSQL_Database)
'   Call Class_Reporte.FUNC_SetDatabaseSubReport("Repote_Encabezado.rpt", gsSQL_Server$, gsSQL_Database)
'   Call Class_Reporte.FUNC_ViewReport("V")
    
   Call limpiar_cristal
    
   With BAC_Parametros.BacParam
      .Destination = crptToWindow
      .ReportFileName = gsRPT_Path & "Emisores.rpt"
      Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
      .WindowTitle = "Reporte de Emisores"
      .Formulas(0) = "xUsuario='" & gsBAC_User & "'"
      .Connect = SwConeccion
      .Action = 1
   End With



   Call LogAuditoria("10", OptLocal, "Informe de Emisores", "", "")
   Exit Sub
'    Call LogAuditoria("08", OptLocal, "Informe de Emisores", "", "")
Elpt:
   Screen.MousePointer = vbDefault
   MsgBox "Problemas Al Emitir Informe", vbExclamation
   Call LogAuditoria("10", OptLocal, "Informe de Emisores- Error al enviar informe", "", "")
   
End Sub

Private Sub OPC_830_Click()
   On Error GoTo Elpt
    Dim OptLocal As String

    Opt = "opc_830"
    OptLocal = Opt

'   Call Class_Reporte.FUNC_NewReport("Reporte_Cartera")
'   Call Class_Reporte.FUNC_SetFormulaFields("{@xUsuario}", "'" & gsBAC_User & "'")
'   Call Class_Reporte.FUNC_SetDatabase(gsSQL_Server$, gsSQL_Database)
'   Call Class_Reporte.FUNC_SetDatabaseSubReport("Repote_Encabezado.rpt", gsSQL_Server$, gsSQL_Database)
'   Call Class_Reporte.FUNC_ViewReport("V")
 
   Call limpiar_cristal
 
   With BAC_Parametros.BacParam
      .Destination = crptToWindow
      .ReportFileName = gsRPT_Path & "carteras.rpt"
      Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
      .WindowTitle = "Reporte de Entidades"
      .Formulas(0) = "xUsuario='" & gsBAC_User & "'"
      .Connect = SwConeccion
      .Action = 1
   End With


   Call LogAuditoria("10", OptLocal, "Informe de Entidades", "", "")
   Exit Sub

Elpt:
   Screen.MousePointer = vbDefault
   MsgBox "Problemas Al Emitir Informe", vbExclamation
   Call LogAuditoria("10", OptLocal, "Informe de Entidades- Error al emitir informe", "", "")
End Sub


Private Sub OPC_850_Click()
   Dim OptLocal As String
   Opt = "opc_850"
   Informe_Valor_Moneda.Show

End Sub

Private Sub OPC_870_Click()
   On Error GoTo Elpt
   Dim OptLocal As String
   Opt = "opc_870"
   OptLocal = Opt

   Dim TitRpt As String
   Call limpiar_cristal

   Screen.MousePointer = vbHourglass
   TitRpt = "INFORME DE FAMILIAS DE INSTRUMENTOS"
   BAC_Parametros.BacParam.ReportFileName = gsRPT_Path & "MANTFAM.RPT"
   Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
   BAC_Parametros.BacParam.WindowTitle = "INFORME DE FAMILIAS DE INSTRUMENTOS"
   BAC_Parametros.BacParam.Destination = 0
   BAC_Parametros.BacParam.Formulas(0) = "tit='" & TitRpt & "'"
   BAC_Parametros.BacParam.Formulas(1) = "xUsuario='" & gsBAC_User & "'"
   BAC_Parametros.BacParam.Destination = crptToWindow
   BAC_Parametros.BacParam.Action = 1
   Screen.MousePointer = vbDefault
   
   
   Call LogAuditoria("10", OptLocal, "Informe de Familias de Instrumentos", "", "")
   Exit Sub
'   Call LogAuditoria("08", OptLocal, "Informe de Familias de Instrumentos", "", "")
Elpt:
   Screen.MousePointer = vbDefault
   MsgBox "Problemas Al Emitir Informe", vbExclamation
   Call LogAuditoria("10", OptLocal, "Informe de Familias de Instrumentos- Error al emitir informe", "", "")
End Sub

Private Sub OPC_871_Click()
   On Error GoTo Elpt
   Dim OptLocal As String
   Opt = "opc_871"
   OptLocal = Opt

   Dim TitRpt As String
   Call limpiar_cristal

   Screen.MousePointer = vbHourglass
   TitRpt = "INFORME DE PRODUCTOS V/S CODIGOS DE COMERCIO"
   BAC_Parametros.BacParam.ReportFileName = gsRPT_Path & "RPT_cod_plan_aut.rpt"
   Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
   BAC_Parametros.BacParam.WindowTitle = "INFORME DE PRODUCTOS V/S CODIGOS DE COMERCIO"
   
   BAC_Parametros.BacParam.Destination = 2
   BAC_Parametros.BacParam.StoredProcParam(0) = gsBAC_User
   BAC_Parametros.BacParam.StoredProcParam(1) = gsBAC_User
   BAC_Parametros.BacParam.Destination = crptToWindow
   BAC_Parametros.BacParam.Action = 1
   Screen.MousePointer = vbDefault
   
   
   Call LogAuditoria("10", OptLocal, "Informe de Productos v/s Códigos de Comercio", "", "")
   Exit Sub
'   Call LogAuditoria("08", OptLocal, "Informe de Familias de Instrumentos", "", "")
Elpt:
   Screen.MousePointer = vbDefault
   MsgBox "Problemas Al Emitir Informe", vbExclamation
   Call LogAuditoria("10", OptLocal, "Informe de Familias de Instrumentos- Error al emitir informe", "", "")


End Sub

Private Sub opc_900_Click()
    Unload Me
End Sub





Private Sub OPC_901_Click()
   Opt = "opc_901"
    BacMntTasasMonedas.Show
End Sub

Private Sub OPC_MONEDA_MERCADO_Click()
    On Error Resume Next
    Opt = "opc_33"
    BacmnMercado.Show
    On Error GoTo 0
End Sub




Private Sub ProdporCam_Click()
    ProdxCampos.Tag = "F" ' mantenedor campo
    ProdxCampos.Caption = "Productos por Campo"
    ProdxCampos.Show
End Sub

'
Private Sub Timer1_Timer()
    If Not gsc_Parametros.DatosGenerales() Then
        MsgBox "Error al Cargar Parametros", vbCritical, "MENSAJE"
        Unload Me
        Exit Sub
    End If

    Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
    Me.PnlFecha.Caption = Format(gsbac_fecp, gsc_FechaDMA)
    Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, FDecimal)
    Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, FDecimal)
    Me.PnlUsuario.Caption = gsBAC_User

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    
    If Button.Index = 1 Then
        opc_21_Click
    ElseIf Button.Index = 3 Then
        opc_614_Click
    ElseIf Button.Index = 5 Then
        opc_611_Click
    ElseIf Button.Index = 7 Then
        opc_33_Click
    ElseIf Button.Index = 9 Then
        opc_551_Click
    ElseIf Button.Index = 11 Then
        opc_700_Click
    End If

End Sub
