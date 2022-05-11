VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form frmLogAuditoria 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Log Auditoria"
   ClientHeight    =   6945
   ClientLeft      =   420
   ClientTop       =   2760
   ClientWidth     =   11100
   Icon            =   "frmLogAuditoria.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6945
   ScaleWidth      =   11100
   Begin VB.Frame Frame1 
      Caption         =   "Opciones de Consulta"
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
      Height          =   3255
      Left            =   120
      TabIndex        =   2
      Top             =   600
      Width           =   10935
      Begin VB.Frame Frame5 
         Caption         =   "Entre Horas"
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
         Height          =   1215
         Left            =   7080
         TabIndex        =   27
         Top             =   1920
         Visible         =   0   'False
         Width           =   3735
         Begin MSMask.MaskEdBox txtHoraTermino 
            Height          =   300
            Left            =   1680
            TabIndex        =   31
            Top             =   720
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   529
            _Version        =   393216
            ForeColor       =   8388608
            MaxLength       =   8
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Format          =   "hh:mm:ss"
            PromptChar      =   "_"
         End
         Begin MSMask.MaskEdBox txtHoraInicio 
            Height          =   300
            Left            =   1680
            TabIndex        =   30
            Top             =   360
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   529
            _Version        =   393216
            ForeColor       =   8388608
            MaxLength       =   8
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Format          =   "hh:mm:ss"
            PromptChar      =   "_"
         End
         Begin VB.Label Label10 
            Caption         =   "Termino"
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
            Height          =   255
            Left            =   720
            TabIndex        =   29
            Top             =   720
            Width           =   975
         End
         Begin VB.Label Label9 
            Caption         =   "Inicio"
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
            Height          =   255
            Left            =   720
            TabIndex        =   28
            Top             =   360
            Width           =   855
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Entre Fechas"
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
         Height          =   1575
         Left            =   7080
         TabIndex        =   12
         Top             =   240
         Width           =   3735
         Begin VB.OptionButton FechaP 
            Caption         =   "Proceso"
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
            Left            =   120
            TabIndex        =   24
            Top             =   360
            Width           =   1215
         End
         Begin BACControles.TXTFecha cmbFechaTermino 
            Height          =   300
            Left            =   1680
            TabIndex        =   16
            Top             =   1080
            Width           =   1575
            _ExtentX        =   2778
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
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/06/2001"
         End
         Begin BACControles.TXTFecha cmbFechaInicio 
            Height          =   300
            Left            =   1680
            TabIndex        =   14
            Top             =   720
            Width           =   1575
            _ExtentX        =   2778
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
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/06/2001"
         End
         Begin VB.Label Label6 
            Caption         =   "Termino"
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
            Height          =   255
            Left            =   720
            TabIndex        =   15
            Top             =   1080
            Width           =   855
         End
         Begin VB.Label Label5 
            Caption         =   "Inicio"
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
            Height          =   255
            Left            =   720
            TabIndex        =   13
            Top             =   720
            Width           =   735
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Ordenado Por"
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
         Height          =   855
         Left            =   120
         TabIndex        =   11
         Top             =   2280
         Width           =   6855
         Begin VB.OptionButton optModulo 
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
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   1320
            TabIndex        =   26
            Top             =   360
            Width           =   975
         End
         Begin VB.OptionButton optUsuario 
            Caption         =   "Usuario"
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
            Height          =   255
            Left            =   120
            TabIndex        =   25
            Top             =   360
            Width           =   1215
         End
         Begin VB.OptionButton optFechaS 
            Caption         =   "Fecha Sistema"
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
            Left            =   2640
            TabIndex        =   22
            Top             =   360
            Width           =   1575
         End
         Begin VB.OptionButton optFechaP 
            Caption         =   "Fecha Proceso"
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
            Left            =   4560
            TabIndex        =   21
            Top             =   360
            Width           =   1695
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Filtros"
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
         Height          =   1935
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   6855
         Begin VB.ComboBox cmbEntidad 
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   960
            Locked          =   -1  'True
            Style           =   1  'Simple Combo
            TabIndex        =   23
            Top             =   360
            Width           =   2295
         End
         Begin VB.ComboBox cmbMenu 
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
            ItemData        =   "frmLogAuditoria.frx":030A
            Left            =   4200
            List            =   "frmLogAuditoria.frx":030C
            Style           =   2  'Dropdown List
            TabIndex        =   17
            Top             =   1320
            Width           =   2535
         End
         Begin VB.ComboBox cmbEvento 
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
            ItemData        =   "frmLogAuditoria.frx":030E
            Left            =   4200
            List            =   "frmLogAuditoria.frx":0310
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   840
            Width           =   2535
         End
         Begin VB.ComboBox cmbModulo 
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
            ItemData        =   "frmLogAuditoria.frx":0312
            Left            =   960
            List            =   "frmLogAuditoria.frx":0314
            Style           =   2  'Dropdown List
            TabIndex        =   9
            Top             =   1320
            Width           =   2295
         End
         Begin VB.ComboBox cmbTerminal 
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
            ItemData        =   "frmLogAuditoria.frx":0316
            Left            =   4200
            List            =   "frmLogAuditoria.frx":0318
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   360
            Width           =   2535
         End
         Begin VB.ComboBox cmbUsuario 
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
            ItemData        =   "frmLogAuditoria.frx":031A
            Left            =   960
            List            =   "frmLogAuditoria.frx":031C
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   840
            Width           =   2295
         End
         Begin VB.Label Label8 
            Caption         =   "Entidad"
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
            Height          =   255
            Left            =   120
            TabIndex        =   20
            Top             =   360
            Width           =   855
         End
         Begin VB.Label Label4 
            Caption         =   "Terminal"
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
            Height          =   255
            Left            =   3360
            TabIndex        =   19
            Top             =   360
            Width           =   975
         End
         Begin VB.Label Label7 
            Caption         =   "Usuario"
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
            Height          =   255
            Left            =   120
            TabIndex        =   18
            Top             =   840
            Width           =   855
         End
         Begin VB.Label Label3 
            Caption         =   "Evento"
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
            Height          =   255
            Left            =   3360
            TabIndex        =   6
            Top             =   840
            Width           =   855
         End
         Begin VB.Label Label2 
            Caption         =   "Menu"
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
            Height          =   255
            Left            =   3360
            TabIndex        =   5
            Top             =   1320
            Width           =   855
         End
         Begin VB.Label Label1 
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
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   120
            TabIndex        =   4
            Top             =   1320
            Width           =   855
         End
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   2895
      Left            =   120
      TabIndex        =   1
      Top             =   3960
      Width           =   10935
      _ExtentX        =   19288
      _ExtentY        =   5106
      _Version        =   393216
      Cols            =   13
      FixedCols       =   0
      RowHeightMin    =   280
      BackColor       =   -2147483644
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      GridLines       =   2
      SelectionMode   =   1
      AllowUserResizing=   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3120
      Top             =   0
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
            Picture         =   "frmLogAuditoria.frx":031E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLogAuditoria.frx":0638
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLogAuditoria.frx":0952
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLogAuditoria.frx":0C6C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11100
      _ExtentX        =   19579
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
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir Informe"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "frmLogAuditoria"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Sis, log_Consulta, EntreFecha, EntrefechaRPT, OrdenadoRPT As String
Dim Ordenado, FechaInim, FechaTer As String
Dim SQL_Final As String
Dim Valor(6) As String
Dim ValorRPT(6) As String

