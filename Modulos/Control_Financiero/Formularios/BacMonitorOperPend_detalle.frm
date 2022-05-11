VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMonitorOperPend_Detalle 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Detalle de Operación"
   ClientHeight    =   6735
   ClientLeft      =   -750
   ClientTop       =   495
   ClientWidth     =   10290
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6735
   ScaleWidth      =   10290
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10200
      _ExtentX        =   17992
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Traspaso"
            Object.ToolTipText     =   "Traspaso Linea desde Otro Sistema"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "3"
            ImageIndex      =   7
         EndProperty
      EndProperty
      OLEDropMode     =   1
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   2355
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   7
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMonitorOperPend_detalle.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMonitorOperPend_detalle.frx":0452
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMonitorOperPend_detalle.frx":076C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMonitorOperPend_detalle.frx":0A86
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMonitorOperPend_detalle.frx":0ED8
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMonitorOperPend_detalle.frx":11F2
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMonitorOperPend_detalle.frx":1644
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2745
      Left            =   0
      TabIndex        =   1
      Top             =   1710
      Width           =   10245
      _Version        =   65536
      _ExtentX        =   18071
      _ExtentY        =   4842
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   2
      Begin Threed.SSFrame SSFrame1 
         Height          =   2535
         Left            =   105
         TabIndex        =   2
         Top             =   60
         Width           =   10020
         _Version        =   65536
         _ExtentX        =   17674
         _ExtentY        =   4471
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin MSFlexGridLib.MSFlexGrid grilla 
            Height          =   2370
            Left            =   30
            TabIndex        =   3
            TabStop         =   0   'False
            Top             =   120
            Width           =   9945
            _ExtentX        =   17542
            _ExtentY        =   4180
            _Version        =   393216
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483636
            GridColor       =   16777215
            GridColorFixed  =   16777215
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
         End
      End
   End
   Begin Threed.SSPanel SSPanel4 
      Height          =   285
      Left            =   45
      TabIndex        =   4
      Top             =   4575
      Width           =   10155
      _Version        =   65536
      _ExtentX        =   17903
      _ExtentY        =   503
      _StockProps     =   15
      Caption         =   "Mensaje de Error en Lineas"
      ForeColor       =   8388608
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   5
      FloodColor      =   8388608
      Font3D          =   2
      Alignment       =   8
   End
   Begin Threed.SSPanel SSPanel3 
      Height          =   1185
      Left            =   0
      TabIndex        =   6
      Top             =   570
      Width           =   10245
      _Version        =   65536
      _ExtentX        =   18071
      _ExtentY        =   2090
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   2
      Begin Threed.SSFrame SSFrame3 
         Height          =   960
         Left            =   105
         TabIndex        =   7
         Top             =   60
         Width           =   10020
         _Version        =   65536
         _ExtentX        =   17674
         _ExtentY        =   1693
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.Label LabProducto 
            BackColor       =   &H00E0E0E0&
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
            Height          =   315
            Left            =   4395
            TabIndex        =   16
            Top             =   195
            Width           =   2595
         End
         Begin VB.Label Label1 
            Caption         =   "Producto"
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
            Left            =   3240
            TabIndex        =   15
            Top             =   180
            Width           =   1155
         End
         Begin VB.Label Label5 
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   7125
            TabIndex        =   14
            Top             =   195
            Width           =   1155
         End
         Begin VB.Label LabOperador 
            BackColor       =   &H00E0E0E0&
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
            Height          =   315
            Left            =   8295
            TabIndex        =   13
            Top             =   210
            Width           =   1575
         End
         Begin VB.Label LabNombre 
            BackColor       =   &H00E0E0E0&
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
            Height          =   315
            Left            =   4395
            TabIndex        =   5
            Top             =   555
            Width           =   5475
         End
         Begin VB.Label Label3 
            Caption         =   "Cliente"
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
            Left            =   3240
            TabIndex        =   12
            Top             =   555
            Width           =   1155
         End
         Begin VB.Label Label2 
            Caption         =   "Numero Operación"
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
            Left            =   100
            TabIndex        =   11
            Top             =   555
            Width           =   1755
         End
         Begin VB.Label LabNumoper 
            BackColor       =   &H00E0E0E0&
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
            Height          =   315
            Left            =   1900
            TabIndex        =   10
            Top             =   555
            Width           =   1170
         End
         Begin VB.Label Label4 
            Caption         =   "Sistema"
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
            Left            =   100
            TabIndex        =   9
            Top             =   200
            Width           =   1155
         End
         Begin VB.Label LabSistema 
            BackColor       =   &H00E0E0E0&
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
            Height          =   315
            Left            =   1900
            TabIndex        =   8
            Top             =   200
            Width           =   1170
         End
      End
   End
   Begin Threed.SSPanel SSPanel2 
      Height          =   1860
      Left            =   0
      TabIndex        =   17
      Top             =   4815
      Width           =   10245
      _Version        =   65536
      _ExtentX        =   18071
      _ExtentY        =   3281
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   2
      Begin Threed.SSFrame SSFrame2 
         Height          =   1620
         Left            =   120
         TabIndex        =   18
         Top             =   60
         Width           =   10020
         _Version        =   65536
         _ExtentX        =   17674
         _ExtentY        =   2857
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin MSFlexGridLib.MSFlexGrid grilla_error 
            Height          =   1455
            Left            =   30
            TabIndex        =   19
            TabStop         =   0   'False
            Top             =   120
            Width           =   9945
            _ExtentX        =   17542
            _ExtentY        =   2566
            _Version        =   393216
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483636
            GridColor       =   16777215
            GridColorFixed  =   16777215
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
         End
      End
   End
   Begin VB.Label LabMonto 
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "No borrar"
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
      Left            =   2625
      TabIndex        =   22
      Top             =   7035
      Visible         =   0   'False
      Width           =   1170
   End
   Begin VB.Label LabCod 
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "No borrar"
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
      Left            =   1425
      TabIndex        =   21
      Top             =   7020
      Visible         =   0   'False
      Width           =   1170
   End
   Begin VB.Label LabRut 
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "No borrar"
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
      Left            =   195
      TabIndex        =   20
      Top             =   7020
      Visible         =   0   'False
      Width           =   1170
   End
