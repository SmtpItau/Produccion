VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacMntOma 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Códigos OMA"
   ClientHeight    =   1995
   ClientLeft      =   1845
   ClientTop       =   1425
   ClientWidth     =   5820
   FillStyle       =   0  'Solid
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   9.75
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Bacmntoa.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form3"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1995
   ScaleWidth      =   5820
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5220
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
            Picture         =   "Bacmntoa.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntoa.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntoa.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntoa.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   5820
      _ExtentX        =   10266
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
   Begin Threed.SSPanel SSPanel1 
      Height          =   1395
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   5805
      _Version        =   65536
      _ExtentX        =   10239
      _ExtentY        =   2461
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame Frame 
         Height          =   1305
         Index           =   0
         Left            =   60
         TabIndex        =   4
         Top             =   15
         Width           =   5670
         _Version        =   65536
         _ExtentX        =   10001
         _ExtentY        =   2302
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
         Begin VB.TextBox txtcodigo 
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
            Left            =   1635
            MaxLength       =   3
            MouseIcon       =   "Bacmntoa.frx":11E2
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   150
            Width           =   1140
         End
         Begin VB.TextBox TxtNombre 
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
            Left            =   1620
            MaxLength       =   45
            TabIndex        =   2
            Top             =   480
            Width           =   3945
         End
         Begin VB.ComboBox cmbOperacion 
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
            Height          =   330
            Left            =   1620
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   855
            Width           =   3945
         End
         Begin VB.Label Label 
            Caption         =   "Código"
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
            Index           =   0
            Left            =   60
            TabIndex        =   7
            Top             =   150
            Width           =   1500
         End
         Begin VB.Label Label 
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
            Height          =   315
            Index           =   2
            Left            =   60
            TabIndex        =   6
            Top             =   480
            Width           =   1500
         End
         Begin VB.Label Label 
            Caption         =   "Tipo Operación"
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
            Index           =   1
            Left            =   60
            TabIndex        =   5
            Top             =   855
            Width           =   1500
         End
      End
   End
End
Attribute VB_Name = "BacMntOma"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim sql$
Dim Datos()
Dim i%
Public Function CargaPanel(Valor As Boolean)
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
End Function
Public Function ValidaElimi()
   ValidaElimi = True
   If Trim(TxtCodigo.Text) = "" Then
       MsgBox "ERROR : Código vacío", 16, TITSISTEMA
       TxtCodigo.SetFocus
       ValidaElimi = False
   End If
   If Trim$(txtNombre.Text) = "" Then
       MsgBox "ERROR : Descripción vacía", 16, TITSISTEMA
       txtNombre.SetFocus
       ValidaElimi = False
   End If
   If cmbOperacion.Tag = "" Then
       MsgBox "ERROR : Tipo de Operación vacía", 16, TITSISTEMA
       cmbOperacion.SetFocus
       ValidaElimi = False
   End If
End Function
Public Function Limpiar()
    TxtCodigo = ""
    txtNombre = ""
    Call ActivaBoton(False)
    Carga_Listas "TipoDocumento", cmbOperacion
    cmbOperacion_LostFocus
    TxtCodigo.SetFocus
End Function
Public Function ActivaBoton(Valor As Boolean)
    TxtCodigo.Enabled = Not Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    txtNombre.Enabled = Valor
    cmbOperacion.Enabled = Valor
End Function
Private Sub cmbOperacion_Click()
    cmbOperacion.Tag = ""
    If cmbOperacion.ListIndex >= 0 Then
        cmbOperacion.Tag = Left(cmbOperacion.List(cmbOperacion.ListIndex), 1)
    End If
End Sub
Private Sub cmbOperacion_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub
Private Sub cmbOperacion_LostFocus()
    Me.cmbOperacion.Tag = ""
    If cmbOperacion.ListIndex >= 0 Then
        cmbOperacion.Tag = Left(cmbOperacion.List(cmbOperacion.ListIndex), 1)
    End If
End Sub
Private Sub xcmdEliminar_Click()
    If ValidaElimi() Then
        If MsgBox("Está seguro de eliminar el registro", 36, TITSISTEMA) = 6 Then
            Envia = Array()
            AddParam Envia, CDbl(txtcodigo.Text)
            If Not Bac_Sql_Execute("SP_BORRA_OMA ", Envia) Then
                If Bac_SQL_Fetch(Datos()) Then
                    If Trim(Datos(1)) <> "OK" Then
                        MsgBox " No se puede eliminar registro ", 64, TITSISTEMA
                    End If
                End If
            Else
                MsgBox "Registro Eliminado ", 16, TITSISTEMA
            End If
            Call Limpiar
        Else
            TxtCodigo.Enabled = True
            TxtCodigo.SetFocus
        End If
    End If
