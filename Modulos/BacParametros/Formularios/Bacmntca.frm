VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacMntCateg 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Categorías"
   ClientHeight    =   3090
   ClientLeft      =   2010
   ClientTop       =   150
   ClientWidth     =   5910
   Icon            =   "Bacmntca.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   MousePointer    =   99  'Custom
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3090
   ScaleWidth      =   5910
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5265
      Top             =   135
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
            Picture         =   "Bacmntca.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntca.frx":075E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntca.frx":0BB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntca.frx":0ED2
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
      Width           =   5910
      _ExtentX        =   10425
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
      Height          =   2550
      Left            =   0
      TabIndex        =   11
      Top             =   540
      Width           =   5895
      _Version        =   65536
      _ExtentX        =   10398
      _ExtentY        =   4498
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
      Begin VB.Frame Frame1 
         Caption         =   "Indicadores"
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
         Height          =   1575
         Left            =   120
         TabIndex        =   10
         Top             =   840
         Width           =   5655
         Begin VB.CheckBox chkIGlosa 
            Caption         =   "    Indicador  de  Glosa"
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
            Height          =   255
            Left            =   240
            TabIndex        =   7
            Top             =   1200
            Width           =   2655
         End
         Begin VB.CheckBox chkIValor 
            Caption         =   "    Indicador  de  Valor"
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
            Height          =   255
            Left            =   240
            TabIndex        =   5
            Top             =   960
            Width           =   2655
         End
         Begin VB.CheckBox chkIFecha 
            Caption         =   "    Indicador  de  Fecha"
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
            Height          =   255
            Left            =   240
            TabIndex        =   4
            Top             =   720
            Width           =   2655
         End
         Begin VB.CheckBox chkITasa 
            Caption         =   "    Indicador  de  Tasa"
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
            Height          =   255
            Left            =   240
            TabIndex        =   3
            Top             =   480
            Width           =   2655
         End
         Begin VB.CheckBox chkICodigo 
            Caption         =   "    Indicador  de  Código"
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
            Height          =   255
            Left            =   240
            TabIndex        =   2
            Top             =   240
            Width           =   2655
         End
      End
      Begin VB.TextBox txtDesCategoria 
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
         Height          =   285
         Left            =   1440
         MaxLength       =   25
         TabIndex        =   1
         Top             =   480
         Width           =   4335
      End
      Begin VB.TextBox txtNCategoria 
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
         Height          =   285
         Left            =   120
         MaxLength       =   4
         MouseIcon       =   "Bacmntca.frx":11F2
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   480
         Width           =   885
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Descripción "
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
         Left            =   1440
         TabIndex        =   9
         Top             =   240
         Width           =   1080
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Nº Categoría"
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
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   1125
      End
   End
End
Attribute VB_Name = "BacMntCateg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim objCategoria As Object
Dim Paso As Long

Function ValidarDatos() As Boolean

   ValidarDatos = True
   
   If txtNCategoria.Text = "" Then
      MsgBox "ERROR : Debe ingresar número de categoría", vbCritical, TITSISTEMA
      txtNCategoria.SetFocus
      ValidarDatos = False
   End If
   
   If txtDesCategoria.Text = "" Then
      MsgBox "ERROR : Debe ingresar descripción de categoría", vbCritical, TITSISTEMA
      txtDesCategoria.SetFocus
      ValidarDatos = False
   End If
   
End Function



Public Sub Limpiar()
    txtNCategoria.Text = ""
    txtDesCategoria.Text = ""
    chkICodigo.Value = 0
    chkITasa.Value = 0
    chkIFecha.Value = 0
    chkIValor.Value = 0
    chkIGlosa.Value = 0
End Sub



Private Sub chkICodigo_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
End Sub

Private Sub chkIFecha_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
End Sub

Private Sub chkIGlosa_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
End Sub

Private Sub chkITasa_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
End Sub

Private Sub chkIValor_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
End Sub

Private Sub cmdEliminar_Click()
If MsgBox("Esta Seguro de Eliminar la Categoría", 36, "Eliminación de Registro") = 6 Then
        If Elimina_Sql Then
             MsgBox "Eliminación se realizó con exito", vbInformation, TITSISTEMA
        Else
            MsgBox "Eliminación no se realizó con exito", vbInformation, TITSISTEMA
        End If
 End If
    
End Sub



Function Elimina_Sql() As Boolean
  
  If objCategoria.Eliminar(txtNCategoria.Text) = True Then
      Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_619 " _
                                    , "03" _
                                    , "Elimina" _
                                    , " " _
                                    , " " _
                                    , "Elimina" & " " & Trim(txtDesCategoria.Text) & " " & Trim(txtNCategoria.Text))
      Call Limpiar
      Call HabilitarControles(False)
      txtNCategoria.SetFocus
      Elimina_Sql = True
   Else
   
      'MsgBox "Error : No eliminó Categoría ", vbcritical, "Bac-Trader"
      Elimina_Sql = False
   End If

End Function

Private Sub cmdGrabar_Click()
   Dim CODI      As Variant
   Dim codigo    As Integer
   'Norepi = 1
   Sw = 0

   Me.MousePointer = 11

   If Not ValidarDatos() Then   'Valdiaci¢n de los datos del cliente.
      Me.MousePointer = 0
      Exit Sub
   End If
   
      If Grabar_SQL() Then
           MsgBox " La grabación se realizó con exito", vbInformation, TITSISTEMA
      Else
            MsgBox " La grabación no se realizó con exito", vbCritical, TITSISTEMA
      End If