End
Attribute VB_Name = "BacMonitorOperPend_Detalle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cSistema As String
Dim nNumoper As Double
Dim Aprueba  As Integer

Sub LlenarGrilla()

    With grilla
    
        .Rows = 3
        .Cols = 10
        .FixedCols = 0
        .FixedRows = 2
        .GridLinesFixed = flexGridNone
        
        .TextMatrix(0, 0) = "Número"
        .TextMatrix(1, 0) = "Documento"
        
        .TextMatrix(0, 1) = "Correlativo"
        .TextMatrix(1, 1) = ""
        
        .TextMatrix(0, 2) = "Rut"
        .TextMatrix(1, 2) = "Cliente"
        
        .TextMatrix(0, 3) = "Codigo"
        .TextMatrix(1, 3) = "Cliente"
        
        .TextMatrix(0, 4) = "Cliente"
        .TextMatrix(1, 4) = "Linea"
        
        .TextMatrix(0, 5) = "Monto"
        .TextMatrix(1, 5) = ""
        
        .TextMatrix(0, 6) = "Fecha"
        .TextMatrix(1, 6) = "Vencimiento"
        
        .TextMatrix(0, 7) = "Error"
        .TextMatrix(1, 7) = ""
        
        .TextMatrix(0, 8) = "Exceso_Sis"
        .TextMatrix(1, 8) = ""
        
        .TextMatrix(0, 9) = "Exceso_Gen"
        .TextMatrix(1, 9) = ""
        
        
        .ColWidth(0) = 1000
        .ColWidth(1) = 1000
        .ColWidth(2) = 0
        .ColWidth(3) = 0
        .ColWidth(4) = 3600
        .ColWidth(5) = 2000
        .ColWidth(6) = 1200
        .ColWidth(7) = 1000
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .RowHeight(0) = 370
        .Rows = .FixedRows
        
        For m = 0 To .Rows - 1
            For mm = 0 To .Cols - 1
                .Col = mm
                .Row = m
                .CellFontBold = True
                .GridLinesFixed = flexGridNone
            Next mm
        Next m
        
        .FocusRect = flexFocusHeavy
        .Enabled = False
        
    End With
   
