VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form BacMiddled_Office 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor Middled-Office"
   ClientHeight    =   5880
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9450
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5880
   ScaleWidth      =   9450
   Begin VB.Frame Frame1 
      Caption         =   "Operación de Derivado"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   5220
      Left            =   75
      TabIndex        =   0
      Top             =   570
      Width           =   9300
      Begin VB.Frame Frame3 
         Caption         =   "Operación Relacionada"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   2490
         Left            =   195
         TabIndex        =   2
         Top             =   2565
         Width           =   8955
         Begin VB.TextBox TxtNumeroR 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   1080
            MousePointer    =   14  'Arrow and Question
            TabIndex        =   21
            Top             =   1320
            Width           =   1815
         End
         Begin BACControles.TXTFecha TxtFechaRev 
            Height          =   300
            Left            =   6240
            TabIndex        =   19
            Top             =   1320
            Width           =   1815
            _ExtentX        =   3201
            _ExtentY        =   529
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
            Text            =   "25/08/2011"
         End
         Begin VB.ComboBox CmbTipoPeriodo 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   6240
            Style           =   2  'Dropdown List
            TabIndex        =   17
            Top             =   2040
            Width           =   1815
         End
         Begin VB.ComboBox CmbModuloR 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1080
            Style           =   2  'Dropdown List
            TabIndex        =   16
            Top             =   735
            Width           =   1815
         End
         Begin BACControles.TXTNumero TXTPeriodo 
            Height          =   300
            Left            =   6240
            TabIndex        =   15
            Top             =   1680
            Width           =   1815
            _ExtentX        =   3201
            _ExtentY        =   529
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin Threed.SSCheck SscEarlyTerm 
            Height          =   225
            Left            =   4140
            TabIndex        =   10
            Top             =   705
            Width           =   2625
            _Version        =   65536
            _ExtentX        =   4630
            _ExtentY        =   397
            _StockProps     =   78
            Caption         =   "Sujeto a Early Termination"
            ForeColor       =   12582912
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
         Begin VB.Label LblTipoPeriodo 
            Caption         =   "Tipo Periodo"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Left            =   4140
            TabIndex        =   13
            Top             =   2085
            Width           =   1305
         End
         Begin VB.Label LblPeriodo 
            Caption         =   "Cantidad de Periodos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   195
            Left            =   4140
            TabIndex        =   12
            Top             =   1725
            Width           =   1860
         End
         Begin VB.Label LblFechaRev 
            Caption         =   "Fecha revisión"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Left            =   4140
            TabIndex        =   11
            Top             =   1305
            Width           =   1890
         End
         Begin VB.Label LblNumeroR 
            Caption         =   "Numero"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   210
            Left            =   225
            TabIndex        =   9
            Top             =   1305
            Width           =   1260
         End
         Begin VB.Label LblModuloR 
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
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   1
            Left            =   225
            TabIndex        =   8
            Top             =   705
            Width           =   1350
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   2250
         Left            =   180
         TabIndex        =   1
         Top             =   240
         Width           =   8985
         Begin VB.TextBox TxtNumero 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   1080
            MousePointer    =   14  'Arrow and Question
            TabIndex        =   20
            Top             =   1320
            Width           =   1815
         End
         Begin BACControles.TXTFecha TxtFechaVenc 
            Height          =   300
            Left            =   5880
            TabIndex        =   18
            Top             =   1320
            Width           =   1575
            _ExtentX        =   2778
            _ExtentY        =   529
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
            Text            =   "01/01/1000"
         End
         Begin VB.ComboBox CmbModulo 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1080
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   765
            Width           =   1815
         End
         Begin VB.Label LblEstado 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H0000C000&
            Height          =   255
            Left            =   120
            TabIndex        =   23
            Top             =   240
            Width           =   2535
         End
         Begin VB.Label Label1 
            Caption         =   "Cliente :"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Left            =   3120
            TabIndex        =   22
            Top             =   840
            Width           =   855
         End
         Begin VB.Label LblCliente 
            ForeColor       =   &H00C00000&
            Height          =   450
            Left            =   4080
            TabIndex        =   7
            Top             =   840
            Width           =   4725
         End
         Begin VB.Label LblFechaVenc 
            Caption         =   "Fecha Vencimiento"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   270
            Left            =   4140
            TabIndex        =   6
            Top             =   1380
            Width           =   1755
         End
         Begin VB.Label LblNumero 
            Caption         =   "Numero"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   255
            Left            =   225
            TabIndex        =   5
            Top             =   1305
            Width           =   1170
         End
         Begin VB.Label LblModulo 
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
            ForeColor       =   &H00C00000&
            Height          =   330
            Index           =   0
            Left            =   210
            TabIndex        =   4
            Top             =   840
            Width           =   1515
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8640
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMiddled_Office.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMiddled_Office.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMiddled_Office.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMiddled_Office.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMiddled_Office.frx":3B68
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMiddled_Office.frx":3E82
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMiddled_Office.frx":4D5C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   9450
      _ExtentX        =   16669
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Reporte"
            ImageIndex      =   6
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
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Exportar Excel"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "BacMiddled_Office.frx":5C36
      OLEDropMode     =   1
      Begin MSComDlg.CommonDialog Command 
         Left            =   5160
         Top             =   0
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
End
Attribute VB_Name = "BacMiddled_Office"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Proc_Carga_Combos()
    Dim DATOS()
    
