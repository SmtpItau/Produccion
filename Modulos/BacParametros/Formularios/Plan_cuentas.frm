VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Plan_Cuentas 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor Plan de Cuentas "
   ClientHeight    =   3375
   ClientLeft      =   1530
   ClientTop       =   4335
   ClientWidth     =   6090
   Icon            =   "Plan_cuentas.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3375
   ScaleWidth      =   6090
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   2790
      Left            =   0
      TabIndex        =   8
      Top             =   540
      Width           =   6015
      _Version        =   65536
      _ExtentX        =   10610
      _ExtentY        =   4921
      _StockProps     =   15
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
      Begin VB.Frame Frame1 
         Height          =   2700
         Left            =   60
         TabIndex        =   9
         Top             =   15
         Width           =   5880
         Begin VB.TextBox TX_CtaSbif 
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
            Left            =   1680
            MaxLength       =   11
            MouseIcon       =   "Plan_cuentas.frx":030A
            TabIndex        =   16
            Top             =   2280
            Width           =   1575
         End
         Begin VB.ComboBox CmbCuenta 
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
            ItemData        =   "Plan_cuentas.frx":0614
            Left            =   1680
            List            =   "Plan_cuentas.frx":061E
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   1920
            Width           =   2760
         End
         Begin VB.TextBox TxtTcuenta 
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
            Left            =   3015
            TabIndex        =   7
            Top             =   1890
            Visible         =   0   'False
            Width           =   2670
         End
         Begin VB.TextBox TxtSContable 
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
            Height          =   345
            Left            =   1680
            MaxLength       =   3
            TabIndex        =   5
            Top             =   1560
            Width           =   2745
         End
         Begin VB.ComboBox cmbTipMon 
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
            Left            =   1680
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   1200
            Width           =   2775
         End
         Begin VB.TextBox txtGlo 
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
            Left            =   1680
            MaxLength       =   30
            TabIndex        =   3
            Top             =   840
            Width           =   2760
         End
         Begin VB.TextBox txtDes 
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
            Left            =   1680
            MaxLength       =   70
            TabIndex        =   2
            Top             =   510
            Width           =   4095
         End
         Begin VB.TextBox txtCta 
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
            Left            =   1680
            MaxLength       =   12
            MouseIcon       =   "Plan_cuentas.frx":0632
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   180
            Width           =   1575
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Cuenta Sbif"
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
            Index           =   4
            Left            =   120
            TabIndex        =   17
            Top             =   2280
            Width           =   1005
         End
         Begin VB.Label Label3 
            Caption         =   "Tipo Cuenta"
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
            Height          =   285
            Left            =   90
            TabIndex        =   15
            Top             =   1920
            Width           =   1485
         End
         Begin VB.Label Label1 
            Caption         =   "Sector Contable"
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
            Height          =   240
            Left            =   75
            TabIndex        =   14
            Top             =   1560
            Width           =   1440
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Tipo de Moneda"
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
            Index           =   3
            Left            =   60
            TabIndex        =   13
            Top             =   1215
            Width           =   1395
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Glosa Breve"
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
            Index           =   2
            Left            =   60
            TabIndex        =   12
            Top             =   885
            Width           =   1050
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Descripción"
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
            Index           =   1
            Left            =   60
            TabIndex        =   11
            Top             =   555
            Width           =   1020
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Cuenta"
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
            Index           =   0
            Left            =   60
            TabIndex        =   10
            Top             =   225
            Width           =   615
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2880
      Top             =   2040
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
            Picture         =   "Plan_cuentas.frx":093C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Plan_cuentas.frx":0D8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Plan_cuentas.frx":11E0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Plan_cuentas.frx":14FA
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
      Width           =   6090
      _ExtentX        =   10742
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
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   480
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   4800
      Visible         =   0   'False
      Width           =   1140
   End
End
Attribute VB_Name = "Plan_Cuentas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim sql$, Datos(), I&
Dim nerror%, sError$
Dim objCodigo As Object

