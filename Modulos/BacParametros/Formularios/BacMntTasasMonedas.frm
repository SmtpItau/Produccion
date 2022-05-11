VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACControles.ocx"
Begin VB.Form BacMntTasasMonedas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor Valores de  Tasas por Monedas"
   ClientHeight    =   5355
   ClientLeft      =   1740
   ClientTop       =   1605
   ClientWidth     =   6135
   Icon            =   "BacMntTasasMonedas.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5355
   ScaleWidth      =   6135
   Begin VB.Frame Frame1 
      Height          =   4785
      Left            =   0
      TabIndex        =   6
      Top             =   510
      Width           =   6135
      Begin BACControles.TXTNumero TXTNumerico 
         Height          =   280
         Left            =   2880
         TabIndex        =   25
         Top             =   2520
         Width           =   1380
         _ExtentX        =   2434
         _ExtentY        =   503
         BackColor       =   -2147483646
         ForeColor       =   -2147483639
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   3060
         Left            =   2145
         TabIndex        =   5
         Top             =   1620
         Width           =   3885
         _ExtentX        =   6853
         _ExtentY        =   5398
         _Version        =   393216
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   12632256
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         GridLines       =   2
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
      Begin VB.TextBox txtCodTasa 
         Alignment       =   1  'Right Justify
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
         Left            =   240
         MaxLength       =   5
         MouseIcon       =   "BacMntTasasMonedas.frx":030A
         MousePointer    =   99  'Custom
         TabIndex        =   1
         Top             =   1110
         Width           =   1095
      End
      Begin VB.TextBox txtCodMoneda 
         Alignment       =   1  'Right Justify
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
         Left            =   240
         MaxLength       =   5
         MouseIcon       =   "BacMntTasasMonedas.frx":0614
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   510
         Width           =   1095
      End
      Begin VB.TextBox TxtGlosaMon 
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
         Left            =   2145
         TabIndex        =   8
         Top             =   510
         Width           =   3855
      End
      Begin VB.TextBox TxtGlosaTasa 
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
         Left            =   2130
         TabIndex        =   7
         Top             =   1110
         Width           =   3855
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   1425
         Left            =   45
         TabIndex        =   12
         Top             =   120
         Width           =   2025
         _Version        =   65536
         _ExtentX        =   3572
         _ExtentY        =   2514
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
         ShadowStyle     =   1
         Begin VB.Label Lblcodtasa 
            Caption         =   "Cod. Tasa"
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
            Left            =   165
            TabIndex        =   14
            Top             =   735
            Width           =   1095
         End
         Begin VB.Label lblcodmon 
            Caption         =   "Cod. Moneda"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   165
            TabIndex        =   13
            Top             =   135
            Width           =   1335
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   1425
         Left            =   2085
         TabIndex        =   15
         Top             =   120
         Width           =   4005
         _Version        =   65536
         _ExtentX        =   7064
         _ExtentY        =   2514
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
         ShadowStyle     =   1
         Begin VB.Label lblnombretasa 
            Caption         =   "Nombre Tasa"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   45
            TabIndex        =   17
            Top             =   735
            Width           =   1815
         End
         Begin VB.Label lblnombremoneda 
            Caption         =   "Nombre  Moneda"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   60
            TabIndex        =   16
            Top             =   135
            Width           =   1935
         End
      End
      Begin VB.Frame Frame3 
         Height          =   3255
         Left            =   45
         TabIndex        =   9
         Top             =   1485
         Width           =   2025
         Begin VB.HScrollBar HSclano 
            Height          =   330
            LargeChange     =   10
            Left            =   975
            Max             =   2054
            Min             =   1900
            TabIndex        =   3
            Top             =   1320
            Value           =   2000
            Width           =   495
         End
         Begin VB.ComboBox cmbMes 
            BackColor       =   &H00FFFFFF&
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
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   480
            Width           =   1710
         End
         Begin VB.ComboBox CmbPeriodo 
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
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   2130
            Width           =   1710
         End
         Begin Threed.SSFrame SSFrame4 
            Height          =   840
            Left            =   60
            TabIndex        =   19
            Top             =   120
            Width           =   1890
            _Version        =   65536
            _ExtentX        =   3334
            _ExtentY        =   1482
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
            Font3D          =   1
            ShadowStyle     =   1
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Mes"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H8000000D&
               Height          =   195
               Index           =   4
               Left            =   105
               TabIndex        =   20
               Top             =   135
               Width           =   360
            End
         End
         Begin Threed.SSFrame SSFrame5 
            Height          =   765
            Left            =   60
            TabIndex        =   21
            Top             =   960
            Width           =   1875
            _Version        =   65536
            _ExtentX        =   3307
            _ExtentY        =   1349
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
            ShadowStyle     =   1
            Begin VB.Label LblAnno 
               Alignment       =   2  'Center
               BackColor       =   &H80000005&
               BorderStyle     =   1  'Fixed Single
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
               Height          =   330
               Left            =   75
               TabIndex        =   23
               ToolTipText     =   "Cambio de Año ->"
               Top             =   345
               Width           =   615
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Año"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H8000000D&
               Height          =   195
               Index           =   5
               Left            =   75
               TabIndex        =   22
               Top             =   105
               Width           =   345
            End
         End
         Begin Threed.SSFrame SSFrame6 
            Height          =   900
            Left            =   60
            TabIndex        =   24
            Top             =   1740
            Width           =   1875
            _Version        =   65536
            _ExtentX        =   3307
            _ExtentY        =   1587
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
            ShadowStyle     =   1
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Período"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H8000000D&
               Height          =   195
               Left            =   75
               TabIndex        =   11
               Top             =   135
               Width           =   690
            End
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   3240
         Left            =   2085
         TabIndex        =   18
         Top             =   1500
         Width           =   4005
         _Version        =   65536
         _ExtentX        =   7064
         _ExtentY        =   5715
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
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   6135
      _ExtentX        =   10821
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Datos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Imprimir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4830
         Top             =   -45
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
               Picture         =   "BacMntTasasMonedas.frx":091E
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntTasasMonedas.frx":0D70
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntTasasMonedas.frx":11C2
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntTasasMonedas.frx":14DC
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntTasasMonedas.frx":17F6
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacMntTasasMonedas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim objCodigo               As Object
Dim oka                     As Boolean
Dim Periodo                 As Integer