End Sub

Sub CargarGrilla()
    
    Dim datos()
    Dim I, SW, m, mm         As Integer
    Dim Mensaje, id_sis        As String
    
    Mensaje = ""
    id_sis = ""
    F = 0
    j = 0
    
    'Ingresa datos de la tabla a la grilla
    
    cSistema = BacMonitorOperPend.grilla.TextMatrix(BacMonitorOperPend.grilla.Row, 0)
    nNumoper = Val(BacMonitorOperPend.grilla.TextMatrix(BacMonitorOperPend.grilla.Row, 6))
    
    Envia = Array(cSistema, nNumoper)
    
    If Not Bac_Sql_Execute("Sp_Lineas_LeerOpPendientes_Detalle", Envia) Then
        Exit Sub
    Else
        
        I = 2
        With grilla
        
            SW = 0
            
            Do While Bac_SQL_Fetch(datos())
            
                SW = 1
                .Rows = .Rows + 1
                I = .Rows - 1
                .RowHeight(I) = 315
                
                .TextMatrix(I, 0) = datos(2)    'numdocu
                .TextMatrix(I, 1) = datos(3)    'correla
                .TextMatrix(I, 2) = datos(4)    'rut cliente
                .TextMatrix(I, 3) = datos(5)    'Codigo cliente
                .TextMatrix(I, 4) = datos(6)    'Cliente  Linea
                .TextMatrix(I, 5) = Format(datos(7), FDecimal)     'Monto
                .TextMatrix(I, 6) = datos(8)     'Fecha de Vcto.
                .TextMatrix(I, 7) = datos(9)     'Error
                .TextMatrix(I, 8) = CDbl(datos(10))     'Monto Exceso Sistema
                .TextMatrix(I, 9) = CDbl(datos(11))     'Monto Exceso General
            
            Loop
            
            If SW = 0 Then
                MsgBox "No Existe Información", vbCritical, TITSISTEMA
                Toolbar1.Buttons(1).Enabled = False
            Else
            
            
            Aprueba = True
            For m = 0 To .Rows - 1
                For mm = 0 To .Cols - 1
                    .Col = mm
                    .Row = m
                    
                    If .TextMatrix(m, 7) = "SI" Then
                        .CellForeColor = vbRed
                        Aprueba = False
                    End If
                
                Next mm
            Next m
            
            
            grilla.Row = .FixedRows
            grilla.Col = 1
            grilla.Enabled = True
            
            Call LlenarGrilla_Error
            Call Cargargrilla_error
            
            End If
        
        End With
    
    End If
    
    
    LabSistema = BacMonitorOperPend.grilla.TextMatrix(BacMonitorOperPend.grilla.Row, 0)
    LabNumoper = BacMonitorOperPend.grilla.TextMatrix(BacMonitorOperPend.grilla.Row, 6)
    LabNombre = BacMonitorOperPend.grilla.TextMatrix(BacMonitorOperPend.grilla.Row, 7)
    LabProducto = BacMonitorOperPend.grilla.TextMatrix(BacMonitorOperPend.grilla.Row, 1)
    LabOperador = BacMonitorOperPend.grilla.TextMatrix(BacMonitorOperPend.grilla.Row, 8)

End Sub
Sub Traspaso_Linea()
    
    Dim datos()
    Dim nRutCli As Double
    Dim nCodCli As Double
    Dim nMonot  As Double
    
   
    'Ingresa datos de la tabla a la grilla_error
    
    nRutCli = Val(grilla.TextMatrix(grilla.Row, 2))
    nCodCli = Val(grilla.TextMatrix(grilla.Row, 3))
    nMonto = CDbl(grilla.TextMatrix(grilla.Row, 8))
    
    Envia = Array(cSistema, nRutCli, nCodCli, nMonto)
    
    If Not Bac_Sql_Execute("Sp_Lineas_DisponibleTraspaso", Envia) Then
        Exit Sub
    Else
    
        Do While Bac_SQL_Fetch(datos())
            If datos(1) = "NO" Then
                MsgBox datos(2), vbCritical, TITSISTEMA
                Exit Sub
            End If
        
        Loop
    
    End If
    
    LabRut.Caption = nRutCli
    LabCod.Caption = nCodCli
    LabMonto.Caption = nMonto
    
    BacMonitorOperPend_Traspaso.Show vbModal
    
    Call LlenarGrilla
    Call CargarGrilla

