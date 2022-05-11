VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMatrizAtri 
   Appearance      =   0  'Flat
   BackColor       =   &H80000004&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Matriz de Atribuciones por Operador en Pesos"
   ClientHeight    =   4695
   ClientLeft      =   -1545
   ClientTop       =   1455
   ClientWidth     =   10365
   Icon            =   "BacMatrizAtri.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4695
   ScaleWidth      =   10365
   ShowInTaskbar   =   0   'False
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
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatrizAtri.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatrizAtri.frx":0EE6
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatrizAtri.frx":1DC0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatrizAtri.frx":2C9A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMatrizAtri.frx":3B74
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4245
      Left            =   -30
      TabIndex        =   0
      Top             =   480
      Width           =   10455
      _Version        =   65536
      _ExtentX        =   18441
      _ExtentY        =   7488
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
      BevelOuter      =   0
      BevelInner      =   2
      Begin BACControles.TXTNumero texto 
         Height          =   255
         Left            =   2400
         TabIndex        =   11
         Top             =   2520
         Visible         =   0   'False
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   450
         BackColor       =   12632256
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox CmbSistema 
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
         Left            =   1905
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   480
         Width           =   4860
      End
      Begin VB.ComboBox cmbPro 
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
         Left            =   1905
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   840
         Width           =   4860
      End
      Begin VB.ComboBox cmbTipOpe 
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
         Left            =   1905
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   150
         Width           =   3540
      End
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   2115
         Left            =   120
         TabIndex        =   4
         Top             =   2055
         Width           =   10140
         _ExtentX        =   17886
         _ExtentY        =   3731
         _Version        =   393216
         RowHeightMin    =   315
         BackColor       =   -2147483644
         BackColorBkg    =   -2147483636
         GridColorFixed  =   16777215
         Enabled         =   0   'False
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
      End
      Begin Threed.SSPanel SSPanel2 
         Height          =   30
         Left            =   90
         TabIndex        =   7
         Top             =   1575
         Width           =   10170
         _Version        =   65536
         _ExtentX        =   17939
         _ExtentY        =   53
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
      End
      Begin Threed.SSPanel SSPanel3 
         Height          =   270
         Left            =   120
         TabIndex        =   10
         Top             =   1680
         Width           =   10110
         _Version        =   65536
         _ExtentX        =   17833
         _ExtentY        =   476
         _StockProps     =   15
         Caption         =   "  Producto"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
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
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
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
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   9
         Top             =   480
         Width           =   630
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
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
         Height          =   195
         Left            =   240
         TabIndex        =   6
         Top             =   840
         Width           =   780
      End
      Begin VB.Label Label1 
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
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   5
         Top             =   150
         Width           =   795
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   10365
      _ExtentX        =   18283
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
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
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "BacMatrizAtri.frx":3E8E
      OLEDropMode     =   1
   End
End
Attribute VB_Name = "BacMatrizAtri"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Grilla          As Variant
Dim ValNue          As String
Dim ValAnt          As String
Dim xCmbIntValor    As Integer

Sub Busca()
    Dim I%
    Dim Datos()
        
    If Trim(cmbTipOpe) <> "" And Trim(cmbPro) = "" Then
       Exit Sub
    End If
    
    Envia = Array(Trim(Right(cmbTipOpe, 20)), _
                 Trim(Right(Mid(cmbPro, 1, Len(cmbPro) - 50), 10)))
       
    If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_BUSCAPRODUCTOS", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Sub
    End If
    
    Grid1.Rows = Grid1.FixedRows
    
    Do While Bac_SQL_Fetch(Datos())
        Grid1.Rows = Grid1.Rows + 1
        Grid1.Row = Grid1.Rows - 1
        Grid1.TextMatrix(Grid1.Row, 0) = Format(Datos(3), FEntero)
        Grid1.TextMatrix(Grid1.Row, 1) = Format(Datos(4), FEntero)
        Grid1.TextMatrix(Grid1.Row, 2) = Format(Datos(5), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 3) = Format(Datos(6), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 4) = Format(Datos(7), FDecimal)
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    Loop
    
    If Grid1.Rows = Grid1.FixedRows Then
        Call InsertarRow(Grid1)
    End If
    
    Grid1.Col = 0
    Grid1.Row = Grid1.FixedRows
    
End Sub