Dim Paso                    As String
Dim Pasos                   As String
Dim dias                    As Integer
Dim Ann                     As Integer
Dim Mes                     As Integer

Const nFormatoIngreso = "#,##0.000000"

Private User()              As Variant

Private Sub cmbMes_Click()
 
    If cmbMes.ListIndex <> -1 And oka <> False Then
          Call HSclano_Change
          Exit Sub
       End If

End Sub

Private Sub CmbPeriodo_Click()

      If CmbPeriodo.ListIndex <> -1 And oka <> False Then
          Call HSclano_Change
          Exit Sub
       End If

End Sub

Private Sub cmdGrabar()
          
    If Grilla.Rows <= 2 Then
       
       Exit Sub
    
    End If
         
    TXTNumerico.Visible = False
    TXTNumerico.Text = ""

    Screen.MousePointer = 11
             
    If GrabarTmMn(txtCodMoneda.Text, txtCodTasa.Text) = False Then
        
        MsgBox "ERROR : DE GRABACION  ", 16, TITSISTEMA
        Screen.MousePointer = 0
        'Call Grabar_Log(gsSQL_Version, gsBAC_User, CDate(gsbac_fecp), "Grabación se realizó con Exito : Tasas por Moneda ")
       
       Exit Sub
      
      Else
        
        MsgBox "Grabación se realizó con exito ", 64, TITSISTEMA
        
        Call HSclano_Change
    
    End If
 
    Screen.MousePointer = 0
        
End Sub
Private Sub cmdLimpiar()

   Screen.MousePointer = 11

    Call LimpiarTodo
    Call Habilitar(False)

    Call EstadoGrilla(Grilla)
    Call BacIniciaGrilla(14, 4, 1, 0, False, Grilla)
    Call BacLimpiaGrilla(Grilla)
    
   ' Set objCodigo = New clsCodigo
    'Call objCodigo.CargaObjetos(CmbPeriodo, MDTC_PERIODO)
   ' Set objCodigo = Nothing
    
    TXTNumerico.Visible = False: TXTNumerico.Text = ""
    Periodo = 0: Grilla.Enabled = False
    Toolbar1.Buttons(4).Enabled = True
    'CmdSalir.Enabled = True

    txtCodTasa.Enabled = True
    txtCodMoneda.Enabled = True
   
    txtCodMoneda.SetFocus
   
   Screen.MousePointer = 0

End Sub


Private Sub Command1_Click()
End Sub

