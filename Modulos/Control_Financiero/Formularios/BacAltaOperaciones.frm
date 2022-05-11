VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BacAltaOperaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Alta de Operaciones"
   ClientHeight    =   4980
   ClientLeft      =   1620
   ClientTop       =   1800
   ClientWidth     =   11985
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4980
   ScaleWidth      =   11985
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   12285
      Top             =   210
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacAltaOperaciones.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacAltaOperaciones.frx":0EDA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel PanelMonitoreo 
      Height          =   6105
      Left            =   0
      TabIndex        =   1
      Top             =   405
      Width           =   12105
      _Version        =   65536
      _ExtentX        =   21352
      _ExtentY        =   10769
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
         Height          =   4515
         Left            =   105
         TabIndex        =   2
         Top             =   60
         Width           =   11880
         _Version        =   65536
         _ExtentX        =   20955
         _ExtentY        =   7964
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
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   4290
            Left            =   30
            TabIndex        =   0
            TabStop         =   0   'False
            Top             =   165
            Width           =   11820
            _ExtentX        =   20849
            _ExtentY        =   7567
            _Version        =   393216
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            GridColor       =   16777215
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            SelectionMode   =   1
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
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   11985
      _ExtentX        =   21140
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Aprobar"
            Description     =   "Aprobar"
            Object.ToolTipText     =   "Aprobar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Rechazar"
            Description     =   "Rechazar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      OLEDropMode     =   1
   End
End
Attribute VB_Name = "BacAltaOperaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sw_Sel As Integer
Dim X As Integer
Dim C As Integer
Dim GrillaLista As Boolean

Const iColSistema = 0
Const iColProducto = 1
Const iColNumeroOperacion = 2
Const iColNombreCliente = 3
Const iColMoneda = 4
Const iColMonto = 5
Const iColFechaInicio = 6
Const iNumeroColumnas = 7

Sub Refrescar()
    Call CargarGrilla
    If Grilla.Rows > Grilla.FixedRows Then
        Grilla.SetFocus
    End If

End Sub

Sub LlenarGrilla()

    With Grilla
    
        .Rows = 3
        .Cols = iNumeroColumnas
        .FixedCols = 0
        .FixedRows = 2
        
        .TextMatrix(0, 0) = "Sistema"
        .TextMatrix(1, 0) = ""
        
        .TextMatrix(0, 1) = "Tipo"
        .TextMatrix(1, 1) = "Producto"
        
        .TextMatrix(0, 2) = "Número"
        .TextMatrix(1, 2) = "Operación"
        
        .TextMatrix(0, 3) = "Nombre"
        .TextMatrix(1, 3) = "Cliente"
        
        .TextMatrix(0, 4) = "Moneda"
        .TextMatrix(1, 4) = ""
        
        .TextMatrix(0, 5) = "Monto"
        .TextMatrix(1, 5) = "Original"
        
        .TextMatrix(0, 6) = "Fecha Inicio"
        .TextMatrix(1, 6) = ""
                              
        .ColWidth(iColSistema) = 850
        .ColWidth(iColProducto) = 4600
        .ColWidth(iColNumeroOperacion) = 1000
        .ColWidth(iColNombreCliente) = 4000
        .ColWidth(iColMoneda) = 0
        .ColAlignment(iColMonto) = flexAlignCenterCenter
        .ColAlignment(iColFechaInicio) = flexAlignRightCenter
        
        .ColWidth(iColMonto) = 2100
        .ColWidth(iColFechaInicio) = 1500
        .RowHeightMin = 370
        .Rows = .FixedRows
        .Enabled = False
        Call Formato_Grilla(Grilla)
       .FocusRect = flexFocusLight

    End With
    
End Sub