Private Sub cmbModulo_Click()
    Sis = Right(cmbModulo.Text, 3)
    
    If Not Bac_Sql_Execute("sp_filtro_log_auditoria MENU," & Sis) Then
        Exit Sub
    Else
        cmbMenu.Clear
        Do While Bac_SQL_Fetch(Datos())
                cmbMenu.AddItem Datos(2) & Space(30) & Datos(1)
        Loop
        
    End If
    
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    
    optFechaS.Value = True
    txtHoraInicio.Text = Time
    txtHoraTermino.Text = Time
    cmbFechaInicio.Text = Format(Date, "dd/mm/yyyy")
    cmbFechaTermino.Text = Format(Date, "dd/mm/yyyy")
    Toolbar1.Buttons(3).Enabled = False
    Define_Cabecera
    LLena_Combos
    
End Sub

Private Sub Grd_DblClick()

    With Grd
        
        logFila = .Row
        logColumna = .Col
        If .TextMatrix(logFila, 0) = Empty Then
            Exit Sub
        Else
            frmLogUsuario.Show 1
        End If
              
    End With
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        
        Case 1
            Limpiar_Controles
            Limpia_Grilla
            LLena_Combos
            
            Toolbar1.Buttons(3).Enabled = False
            Ordenado = ""
            
        Case 2
            Ejecuta_Consulta
            
            If Grd.TextMatrix(1, 1) <> Empty Then Toolbar1.Buttons(3).Enabled = True
                      
            Toolbar1.Buttons(1).Enabled = True
                    
        Case 3
            Imprimir
             
        Case 4
          Unload Me
    
    End Select