Private Sub Form_Activate()

    Call BacIniciaGrilla(14, 4, 1, 0, False, Grilla)
    Call CargarParam_TmMn(Grilla)
    Me.Icon = BACSwapParametros.Icon
  
End Sub

Private Sub Form_Load()
    
    On Error GoTo Error
    
    Me.Top = 0
    Me.Left = 0
    oka = False
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_901" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
                          
    Call BacLimpiaGrilla(Grilla)
    Call BacIniciaGrilla(14, 4, 1, 0, False, Grilla)
    Call CargarParam_TmMn(Grilla)
     
    Call BacLLenaComboMes(cmbMes)
    
    Call LeerPeriodo(CmbPeriodo)
       
    
    Call Habilitar(False)
     
    txtNumerico.CantidadDecimales = 6
    TXTNumerico.Visible = False
    TXTNumerico.Text = ""
    
    TxtGlosaMon.Enabled = False
    TxtGlosaTasa.Enabled = False
    Toolbar1.Buttons(4).Enabled = True
    'CmdSalir.Enabled = True
    oka = True
    
    
    
    Exit Sub
    
Error:
      MsgBox "ERROR : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Sub
       
End Sub

Private Sub grilla_DblClick()
    grilla_KeyPress 13
End Sub

Private Sub Grilla_GotFocus()
Call Pinta(Grilla)
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
    
With Grilla
             
    .Col = 1
    
    PROC_POSICIONA_TEXTOX Grilla, TXTNumerico
    .Enabled = False
    TXTNumerico.Visible = True
   ' TXTNumerico.Text = 0
    TXTNumerico.Text = Chr(KeyAscii)  'BacCtrlTransMonto(.TextMatrix(.Row, .Col))
    TXTNumerico.SetFocus
    TXTNumerico.SelStart = 1
    
 End With
   
End Sub

Private Sub Grilla_LeaveCell()
    Call Despinta(Grilla)
End Sub

Private Sub grilla_SelChange()
    Call Pinta(Grilla)
End Sub

Private Sub HSclano_Change()
 With Grilla
 
    TXTNumerico.Visible = False
    TXTNumerico.Text = ""
    
     Mes = cmbMes.ItemData(cmbMes.ListIndex)
     Ann = Val(HSclano.Value)
     dias = DiasDelMes(Mes, Ann)
          
   If Trim$(txtCodMoneda.Text) = "" Or Trim$(txtCodTasa.Text) = "" Then
     .Rows = 2
     Exit Sub
  End If
 
  If Mes <= 0 Then
    .Rows = 2
    Exit Sub
  End If
 
  If dias <= 0 Then
     .Rows = 2
     Exit Sub
  End If
 
  
      If CmbPeriodo.ListCount > 0 And CmbPeriodo.ListIndex = -1 Then
           CmbPeriodo.ListIndex = 0
       End If
       
      If CmbPeriodo.ListCount = 0 Then
            MsgBox "La Tabla Amortizaciones de Interes NO contiene nada ,  Debe Ingresar Valores ", 16, TITSISTEMA
            
            Toolbar1.Buttons(1).Enabled = False
            Toolbar1.Buttons(2).Enabled = False
            Toolbar1.Buttons(3).Enabled = True
            Exit Sub
       End If
       
        If CmbPeriodo.ListCount > 0 And CmbPeriodo.ListIndex <> -1 Then
           Periodo = CmbPeriodo.ItemData(CmbPeriodo.ListIndex)
        End If
         
         
    Screen.MousePointer = 11

    Call Habilitar(True)
    LblAnno.Caption = Str$(HSclano.Value)
   
   If Not LeerTmMn(txtCodMoneda.Text, txtCodTasa.Text) Then
        MsgBox "ERROR : DE LECTURA  ", 16, TITSISTEMA
        Screen.MousePointer = 0
        Exit Sub
   End If
        
        
    Screen.MousePointer = 0
    .Row = 1: .Col = 1: Call Pinta(Grilla)
    If .Enabled Then .SetFocus
    
End With
          