Sub Rebajar_Operacion()
Dim Datos()
Dim Indice          As Long
Dim cMensaje        As String
Dim sApruebaLineas  As String
Dim sApruebaLimites As String
Dim sApruebaTasas   As String
Dim sApruebaGrupos  As String
Dim nMontoLineas    As String
   
    On Error Resume Next
    
    If Sw_Sel = 0 Then
        MsgBox "Seleccione una Operación", vbInformation, TITSISTEMA
        
        If Grilla.Enabled Then
           Grilla.SetFocus
        End If
        Exit Sub
    
    End If
   
    If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumeroOperacion)) Then
        Exit Sub
    End If
                
    cSistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
    nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumeroOperacion))
            
    Envia = Array()
    AddParam Envia, gsBAC_Fecp
    AddParam Envia, cSistema
    AddParam Envia, nNumoper

    If Not Bac_Sql_Execute("Sp_Lineas_Anula", Envia) Then
       MsgBox "No se pudo Rebajar Líneas", vbInformation, "Rebaja de Operaciones"
    End If
    
    '********************************
    'ENDEUDAMIENTO
    '********************************
    Envia = Array()
    AddParam Envia, cSistema
    AddParam Envia, nNumoper
    AddParam Envia, 0

    If Not Bac_Sql_Execute("sp_rebaja_Endeudamiento", Envia) Then
       MsgBox "No se pudo anular Endeudamiento atribuidas a la operacion", vbInformation, "Anulacion de Endeudamiento"
    End If
             
    Call LlenarGrilla
    Call CargarGrilla

End Sub

Sub CargarGrilla(Optional SwCarga As Boolean)
On Error Resume Next
    Dim Datos()
    Dim PosicionActual As Long
    Dim Indice        As Long

      If Not Bac_Sql_Execute("Sp_LeerOperacionesAlta") Then
         MsgBox "Problemas en la Consulta", vbExclamation, TITSISTEMA
         Exit Sub
      End If
      
      With Grilla
         .Redraw = False
         .Rows = .FixedRows
         SwCarga = False
         
         Do While Bac_SQL_Fetch(Datos())
           .Rows = .Rows + 1
           SwCarga = True
           .TextMatrix(.Rows - 1, iColSistema) = Datos(1)                           'Identificacion sistema
           .TextMatrix(.Rows - 1, iColProducto) = Datos(2)                          'Producto
           .TextMatrix(.Rows - 1, iColNumeroOperacion) = Format(Datos(3), FEntero)  'Numoper
           .TextMatrix(.Rows - 1, iColNombreCliente) = Datos(4)                     'Cliente
           .TextMatrix(.Rows - 1, iColMoneda) = Datos(5)                            'Moneda
           .TextMatrix(.Rows - 1, iColMonto) = Format(Datos(6), IIf(Datos(5) = "$", FEntero, FDecimal)) 'Monto
           .TextMatrix(.Rows - 1, iColFechaInicio) = Datos(7)                       'Fecha Inicio
                      
         Loop
         
         If SwCarga = False Then
            MsgBox "No Existe Información", vbExclamation, TITSISTEMA
            Toolbar1.Buttons(1).Enabled = False
         Else
            .Redraw = True
            .Row = .FixedRows
            .Col = 1
            .Enabled = True
            .FocusRect = flexFocusNone
            Sw_Sel = 0
            .Col = 0
            Toolbar1.Buttons(1).Enabled = True
            
         End If
         
      End With

   On Error GoTo 0
End Sub

Private Sub Form_Load()
   Move 0, 0
   Me.Icon = BacControlFinanciero.Icon
   Toolbar1.Buttons(1).Enabled = False  'Aprobar
   Call LlenarGrilla
   Call CargarGrilla
   
End Sub

Private Sub grilla_Click()
    Sw_Sel = 1
    Toolbar1.Buttons(1).Enabled = True
    
End Sub

Private Sub SSTab1_Click(PreviousTab As Integer)
   If Grilla.Enabled Then
      Grilla.SetFocus
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
          Case 1
               Call Rebajar_Operacion
               
          Case 2
               Unload Me
               
   End Select
   
End Sub
