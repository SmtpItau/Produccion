VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacFechas 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   2955
   ClientLeft      =   4650
   ClientTop       =   4065
   ClientWidth     =   5265
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacfecha.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2955
   ScaleWidth      =   5265
   Begin Threed.SSFrame SSFrame1 
      Height          =   2385
      Left            =   0
      TabIndex        =   0
      Top             =   525
      Width           =   5220
      _Version        =   65536
      _ExtentX        =   9208
      _ExtentY        =   4207
      _StockProps     =   14
      Caption         =   "Rango de Fechas Reporte"
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
      Font3D          =   3
      Begin VB.Frame Frame3 
         Caption         =   "Entidad"
         ForeColor       =   &H00800000&
         Height          =   720
         Left            =   105
         TabIndex        =   5
         Top             =   315
         Width           =   5040
         Begin VB.ComboBox Combo1 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   225
            Width           =   4860
         End
      End
      Begin Threed.SSFrame Frame_vcto 
         Height          =   1140
         Left            =   75
         TabIndex        =   6
         Top             =   975
         Visible         =   0   'False
         Width           =   5055
         _Version        =   65536
         _ExtentX        =   8916
         _ExtentY        =   2011
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSOption Opc_Cup 
            Height          =   375
            Left            =   225
            TabIndex        =   9
            Top             =   405
            Width           =   1155
            _Version        =   65536
            _ExtentX        =   2037
            _ExtentY        =   661
            _StockProps     =   78
            Caption         =   "Cupones"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.24
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Value           =   -1  'True
            Font3D          =   3
         End
         Begin Threed.SSOption Opc_Int 
            Height          =   375
            Left            =   1650
            TabIndex        =   8
            Top             =   435
            Width           =   1575
            _Version        =   65536
            _ExtentX        =   2778
            _ExtentY        =   661
            _StockProps     =   78
            Caption         =   "&Interbancarios"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.24
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
         End
         Begin Threed.SSOption Opc_Cap 
            Height          =   375
            Left            =   3555
            TabIndex        =   7
            Top             =   420
            Width           =   1320
            _Version        =   65536
            _ExtentX        =   2328
            _ExtentY        =   661
            _StockProps     =   78
            Caption         =   "&Pactos"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.24
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
         End
      End
      Begin BACControles.TXTFecha DteDesde 
         Height          =   285
         Left            =   930
         TabIndex        =   10
         Top             =   1305
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   503
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
         Text            =   "08/11/2000"
      End
      Begin BACControles.TXTFecha Dtehasta 
         Height          =   300
         Left            =   3495
         TabIndex        =   11
         Top             =   1305
         Width           =   1455
         _ExtentX        =   2566
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
         Text            =   "08/11/2000"
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Hasta"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   240
         Left            =   2805
         TabIndex        =   4
         Top             =   1320
         Width           =   705
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Desde"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   240
         Left            =   180
         TabIndex        =   3
         Top             =   1320
         Width           =   765
      End
      Begin VB.Label LblNomList 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   240
         Left            =   120
         TabIndex        =   2
         Top             =   360
         Width           =   60
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3915
      Top             =   0
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
            Picture         =   "Bacfecha.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacfecha.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   15
      TabIndex        =   12
      Top             =   0
      Width           =   5250
      _ExtentX        =   9260
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
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGenerar"
            Description     =   "Salir"
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Generar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacFechas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Sub Generar()
   Dim nTipo As Integer
    'aqui estoy
     nTipo = IIf(Opc_Cup.Value = True, 1, IIf(Opc_Int.Value = True, 2, IIf(Opc_Cap.Value = True, 3, 0)))


   If (Me.Tag = "PAPELHIS" Or Me.Tag = "CONTHIS") Then
      If Not Format$(DteDesde.Text) < gsBac_Fecp Then
         MsgBox "Fecha debe ser menor que fecha de proceso", vbExclamation, gsBac_Version
         Exit Sub
      End If
      BacPapeleta.proFecha = Format$(DteDesde.Text, "yyyymmdd")
      BacPapeleta.proTipo = "HIS"
      BacPapeleta.Show
 

   '(INI) LD1-COR-035-Configuración BAC Corpbanca – Tarea: Incorporación de procesos y reportes de limites de permanecia
   ElseIf Me.Tag = "VIRF" Then
       Call LlamaListados(BacTrader.ActiveForm.DteDesde.Text, BacTrader.ActiveForm.Dtehasta.Text, BacTrader.ActiveForm.Tag, Val(Trim$(Right$(Combo1, 10))), nTipo)

   ElseIf Me.Tag = "CIRF" Then
       Call LlamaListados(BacTrader.ActiveForm.DteDesde.Text, BacTrader.ActiveForm.Dtehasta.Text, BacTrader.ActiveForm.Tag, Val(Trim$(Right$(Combo1, 10))), nTipo)

   ElseIf Me.Tag = "CHOLD" Then
       Call LlamaListados(BacTrader.ActiveForm.DteDesde.Text, BacTrader.ActiveForm.Dtehasta.Text, BacTrader.ActiveForm.Tag, Val(Trim$(Right$(Combo1, 10))), nTipo)

   
   
   '(FIN) LD1-COR-035-Configuración BAC Corpbanca – Tarea: Incorporación de procesos y reportes de limites de permanecia
   Else     
      Call LlamaListados(BacTrader.ActiveForm.DteDesde.Text, BacTrader.ActiveForm.Dtehasta.Text, BacTrader.ActiveForm.Tag, Val(Trim$(Right$(Combo1, 10))), nTipo)

   '  End If

   End If
   Unload Me
    