End Sub
Sub Pinta(Grilla As Object)

 With Grilla
      If .Row <> 0 Then
            .CellForeColor = 16777215
            .CellBackColor = &H800000
            '.CellBackColor = &H80000002 &H00800000&
      End If
 End With
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1      '"Grabar"
                cmdGrabar
                Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_901 " _
                                    , "01" _
                                    , "Grabar" _
                                    , " " _
                                    , " " _
                                    , " ")
        Case 2      '"Eliminar"
                cmdLimpiar
                
        Case 3 '"Imprimir"
                
               CmdReporte
                
        Case 4      '"salir"
           Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_901 " _
                                    , "08" _
                                    , "SALIR OPCION MENU" _
                                    , " " _
                                    , " " _
                                    , " ")
                Unload Me
    End Select

End Sub

Private Sub TxtCodMoneda_DblClick()
         
    
    BacAyuda.Tag = "MDMN"
    BacAyuda.Show 1
    
    
    If giAceptar% = True Then
         
         Toolbar1.Buttons(2).Enabled = True
         txtCodMoneda.Text = gsCodigo$
         TxtGlosaMon.Text = gsDescripcion$
         txtCodMoneda.SetFocus
         SendKeys "{ENTER}"
         
    End If

End Sub

Private Sub txtCodMoneda_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyF3 Then Call TxtCodMoneda_DblClick

End Sub

Private Sub TxtCodMoneda_KeyPress(KeyAscii As Integer)
 
    BacSoloNumeros KeyAscii
   
    If KeyAscii = 13 And Trim$(txtCodMoneda.Text) <> "" Then
        KeyAscii = 0
        Set objCodigo = New clsMoneda
        If objCodigo.LeerPorCodigox(Val(txtCodMoneda.Text)) = True Then
'        If objCodigo.LeerxCodigo(Val(txtCodMoneda.Text)) Then
            If Existe = False Then GoTo noexiste:
            
            txtCodMoneda.Text = objCodigo.mncodmon
            TxtGlosaMon.Text = objCodigo.mndescrip
            txtCodMoneda.SetFocus
            SendKeys "{TAB}"
            Exit Sub
       Else
           
            Call cmdLimpiar
            txtCodMoneda.Text = ""
            txtCodMoneda.SetFocus
            Exit Sub
       End If
          
noexiste:
    Call cmdLimpiar
    MsgBox "El codigo de Moneda no Existe...", vbExclamation, TITSISTEMA
    txtCodMoneda.Text = ""
    txtCodMoneda.SetFocus
End If
End Sub
Private Sub TxtCodTasa_DblClick()

   Set objCodigo = New clsCodigo
   
   BacAyuda.Tag = "MDTC_TASASMONEDAS"
   BacAyuda.Show 1

   If giAceptar% Then
      
      txtCodTasa.Text = gsCodigo$
      TxtGlosaTasa.Text = gsGlosa$
      TxtCodTasa_KeyPress 13
      'txtCodTasa.SetFocus
      SendKeys "{ENTER}"

   End If

End Sub

Public Function CargarParam_TmMn(Grillas As Object)

With Grillas

         .ColWidth(0) = 1500           '- fecha
         .ColWidth(1) = 2000           '- Valor
         .ColWidth(2) = 1              '- valor captacion
         .ColWidth(3) = 1              '- valor colocacion
         
         
         .RowHeight(0) = 350
         .CellFontWidth = 5
        
         '.RowHeight() = 290
         .Row = 0
         
         .Col = 0
         .FixedAlignment(0) = 4
         .Text = " Fecha "
         .ColAlignment(0) = 4
         .CellFontBold = True
         
         '.CellForeColor = 1
         
         .Col = 1
         .FixedAlignment(1) = 4
         .Text = "  Valor  "
         .CellFontBold = True
         '.CellForeColor = 1
         
         
         '.col = 2
         '.Text = "Valor Captacion "
         '.CellFontBold = True
         
         
         '.col = 3
         '.Text = " Valor Colocacion  "
         '.CellFontBold = True
         
End With

End Function
Private Function DiasDelMes(Mes As Integer, Ann As Integer) As Integer

Dim dias    As String
Dim Residuo As Currency

    dias = "312831303130313130313031"
    
   If Mes = 0 Then
      DiasDelMes = 0
      Exit Function
   End If
   
    
    If Mes = 2 Then
    
          Residuo = Ann Mod 4
          If Residuo = 0 Then
                DiasDelMes = 29
            Else
                DiasDelMes = 28
         End If
         
    Else
            DiasDelMes = Val(Mid$(dias, ((Mes * 2) - 1), 2))
    End If
             
End Function
          
Public Function LeerTmMn(CodMoneda As String, CodTasa As String)

On Error GoTo Error

