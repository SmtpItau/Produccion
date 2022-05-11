VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacMntGlosa 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   " Mantención de Glosas por Clientes"
   ClientHeight    =   2175
   ClientLeft      =   1245
   ClientTop       =   2340
   ClientWidth     =   5160
   FillStyle       =   0  'Solid
   Icon            =   "Bacmntgo.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2175
   ScaleWidth      =   5160
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4860
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
            Picture         =   "Bacmntgo.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntgo.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntgo.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntgo.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   13
      Top             =   0
      Width           =   5160
      _ExtentX        =   9102
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
      Height          =   1605
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   5160
      _Version        =   65536
      _ExtentX        =   9102
      _ExtentY        =   2831
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
      Begin Threed.SSFrame Frame 
         Height          =   585
         Index           =   0
         Left            =   45
         TabIndex        =   6
         Top             =   15
         Width           =   5040
         _Version        =   65536
         _ExtentX        =   8890
         _ExtentY        =   1032
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
         Begin VB.TextBox TxtGlosa 
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
            Left            =   1350
            MaxLength       =   35
            MouseIcon       =   "Bacmntgo.frx":11E2
            MousePointer    =   99  'Custom
            TabIndex        =   7
            Top             =   165
            Width           =   3615
         End
         Begin VB.Label Label 
            Caption         =   " Glosa"
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
            Left            =   45
            TabIndex        =   12
            Top             =   180
            Width           =   1500
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   960
         Index           =   1
         Left            =   60
         TabIndex        =   1
         Top             =   570
         Width           =   5025
         _Version        =   65536
         _ExtentX        =   8864
         _ExtentY        =   1693
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
            Height          =   315
            Left            =   1320
            MaxLength       =   35
            TabIndex        =   11
            Top             =   510
            Width           =   3615
         End
         Begin VB.TextBox Txtrut 
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
            Left            =   1320
            MaxLength       =   9
            MouseIcon       =   "Bacmntgo.frx":14EC
            MousePointer    =   99  'Custom
            TabIndex        =   8
            Top             =   165
            Width           =   1290
         End
         Begin VB.TextBox Txtdigito 
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
            Left            =   2670
            MaxLength       =   1
            TabIndex        =   9
            Top             =   165
            Width           =   255
         End
         Begin VB.TextBox txtcodigo 
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
            Left            =   3810
            MaxLength       =   20
            TabIndex        =   10
            Top             =   165
            Width           =   1125
         End
         Begin VB.Label Label 
            Caption         =   " Nombre"
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
            Left            =   45
            TabIndex        =   5
            Top             =   510
            Width           =   1170
         End
         Begin VB.Label Label1 
            Caption         =   " Rut Cliente"
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
            Left            =   30
            TabIndex        =   4
            Top             =   210
            Width           =   1140
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "-"
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
            Left            =   2595
            TabIndex        =   3
            Top             =   165
            Width           =   75
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
            Index           =   4
            Left            =   3030
            TabIndex        =   2
            Top             =   210
            Width           =   780
         End
      End
   End
End
Attribute VB_Name = "BacMntGlosa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim sql As String, Datos()

Function ActivaBoton(Valor As Boolean)
  TxtGlosa.Enabled = Not Valor
  txtcodigo.Enabled = Valor
  TxtNombre.Enabled = Valor
  Txtrut.Enabled = Valor
  Txtdigito.Enabled = Valor
  Toolbar1.Buttons(1).Enabled = Valor
  Toolbar1.Buttons(2).Enabled = Valor
End Function
Private Sub Form_Load()
 Me.Top = 0
 Me.Left = 0
 Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_660" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
 
 Call ActivaBoton(False)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
   Case 1
      Me.MousePointer = 11
      
      If ValidaElimi() Then
       Envia = Array()
       AddParam Envia, Txtrut
       AddParam Envia, txtcodigo
       AddParam Envia, Trim(TxtGlosa.Text)
       
       If Bac_Sql_Execute("SP_GGLOS  ", Envia) Then
       
          If Bac_SQL_Fetch(Datos()) Then
          
              If Trim(Datos(1)) = "NO" Then
                  MsgBox "No se puede grabar el registro", 64, TITSISTEMA
              End If
              
          End If
          
       Else
         MsgBox "Grabación se realizó con éxito ", 64, TITSISTEMA
          Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_660 " _
                          , "01" _
                          , "Grabar, Mantencion Glosa" _
                          , "ABREVIATURA_CLIENTE " _
                          , " " _
                          , "Grabar, Mantencion Glosa" & " " & Trim(TxtGlosa.Text) & " " & Trim(TxtNombre.Text))
       End If
      End If
        Call Limpiar
        Me.MousePointer = 0
        
   Case 2
   
       If ValidaElimi() Then
       
            If MsgBox("Está seguro de eliminar el registro", 36, TITSISTEMA) = 6 Then
                Envia = Array()
                AddParam Envia, Txtrut
                AddParam Envia, txtcodigo
                AddParam Envia, Trim(TxtGlosa.Text)
                
                If Bac_Sql_Execute("SP_EGLOS  ", Envia) Then
                    
                    If Bac_SQL_Fetch(Datos()) Then
                    
                        If Trim(Datos(1)) <> "OK" Then
                            MsgBox "No puede Eliminar el Registro hay Datos", vbExclamation, TITSISTEMA
                        End If
                    
                    Else
                        MsgBox " Registro eliminado ", 64, TITSISTEMA
                        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                        , gsbac_fecp _
                        , gsBac_IP _
                        , gsBAC_User _
                        , "PCA" _
                        , "OPC_660 " _
                        , "03" _
                        , "Elimina, Mantencion Glosa" _
                        , "ABREVIATURA_CLIENTE " _
                        , " " _
                        , "Elimina, Mantencion Glosa" & " " & Trim(TxtGlosa.Text) & " " & Trim(TxtNombre.Text))
                    End If
                    
                Else
                       MsgBox "Problemas con procedimiento 'sp_eglos'", vbExclamation, TITSISTEMA
                End If
                
                Call Limpiar
                
            Else
                Txtrut.SetFocus
                
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
                          , "OPC_660 " _
                          , "08" _
                          , "SALIR DE OPCION MENU " _
                          , " " _
                          , " " _
                          , " ")
      Unload Me
      