End Sub



Function Grabar_SQL() As Boolean

With objCategoria
   .ctCategoria = txtNCategoria.Text
   
   .ctDescripcion = txtDesCategoria.Text
   .ctICod = IIf(chkICodigo.Value = 1, "1", "0")
   .ctITasa = IIf(chkITasa.Value = 1, "1", "0")
   .ctIFecha = IIf(chkIFecha.Value = 1, "1", "0")
   .ctIValor = IIf(chkIValor.Value = 1, "1", "0")
   .ctIGlosa = IIf(chkIGlosa.Value = 1, "1", "0")
   
   If objCategoria.Grabar() Then
       Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_619 " _
                                    , "01" _
                                    , "Grabar" _
                                    , " " _
                                    , " " _
                                    , "Grabar" & " " & Trim(txtDesCategoria.Text) & " " & Trim(txtNCategoria.Text))
                                    
      'MsgBox "Grabación se realizó con exito ", vbInformation, "Bac-Cambio"
      Call Limpiar
      Call HabilitarControles(False)
      txtNCategoria.SetFocus
      Grabar_SQL = True
   Else
      'MsgBox "ERROR :Grabación no se llevo a cabo ", vbcritical, "Bac-Cambio"
      Grabar_SQL = False
   End If

   Me.MousePointer = 0
End With
End Function


Private Sub cmdlimpiar_Click()
    Call Limpiar
    HabilitarControles False
End Sub

Private Sub cmdSalir_Click()
Unload Me
End Sub

Private Sub Form_Load()
On Error GoTo Eti1
   Me.Top = 0
   Me.Left = 0
   Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_619" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
   
   
   Paso = 1
   Set objCategoria = New clsCategorias
'objmensajecl.Valores
Exit Sub
Eti1:
  MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
  Unload Me
  Exit Sub
End Sub




Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
          Dim CODI      As Variant
   Dim codigo    As Integer
   'Norepi = 1
   Sw = 0

   Me.MousePointer = 11

   If Not ValidarDatos() Then   'Valdiaci¢n de los datos del cliente.
      Me.MousePointer = 0
      Exit Sub
   End If
   
      If Grabar_SQL() Then
           MsgBox " La grabación se realizó con exito", vbInformation, TITSISTEMA
      Else
            MsgBox " La grabación no se realizó con exito", vbCritical, TITSISTEMA
      End If
    Case 2
        If MsgBox("Esta Seguro de Eliminar la Categoría", 36, TITSISTEMA) = 6 Then
        If Elimina_Sql Then
             MsgBox "Eliminación se realizó con exito", vbInformation, TITSISTEMA
        Else
            MsgBox "Eliminación no se realizó con exito", vbInformation, TITSISTEMA
        End If
 End If
    Case 3
            Call Limpiar
    HabilitarControles False

    Case 4
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_619 " _
                                    , "08" _
                                    , "Salir Opcion De Menu" _
                                    , " " _
                                    , " " _
                                    , " ")
        Unload Me
End Select
End Sub

Private Sub txtDesCategoria_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        SendKeys$ "{TAB}"
    Else
        BacToUCase KeyAscii
    End If
End Sub

Private Sub txtNCategoria_DblClick()

BacControlWindows 100

BacAyuda.Tag = "MDCT"
BacAyuda.Show 1

If giAceptar% = True Then
      
    txtNCategoria.Text = Val(gsCodigo$)
        
    Call HabilitarControles(True)
    Paso = 0
    'SendKeys "{TAB}"
End If

    
End Sub

Private Sub HabilitarControles(Valor As Boolean)
    txtNCategoria.Enabled = Not Valor
    txtDesCategoria.Enabled = Valor
    chkICodigo.Enabled = Valor
    chkIFecha.Enabled = Valor
    chkIGlosa.Enabled = Valor
    chkITasa.Enabled = Valor
    chkIValor.Enabled = Valor
    
    
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    
    Toolbar1.Buttons(3).Enabled = Valor
End Sub

Private Sub txtNCategoria_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF3 Then Call txtNCategoria_DblClick
End Sub

Private Sub txtNCategoria_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      txtDesCategoria.Enabled = True
      SendKeys$ "{TAB}"
    
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
   End If
     
   BacCaracterNumerico KeyAscii
End Sub

Private Sub txtNCategoria_LostFocus()
   Dim codigo     As Integer
   Dim Bandera   As Integer

 Bandera = True
 If Trim(txtNCategoria) = "" Then
   Call Limpiar
   Call HabilitarControles(False)
   Exit Sub
 Else
     codigo = txtNCategoria.Text
   
      If objCategoria.LeerPorCateg(codigo) = True Then
         Call HabilitarControles(True)
         Call Limpiar
            txtNCategoria.Text = codigo
            txtDesCategoria.Text = objCategoria.ctDescripcion
            chkICodigo.Value = Val(objCategoria.ctICod)
            chkITasa.Value = Val(objCategoria.ctITasa)
            chkIFecha.Value = Val(objCategoria.ctIFecha)
            chkIValor.Value = Val(objCategoria.ctIValor)
            chkIGlosa.Value = Val(objCategoria.ctIGlosa)
                     txtDesCategoria.SetFocus
         
     Else
         MsgBox "Error : En Carga de Datos", vbCritical, TITSISTEMA
         Exit Sub
     End If
End If

     Paso = 1
End Sub
