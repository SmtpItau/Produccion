VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacConOper 
   Appearance      =   0  'Flat
   BackColor       =   &H80000004&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Control de Tasa de Operaciones"
   ClientHeight    =   4365
   ClientLeft      =   5520
   ClientTop       =   5355
   ClientWidth     =   7950
   Icon            =   "BacConOper.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4365
   ScaleWidth      =   7950
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   3930
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   7935
      _Version        =   65536
      _ExtentX        =   13996
      _ExtentY        =   6932
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
      Begin VB.ComboBox CmbMonCon 
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
         Left            =   1890
         Style           =   2  'Dropdown List
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   1215
         Width           =   4860
      End
      Begin VB.ComboBox CmbSistema 
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
         Left            =   1905
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   165
         Width           =   4860
      End
      Begin BACControles.TXTNumero texto 
         Height          =   285
         Left            =   630
         TabIndex        =   8
         Top             =   2115
         Visible         =   0   'False
         Width           =   1485
         _ExtentX        =   2619
         _ExtentY        =   503
         BackColor       =   8388608
         ForeColor       =   16777215
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "0"
         Max             =   "0"
         CantidadDecimales=   "4"
      End
      Begin VB.ComboBox CmbFormadePago 
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
         Top             =   870
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
         TabIndex        =   2
         Top             =   525
         Width           =   4860
      End
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   2115
         Left            =   90
         TabIndex        =   4
         Top             =   1725
         Width           =   7740
         _ExtentX        =   13653
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
         Top             =   1635
         Width           =   7770
         _Version        =   65536
         _ExtentX        =   13705
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
      Begin VB.Label Label1 
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
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   10
         Top             =   1290
         Width           =   690
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
         Top             =   165
         Width           =   630
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Forma de Pago"
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
         Top             =   870
         Width           =   1290
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
         TabIndex        =   5
         Top             =   525
         Width           =   780
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   7950
      _ExtentX        =   14023
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
      MouseIcon       =   "BacConOper.frx":000C
      OLEDropMode     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8490
      Top             =   690
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
            Picture         =   "BacConOper.frx":0326
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConOper.frx":1200
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConOper.frx":20DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConOper.frx":2FB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConOper.frx":3E8E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacConOper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Grilla          As Variant
Dim ValNue          As String
Dim ValAnt          As String
Dim ValorFormaPago
Dim EntraraFocus

Private Sub CmbMonCon_Change()
   Toolbar1.Buttons(4).Enabled = True
End Sub

Private Sub CmbMonCon_Click()
   Toolbar1.Buttons(4).Enabled = True
   Toolbar1.Buttons(3).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
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

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   texto.Visible = False
   
   Select Case Button.Index
    Case 2
       Call Graba
       Call CargarCombos
       Call CargarGrid
    Case 3
       Call Elimina
       Call CargarCombos
       Call CargarGrid
    Case 1
       Call CargarCombos
       Call CargarGrid
    Case 4
         Call Busca
         Grid1.Enabled = True
         Grid1.SetFocus
    Case 5
       Unload Me
   End Select

End Sub

Private Sub CmbSistema_Click()
    CargarCombosProducto
End Sub

Private Sub cmbPro_KeyDown(KeyCode As Integer, Shift As Integer)
    
   If KeyCode = 27 Then
      If cmbPro.ListIndex <> cmbPro.Tag Then
         cmbPro.ListIndex = cmbPro.Tag
         Exit Sub
      End If
      Unload Me
   End If
   If KeyCode = 13 Then
        CmbFormadePago.SetFocus
   End If

End Sub

Private Sub CmbFormadePago_Click()
    CmbMonCon.SetFocus
End Sub

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
End Sub

Private Sub Texto_KeyDown(KeyCode As Integer, Shift As Integer)
    If Grilla = 1 Then
        Call TextoKeyDown(KeyCode, Shift, Grid1, texto)
    End If
End Sub
    