End Sub
Sub Define_Cabecera()
    
    With Grd
        
        .RowHeight(0) = 300
        .BackColorFixed = &H808000
        .ForeColorFixed = &HFFFFFF
        
        .ColWidth(0) = 0        'Entidad
        .ColWidth(1) = 1400     'Fecha Proceso
        .ColWidth(2) = 1400     'Fecha Sistema
        .ColWidth(3) = 1300     'Hora Porceso
        .ColWidth(4) = 2000     'Terminal
        .ColWidth(5) = 1600     'Usuario
        .ColWidth(6) = 1600     'ID Sistema
        .ColWidth(7) = 2200     'Menu
        .ColWidth(8) = 2200     'Evento
        .ColWidth(9) = 1500     'Detalle
        .ColWidth(10) = 1200    'Tabla Afectada
        .ColWidth(11) = 1500    'Valor Anterior
        .ColWidth(12) = 1500    'Valor Nuevo
          
        .TextMatrix(0, 0) = "Entidad"
        .TextMatrix(0, 1) = "Fecha Proceso"
        .TextMatrix(0, 2) = "Fecha Sistema"
        .TextMatrix(0, 3) = "Hora Proceso"
        .TextMatrix(0, 4) = "Terminal"
        .TextMatrix(0, 5) = "Usuario"
        .TextMatrix(0, 6) = "ID Sistema"
        .TextMatrix(0, 7) = "Menu"
        .TextMatrix(0, 8) = "Evento"
        .TextMatrix(0, 9) = "Detalle"
        .TextMatrix(0, 10) = "Tabla Afectada"
        .TextMatrix(0, 11) = "Valor Nuevo "
        .TextMatrix(0, 12) = "Valor Anterior"
        
    End With

End Sub

Sub LLena_Combos()

    If Not Bac_Sql_Execute("sp_filtro_log_auditoria USUARIO,''") Then
        MsgBox "Problemas al Cargar Opciones para la Consulta.", vbInformation, TITSISTEMA
    Else
    
        Do While Bac_SQL_Fetch(Datos())
                cmbUsuario.AddItem Datos(1)
        Loop
        
    End If
    
    If Not Bac_Sql_Execute("sp_filtro_log_auditoria TERMINAL,''") Then
       MsgBox "Problemas al Cargar Opciones para la Consulta.", vbInformation, TITSISTEMA
        
    Else
    
        Do While Bac_SQL_Fetch(Datos())
                cmbTerminal.AddItem Datos(1)
        Loop
        
    End If
    
    If Not Bac_Sql_Execute("sp_filtro_log_auditoria MODULO,''") Then
        MsgBox "Problemas al Cargar Opciones para la Consulta.", vbInformation, TITSISTEMA
    Else
        Do While Bac_SQL_Fetch(Datos())
                cmbModulo.AddItem Datos(2) & Space(30) & Datos(1)
        Loop
    End If
    
    If Not Bac_Sql_Execute("sp_filtro_log_auditoria EVENTO,''") Then
        MsgBox "Problemas al Cargar Opciones para la Consulta.", vbInformation, TITSISTEMA
    Else
        Do While Bac_SQL_Fetch(Datos())
                cmbEvento.AddItem Datos(2) & Space(30) & Datos(1)
        Loop
    End If
    
    If Not Bac_Sql_Execute("sp_filtro_log_auditoria ENTIDAD,''") Then
        MsgBox "Problemas al Cargar Opciones para la Consulta.", vbInformation, TITSISTEMA
    Else
        Do While Bac_SQL_Fetch(Datos())
                cmbEntidad.Text = Datos(2) & Space(30) & Datos(1)
        Loop
    End If
    