End Sub

Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   
   Me.Top = BacMonitorOperPend.Top + 350
   Me.Left = BacMonitorOperPend.Left + 400
   
   Aprueba = False
   
   Call LlenarGrilla
   Call CargarGrilla
End Sub

Private Sub Form_Unload(Cancel As Integer)
Dim sLineas  As String
Dim sLimites As String

    If Aprueba Then

        cSistema = LabSistema
        nNumoper = Val(LabNumoper)
        sLineas = Mid(BacMonitorOperPend.Tag, 1, 1)
        sLimites = Mid(BacMonitorOperPend.Tag, 2, 1)
        
        Envia = Array(gsBAC_Fecp, cSistema, nNumoper, gsBAC_User, sLimites, sLineas)

        If Not Bac_Sql_Execute("Sp_Lineas_Autoriza", Envia) Then
            MsgBox "Problemas al Autorizar Operación", vbCritical, TITSISTEMA
            Exit Sub
        End If
        
        MsgBox "Operación Aprobada Correctamente", vbInformation, TITSISTEMA
    
    End If
    
    
End Sub

Private Sub grilla_Click()

   Call LlenarGrilla_Error
   Call Cargargrilla_error

End Sub

Sub LlenarGrilla_Error()

    With grilla_error
    
        .Rows = 3
        .Cols = 1
        .FixedCols = 0
        .FixedRows = 1       '2
        .GridLinesFixed = flexGridNone
        
        .TextMatrix(0, 0) = "Mensaje de Error"
        .TextMatrix(1, 0) = ""
        
        .ColWidth(0) = 9800
        .RowHeight(0) = 370
        .Rows = .FixedRows
        
        For m = 0 To .Rows - 1
            For mm = 0 To .Cols - 1
                .Col = mm
                .Row = m
                .CellFontBold = True
                .GridLinesFixed = flexGridNone
            Next mm
        Next m
        
        .FocusRect = flexFocusHeavy
        .Enabled = False
        
    End With

End Sub


Sub Cargargrilla_error()
    
    Dim datos()
    Dim SW           As Integer
    Dim I            As Integer
    Dim Mensaje      As String
    
    Mensaje = ""
    
    'Ingresa datos de la tabla a la grilla_error
    
    nNumdocu = Val(grilla.TextMatrix(grilla.Row, 0))
    nCorrela = Val(grilla.TextMatrix(grilla.Row, 1))
    
    Envia = Array(cSistema, nNumoper, nNumdocu, nCorrela)
    
    If Not Bac_Sql_Execute("Sp_Lineas_ErrorDetalle", Envia) Then
        Exit Sub
    Else
    
        I = 2
        With grilla_error
        
            SW = 0
            
            Do While Bac_SQL_Fetch(datos())
                SW = 1
                .Rows = .Rows + 1
                I = .Rows - 1
                .RowHeight(I) = 315
                
                If Val(datos(2)) > 0 Then
                    Mensaje = " en  $ " + Format(datos(2), FDecimal)
                Else
                    Mensaje = ""
                End If
                
                .TextMatrix(I, 0) = Trim(datos(1)) + Mensaje   'glosa del sistema
                
            Loop
            
            
            If SW <> 0 Then
                grilla_error.Row = .FixedRows
                grilla_error.Col = 0
                grilla_error.Enabled = True
            End If
        
        End With
        
    End If
    

End Sub

Private Sub grilla_RowColChange()
    
    Call LlenarGrilla_Error
    Call Cargargrilla_error
    
    If Val(grilla.TextMatrix(grilla.Row, 8)) = 0 Then
        Toolbar1.Buttons(1).Enabled = False
    Else
        Toolbar1.Buttons(1).Enabled = True
    End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      Case Is = "Salir"
         Unload Me
      Case Is = "Traspaso"
         Call Traspaso_Linea
      Case Else
         MsgBox Button.Key & " Operación", vbInformation, TITSISTEMA
   End Select
   
End Sub