Sub textovisible(Grid As MSFlexGrid, texto As Control)
    
    If Grid.Col = 1 Then
        texto.CantidadDecimales = 0
        texto.Max = "99999"
        texto.Text = Grid.Text
    ElseIf Grid.Col = 2 Then
        texto.CantidadDecimales = 4
        texto.Max = "9999"
        texto.Text = Grid.Text
    ElseIf Grid.Col = 3 Then
        texto.CantidadDecimales = 4
        texto.Max = "9999"
        texto.Text = Grid.Text
    ElseIf Grid.Col = 4 Then
        texto.CantidadDecimales = 4
        texto.Max = "999"
        texto.Text = Grid.Text
    End If
    Call PROC_POSICIONA_TEXTO(Grid, texto)
    texto.Visible = True
    texto.SetFocus
End Sub

Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer, Grid As MSFlexGrid)
    
    If KeyCode = 45 Then
          If Grid.TextMatrix(Grid.Row, 2) = 0# Or Grid.TextMatrix(Grid.Row, 3) = 0# Then
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
        If Grid.Col <> 0 Then
            Call textovisible(Grid, texto)
        End If
    End If
    
End Sub

Sub Grid_KeyPress(KeyAscii As Integer, Grid As MSFlexGrid, texto As Control)
    
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        If Grid.Col <> 0 Then
            Call textovisible(Grid, texto)
            texto.Text = Chr(KeyAscii)
            texto.SelStart = 1
        End If
    End If

End Sub

Sub TextoKeyDown(KeyCode As Integer, Shift As Integer, Grid As MSFlexGrid, texto As Control)
    EntraraFocus = 1
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
                    MsgBox "El dia Hasta no puede ser menor al dia anterior", vbCritical, TITSISTEMA
                    EntraraFocus = 0
                    texto.Text = Grid.TextMatrix(Grid.Row, Grid.Col)
                    texto.Text = ""
                    texto.Visible = False
                    Grid.SetFocus
                    Exit Sub
                End If
            Else
                If CDbl(Format(texto.Text, FEntero)) > CDbl(Format(Grid.TextMatrix(Grid.Row, 0), FEntero)) _
                    And CDbl(Format(texto.Text, FEntero)) < CDbl(Format(Grid.TextMatrix(Grid.Row + 1, 1), FEntero)) Then
                    Grid.Text = texto.Text
                    Grid.SetFocus
                Else
                    MsgBox "Datos Mal Ingresados", vbCritical, TITSISTEMA
                End If
            End If
        ElseIf Grid.Col = 2 Then
               Grid.Text = texto.Text
        ElseIf Grid.Col = 3 Then
               Grid.Text = texto.Text
        ElseIf Grid.Col = 4 Then
               Grid.Text = texto.Text
        End If
        Grid.SetFocus
    End If
End Sub

Private Sub Texto_LostFocus()

If EntraraFocus = 0 Then Exit Sub
If Grilla = 1 Then
  If Grid1.Col = 2 Or Grid1.Col = 3 Or Grid1.Col = 4 Then
     Grid1.Text = Format(texto.Text, FDecimal)
     Grid1.SetFocus
   Else
     Grid1.Text = Format(texto.Text, FEntero)
     Grid1.SetFocus
  End If
  
End If
 
 texto.Visible = False
End Sub

Private Function CargarCombos()

    Dim Datos()
    Dim Espacio0 As Integer
    Dim Espacio1 As Integer
    Dim Espacio2 As Integer
    
    CmbSistema.Clear
    cmbPro.Clear
    CmbFormadePago.Clear
    CmbMonCon.Clear
    
    If Bac_Sql_Execute("SP_CMBSISTEMA2") Then
      Do While Bac_SQL_Fetch(Datos())
         CmbSistema.AddItem Datos(2) & Space(150) & Datos(1)
      Loop
    End If
    
    CmbSistema.ListIndex = 1

    Envia = Array()
    Envia = Array("1")
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Function
    End If
   
    CmbMonCon.Clear
    Do While Bac_SQL_Fetch(Datos())
      CmbMonCon.AddItem (Datos(3) & Space(100) & Datos(1))
    Loop

    Envia = Array()
    Envia = Array("2")
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Function
    End If
   
    CmbFormadePago.Clear
    Do While Bac_SQL_Fetch(Datos())
      CmbFormadePago.AddItem (Datos(2) & Space(100) & Datos(1))
    Loop
    
    CmbSistema.ListIndex = 1
    cmbPro.ListIndex = -1
    CmbFormadePago.ListIndex = -1
    CmbMonCon.ListIndex = -1
    