End Select

End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)
 Call BacToUCase(KeyAscii)
 
 If KeyAscii = 13 Then
  Call BuscaCliGlosa(Txtrut.Text, txtcodigo.Text)
  txtcodigo.SetFocus
 End If
 
End Sub

Private Sub txtglosa_DblClick()
    BacControlWindows 100
    BacAyuda.Tag = "MECLA"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        Call ActivaBoton(True)
        Txtdigito.Text = gsDigito$
        TxtGlosa.Text = gsGlosa$
        Txtrut.Text = gsCodigo$
        TxtNombre.Text = gsDescripcion$
        txtcodigo.Text = gsValor
        
        Txtrut.Enabled = True
        Txtdigito.Enabled = True
        TxtNombre.Enabled = True
        txtcodigo.Enabled = True
    End If
    
End Sub
Public Function CargaPanel(Valor As Boolean)
Toolbar1.Buttons(1).Enabled = Valor
Toolbar1.Buttons(2).Enabled = Valor
  
End Function

Private Sub txtglosa_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then Call txtglosa_DblClick
End Sub

Private Sub txtGlosa_KeyPress(KeyAscii As Integer)

  If KeyAscii% = vbKeyReturn And Len(Trim(TxtGlosa.Text)) > 0 Then
        
        Call ActivaBoton(True)
        Envia = Array()
        AddParam Envia, TxtGlosa.Text
        
        If Not Bac_Sql_Execute("SP_CLIENTE_ABREVIADO", Envia) Then
            MsgBox "Problemas Con Procedimiento Almacenado, 'sp_Cliente_Abreviado' ", vbCritical
            'txtrut.SetFocus
            Exit Sub
        End If
        
        If Bac_SQL_Fetch(Datos()) Then
            ' Encontro el registro
            Txtrut.Text = CDbl(CDbl(Datos(1)))
            Txtdigito.Text = Trim(Datos(2))
            TxtNombre.Text = Trim(Datos(3))
            txtcodigo.Text = CDbl(CDbl(Datos(4)))
        End If
        
        Txtdigito.Enabled = False
        TxtNombre.Enabled = False
        Txtrut.SetFocus
  
  Else
     Call BacToUCase(KeyAscii)
  End If
  
 End Sub

Private Sub TxtNombre_Change()
  If Trim(TxtNombre.Text) <> "" Then Toolbar1.Buttons(1).Enabled = True
End Sub
Private Sub txtNombre_KeyPress(KeyAscii As Integer)
 Call BacToUCase(KeyAscii)
 If KeyAscii = 13 And Trim(TxtNombre) <> "" Then SendKeys "{tab}"
End Sub
Public Function Limpiar()
 TxtGlosa = ""
 txtcodigo = ""
 TxtNombre = ""
 Txtrut = ""
 Txtdigito = ""
 Call ActivaBoton(False)
 TxtGlosa.SetFocus
End Function
Public Function ValidaElimi()
  ValidaElimi = True
  If (TxtGlosa) = "" Then
    MsgBox "ERROR : Glosa vacía", 16, TITSISTEMA
    TxtGlosa.SetFocus
    ValidaElimi = False
   End If
   If Trim$(Txtrut) = "" Then
       MsgBox "ERROR :Rut vacío", 16, TITSISTEMA
       Txtrut.SetFocus
       ValidaElimi = False
   End If
   If (txtcodigo) = "" Then
    MsgBox "ERROR : Código vacío", 16, TITSISTEMA
    txtcodigo.SetFocus
    ValidaElimi = False
   End If
 End Function

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 And Trim(txtcodigo) <> "" Then
  Call BuscaCliGlosa(Txtrut.Text, txtcodigo.Text)
 End If
 
End Sub

Private Sub txtRut_DblClick()
   BacControlWindows 100
   'BacAyuda.Tag = "MDCL_U"
   'BacAyuda.Show 1
   BacAyudaCliente.Tag = "MDCL_U"
   BacAyudaCliente.Show 1
   
 If giAceptar% = True Then
   TxtNombre.Text = gsNombre
   Txtrut.Text = gsCodigo
   txtcodigo.Text = gsCodCli
   Txtdigito.Text = gsDigito
   Call BuscaCliGlosa(Txtrut.Text, txtcodigo.Text)
 End If
 
End Sub

Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then Call txtRut_DblClick
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 And Trim(Txtrut) <> "" Then
  SendKeys "{TAB}"
 Else
  If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then KeyAscii = 0
 End If
End Sub

Public Sub BuscaCliGlosa(varut As String, varutco As String)

   Envia = Array()
   AddParam Envia, varut
   AddParam Envia, varutco
  If Not Bac_Sql_Execute("SP_BACLINGREGEN_BUSCA_NOMBRE ", Envia) Then
     Exit Sub
  End If
  If Not Bac_SQL_Fetch(Datos()) Then
     MsgBox "Rut erróneo", 16, TITSISTEMA
     Call Limpiar
  Else
     Txtdigito.Text = Datos(3)
     TxtNombre.Text = Datos(1)
     txtcodigo.Text = Datos(4)
  End If
End Sub