'    CmbModulo.AddItem "Forward" & Space(70) & "BFW"
'    CmbModulo.AddItem "Swap" & Space(70) & "PCS"
'    CmbModulo.AddItem "Opciones" & Space(70) & "OPT"

    'Envia = Array()
    If Not Bac_Sql_Execute("SP_RIEFIN_CON_DERIVADOS") Then
        MsgBox "Actualizacion de Lineas" & vbCrLf & vbCrLf & "Error en la carga de clientes.", vbExclamation, App.Title
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(DATOS())
        CmbModulo.AddItem Trim(DATOS(2)) & Space(70) & Trim(DATOS(1))
    Loop
        
    'Carga Combo CmbModuloR
    CmbModuloR.AddItem "RENTA FIJA" & Space(70) & "BTR"
    CmbModuloR.AddItem "BONOS EXTERIOR" & Space(70) & "BEX"
    CmbModuloR.AddItem "OTROS" & Space(70) & "OTR"
    
    
    'Carga Combo CmbTipoPeriodo
    'Envia = Array()
    If Not Bac_Sql_Execute("SP_RIEFIN_TIPO_PERIODO") Then
        MsgBox "Actualizacion de Lineas" & vbCrLf & vbCrLf & "Error en la carga de clientes.", vbExclamation, App.Title
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(DATOS())
        CmbTipoPeriodo.AddItem DATOS(4) & Space(60) & DATOS(3)
    Loop
End Sub



Private Sub Proc_Consulta_Middle_Office()
    Dim DATOS()
    Dim nContador1 As Integer
    Envia = Array()
    AddParam Envia, Trim(Right(CmbModulo.Text, 10))
    AddParam Envia, IIf(Trim(TxtNumero.Text) = "", 0, Trim(TxtNumero.Text))
    
    If Not Bac_Sql_Execute("SP_RIEFIN_CON_DRV_MIDDLE_OFFICE", Envia) Then
        Call MsgBox("Error." & vbCrLf & vbCrLf & "Se ha generado un error al intentar Leer.", vbInformation, App.Title)
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(DATOS())
        Let Me.LblEstado.Caption = "Consultando"
        If DATOS(3) = "S" Then
            SscEarlyTerm.Value = True
        Else
            Me.SscEarlyTerm.Value = False
        End If
        
        TxtFechaRev.Text = DATOS(4)
        TXTPeriodo.Text = DATOS(5)
        
        For nContador1 = 0 To CmbTipoPeriodo.ListCount - 1
            If Trim(Right(CmbTipoPeriodo.List(nContador1), 10)) = CDbl(Trim(DATOS(6))) Then
                CmbTipoPeriodo.ListIndex = nContador1
                Exit For
            End If
        Next nContador1
               
        For nContador1 = 0 To CmbModuloR.ListCount - 1
           If Trim(Right(CmbModuloR.List(nContador1), 10)) = (Trim(DATOS(7))) Then
               CmbModuloR.ListIndex = nContador1
               Exit For
           End If
        Next nContador1
                
        TxtNumeroR.Text = DATOS(8)
        TxtFechaVenc.Text = DATOS(9)
     Loop
      If Me.LblEstado.Caption = "" And Me.CmbModulo.ListIndex <> -1 Then
        Let Me.LblEstado.Caption = "Insertando"
      End If