End Sub

Sub Limpiar_Controles()
    
    cmbUsuario.Refresh
    txtHoraInicio.Text = Time
    txtHoraTermino.Text = Time
    
    cmbEntidad.Clear
    cmbUsuario.Clear
    cmbModulo.Clear
    cmbTerminal.Clear
    cmbEvento.Clear
    cmbMenu.Clear
    
    optFechaS.Value = True
    cmbFechaInicio.Text = Date
    cmbFechaTermino.Text = Date
    FechaP.Value = True
        
End Sub

Sub Ejecuta_Consulta()
    Dim sqlUsuario, sqlTerminal, sqlModulo, sqlEntidad, sqlEvento, sqlMenu As String
    
    log_Consulta = ""
    Limpia_Grilla
    
    If cmbEntidad.Text <> Empty Then
        Valor(1) = "'" & Trim(Right(cmbEntidad.Text, 3)) & "'"
        ValorRPT(1) = Trim(Right(cmbEntidad.Text, 3))
         
    Else
        Valor(1) = "''"
        ValorRPT(1) = " "
        
    End If
    
    If cmbUsuario.Text <> Empty Then
        Valor(2) = "'" & cmbUsuario.Text & "'"
        ValorRPT(2) = cmbUsuario.Text
         
    Else
        Valor(2) = "''"
        ValorRPT(2) = " "
        
    End If
    
    If cmbModulo.Text <> Empty Then
        Valor(3) = "'" & Trim(Right(cmbModulo.Text, 3)) & "'"
        ValorRPT(3) = Trim(Right(cmbModulo.Text, 3))
        
    Else
        Valor(3) = "''"
        ValorRPT(3) = " "
        
    End If
    
    If cmbTerminal.Text <> Empty Then
        Valor(4) = "'" & cmbTerminal.Text & "'"
        ValorRPT(4) = cmbTerminal.Text
        
    Else
        Valor(4) = "''"
        ValorRPT(4) = " "
        
    End If
    
    If cmbEvento.Text <> Empty Then
        Valor(5) = "'" & Trim(Right(cmbEvento.Text, 3)) & "'"
        ValorRPT(5) = Trim(Right(cmbEvento.Text, 3))
         
    Else
        Valor(5) = "''"
        ValorRPT(5) = " "
        
    End If
    
    If cmbMenu.Text <> Empty Then
        Valor(6) = "'" & Trim(Right(cmbMenu.Text, 20)) & "'"
        ValorRPT(6) = Trim(Right(cmbMenu.Text, 20))
         
    Else
        Valor(6) = "''"
        ValorRPT(6) = " "
    End If
            
    OpcionOrdena
    
    If FechaP.Value Then
        EntreFecha = "'" & Format(cmbFechaInicio.Text, "yyyymmdd") & "p" & Format(cmbFechaTermino.Text, "yyyymmdd") & "'"
        EntrefechaRPT = Format(cmbFechaInicio.Text, "yyyymmdd") & "p" & Format(cmbFechaTermino.Text, "yyyymmdd")
        
    Else
        EntreFecha = "'" & Format(cmbFechaInicio.Text, "yyyymmdd") & "a" & Format(cmbFechaTermino.Text, "yyyymmdd") & "'"
        EntrefechaRPT = Format(cmbFechaInicio.Text, "yyyymmdd") & "a" & Format(cmbFechaTermino.Text, "yyyymmdd")
         
    End If
    
     SQL_Final = "sp_consulta_log_auditoria " & Valor(1) & "," _
                                                 & Valor(2) & "," _
                                                 & Valor(3) & "," _
                                                 & Valor(4) & "," _
                                                 & Valor(5) & "," _
                                                 & Valor(6) & "," _
                                                 & EntreFecha & "," _
                                                 & Ordenado
       
    
    If Not Bac_Sql_Execute(SQL_Final) Then
        MsgBox "No se ha Podido ejecutar la Consulta.", vbInformation, TITSISTEMA
        
    Else
        
        Do While Bac_SQL_Fetch(Datos())
        
            With Grd
            .Row = .Rows - 1
            
            .Col = 0: .Text = Datos(1)
            .Col = 1: .Text = Datos(2)
            .Col = 2: .Text = Datos(3)
            .Col = 3: .Text = Datos(4)
            .Col = 4: .Text = Datos(5)
            .Col = 5: .Text = Datos(6)
            .Col = 6: .Text = Datos(7)
            .Col = 7: .Text = Datos(15) '8
            .Col = 8: .Text = Datos(16) '9
            .Col = 9: .Text = Datos(10)
            .Col = 10: .Text = Datos(11)
            .Col = 11: .Text = Datos(13)
            .Col = 12: .Text = Datos(12)
        
            .Rows = .Rows + 1
            End With
            
        Loop
    
    End If
                       