End Function

Private Function CargarGrid()
   
   Titulos1 = Array("Dias ", "Dias ", "% Desviacion", "% Desviacion", "Tasa")
   Titulos2 = Array("Desde", "Hasta", "Minima", "Maxima", "Sugerida")
   Anchos = Array("1500", "1500", "2550", "2550", "2500")
   Call PROC_CARGARGRILLA(Grid1, 315, 215, Anchos, Titulos1, , Titulos2)
   Grid1.Col = 0
   Grid1.Row = Grid1.FixedRows
   Grid1.Rows = Grid1.Rows - 1
   Call InsertarRow(Grid1)
   Grid1.Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   
End Function

Private Function Graba()
    
    Dim i%
    Dim Datos()
    Dim Error As Boolean
    Error = False
    
    If cmbPro.ListIndex = -1 Then
        Error = True
    End If
        
    For i% = 2 To Grid1.Rows - 1
        If CDbl(Format(Grid1.TextMatrix(i%, 1), FEntero)) <= CDbl(Format(Grid1.TextMatrix(i%, 0), FEntero)) Then
            Error = True
            Exit For
        End If
    Next i%
    
    If Error = True Then
        GoTo Errorr
    End If
    
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
       MsgBox "Error en Begin Transaction", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    For i% = 2 To Grid1.Rows - 1
         ValorFormaPago = IIf(Trim(Right(CmbFormadePago.Text, 5)) = "", 0, Trim(Right(CmbFormadePago.Text, 5)))
         Envia = Array("I", _
                       Trim(Right(CmbSistema, 20)), _
                       Trim(Right(cmbPro, 5)), _
                       CDbl(ValorFormaPago), _
                       CDbl(Trim(Right(CmbMonCon.Text, 5))), _
                       CDbl(Grid1.TextMatrix(i%, 0)), _
                       CDbl(Grid1.TextMatrix(i%, 1)), _
                       CDbl(Grid1.TextMatrix(i%, 2)), _
                       CDbl(Grid1.TextMatrix(i%, 3)), _
                       IIf(i% = 2, 1, 2), _
                       CDbl(Grid1.TextMatrix(i%, 4)))

        If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_CONTROLTASA", Envia) Then

            Envia = Array("R")

            If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then

                MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
                Grid1.SetFocus

                Exit Function

            End If

            MsgBox "No se puede Grabar problema con la comunicacion", vbCritical, TITSISTEMA
            Grid1.SetFocus

            Exit Function

        End If

    Next i%
   
    Envia = Array("C")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
        MsgBox "Error en Commit Transaction", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    MsgBox "Grabación Realizada con Exito", vbInformation, TITSISTEMA
    
    Call GRABA_LOG_AUDITORIA("1", (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10003", "01", "GRABA MATRIZ DE RIESGO ;INSTRUMENTO Y ATRIBUCIONES", "MATRIZ_ATRIBUCION_INSTRUMENTO;MATRIZ_ATRIBUCION", ValNue, "")
    Call CargarGrid
    Exit Function
Errorr:
MsgBox "Datos Mal Ingresados Verifique", vbCritical, TITSISTEMA
        Grid1.SetFocus
End Function

Private Function Elimina()
   
    res = MsgBox("Esta seguro que desea Eliminar?", vbYesNo + vbQuestion, TITSISTEMA)
    If res = vbYes Then
         ValorFormaPago = IIf(Trim(Right(CmbFormadePago.Text, 5)) = "", 0, Trim(Right(CmbFormadePago.Text, 5)))
         Envia = Array("E", _
                       Trim(Right(CmbSistema, 20)), _
                       Trim(Right(cmbPro, 5)), _
                       CDbl(ValorFormaPago), _
                       CDbl(Trim(Right(CmbMonCon.Text, 5))))
        If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_CONTROLTASA", Envia) Then
           MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
           Exit Function
        End If
        
        MsgBox "Eliminación realizada con exito", vbInformation, TITSISTEMA
        Call GRABA_LOG_AUDITORIA("1", (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10003", "03", "ELIMINA MATRIZ Y ATRIBUCIONES", "MATRIZ_ATRIBUCION_INSTRUMENTO;MATRIZ_ATRIBUCION", ValNue, "")
        Call CargarGrid
    End If
End Function

Private Function CargarCombosProducto()
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistema.Text, 3))
    If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    cmbPro.Enabled = True
    cmbPro.Clear
    
    Do While Bac_SQL_Fetch(Datos())
        Espacio0 = 50 - Len(Datos(2))
        Espacio1 = 150 - Len(Datos(1))
        cmbPro.AddItem (Datos(2) & Space(Espacio1) & Datos(1))
    Loop

End Function

Private Function Busca()
    Dim i%
    Dim Datos()
    
    If Trim(cmbPro) = "" Then
       Exit Function
    End If
    ValorFormaPago = IIf(Trim(Right(CmbFormadePago.Text, 5)) = "", 0, Trim(Right(CmbFormadePago.Text, 5)))
    Envia = Array("B", _
            Trim(Right(CmbSistema, 20)), _
            Trim(Right(cmbPro, 5)), _
            CDbl(ValorFormaPago), _
            CDbl(Trim(Right(CmbMonCon.Text, 5))))
    If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_CONTROLTASA", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    Grid1.Rows = Grid1.FixedRows
    
    Do While Bac_SQL_Fetch(Datos())
        Grid1.Rows = Grid1.Rows + 1
        Grid1.Row = Grid1.Rows - 1
        Grid1.TextMatrix(Grid1.Row, 0) = Format(Datos(1), FEntero)
        Grid1.TextMatrix(Grid1.Row, 1) = Format(Datos(2), FEntero)
        Grid1.TextMatrix(Grid1.Row, 2) = Format(Datos(3), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 3) = Format(Datos(4), FDecimal)
        Grid1.TextMatrix(Grid1.Row, 4) = Format(Datos(5), FDecimal)
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    Loop
    
    If Grid1.Rows = Grid1.FixedRows Then
        Call InsertarRow(Grid1)
    End If
    
    Grid1.Col = 0
    Grid1.Row = Grid1.FixedRows
    
End Function

Sub InsertarRow(Grid As MSFlexGrid)
    Dim Monto   As Integer
    Grid1.Rows = Grid1.Rows + 1
    Grid1.Row = Grid1.Rows - 1
    Grid1.Col = 0
    
    If Grid1.Rows = 3 Then
        Monto = 0
    Else
        If Grid1.TextMatrix(Grid1.Row - 1, 1) > 0 Then
            Monto = Grid1.TextMatrix(Grid1.Row - 1, 1) + 1
        Else
            Monto = CDbl(Format(Grid1.TextMatrix(Grid1.Row, 0), FEntero))
        End If
    End If
    Grid1.TextMatrix(Grid1.Row, 0) = 0
    Grid1.TextMatrix(Grid1.Row, 0) = Monto
    Grid1.TextMatrix(Grid1.Row, 1) = Grid1.TextMatrix(Grid1.Row, 0) + 1
    Grid1.TextMatrix(Grid1.Row, 2) = 0
    Grid1.TextMatrix(Grid1.Row, 3) = 0
    Grid1.TextMatrix(Grid1.Row, 4) = 0
    Grid1.TextMatrix(Grid1.Row, 0) = Format(Grid1.TextMatrix(Grid1.Row, 0), FEntero)
    Grid1.TextMatrix(Grid1.Row, 1) = Format(Grid1.TextMatrix(Grid1.Row, 1), FEntero)
    Grid1.TextMatrix(Grid1.Row, 2) = Format(Grid1.TextMatrix(Grid1.Row, 2), FDecimal)
    Grid1.TextMatrix(Grid1.Row, 3) = Format(Grid1.TextMatrix(Grid1.Row, 3), FDecimal)
    Grid1.TextMatrix(Grid1.Row, 4) = Format(Grid1.TextMatrix(Grid1.Row, 4), FDecimal)
    
    SendKeys "{HOME}"

End Sub