End Sub

Private Sub Proc_Elimina_Middle_Office()
    Dim DATOS()
    
    Envia = Array()
    AddParam Envia, Trim(Right(CmbModulo.Text, 10))
    AddParam Envia, CDbl(Trim(TxtNumero.Text))
    
    If Not Bac_Sql_Execute("SP_RIEFIN_DEL_DRV_MIDDLE_OFFICE", Envia) Then
        Call MsgBox("Error." & vbCrLf & vbCrLf & "Se ha generado un error al intentar Eliminar.", vbInformation, App.Title)
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(DATOS())
    
        If DATOS(1) = -1 Then
            Call MsgBox(DATOS(2), vbInformation, App.Title)
            Exit Sub
        End If
    Loop
    
    
    Call MsgBox("Se elimino la información de forma exitosa.", vbInformation, App.Title)

    
End Sub


Private Sub Proc_Graba_Middle_Office()
    Dim DATOS()
    
    Envia = Array()
    AddParam Envia, Trim(Right(CmbModulo.Text, 10))
    AddParam Envia, CDbl(Trim(TxtNumero.Text))
    If Me.SscEarlyTerm.Value = True Then
       AddParam Envia, "S"
    Else
       AddParam Envia, "N"
    End If
    AddParam Envia, CDate(Trim(TxtFechaRev.Text))
    AddParam Envia, CDbl(Trim(TXTPeriodo.Text))
    AddParam Envia, IIf(Trim(Right(Me.CmbTipoPeriodo.Text, 10)) = "", 0, Trim(Right(Me.CmbTipoPeriodo.Text, 10)))
    AddParam Envia, Trim(Right(Me.CmbModuloR.Text, 10))
    AddParam Envia, IIf(Trim(Me.TxtNumeroR.Text) = "", 0, Trim(Me.TxtNumeroR.Text))
    AddParam Envia, Trim(Me.TxtFechaVenc.Text)
   
   If Not Bac_Sql_Execute("SP_RIEFIN_GRABA_DRV_MIDDLE_OFFICE", Envia) Then
      Call MsgBox("Error." & vbCrLf & vbCrLf & "Se ha generado un error al intentar Grabar.", vbExclamation, App.Title)
      Exit Sub
   End If
   
    Do While Bac_SQL_Fetch(DATOS())
    
        If DATOS(1) = -1 Then
            Call MsgBox(DATOS(2), vbInformation, App.Title)
            Exit Sub
        End If
    Loop

    
    Call MsgBox("Se grabo la información de forma exitosa.", vbExclamation, App.Title)

End Sub



Private Sub Proc_Limpiar(Limpiar As String)


    If Limpiar = "Todo" Then
        Me.CmbModulo.ListIndex = -1
        Me.TxtNumero.Text = ""
    End If


    If Limpiar = "Modulo" Or Limpiar = "Todo" Then
        LblCliente.Caption = ""
        TxtFechaVenc.Text = "01/01/1000"
        Let Limpiar = ""
    End If
    
    CmbModuloR.ListIndex = -1
    TxtNumeroR.Text = ""
    SscEarlyTerm.Value = False
    TXTPeriodo.Text = ""
    TxtFechaRev.Text = CDate(Format(gsBAC_Fecp, "dd/mm/yyyy"))
    CmbTipoPeriodo.ListIndex = -1
    LblEstado.Caption = ""
    
End Sub

Private Sub cmbModulo_Click()
    Dim Limpiar As String
    TxtNumero.Text = ""
    LblCliente.Caption = ""
    TxtFechaVenc.Text = "01/01/1000"
    
    Let Limpiar = "Modulo"
    Call Proc_Limpiar(Limpiar)
    
End Sub