Sub LimpiarPlandeCuentas()
    txtCta.Text = ""
    txtDes.Text = ""
    txtGlo.Text = ""
    TX_CtaSbif.Text = ""
    
    cmbTipMon.Clear
    cmbTipMon.AddItem "NACIONAL": cmbTipMon.ItemData(cmbTipMon.NewIndex) = 0
    cmbTipMon.AddItem "EXTRANJERA": cmbTipMon.ItemData(cmbTipMon.NewIndex) = 1
    cmbTipMon.ListIndex = 0
    CmbCuenta.ListIndex = 0
    
    cmbTipMon_LostFocus
    TxtTcuenta.Text = ""
    TxtSContable.Text = ""
    
    Set objCodigo = New clsCodigo
    
    Set objCodigo = Nothing
    txtCta.Enabled = True
End Sub
Private Function Eliminar()
        Dim RES
        RES = MsgBox("¿Confirma que desea Eliminar la cuenta " & txtCta.Text & " " & txtGlo.Text & "?", vbYesNo + vbQuestion, TITSISTEMA)
        
        If RES = 6 Then
            nerror = 0
            sError = "Cuenta fue Eliminada con Exito"
            
            Envia = Array()
            AddParam Envia, txtCta.Text
            
            If Not Bac_Sql_Execute("SP_ELIMINA_CUENTA", Envia) Then
               nerror = -1
               sError = "Problemas al Eliminar la Cuenta " & txtCta
            End If
            
            If Bac_SQL_Fetch(Datos()) Then
                nerror = Datos(1)
                sError = Datos(2)
            End If
            
            MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
            Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_554 " _
                                    , "03" _
                                    , "Borrar " _
                                    , "PLAN_DE_CUENTA" _
                                    , " " _
                                    , sError & " " & txtCta.Text & " " & txtDes.Text & " " & CmbCuenta.Text)
                                    
            If nerror = 0 Then
                Call LimpiarPlandeCuentas
                txtCta.SetFocus
            End If
            
        End If
        
End Function
Private Function Grabar()
        nerror = 0
        
        sError = "Cuenta Fue Grabada con éxito"
    
        If Not Valida_Datos Then
            Exit Function
        End If
        
        Screen.MousePointer = 11
        
        'cmbSBIF.Tag = cmbSBIF.ItemData(cmbSBIF.ListIndex)
        cmbTipMon.Tag = Left(cmbTipMon.Text, 1)
     
        Envia = Array()
        AddParam Envia, txtCta
        AddParam Envia, txtDes
        AddParam Envia, txtGlo
        AddParam Envia, Mid(CmbCuenta.Text, 1, 3)
        AddParam Envia, ""
        AddParam Envia, ""
        AddParam Envia, Trim(TxtSContable.Text)
        AddParam Envia, cmbTipMon.Tag
        AddParam Envia, 0
        AddParam Envia, Trim(TX_CtaSbif)
        AddParam Envia, 0
        AddParam Envia, 0
     '   AddParam Envia, CDbl(Trim(TX_MdaCtbl))
                                 
        If Not Bac_Sql_Execute("SP_TRUCO", Envia) Then
           nerror = -1
           sError = "Problemas al Grabar la Cuenta " & txtCta
           MsgBox "Problemas al Grabar la Cuenta ", vbOKOnly + vbCritical, TITSISTEMA
           Screen.MousePointer = 0
           Exit Function
        End If
        
        If Bac_SQL_Fetch(Datos()) Then
            nerror = Datos(1)
            sError = Datos(2)
        End If
        
        MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_554 " _
                                    , "01" _
                                    , "Grabar" _
                                    , "PLAN_DE_CUENTA" _
                                    , " " _
                                    , sError & " " & txtCta.Text & " " & txtDes.Text & " " & CmbCuenta.Text)
        If nerror = 0 Then
            Call LimpiarPlandeCuentas
            txtCta.SetFocus
        End If
        
        Screen.MousePointer = 0
        
End Function
Function Valida_Datos() As Boolean

    Valida_Datos = False
    
    If txtCta = "" Then
        MsgBox "Debe Ingresar Código de La Cuenta", vbInformation, TITSISTEMA
        txtCta.SetFocus
    ElseIf txtDes = "" Then
        MsgBox "Debe Ingresar DESCRIPCION de la Cuenta", vbInformation, TITSISTEMA
        txtDes.SetFocus
    ElseIf txtGlo = "" Then
        MsgBox "Debe Ingresar GLOSA de la Cuenta", vbInformation, TITSISTEMA
        txtGlo.SetFocus
    ElseIf cmbTipMon.Tag = "" Or cmbTipMon.ListIndex < 0 Then
        MsgBox ("Debe Seleccionar TIPO DE MONEDA")
        cmbTipMon.SetFocus
         
    Else
        Valida_Datos = True
    End If
    