End Sub
Private Sub Form_GotFocus()
    WindowState = 0
End Sub

Private Sub Form_Load()
    Move 15, 1
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_651" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
    
    
    Call ActivaBoton(False)
    Me.Visible = True
    Call Limpiar
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim Valores As String
    
    Select Case Button.Index
    Case 1
    
        Me.MousePointer = 11
        
        If ValidaElimi() Then
            
            Envia = Array()
            AddParam Envia, CDbl(TxtCodigo.Text)
            AddParam Envia, txtNombre.Text
            AddParam Envia, cmbOperacion.Tag
            
            If Bac_Sql_Execute("SP_GRABA_OMA ", Envia) Then
                
                If Bac_SQL_Fetch(Datos()) Then
                    
                    If Trim(Datos(1)) <> "OK" Then
                        
                        MsgBox " No se puede grabar registro ", 64, TITSISTEMA
                    
                    Else
                        
                        MsgBox " Registro Grabado Correctamente ", 64, TITSISTEMA
                         Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_651 " _
                                    , "01" _
                                    , "Grabar Codigo" _
                                    , "AYUDA_PLANILLA " _
                                    , " " _
                                    , "Grabar Codigo" & " " & Str(CDbl(TxtCodigo.Text)) & " Descripcion " & txtNombre.Text & " Tipo Operacion " & Trim(cmbOperacion.Text))
                        Call Limpiar
                    
                    End If
                
                End If
            
            End If
        
        End If
        
        Me.MousePointer = 0
        
    Case 2
    
        If ValidaElimi() Then
        
            If MsgBox("Está seguro de eliminar el registro", 36, TITSISTEMA) = 6 Then
                
                Envia = Array()
                AddParam Envia, CDbl(txtcodigo.Text)
                If Not Bac_Sql_Execute("SP_BORRA_OMA ", Envia) Then
                    If Bac_SQL_Fetch(Datos()) Then
                        If Trim(Datos(1)) <> "OK" Then
                            MsgBox " No se puede eliminar registro ", 64, TITSISTEMA
                        End If
                    End If
                Else
                    MsgBox "Regitro Eliminado ", vbInformation, TITSISTEMA
                    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_651 " _
                                    , "03" _
                                    , "Eliminar" _
                                    , "AYUDA_PLANILLA " _
                                    , " " _
                                    , "Eliminar" & " " & Str(CDbl(TxtCodigo.Text)) & " " & txtNombre.Text)
                End If
                Call Limpiar
            Else
                TxtCodigo.Enabled = True
                TxtCodigo.SetFocus
            End If
            
        End If
        
    Case 3
        Call Limpiar
        
    Case 4
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_651 " _
                                    , "08" _
                                    , "Salir Opcion De Menu" _
                                    , " " _
                                    , " " _
                                    , " ")
        Unload Me
        
    End Select
    
End Sub
Private Sub txtCodigo_DblClick()
    BacControlWindows 100
    BacAyuda.Tag = "tbCodigosOMA"
    BacAyuda.Show 1
    If giAceptar% Then
        Call ActivaBoton(True)
        TxtCodigo.Text = CDbl(gsCodigo$)
        txtNombre.Text = gsGlosa$
        bacBuscarCombo cmbOperacion, CDbl(gsDigito)
        txtNombre.SetFocus
    End If
End Sub
Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF3 Then
        Call txtCodigo_DblClick
    End If
End Sub
Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn And Len(Trim(TxtCodigo.Text)) > 0 Then
        Call ActivaBoton(True)
        Envia = Array()
        AddParam Envia, TxtCodigo.Text
        
        If Not Bac_Sql_Execute("SP_CODIGO_OMA", Envia) Then
            Exit Sub
        End If
        
        If Bac_SQL_Fetch(Datos()) Then
            ' Encontro el registro
            txtNombre.Text = Trim(Datos(3))
            bacBuscarCombo cmbOperacion, CDbl(Left(Datos(2), 2))
            
            cmbOperacion_LostFocus
            Call CargaPanel(True)
            
        Else
            ' No encontro el registro
            
            Call CargaPanel(False)
        End If
        txtNombre.SetFocus
    Else
        If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
            KeyAscii = 0
        End If
    End If
    
End Sub
Private Sub TxtNombre_Change()
    If Trim(txtNombre.Text) <> "" Then
        Toolbar1.Buttons(1).Enabled = True
    End If
End Sub
Private Sub txtNombre_KeyPress(KeyAscii As Integer)
    Call BacToUCase(KeyAscii)
    If KeyAscii = 13 And Trim(txtNombre) <> "" Then
        SendKeys "{tab}"
    End If
End Sub