Dim datos()
Dim Sql As String
Dim Fila As Integer
Dim fecha As Date
Dim Meses As String

    LeerTmMn = False
            
            '**** Creo los dinamicos con los dias del mes seleccionado
                  
            ReDim User(0 To 2, 0 To dias - 1)     ' Dias del mes
            
            For Fila = 0 To dias - 1
                 User(0, Fila) = Format(Fila + 1, "00") + "/" + Format(Mes, "00") + "/" + Trim$(Str(Ann)) '-  fecha -'
                 User(1, Fila) = "0"                '-  Valor  -'
            Next Fila
               
               
            Meses = Str(Ann) & Format(Mes, "00")
  
           
'''''    Sql = ""
'''''    'SQL = giSQL_DatabaseCommon..
'''''    Sql = Sql & "sp_Leer_TasasMonedas "
'''''    Sql = Sql & Val(CodMoneda)
'''''    Sql = Sql & "," & Val(CodTasa)
'''''    Sql = Sql & "," & Periodo
'''''    Sql = Sql & "," & Val(Meses)
'''''    Sql = Sql & "," & Len(Trim(Meses))
    
    Envia = Array()
    AddParam Envia, CDbl(CodMoneda)
    AddParam Envia, CDbl(CodTasa)
    AddParam Envia, CDbl(Periodo)
    AddParam Envia, CDbl(Meses)
    AddParam Envia, CDbl(Len(Trim(Meses)))
            
    If Not Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
        Exit Function
    End If


        Do While Bac_SQL_Fetch(datos())
            
            fecha = Format$(CDate(datos(7)), "dd/mm/yyyy")
            
            For Fila = 0 To UBound(User, 2)
                If CDate(Trim$(User(0, Fila))) = Trim$(fecha) Then
                    User(1, Fila) = CDbl(datos(8))        '-  Valor -'
                    Exit For
                End If
            Next Fila
            
        Loop
    
                        
  With Grilla

        .Rows = 2
        .TextMatrix(1, 0) = "": .TextMatrix(1, 1) = ""
        .Redraw = False
         
        For Fila = 0 To dias - 1
            .Row = Fila + 1
            .TextMatrix(.Row, 0) = User(0, Fila)   '- fecha
           '.TextMatrix(.Row, 1) = Format(User(1, fila), "#,##0.0000")
            .TextMatrix(.Row, 1) = Format(User(1, fila), nFormatoIngreso)
            '.TextMatrix(.Row, 1) = User(1, Fila)
            .Rows = .Rows + 1
        Next Fila
                  
        
        .Rows = .Rows - 1
        .Redraw = True
        .Enabled = True
    
    End With
    
    LeerTmMn = True
   
Exit Function

Error:
            LeerTmMn = False
            MsgBox "ERROR : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
            Exit Function
   
End Function
Public Function LimpiarTodo()

    txtCodMoneda.Text = ""
    txtCodTasa.Text = ""
    TxtGlosaMon.Text = ""
    TxtGlosaTasa.Text = ""
    LblAnno.Caption = ""
    cmbMes.ListIndex = -1
    CmbPeriodo.ListIndex = -1

    txtCodTasa.Enabled = True
    txtCodMoneda.Enabled = True


End Function

Public Function Habilitar(Valor As Boolean)


On Error GoTo Error

    CmbPeriodo.Enabled = Valor
    cmbMes.Enabled = Valor
    HSclano.Enabled = Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
    'cmdGrabar.Enabled = Valor
    'cmdLimpiar.Enabled = Valor

    Exit Function
Error:
      MsgBox "ERROR : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Function

     
End Function

Private Sub txtCodTasa_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyF3 Then Call TxtCodTasa_DblClick

End Sub