Private Sub CmbModuloR_Click()
    TxtNumeroR.Text = ""
   
End Sub

Private Sub Form_Load()
    Let Me.Icon = BacControlFinanciero.Icon
    Let Me.top = 0: Let Me.Left = 0
    TxtFechaVenc.Enabled = False
    
    If Me.SscEarlyTerm.Value = True Then
        TxtFechaRev.Enabled = True
        TXTPeriodo.Enabled = True
        CmbTipoPeriodo.Enabled = True
    Else
        TxtFechaRev.Enabled = False
        TXTPeriodo.Enabled = False
        CmbTipoPeriodo.Enabled = False
    End If
    
    Call Proc_Carga_Combos
    TxtFechaRev.Text = CDate(Format(gsBAC_Fecp, "dd/mm/yyyy"))
End Sub

Private Sub SscEarlyTerm_Click(Value As Integer)
    If Me.SscEarlyTerm.Value = True Then
        TxtFechaRev.Enabled = True
        TXTPeriodo.Enabled = True
        CmbTipoPeriodo.Enabled = True
    Else
        TxtFechaRev.Enabled = False
        TXTPeriodo.Enabled = False
        CmbTipoPeriodo.Enabled = False
    End If
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
     Dim Limpiar As String
     Dim Existe As Boolean
     Let Limpiar = ""
     Select Case Button.Index
        Case 1 'Grabar
                If Me.CmbModulo.Text = "" Or Me.TxtNumero.Text = "" Or Me.TxtFechaVenc.Text = "01/01/1000" Then
                    MsgBox "Debe Ingresar Modulo, Operacion y Fecha vencimiento para poder grabar.", vbInformation
                    Exit Sub
                End If
                
                Call Proc_Valida_Operaciones_Relacionadas(Existe)
                Call Proc_Valida_Operaciones(Existe)
                
                If Existe = True Then
                    Let Existe = False
                    Exit Sub
                End If
                
               Call Proc_Graba_Middle_Office
               Let Limpiar = "Todo"
               Call Proc_Limpiar(Limpiar)
        
        Case 2 'Limpiar
                Let Limpiar = "Todo"
                Call Proc_Limpiar(Limpiar)
             
        Case 3 'Eliminar
                If Me.CmbModulo.Text = "" Or Me.TxtNumero.Text = "" Or Me.CmbModulo.ListIndex = -1 Then
                    MsgBox "Debe Ingresar Modulo y Numero de  Operacion para poder Eliminar.", vbInformation
                    Exit Sub
                End If
        
                Call Proc_Elimina_Middle_Office
                Let Limpiar = "Todo"
                Call Proc_Limpiar(Limpiar)
                
        Case 4 'Reporte
        
                Call Limpiar_Cristal
                
                If Button.Index = 1 Then
                    BacControlFinanciero.CryFinanciero.Destination = 1
                Else
                    BacControlFinanciero.CryFinanciero.Destination = 0
                End If
                
                BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Rpt_Middled_Office.rpt"
                'BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Trim(Right(cmbTipOpe, 20))
                BacControlFinanciero.CryFinanciero.Connect = swConeccion
                BacControlFinanciero.CryFinanciero.Action = 1
                
                
        Case 5 ' Exportar Excel
                Call Proc_Genera_Excel
        Case 6 'Salir
                Unload Me
    End Select
End Sub