End Sub

Private Sub cmdSalir_Click()
    Unload Me
End Sub


Private Sub Form_Activate()

    Me.DteDesde.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
    Me.Dtehasta.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
    Me.Frame_vcto.Visible = False

    Select Case BacTrader.ActiveForm.Tag

        Case "VCTOIB"
            Me.Caption = "Listado de Vencimiento de Interbancarios"
            Me.Label1.Visible = False
            Me.DteDesde.Visible = False

            Me.Label2.Left = Me.Label1.Left
            Me.Dtehasta.Left = Me.DteDesde.Left



        Case "VCTOPACT"
            Me.Caption = "Listado de Vencimiento de Pactos"

        Case "VCTOPAP"
            Me.Caption = "Listado de Vencimiento de Instrumentos"
            Me.Label1.Visible = False
            Me.DteDesde.Visible = False

            Me.Label2.Left = Me.Label1.Left
            Me.Dtehasta.Left = Me.DteDesde.Left
            
        Case "VALMON"
            Me.LblNomList.Caption = "Listado de Vencimiento de Pactos"
            Me.Frame3.Visible = False
            Me.Label1.Top = 700
            Me.Label2.Top = 700
            Me.DteDesde.Top = 700
            Me.Dtehasta.Top = 700
    
            Me.SSFrame1.Height = (Me.SSFrame1.Top + 100) + (Me.Label2.Height + 10) + (Me.Label2.Height + 10) + 200
            Me.Height = (Me.SSFrame1.Top + 100) + (Me.Label2.Height + 10) + (Me.Label2.Height + 10) + 1150
            Me.LblNomList.Caption = "Listado de Valores de Moneda"
            

        Case "PAPELHIS"
'            Me.Caption = "Papeletas Historicas"
'            Me.Dtehasta.Visible = False
'            Me.Frame_vcto.Visible = False
'            Me.Label1.Visible = False
'            Me.Label2.Visible = False
'            Me.DteDesde.Left = Me.DteDesde.Left + 500
'            Me.SSFrame1.Height = (Me.SSFrame1.Top + 100) + (Me.Label4.Height + 100) + (Me.Label4.Height + 100) + 250
'            Me.Height = (Me.SSFrame1.Top + 100) + (Me.Label4.Height + 100) + (Me.Label4.Height + 100) + 1150
'            'Me.CmdAceptar.Caption = "&Procesar"
            
            
              
        Case "CONTRHIS"
        
            Me.LblNomList.Caption = "Contratos Historicos"
        Case "VCTODIA"
        
            Me.SSFrame1.Caption = ""
            Me.LblNomList.Caption = "Listado de Vencimientos del día "
            Me.DteDesde.Visible = False
            Me.Dtehasta.Visible = False
            Me.Frame_vcto.Visible = True
            Me.Label1.Visible = False
            Me.Label2.Visible = False
    End Select

   


End Sub

Private Sub Form_Load()
Dim cSql As String
Dim Datos()

    Me.Top = 0
    Me.Left = 0
    
    Combo1.Clear
    cSql = "EXECUTE SP_LEER_ENTIDADES"
    
    If miSQL.SQL_Execute(cSql) = 0 Then
        Combo1.AddItem "TODAS LAS ENTIDADES                                                 "
        
        Do While Bac_SQL_Fetch(Datos())
            Combo1.AddItem Datos(1) & Space(50 + (30 - Len(Datos(1)))) & Str(Datos(2))
        Loop
        
    Else
    
        MsgBox "Proceso " & cSql & "no existe", vbOKOnly + vbCritical, "Entidades"
        Unload Me
        
    End If
    
    Combo1.ListIndex = 0

End Sub





Private Sub Label4_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
   Case Is = "cmdGenerar"
      Call Generar
   Case Is = "cmdSalir"
      Unload Me
End Select
End Sub