Private Sub TxtCodTasa_KeyPress(KeyAscii As Integer)
 
 On Error GoTo Error
 
    BacSoloNumeros KeyAscii
   
    If KeyAscii = 13 And Val(txtCodTasa.Text) > 0 Then
       
        If Val(txtCodMoneda.Text) <= 0 Then
            
            Call LimpiarTodo
            MsgBox "  Debe Ingresar Codigo Moneda  ", 16, TITSISTEMA
            Exit Sub
        
        End If
       
       If Not BuscarMoneda(txtCodMoneda.Text) Or Not BuscarTasa(txtCodTasa.Text) Then
            Paso = txtCodMoneda.Text
            Pasos = TxtGlosaMon.Text
            Call cmdLimpiar
            txtCodMoneda.Text = Paso
            TxtGlosaMon.Text = Pasos
            TXTNumerico.Visible = False
            TXTNumerico.Text = ""
            txtCodTasa.Text = ""
            txtCodTasa.SetFocus
            Exit Sub
        End If
             
        Call Habilitar(True)
        oka = False
        bacBuscarCombo cmbMes, Month(gsbac_fecp)
        
        Mes = cmbMes.ItemData(cmbMes.ListIndex)
        HSclano.Value = Year(CDate(gsbac_fecp))
        LblAnno.Caption = Str(Year(CDate(gsbac_fecp)))
        oka = True
        
        Call HSclano_Change
        
        txtCodTasa.Enabled = False
        txtCodMoneda.Enabled = False
        
        HSclano.SetFocus
         
         
    End If
     
 Exit Sub
 
Error:
      MsgBox "ERROR : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Sub
  Exit Sub
     
End Sub

Public Function GrabarTmMn(CodMon As String, CodTasa As String) As Boolean
Dim Fila%


On Error GoTo Error

    GrabarTmMn = False
                        
    If CmbPeriodo.ListIndex = -1 And CmbPeriodo.ListCount <> 0 Then
        
        MsgBox "Debe seleccionar Periodo de la Opcion ", vbCritical, TITSISTEMA
        Exit Function
    
    End If
    
    GrabarTmMn = True

With Grilla

    Set objCodigo = New ClsTasas2
    
    For Fila = 1 To .Rows - 1
    
        objCodigo.CodMoneda = Val(CodMon)
        objCodigo.CodTasa = Val(CodTasa)
        objCodigo.CodPeriodo = CmbPeriodo.ItemData(CmbPeriodo.ListIndex)
        objCodigo.fecha = .TextMatrix(Fila, 0)
        objCodigo.Valor = CDbl(.TextMatrix(Fila, 1))
       ' objCodigo.Valor = FUNC_SACACOMA_GRILLA_STandar(.TextMatrix(Fila, 1))
       ' If CDbl(User(1, Fila - 1)) <> (objCodigo.Valor) Then
            If Not objCodigo.GrabarTM Then
                
                GrabarTmMn = False
                MsgBox "No se puede seguir Actualizando Valores de Tasas", TITSISTEMA
                Exit For
            
            End If
            
        'End If
           
    Next Fila
    Set objCodigo = Nothing
     
End With
    
 GrabarTmMn = True
 Exit Function
    
Error:
      MsgBox "ERROR : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Function
            
End Function
Public Function BuscarMoneda(CodMon As String) As Boolean

    Set objCodigo = New clsMoneda
    
    BuscarMoneda = objCodigo.LeerPorCodigox(Val(CodMon))
    
    If BuscarMoneda Then
        TxtGlosaMon.Text = objCodigo.mndescrip
    End If
            
    Set objCodigo = Nothing
            
End Function
Public Function BuscarTasa(CodTasa As String) As Boolean
    
    Set objCodigo = New ClsTasas
    
    BuscarTasa = objCodigo.LeerTc(MDTC_TASAS, Val(CodTasa))
    
    If BuscarTasa Then
        TxtGlosaTasa.Text = objCodigo.glosa
    End If
            
    Set objCodigo = Nothing
    
    If Trim(UCase(TxtGlosaTasa)) = "FIJA" Then
        MsgBox "La Tasa FIJA no esta contemplada para Tasas de Mercado", vbExclamation, TITSISTEMA
        BuscarTasa = False
    End If
            
End Function



'Private Sub txtNumerico_GotFocus()

'    If Val(txtNumerico.Text) = "0" Then
'        txtNumerico.Text = 0
'    End If

'End Sub
'-----------------------------------------------------------------------
Private Sub txtNumerico_KeyPress(KeyAscii As Integer)

With Grilla

   ' PROC_FMT_NUMERICO TxtNumerico, 6, 4, KeyAscii, "", gsc_PuntoDecim

    Select Case KeyAscii
    Case vbKeyReturn
        
        .TextMatrix(.Row, .Col) = TXTNumerico.Text
        .TextMatrix(.Row, .Col) = BacFormatoMonto(.TextMatrix(.Row, .Col), txtNumerico.CantidadDecimales)
        txtNumerico.CantidadDecimales = 6
        TXTNumerico.Text = 0
        TXTNumerico.Visible = False
        .Enabled = True
        .SetFocus
       ' TXTNumerico.SelStart = 1
    Case vbKeyEscape
        txtNumerico.CantidadDecimales = 6
        TXTNumerico.Text = 0
        TXTNumerico.Visible = False
        .Enabled = True
        .SetFocus
        
    End Select
  '  TXTNumerico.SelStart = 1