Private Sub Proc_Genera_Excel()
    On Error GoTo ErrorAction
    Dim cFile      As String
    Dim nFilas     As Long
    Dim pMiFila    As Long
    Dim MiFila     As Long
    Dim MiSheet    As Object
    Dim Respalda   As Boolean
    Dim DATOS()
    Dim Existe As Boolean
    Dim MiExcell As Object
   
    Respalda = False
    Screen.MousePointer = vbHourglass
    cFile = App.Path & "\RescataCartera.xlsx"
    cFile = "Middled_Office.xlsx"
    Command.Filter = ".xlsx"
    Command.CancelError = True

    Set MiExcell = CreateObject("Excel.Application")
    MiExcell.Application.Workbooks.Close
    Set MiLibro = MiExcell.Application.Workbooks.Add
    Set MiHoja = MiLibro.Sheets.Add
    Set MiSheet = MiExcell.Worksheets(1) '--> MiExcell.ActiveSheet
    MiSheet.Name = "Carteras"
   
    MiExcell.DisplayAlerts = False
    Call MiExcell.Worksheets(3).Delete
    Call MiExcell.Worksheets(2).Delete
    MiExcell.DisplayAlerts = True
   
    Dim nContador1 As Integer
    Envia = Array()
    'AddParam Envia, Trim(Right(CmbModulo.Text, 10))
    'AddParam Envia, IIf(Trim(TxtNumero.Text) = "", 0, Trim(TxtNumero.Text))
    
    If Not Bac_Sql_Execute("SP_RIEFIN_RPT_MIDDLED_OFFICE") Then
        Call MsgBox("Error." & vbCrLf & vbCrLf & "Se ha generado un error al intentar Leer.", vbInformation, App.Title)
        Exit Sub
    End If
    Let Existe = False
    Let MiFila = 1
    Do While Bac_SQL_Fetch(DATOS())
        Let Existe = True
        Let MiFila = MiFila + 1
        Let pMiFila = 1
        MiHoja.Cells(pMiFila, 1) = "Sistema"
        MiHoja.Cells(pMiFila, 2) = "Operación"
        MiHoja.Cells(pMiFila, 3) = "E.Term"
        MiHoja.Cells(pMiFila, 4) = "E.Term.Fecha"
        MiHoja.Cells(pMiFila, 5) = "E.Term.Periodo"
        MiHoja.Cells(pMiFila, 6) = "Periodo"
        MiHoja.Cells(pMiFila, 7) = "Relación"
        MiHoja.Cells(pMiFila, 8) = "Op.Relación"
        MiHoja.Cells(pMiFila, 9) = "Fecha Venc."
        
        
        MiHoja.Cells(MiFila, 1) = DATOS(1)
        MiHoja.Cells(MiFila, 2) = CDbl(DATOS(2))
        MiHoja.Cells(MiFila, 3) = DATOS(3)
        MiHoja.Cells(MiFila, 4) = DATOS(4)
        MiHoja.Cells(MiFila, 5) = CDbl(DATOS(5))
        MiHoja.Cells(MiFila, 6) = CDbl(DATOS(6))
        MiHoja.Cells(MiFila, 7) = DATOS(7)
        MiHoja.Cells(MiFila, 8) = CDbl(DATOS(8))
        MiHoja.Cells(MiFila, 9) = DATOS(9)
    Loop
   
    Call BacControlWindows(10)
    Screen.MousePointer = vbDefault
    MiExcell.DisplayAlerts = True
    On Error GoTo ErrorAction
    Command.CancelError = True
    Command.FileName = cFile
   
    Call Command.ShowSave
    
    MiExcell.DisplayAlerts = True
    
    Call MiHoja.SaveAs(Command.FileName)
    
    Screen.MousePointer = vbHourglass
    
   If Respalda = False Then
      Call MsgBox("Proceso Finalizado" & vbCrLf & vbCrLf & "Archivo ha sido almacenado en la ruta : " & vbCrLf & Command.FileName, vbInformation, App.Title)
   End If
     
   MiExcell.Visible = True
  
   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Set MiLibro = Nothing
   Set MiExcell = Nothing
   
  'Call MiLibro.Close
   
    Let Screen.MousePointer = vbDefault
    On Error GoTo 0
    
    Exit Sub