End Function

Private Sub CmbCuenta_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 13 Then
        txtDes.SetFocus
    End If
    
End Sub

Private Sub cmbTipMon_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        TxtSContable.SetFocus
    End If
End Sub

Private Sub cmbTipMon_LostFocus()
    If cmbTipMon.ListIndex >= 0 Then
        cmbTipMon.Tag = Left(cmbTipMon, 1)
    Else
        cmbTipMon.Tag = ""
    End If
End Sub
Private Sub cmdSalir_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_554" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
    If Visible Then
        Top = 1
        Left = 15
    End If
    Me.Top = 0
    Me.Left = 0
    Call LimpiarPlandeCuentas
End Sub

Private Sub Text1_DblClick()


End Sub




Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyF3 Then Call txtCta_DblClick

End Sub


Private Sub Text1_KeyPress(KeyAscii As Integer)

    If KeyAscii% = vbKeyReturn Then
    
      KeyAscii% = 0
      
      If Len(txtCta.Text) <> "11" Then
            Call Busca_TCuenta
      End If
      
      txtDes.SetFocus
      
    ElseIf KeyAscii < 48 Or KeyAscii > 57 Then
    
      If KeyAscii <> 8 Then
         KeyAscii = 0
         
      End If
        
    End If

End Sub

Private Sub Text1_LostFocus()

    txtCta.Tag = Trim(txtCta.Text)

    If txtCta.Tag = "" Then
       Call LimpiarPlandeCuentas
       Exit Sub
       
    End If

    Envia = Array()
    AddParam Envia, txtCta.Tag

    If Bac_Sql_Execute("SP_CONSULTA_TABLAS 'CON_PLAN_CUENTAS1',", Envia) Then
    
        If Bac_SQL_Fetch(Datos()) Then
            txtCta.Text = CDbl(Datos(1))
            txtDes.Text = UCase(Datos(2))
            txtGlo.Text = UCase(Datos(3))
            bacBuscarCombo cmbTipMon, IIf(Datos(4) = "N", 0, 1)
            TxtSContable.Text = Datos(7)
            CmbCuenta.ListIndex = IIf(Datos(6) = "ACT", 0, 1)
            txtCta.Enabled = False
        Else
            txtCta.Enabled = True
        End If
        
    End If



End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
    
    Case 1
        Call Grabar
    Case 2
        Call Eliminar
    Case 3
        Call LimpiarPlandeCuentas
        txtCta.SetFocus
    Case 4
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_554 " _
                                    , "08" _
                                    , "SALIR DE LA OPCION" _
                                    , " " _
                                    , " " _
                                    , " ")
        Unload Me
    End Select
    
End Sub

Private Sub TX_MdaCtbl_DblClick()

    BacAyuda.Tag = "MONEDAS_CTBL"
    BacAyuda.parAyuda = "CON_MON_CUENTAS"
    BacAyuda.parFiltro = ""
    BacAyuda.Show 1

    If giAceptar = True Then
       'TX_MdaCtbl.Text = gsCodigo$
       
       'TX_MdaCtbl_KeyDown 13, 0
       'TX_MdaCtbl.Enabled = False
       
       'If Len(Text1.Text) <> "11" Then
       '   Busca_TCuenta
       'End If
       
    End If


End Sub


Private Sub TX_MdaCtbl_KeyPress(KeyAscii As Integer)

  KeyAscii = Asc(UCase(Chr(KeyAscii)))
  
End Sub

Private Sub txtCta_DblClick()

    BacAyuda.Tag = "CUENTAS"
    BacAyuda.parAyuda = "CON_PLAN_CUENTAS"
    BacAyuda.parFiltro = ""
    BacAyuda.Show 1

    If giAceptar = True Then
       txtCta.Text = gsCodigo$
       
       txtCta_KeyDown 13, 0
       txtCta.Enabled = False
       
       If Len(txtCta.Text) <> "12" Then 'FSA VALOR: 11
          Busca_TCuenta
       End If
       
    End If