End With
  
End Sub

Public Function LeerPeriodo(obj As Object) As Boolean
  
  On Error GoTo Error:
  
 Dim Sql As String
 Dim datos()
   
LeerPeriodo = False

''''  Sql = "SELECT * FROM MDPERIODO WHERE TABLA = " & Val(MDTC_PERIODO)
''''  Sql = "sp_Leer_Periodo " & Val(MDTC_PERIODO)
    Envia = Array()
    AddParam Envia, CDbl(MDTC_PERIODO)
    
    If Not Bac_Sql_Execute("SP_LEER_PERIODO", Envia) Then
        MsgBox "ERROR : NO SE PUEDE CARGAR LA TABLA ", vbCritical, TITSISTEMA
        Exit Function
    End If
    Do While Bac_SQL_Fetch(datos)
        obj.AddItem UCase(datos(2))
        obj.ItemData(obj.NewIndex) = Val(datos(1))
        LeerPeriodo = True
    Loop
  
Exit Function

Error:
       MsgBox "EXISTE UN ERROR DE OBJETO", vbCritical, TITSISTEMA
       Exit Function
End Function

Public Sub CmdReporte()

Dim año As String
Dim Sql As String

On Error GoTo Error

año = Val(LblAnno.Caption)
Mes = Val(cmbMes.ItemData(cmbMes.ListIndex))

If Val(txtCodMoneda.Text) = 0 Or Val(txtCodTasa.Text) = 0 Or Trim(año) = "" Or Mes = 0 Then
     Exit Sub
End If

Screen.MousePointer = 11
 
     Mes = cmbMes.ItemData(cmbMes.ListIndex)
     Ann = Val(HSclano.Value)

 Call LimpiaReportes
 
 With BACSwapParametros.BACParam
 'With Parametros.BacParam 'bacrpt
 
''''    Sql = ""
''''    Sql = Sql & Val(txtCodMoneda.Text)
''''    Sql = Sql & "," & Val(txtCodTasa.Text)
''''    Sql = Sql & "," & CmbPeriodo.ItemData(CmbPeriodo.ListIndex)
''''    Sql = Sql & "," & Trim(Año & Format(Mes, "00"))
''''    Sql = Sql & "," & Len(Año & Format(Mes, "00"))
''''    Sql = Sql & "," & TxtGlosaMon.Text
''''    Sql = Sql & "," & TxtGlosaTasa.Text
''''    Sql = Sql & "," & CmbPeriodo.List(CmbPeriodo.ListIndex)
''''    Sql = Sql & "," & UCase("Informe Valores de MoNEDAS POR TASAS")
    
    
    .Destination = 0
    '.ReportFileName = RptAdm_Path & "ValoresMonedastasas.RPT"
    .ReportFileName = gsRPT_Path & "ValoresMonedastasas.RPT"
    .WindowTitle = "Informe Valores de Monedas"
    .StoredProcParam(0) = Val(txtCodMoneda.Text)
    .StoredProcParam(1) = Val(txtCodTasa.Text)
    .StoredProcParam(2) = CmbPeriodo.ItemData(CmbPeriodo.ListIndex)
    .StoredProcParam(3) = Trim(año & Format(Mes, "00"))
    .StoredProcParam(4) = Len(año & Format(Mes, "00"))
    .StoredProcParam(5) = TxtGlosaMon.Text
    .StoredProcParam(6) = TxtGlosaTasa.Text
    .StoredProcParam(7) = CmbPeriodo.List(CmbPeriodo.ListIndex)
    .StoredProcParam(8) = UCase("Informe Valores de MoNEDAS")
    
    '.Connect = Coneccion
    .Connect = SwConeccion
    .Action = 1
End With

Screen.MousePointer = 0

Exit Sub

Error:
      Screen.MousePointer = 0
      MsgBox "ERROR  : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Sub

End Sub

Sub Despinta(Grilla As Object)

    With Grilla
      If .Row <> 0 Then
        .CellForeColor = -2147483635
'        .CellForeColor = &HC00000

        .CellBackColor = &H8000000F
      End If
    End With

End Sub