ErrorAction:
   Screen.MousePointer = vbDefault
   
 If Err.Number = 32755 Then
    MiExcell.DisplayAlerts = False
    MiExcell.Application.Quit
      Set MiSheet = Nothing
      Set MiHoja = Nothing
     'Call MiLibro.Close
      Set MiLibro = Nothing
      Set MiExcell = Nothing
      'MiExcell.Application.Quit
 Else
   
   If Err.Number = 70 Then
            
        MiExcell.Application.DisplayAlerts = False
        
        Call MiExcell.Application.Workbooks.Close
        MiExcell.Application.Quit
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            Exit Sub
            Resume
            Exit Sub
        End If
    End If
       If Err.Number = 1004 Then
        If MsgBox("Error de Escritura..." & vbCrLf & "Archivo existe, se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            
            Resume
        Else
            Respalda = True
            MiExcell.Application.DisplayAlerts = False
            MiLibro.Application.Workbooks.Close
            MiExcell.Application.Quit
            Screen.MousePointer = vbdefaul
            Exit Sub
        End If
             
       End If
      
      If Err.Number <> 0 Then
         Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
         Screen.MousePointer = vbDefault
         MiExcell.DisplayAlerts = False
         MiExcell.Application.Quit
      End If
   End If
   
    If Existe = False Then
        Call MsgBox("No existe información a consultar" & vbCrLf & vbCrLf & Err.Description, vbInformation, App.Title)
    Else
        Let Existe = False
    End If
   
End Sub


Sub Limpiar_Cristal()
   Dim I As Integer
   
   For I = 0 To 20
        BacControlFinanciero.CryFinanciero.StoredProcParam(I) = ""
        BacControlFinanciero.CryFinanciero.Formulas(I) = ""
   Next I
   
   BacControlFinanciero.CryFinanciero.WindowTitle = ""
   BacControlFinanciero.CryFinanciero.WindowState = crptNormal
   BacControlFinanciero.CryFinanciero.WindowBorderStyle = crptFixedDouble
   BacControlFinanciero.CryFinanciero.WindowControlBox = True
   BacControlFinanciero.CryFinanciero.WindowControls = True
   BacControlFinanciero.CryFinanciero.WindowTop = 75
   BacControlFinanciero.CryFinanciero.WindowLeft = 0
   BacControlFinanciero.CryFinanciero.WindowHeight = Screen.Height / Screen.TwipsPerPixelX - 102
   BacControlFinanciero.CryFinanciero.WindowWidth = Screen.Width / Screen.TwipsPerPixelY + 1
   BacControlFinanciero.CryFinanciero.Connect = swConeccion

End Sub



Private Sub TxtNumero_DblClick()
    Dim Limpiar As String
    '  Operacion_Midd = "Op_Derivados"
    '  BacAyuda_DRV.Tag = Trim(Right(CmbModulo.Text, 10))
    
    BacAyuda_DRV.Sistema = Trim(Right(CmbModulo.Text, 10))
    If CmbModulo.ListIndex <> -1 Then
        BacAyuda_DRV.Show 1
    End If
    
    If giAceptar Then
        Let TxtNumero.Text = Operacion_DRV 'Numero Operacion
        Let TxtFechaVenc.Text = FechaVenc_DRV 'Fecha Vencimiento
        Let Me.LblCliente.Caption = Clie_Operacion_Midd
        Let Operacion_DRV = ""
        Let FechaVenc_DRV = 0
        Let Clie_Operacion_Midd = ""
    End If
    Limpiar = ""
    Call Proc_Limpiar(Limpiar)
    
    Call Proc_Consulta_Middle_Office
    
   
End Sub

Private Sub Proc_Valida_Operaciones(Existe As Boolean)
    Dim DATOS()
    Dim NomProc      As String
    
    Envia = Array()
    AddParam Envia, Trim(Right(CmbModulo.Text, 10))
    AddParam Envia, Trim(Me.TxtNumero.Text)
    NomProc = "SP_RIEFIN_VALIDA_OPERACION_DRV"
    
    If Not Bac_Sql_Execute(NomProc, Envia) Then
       Exit Sub
    End If
    Dim X As ListItem
    Do While Bac_SQL_Fetch(DATOS())
    
    If Trim(DATOS(1)) = -1 Then
        Call MsgBox(DATOS(2), vbInformation, App.Title)
        Let Me.LblCliente.Caption = ""
        Let TxtFechaVenc.Text = "01/01/1000"
         Let Existe = True
        Exit Sub
    Else
        Let LblEstado.Caption = "Insertando"
        Let LblCliente.Caption = ""
        Let TxtFechaVenc.Text = "01/01/1000"
        Let LblCliente.Caption = Trim(DATOS(1))
        Let TxtFechaVenc.Text = CDate(Format(Trim(DATOS(2)), "dd/mm/yyyy")) 'Trim(DATOS(2)) 'Fecha Vencimiento
    End If
    Loop
      
End Sub


Private Sub Proc_Valida_Operaciones_Relacionadas(Existe As Boolean)
    Dim DATOS()
    Dim NomProc      As String
    
    Envia = Array()
    AddParam Envia, Trim(Right(CmbModuloR.Text, 10))
    AddParam Envia, Trim(Me.TxtNumeroR.Text)
    NomProc = "SP_RIEFIN_VALIDA_OPERACION_DRV"
    
    If Not Bac_Sql_Execute(NomProc, Envia) Then
       Exit Sub
    End If
    Dim X As ListItem
    Do While Bac_SQL_Fetch(DATOS())
    
    If Trim(DATOS(1)) = -1 Then
        Call MsgBox(DATOS(2), vbInformation, App.Title)
        Let Existe = True
        Exit Sub
    End If
    Loop
      
End Sub




Private Sub TxtNumero_KeyPress(KeyAscii As Integer)
    Dim Limpiar As String
    Dim Existe As Boolean

    If KeyAscii = vbKeyReturn Then
    
        If Me.TxtNumero.Text = "" Then
            BacAyuda_DRV.Sistema = Trim(Right(CmbModulo.Text, 10))
            If CmbModulo.ListIndex <> -1 Then
            BacAyuda_DRV.Show 1
            End If
        
            If giAceptar Then
                Let TxtNumero.Text = Operacion_DRV 'Numero Operacion
                Let TxtFechaVenc.Text = FechaVenc_DRV 'Fecha Vencimiento
                Let LblCliente.Caption = Clie_Operacion_Midd
                Let Operacion_DRV = ""
                Let FechaVenc_DRV = 0
                Let Clie_Operacion_Midd = ""
            End If
        Else
            Call Proc_Valida_Operaciones(Existe)
            Limpiar = ""
            Call Proc_Limpiar(Limpiar)
            If Existe = True Then
                Let Existe = False
                Exit Sub
            End If
        
        End If
        
        Call Proc_Consulta_Middle_Office
       
    End If
    
'    Limpiar = ""
'    Call Proc_Limpiar(Limpiar)
'    Call Proc_Consulta_Middle_Office

    Cadena = "0123456789" + Chr(8)  'chr(8) = delete, es decir admitimos borrar
    If InStr(Cadena, Chr(KeyAscii)) = 0 Then
        KeyAscii = 0
    End If
          
End Sub


Private Sub TxtNumeroR_DblClick()
    
    
    BacAyuda_DRV.Sistema = Trim(Right(CmbModuloR.Text, 10))
    
    If CmbModuloR.ListIndex <> -1 And Trim(Right(CmbModuloR.Text, 10)) <> "OTR" Then
        BacAyuda_DRV.Show 1
    End If
    
    If giAceptar Then
      TxtFechaVenc.Text = ""
      Let TxtNumeroR.Text = Operacion_DRV 'Numero Operacion
      Let Operacion_DRV = ""
    End If
       
End Sub


Private Sub TxtNumeroR_KeyPress(KeyAscii As Integer)
    Dim Cadena As String
    Dim Existe As Boolean
     
     If KeyAscii = vbKeyReturn Then
    
        If Me.TxtNumeroR.Text = "" Then
            BacAyuda_DRV.Sistema = Trim(Right(CmbModuloR.Text, 10))
            If CmbModuloR.ListIndex <> -1 And Trim(Right(CmbModuloR.Text, 10)) <> "OTR" Then
                BacAyuda_DRV.Show 1
            End If
        
            If giAceptar Then
                Let TxtNumeroR.Text = Operacion_DRV 'Numero Operacion
                Let Operacion_DRV = ""
            End If
        Else
            Call Proc_Valida_Operaciones_Relacionadas(Existe)
            'TxtNumeroR.Text = ""
        End If
       
    End If
    
    Cadena = "0123456789" + Chr(8)       'chr(8) = delete, es decir admitimos borrar
    If InStr(Cadena, Chr(KeyAscii)) = 0 Then
        KeyAscii = 0
    End If

End Sub