Sub Graba()
    
    Dim I%
    Dim Datos()
    Dim Error As Boolean
    Error = False
    If cmbTipOpe.ListIndex = -1 Then
        Error = True
    End If
    
    If cmbPro.ListIndex = -1 Then
        Error = True
    End If
        
    For I% = 2 To Grid1.Rows - 1
        If CDbl(Format(Grid1.TextMatrix(I%, 1), FEntero)) <= CDbl(Format(Grid1.TextMatrix(I%, 0), FEntero)) Then
            Error = True
            Exit For
        End If
    Next I%
    
    If Error = True Then
        GoTo Errorr
    End If
    
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
       MsgBox "Error en Begin Transaction", vbCritical, TITSISTEMA
       Exit Sub
    End If
    
        
    Envia = Array(Trim(Right(cmbTipOpe, 20)), _
                  Trim(Right(Mid(cmbPro, 1, Len(cmbPro) - 50), 10)))
                  
    
    If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_ELIMINAPRODUCTOS", Envia) Then
         
        Envia = Array("R")
        
        If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
            MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
            Exit Sub
        End If
       
       MsgBox "Problema con la Comunicacion de Cliente Servidor", vbCritical, TITSISTEMA
       
       Exit Sub
    
    End If
        
    For I% = 2 To Grid1.Rows - 1
          If Grid1.TextMatrix(I%, 2) <> "" And Grid1.TextMatrix(I%, 3) <> "" Then
         Envia = Array(Trim(Right(cmbTipOpe, 20)), _
                       Trim(Right(CmbSistema, 20)), _
                       Trim(Right(Mid(cmbPro, 1, Len(cmbPro) - 50), 10)), _
                       CDbl(Grid1.TextMatrix(I%, 0)), _
                       CDbl(Grid1.TextMatrix(I%, 1)), _
                       CDbl(Grid1.TextMatrix(I%, 2)), _
                       CDbl(Grid1.TextMatrix(I%, 3)), _
                       CDbl(IIf(Grid1.TextMatrix(I%, 4) = "", 0, Grid1.TextMatrix(I%, 4))))
        
        If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_GRABAPRODUCTOS", Envia) Then
            
            Envia = Array("R")
            
            If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
                
                MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
                Grid1.SetFocus
                
                Exit Sub
            
            End If
            
            MsgBox "No se puede Grabar problema con la comunicacion", vbCritical, TITSISTEMA
            Grid1.SetFocus
            
            Exit Sub
        
        End If
    Else
            MsgBox "Debe Ingresar Valores !!!!", vbCritical
            Exit Sub
    End If
    Next I%
   
    Envia = Array("C")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
        MsgBox "Error en Commit Transaction", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    MsgBox "Grabación Realizada con Exito", vbInformation, TITSISTEMA
    
    Call GRABA_LOG_AUDITORIA("1", (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10003", "01", "GRABA MATRIZ DE RIESGO ;INSTRUMENTO Y ATRIBUCIONES", "MATRIZ_ATRIBUCION_INSTRUMENTO;MATRIZ_ATRIBUCION", ValNue, "")
    Call CargarGrid
    cmbTipOpe.SetFocus
    Exit Sub
Errorr:
MsgBox "Datos Mal Ingresados Verifique", vbCritical, TITSISTEMA
    If cmbTipOpe.Enabled = False Then
        Grid1.SetFocus
    Else
        cmbTipOpe.SetFocus
    End If

End Sub

Sub Elimina()
   
    res = MsgBox("Esta seguro que desea Eliminar?", vbYesNo + vbQuestion, TITSISTEMA)
    If res = vbYes Then
                 
        Envia = Array(Trim(Right(cmbTipOpe, 20)), _
                      Trim(Right(Mid(cmbPro, 1, Len(cmbPro) - 50), 10)))
        If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_ELIMINAPRODUCTOS", Envia) Then
           MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
           Exit Sub
        End If
        
        MsgBox "Eliminación realizada con exito", vbInformation, TITSISTEMA
        Call GRABA_LOG_AUDITORIA("1", (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10003", "03", "ELIMINA MATRIZ Y ATRIBUCIONES", "MATRIZ_ATRIBUCION_INSTRUMENTO;MATRIZ_ATRIBUCION", ValNue, "")
        Call CargarGrid
    End If
End Sub

Sub InsertarRow(Grid As MSFlexGrid)


    Grid.Rows = Grid.Rows + 1
    Grid.Row = Grid.Rows - 1
    Grid.Col = 0
    Grid.TextMatrix(Grid.Row, 0) = Val(Format(Grid.TextMatrix(Grid.Row - 1, 1), FEntero)) ' + 1
    Grid.TextMatrix(Grid.Row, 1) = Grid.TextMatrix(Grid.Row, 0) + 1
    Grid.TextMatrix(Grid.Row, 2) = 0
    Grid.TextMatrix(Grid.Row, 3) = 0
    Grid.TextMatrix(Grid.Row, 0) = Format(Grid.TextMatrix(Grid.Row, 0), FEntero)
    Grid.TextMatrix(Grid.Row, 1) = Format(Grid.TextMatrix(Grid.Row, 1), FEntero)
    Grid.TextMatrix(Grid.Row, 2) = Format(Grid.TextMatrix(Grid.Row, 2), FDecimal)
    Grid.TextMatrix(Grid.Row, 3) = Format(Grid.TextMatrix(Grid.Row, 3), FDecimal)
    Grid.TextMatrix(Grid.Row, 3) = Format(Grid.TextMatrix(Grid.Row, 4), FDecimal)
'''    Oculta.Rows = Oculta.Rows + 1
    SendKeys "{HOME}"


End Sub

Sub CargarCombos()

    Dim Datos()
    Dim Espacio0 As Integer
    Dim Espacio1 As Integer
    Dim Espacio2 As Integer
    cmbTipOpe.Clear
    cmbPro.Clear
    CmbSistema.Clear
    'Sp_CmbSistema2
    If Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
       Do While Bac_SQL_Fetch(Datos())
          CmbSistema.AddItem Datos(2) & Space(150) & Datos(1)
       Loop
    End If
    
    If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEGENUSUARIO") Then
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        cmbTipOpe.AddItem (Datos(2) & Space(100) & Datos(1))
    Loop
    
    
   cmbTipOpe.Enabled = True
   cmbPro.Enabled = False
   cmbTipOpe.ListIndex = IIf(cmbTipOpe.ListCount = 0, -1, 0)
   CmbSistema.ListIndex = -1
   cmbPro.ListIndex = IIf(cmbPro.ListCount = 0, -1, 0)
    
End Sub

Sub CargarGrid()
   
   Titulos1 = Array("Dias ", "Dias ", "Limite   ", "Limite", "Monto  ")
   Titulos2 = Array("Desde", "Hasta", "Operacion", "Diario", "Ocupado")
   Anchos = Array("1500", "1500", "2250", "2250", "2250")
   Call PROC_CARGARGRILLA(Grid1, 315, 215, Anchos, Titulos1, , Titulos2)
   Grid1.Col = 0
   Grid1.Row = Grid1.FixedRows
   Grid1.Rows = Grid1.Rows - 1
   Call InsertarRow(Grid1)
   Grid1.Enabled = False
   Toolbar1.Buttons(2).Enabled = False
End Sub

Private Sub cmbPro_Click()

    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True
    Grid1.Enabled = True

End Sub

Private Sub cmbPro_GotFocus()
   cmbPro.Tag = cmbPro.ListIndex
End Sub

Private Sub cmbPro_KeyDown(KeyCode As Integer, Shift As Integer)
    
   If KeyCode = 27 Then
      If cmbPro.ListIndex <> cmbPro.Tag Then
         cmbPro.ListIndex = cmbPro.Tag
         Exit Sub
      End If
      Unload Me
   End If
   

End Sub

Private Sub CmbSistema_Click()
    Dim Datos()
    Envia = Array()
    
    AddParam Envia, Trim(Right(CmbSistema.Text, 3))
    If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO_II", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    cmbPro.Enabled = True
    cmbPro.Clear
    
    Do While Bac_SQL_Fetch(Datos())
        Espacio0 = 50 - Len(Datos(2))
        Espacio1 = 150 - Len(Datos(1))
        Espacio2 = 50 - Len(Datos(3))
        cmbPro.AddItem (Datos(2) & Space(Espacio1) & Datos(1) & Space(Espacio2) & Datos(3))
    Loop
        
    Toolbar1.Buttons(4).Enabled = True

End Sub

Private Sub cmbTipOpe_GotFocus()
   cmbTipOpe.Tag = cmbTipOpe.ListIndex
End Sub

Private Sub cmbTipOpe_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 27 Then
      If cmbTipOpe.ListIndex <> cmbTipOpe.Tag Then
         cmbTipOpe.ListIndex = cmbTipOpe.Tag
         Exit Sub
      End If
      Unload Me
   End If
   If KeyCode = 13 Then
      CmbSistema.SetFocus
   End If
   
End Sub

Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   
   Me.Icon = Acceso_Usuario.Icon
   
   Call CargarCombos
   Call CargarGrid
   Call GRABA_LOG_AUDITORIA("1", (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10003", "07", "", "", "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call GRABA_LOG_AUDITORIA("1", (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10003", "08", "", "", "", "")
End Sub

'''Private Sub Grid1_DblClick()
'''    texto.Text = ""
'''    Call textovisible(Grid1, texto)
'''End Sub

Private Sub Grid1_KeyDown(KeyCode As Integer, Shift As Integer)
    Grilla = 1
    Call Grid_KeyDown(KeyCode, Shift, Grid1)
End Sub

Private Sub Grid1_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 27 Then
        Unload Me
        Exit Sub
    End If
    Call Grid_KeyPress(KeyAscii, Grid1, texto)
    If KeyAscii <> 13 Then
        texto.Text = Chr(KeyAscii)
        texto.SelStart = 1
    End If
    
End Sub

Private Sub Texto_KeyDown(KeyCode As Integer, Shift As Integer)
    Call TextoKeyDown(KeyCode, Shift, Grid1, texto)
    
    If KeyCode = 13 Then
      If Grilla = 1 Then
         If Grid1.Col = 2 Or Grid1.Col = 3 Then
            Grid1.Text = BacFormatoMonto(texto.Text, 3)
         Else
            Grid1.Text = BacFormatoMonto(texto.Text, 0)
         End If
      End If
      texto.Visible = False

   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   texto.Visible = False
   
   Select Case Button.Index
    Case 2
      Call Graba
      
      CmbSistema.Clear
      Call CargarCombos
      Call CargarGrid
      cmbTipOpe.SetFocus

    Case 3
       Call Elimina
       
      CmbSistema.Clear
      Call CargarCombos
      Call CargarGrid
      cmbTipOpe.SetFocus
       
    Case 1
       CmbSistema.Clear
       Call CargarCombos
       Call CargarGrid
       cmbTipOpe.SetFocus
    Case 4
         Call Busca
         Grid1.Enabled = True
         Grid1.SetFocus
    Case 5
       Unload Me
       
   End Select

End Sub
    
Sub textovisible(Grid As MSFlexGrid, texto As Control)
    
    If Grid.Col = 1 Then
        texto.CantidadDecimales = 0
        texto.Max = "99999"
        texto.Text = Grid.Text
    ElseIf Grid.Col = 2 Then
        texto.CantidadDecimales = 4
        texto.Max = "999999999999"
        texto.Text = CDbl(Grid.Text)
    ElseIf Grid.Col = 3 Then
        texto.CantidadDecimales = 4
        texto.Max = "999999999999"
        texto.Text = Grid.Text
    End If
    
    Call PROC_POSICIONA_TEXTO(Grid, texto)
    texto.Visible = True
    'texto.Text = ""
    'texto.Text = Format(Grid1.TextMatrix(Grid1.Row, Grid1.Col), FDecimal)
    texto.SetFocus
End Sub

Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer, Grid As MSFlexGrid)
    
    If KeyCode = 45 Then

         If Grid.TextMatrix(Grid.Row, 2) = 0# Then
             Exit Sub
         End If
         
         If CDbl(Format(Grid.TextMatrix(Grid.Row, 1), FEntero)) <= 9998 Then
              Call InsertarRow(Grid)
         End If
    End If
    If KeyCode = 46 Then
        If Grid.Row = Grid.Rows - 1 Then
            res = MsgBox("Esta Seguro que Desea Eliminar", vbQuestion + vbYesNo, TITSISTEMA)
            If res = vbYes Then
                   Grid.Rows = Grid.Rows - (Grid.Rows - Grid.RowSel)
                   If Grid.Rows = Grid1.FixedRows Then
                      Call InsertarRow(Grid)
                   End If
            End If
            Grid.SetFocus
        Else
            If Grid.RowSel = Grid.Rows - 1 Then
                res = MsgBox("Esta Seguro que Desea Eliminar", vbQuestion + vbYesNo, TITSISTEMA)
                If res = vbYes Then
                   Grid.Rows = Grid.Rows - (Grid.RowSel - Grid.Row + 1)
                   If Grid.Rows = Grid1.FixedRows Then
                      Call InsertarRow(Grid)
                   End If
                End If
                Grid.SetFocus
            End If
        End If
    End If
    
    If KeyCode = 13 Then
        If Grid.Col <> 0 And Grid.Col <> 4 Then
            Call textovisible(Grid, texto)
        End If
    End If
    
End Sub
Sub Grid_KeyPress(KeyAscii As Integer, Grid As MSFlexGrid, texto As Control)
        
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        If Grid.Col <> 0 And Grid.Col <> 4 Then
            Call textovisible(Grid, texto)
        End If
    End If

End Sub

Sub TextoKeyDown(KeyCode As Integer, Shift As Integer, Grid As MSFlexGrid, texto As Control)
    
''''    If KeyCode = vbKeyEscape Then
''''        texto.Visible = False
''''        Grid.SetFocus
''''    End If
''''    If KeyCode = vbKeyReturn Then
''''        If Grid.Col = 1 Then
''''            If Grid.Row = Grid.Rows - 1 Then
''''                If CDbl(Format(texto.Text, FEntero)) > CDbl(Format(Grid.TextMatrix(Grid.Row, 0), FEntero)) Then
''''                    Grid.Text = texto.Text
''''                Else
''''                    MsgBox "El dia Hasta no puede ser menor al dia Desde", vbCritical, TITSISTEMA
''''                End If
''''            Else
''''                If CDbl(Format(texto.Text, FEntero)) > CDbl(Format(Grid.TextMatrix(Grid.Row, 0), FEntero)) _
''''                    And CDbl(Format(texto.Text, FEntero)) < CDbl(Format(Grid.TextMatrix(Grid.Row + 1, 1), FEntero)) Then
''''                    Grid.Text = texto.Text
''''                Else
''''                            MsgBox "Datos Mal Ingresados", vbCritical, TITSISTEMA
''''                End If
''''            End If
''''        ElseIf Grid.Col = 2 Then
''''               Grid.Text = Format(texto.Text, FDecimal)
''''        ElseIf Grid.Col = 3 Then
''''               Grid.Text = Format(texto.Text, FDecimal)
''''        End If
''''        texto.Text = ""
''''        texto.Visible = False
''''        Grid.SetFocus
''''    End If

If KeyCode = vbKeyEscape Then
        texto.Visible = False
        Grid.SetFocus
    End If
    If KeyCode = vbKeyReturn Then
        If Grid.Col = 1 Then
            If Grid.Row = Grid.Rows - 1 Then
                If CDbl(Format(texto.Text, FEntero)) > CDbl(Format(Grid.TextMatrix(Grid.Row, 0), FEntero)) Then
                    Grid.Text = texto.Text
                Else
                    MsgBox "Datos Mal Ingresados", vbCritical, TITSISTEMA
                End If
            Else
                If CDbl(Format(texto.Text, FEntero)) > CDbl(Format(Grid.TextMatrix(Grid.Row, 0), FEntero)) _
                    And CDbl(Format(texto.Text, FEntero)) < CDbl(Format(Grid.TextMatrix(Grid.Row + 1, 1), FEntero)) Then
                    Grid.Text = texto.Text
                Else
                            MsgBox "Datos Mal Ingresados", vbCritical, TITSISTEMA
                End If
            End If
        ElseIf Grid.Col = 2 Then
'               If CDbl(Format(texto.Text, FDecimal)) < CDbl(Format(Grid.TextMatrix(Grid.Row, 3), FDecimal)) Then
                    Grid.Text = texto.Text
                    'no Grid.Text = Format(Grid.TextMatrix(Grid.Row, 2), FDecimal)
'               Else
                  '  If CDbl(Format(Grid.TextMatrix(Grid.Row, 3), FDecimal)) = 0 Then
                   '     Grid.Text = texto.Text
                     '   Grid.Text = Format(Grid.TextMatrix(Grid.Row, 2), FDecimal)
                    'Else
'                        MsgBox "Datos 'Mayor que' no puede ser Mayor que datos 'Menor Que'", vbCritical, TITSISTEMA
                   ' End If
'               End If
        ElseIf Grid.Col = 3 Then
'                If CDbl(Format(texto.Text, FDecimal)) > CDbl(Format(Grid.TextMatrix(Grid.Row, 2), FDecimal)) Then
                   Grid.Text = texto.Text
                   ' Grid.Text = Format(Grid.Text, FDecimal)
'                ElseIf CDbl(Format(texto.Text, FDecimal)) < CDbl(Format(Grid.TextMatrix(Grid.Row, 4), FDecimal)) Then
'                    MsgBox "Monto Mator que no Puede ser Menor que Monto Ocupado", vbCritical, TITSISTEMA
                'End If
        End If
        Grid.SetFocus
    End If
End Sub