End Sub
Private Sub txtCta_KeyDown(KeyCode As Integer, Shift As Integer)
    
If KeyCode = vbKeyF3 Then Call txtCta_DblClick
    
    
End Sub

Private Sub txtCta_KeyPress(KeyAscii As Integer)
    
    If KeyAscii% = vbKeyReturn Then
    
      KeyAscii% = 0
      
      If Len(txtCta.Text) <> "12" Then 'FSA VALOR: 11
            Call Busca_TCuenta
      End If
      
      txtDes.SetFocus
      
    ElseIf KeyAscii < 48 Or KeyAscii > 57 Then
    
      If KeyAscii <> 8 Then
         KeyAscii = 0
         
      End If
        
    End If
    
End Sub

Private Sub txtCta_LostFocus()

    txtCta.Tag = Trim(txtCta.Text)

    If txtCta.Tag = "" Then
       Call LimpiarPlandeCuentas
       Exit Sub
       
    End If

    Envia = Array()
    AddParam Envia, txtCta.Tag

    If Bac_Sql_Execute("SP_CONSULTA_TABLAS 'CON_PLAN_CUENTAS1',", Envia) Then
    
        If Bac_SQL_Fetch(Datos()) Then
            txtCta.Text = CDbl(Datos(1))
            txtDes.Text = UCase(Datos(2))
            txtGlo.Text = UCase(Datos(3))
            bacBuscarCombo cmbTipMon, IIf(Datos(4) = "N", 0, 1)
            TxtSContable.Text = Datos(7)
            CmbCuenta.ListIndex = IIf(Datos(6) = "ACT", 0, 1)
            txtCta.Enabled = False
        Else
            txtCta.Enabled = True
        End If
        
    End If


End Sub

Private Sub txtDes_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 13 Then
        txtGlo.SetFocus
    End If

End Sub

Private Sub txtDes_KeyPress(KeyAscii As Integer)
    
    KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub


Private Sub txtGlo_KeyDown(KeyCode As Integer, Shift As Integer)

 If KeyCode = 13 Then
    cmbTipMon.SetFocus
 End If
 
End Sub

Private Sub txtGlo_KeyPress(KeyAscii As Integer)
 
 KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub

Sub Busca_TCuenta()
Dim nerror As String

    Envia = Array()
    AddParam Envia, txtCta.Text
  
    If Bac_Sql_Execute("SP_PLAN_CUENTA_BUSCATCUENTA ", Envia) Then
    
       If Bac_SQL_Fetch(Datos()) Then
            If Datos(5) <> "PAS" Then
                txtDes.Text = Datos(2)
                txtGlo.Text = Datos(3)
                TxtSContable.Text = Datos(6)
                TxtTcuenta.Text = "ACTIVO"
                CmbCuenta.ListIndex = 0
               TX_CtaSbif.Text = Datos(7)
''                If Len(Datos(7)) < 2 Then
''                    TX_MdaCtbl.Text = "0" + Datos(7)
''                Else
''                    TX_MdaCtbl.Text = Datos(7)
''                End If
                Select Case Datos(4)
                  Case "E"
                  
                        cmbTipMon.Text = "EXTRANJERA"
                  
                  Case "N"
                  
                        cmbTipMon.Text = "NACIONAL"
                        
                End Select
                
            End If
            
            If Datos(5) = "PAS" Then
                txtDes.Text = Datos(2)
                txtGlo.Text = Datos(3)
                TxtSContable.Text = Datos(4)
                TxtTcuenta.Text = "PASIVO"
                TX_CtaSbif.Text = Datos(7)
''                If Len(Datos(7)) > 2 Then
''                    TX_MdaCtbl.Text = Datos(7)
''                Else
''                    TX_MdaCtbl.Text = Datos(7)
''                End If
                CmbCuenta.ListIndex = 1
            End If
    End If
    
End If

End Sub


Private Sub TxtSContable_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        CmbCuenta.SetFocus
    End If
End Sub

Private Sub TxtSContable_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

