VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacFechas 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   2100
   ClientLeft      =   2130
   ClientTop       =   2970
   ClientWidth     =   5475
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacfecha.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2100
   ScaleWidth      =   5475
   Begin Threed.SSPanel SSPanel1 
      Height          =   1485
      Left            =   45
      TabIndex        =   1
      Top             =   600
      Width           =   5415
      _Version        =   65536
      _ExtentX        =   9551
      _ExtentY        =   2619
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame SSFrame1 
         Height          =   1200
         Left            =   75
         TabIndex        =   2
         Top             =   240
         Width           =   5310
         _Version        =   65536
         _ExtentX        =   9366
         _ExtentY        =   2117
         _StockProps     =   14
         Caption         =   "Rango de Fechas Reporte :"
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
            Height          =   720
            Left            =   165
            TabIndex        =   3
            Top             =   300
            Width           =   5040
            Begin VB.ComboBox Combo1 
               BeginProperty Font 
                  Name            =   "Courier New"
                  Size            =   9
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   360
               Left            =   90
               Style           =   2  'Dropdown List
               TabIndex        =   4
               Top             =   225
               Width           =   4890
            End
         End
         Begin Threed.SSFrame Frame_vcto 
            Height          =   1245
            Left            =   120
            TabIndex        =   5
            Top             =   1200
            Visible         =   0   'False
            Width           =   5055
            _Version        =   65536
            _ExtentX        =   8916
            _ExtentY        =   2196
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
            Begin Threed.SSOption Opc_Cup 
               Height          =   375
               Left            =   225
               TabIndex        =   6
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
                  Size            =   8.25
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
               TabIndex        =   7
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
                  Size            =   8.25
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
               TabIndex        =   8
               Top             =   420
               Width           =   1320
               _Version        =   65536
               _ExtentX        =   2328
               _ExtentY        =   661
               _StockProps     =   78
               Caption         =   "&Captaciones"
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
            End
         End
         Begin BACControles.TXTFecha DteDesde 
            Height          =   255
            Left            =   1680
            TabIndex        =   9
            Top             =   1320
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   450
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
            Text            =   "08/11/2000"
         End
         Begin BACControles.TXTFecha Dtehasta 
            Height          =   255
            Left            =   3840
            TabIndex        =   10
            Top             =   1320
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   450
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
            Text            =   "08/11/2000"
         End
         Begin VB.Label Label4 
            Caption         =   "Fecha Consultar"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Left            =   150
            TabIndex        =   14
            Top             =   1335
            Visible         =   0   'False
            Width           =   1800
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
            TabIndex        =   13
            Top             =   360
            Width           =   60
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Desde"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   240
            Left            =   120
            TabIndex        =   12
            Top             =   1290
            Width           =   585
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Hasta"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   240
            Left            =   3090
            TabIndex        =   11
            Top             =   1305
            Width           =   525
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5475
      _ExtentX        =   9657
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6450
      Top             =   645
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
End
Attribute VB_Name = "BacFechas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Activate()

    Me.DteDesde.Text = Format(gsbac_fecp, "dd/mm/yyyy")
    Me.Dtehasta.Text = Format(gsbac_fecp, "dd/mm/yyyy")
    Me.Frame_vcto.Visible = False

    Select Case BACSwapParametros.ActiveForm.Tag
        Case "VCTOPACT"
            Me.LblNomList.Caption = "Listado de Vencimiento de Pactos"
            
        Case "VALMON"
            Me.DteDesde.Enabled = True
            Me.Dtehasta.Enabled = True
        
            Me.LblNomList.Caption = "Listado de Vencimiento de Pactos"
            Me.Frame3.Visible = False
            Me.Label1.Top = 700
            Me.Label2.Top = 700
            Me.DteDesde.Top = 700
            Me.Dtehasta.Top = 700
    
            Me.LblNomList.Caption = "Listado de Valores de Moneda"
            
        Case "VCTOPAP"
        
            Me.LblNomList.Caption = "Listado de Vencimiento de Papeles"
            
        Case "PAPELHIS"
            Me.Caption = "Papeletas Historicas"
            Me.Dtehasta.Visible = False
            Me.Frame_vcto.Visible = False
            Me.Label1.Visible = False
            Me.Label2.Visible = False
            Me.Label4.Visible = True
            Me.DteDesde.Left = Me.DteDesde.Left + 500
            Me.SSFrame1.Height = (Me.SSFrame1.Top + 100) + (Me.Label4.Height + 100) + (Me.Label4.Height + 100) + 250
            Me.Height = (Me.SSFrame1.Top + 100) + (Me.Label4.Height + 100) + (Me.Label4.Height + 100) + 1150
          
              
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
    Me.Top = 0
    Me.Left = 0
Dim cSql As String
Dim Datos()


    Combo1.Clear
    'cSql = "EXECUTE sp_leer_entidades"
    
    If Bac_Sql_Execute("sp_leer_entidades") Then
        
        Combo1.AddItem "TODAS LAS ENTIDADES                                                 "
        
        Do While Bac_SQL_Fetch(Datos())
            
            Combo1.AddItem Datos(1) & Space(50 + (30 - Len(Datos(1)))) & Str(Datos(2))
        
        Loop
        Combo1.ListIndex = 0
    Else
    
        MsgBox "Proceso " & cSql & "no existe", vbOKOnly + vbCritical, TITSISTEMA
        
        Unload Me
        Exit Sub
    End If
    
    

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
 Case 1
          Dim nTipo As Integer

   If (Me.Tag = "PAPELHIS" Or Me.Tag = "CONTHIS") Then
      If Not Format$(DteDesde.Text) < gsbac_fecp Then
         MsgBox "Fecha debe ser menor que fecha de proceso", vbExclamation, TITSISTEMA
         Exit Sub
      End If
      BacPapeleta.proFecha = Format$(DteDesde.Text, "yyyymmdd")
      BacPapeleta.proTipo = "HIS"
      BacPapeleta.Show
   Else
      'aqui estoy
      nTipo = IIf(Opc_Cup.Value = True, 1, IIf(Opc_Int.Value = True, 2, IIf(Opc_Cap.Value = True, 3, 0)))
      Call LlamaListados(BACSwapParametros.ActiveForm.DteDesde.Text, BACSwapParametros.ActiveForm.Dtehasta.Text, BACSwapParametros.ActiveForm.Tag, Val(Trim$(Right$(Combo1, 10))), nTipo)

   End If
   Unload Me
   
 Case 2
         Unload Me
 End Select
 
End Sub