End Sub

Sub Limpia_Grilla()
    Dim f As Double
       f = 1
       Grd.Clear
       Define_Cabecera
    
    With Grd
       .Rows = 3
       Do
          .RemoveItem (f)
       Loop Until f >= .Row
       
    End With
    
End Sub

Sub OpcionOrdena() 'Ordenado por
    Ordenado = ""
    If optFechaS.Value Then
        Ordenado = "'" & "fechasistema" & "'"
        OrdenadoRPT = "fechasistema"

    ElseIf optFechaP.Value Then
        Ordenado = "'" & "fechaproceso" & "'"
        OrdenadoRPT = "fechaproceso"

    ElseIf optUsuario.Value Then
        Ordenado = "'" & "usuario" & "'"
        OrdenadoRPT = "usuario"

    ElseIf optModulo.Value Then
        Ordenado = "'" & "id_sistema" & "'"
        OrdenadoRPT = "id_sistema"

    End If

End Sub
Sub Imprimir()
    Dim SQL_Informe As String
    On Error GoTo Errores
    
    LimpiarRPT
        
    Screen.MousePointer = vbHourglass
    BACSwapParametros.BACParam.Destination = crptToWindow
    BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacLogdeAuditoria.rpt"
    BACSwapParametros.BACParam.WindowTitle = "LISTADO DE LOG DE AUDITORIA"
    BACSwapParametros.BACParam.StoredProcParam(0) = ValorRPT(1)
    BACSwapParametros.BACParam.StoredProcParam(1) = ValorRPT(2)
    BACSwapParametros.BACParam.StoredProcParam(2) = ValorRPT(3)
    BACSwapParametros.BACParam.StoredProcParam(3) = ValorRPT(4)
    BACSwapParametros.BACParam.StoredProcParam(4) = ValorRPT(5)
    BACSwapParametros.BACParam.StoredProcParam(5) = ValorRPT(6)
    BACSwapParametros.BACParam.StoredProcParam(6) = EntrefechaRPT
    BACSwapParametros.BACParam.StoredProcParam(7) = OrdenadoRPT
    BACSwapParametros.BACParam.Connect = SwConeccion
    BACSwapParametros.BACParam.WindowState = crptMaximized
    BACSwapParametros.BACParam.Action = 1
    Screen.MousePointer = vbDefault

Errores:
     If Err.Description = Empty Then
        Screen.MousePointer = vbDefault
     Else
        MsgBox Err.Description: Exit Sub
     End If

End Sub
Sub LimpiarRPT()

    Dim I As Integer
        For I = 0 To 20
            BACSwapParametros.BACParam.StoredProcParam(I) = ""
            
        Next I

End Sub
