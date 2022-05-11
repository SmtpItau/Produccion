VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form FrmClientesHipotecaria 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Clientes"
   ClientHeight    =   2775
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9060
   Icon            =   "BacMantenedor_Clientes.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2775
   ScaleWidth      =   9060
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   9060
      _ExtentX        =   15981
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9660
      Top             =   45
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
            Picture         =   "BacMantenedor_Clientes.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMantenedor_Clientes.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMantenedor_Clientes.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMantenedor_Clientes.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMantenedor_Clientes.frx":131A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   2235
      Left            =   90
      TabIndex        =   7
      Top             =   465
      Width           =   8895
      Begin Threed.SSFrame SSFrame1 
         Height          =   2205
         Left            =   4725
         TabIndex        =   26
         Top             =   15
         Width           =   60
         _Version        =   65536
         _ExtentX        =   106
         _ExtentY        =   3889
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
      Begin BacControles.txtNumero txtrut_cliente 
         Height          =   315
         Left            =   1050
         TabIndex        =   0
         Top             =   180
         Width           =   1800
         _ExtentX        =   3175
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   8388608
         Text            =   "0"
         CantidadDecimales=   "0"
         Max             =   "99999999"
         MouseIcon       =   "BacMantenedor_Clientes.frx":1634
         MousePointer    =   99
      End
      Begin VB.ComboBox CmbComuna 
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
         Left            =   6270
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   1485
         Width           =   2550
      End
      Begin VB.ComboBox CmbCiudad 
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
         Left            =   6270
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   1155
         Width           =   2550
      End
      Begin VB.ComboBox CmbRegion 
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
         Left            =   6270
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   825
         Width           =   2550
      End
      Begin VB.ComboBox CmbPais 
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
         Left            =   6270
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   495
         Width           =   2550
      End
      Begin VB.TextBox txtemail_cliente 
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
         Left            =   1050
         TabIndex        =   6
         Top             =   1830
         Width           =   3165
      End
      Begin VB.TextBox txtfax_cliente 
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
         Left            =   1050
         TabIndex        =   5
         Top             =   1500
         Width           =   1635
      End
      Begin VB.TextBox txttelefono_cliente 
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
         Left            =   1050
         TabIndex        =   4
         Top             =   1170
         Width           =   1635
      End
      Begin VB.TextBox txtcod_cliente 
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
         Left            =   6255
         TabIndex        =   8
         Top             =   165
         Width           =   645
      End
      Begin VB.TextBox txtdv_cliente 
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
         Left            =   3120
         TabIndex        =   1
         Top             =   180
         Width           =   270
      End
      Begin VB.TextBox txtdirec_cliente 
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
         Left            =   1050
         TabIndex        =   3
         Top             =   840
         Width           =   3615
      End
      Begin VB.TextBox txtNombre_Cliente 
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
         Left            =   1050
         MouseIcon       =   "BacMantenedor_Clientes.frx":194E
         TabIndex        =   2
         Top             =   510
         Width           =   3615
      End
      Begin VB.Label email 
         BackStyle       =   0  'Transparent
         Caption         =   "E-Mail"
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
         Left            =   75
         TabIndex        =   23
         Top             =   1890
         Width           =   1200
      End
      Begin VB.Label fax 
         BackStyle       =   0  'Transparent
         Caption         =   "Fax"
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
         Left            =   75
         TabIndex        =   22
         Top             =   1560
         Width           =   1200
      End
      Begin VB.Label telefono 
         BackStyle       =   0  'Transparent
         Caption         =   "Teléfono"
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
         Left            =   60
         TabIndex        =   21
         Top             =   1230
         Width           =   1200
      End
      Begin VB.Label direccion 
         BackStyle       =   0  'Transparent
         Caption         =   "Dirección"
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
         Left            =   60
         TabIndex        =   20
         Top             =   885
         Width           =   1200
      End
      Begin VB.Label cod_com 
         BackStyle       =   0  'Transparent
         Caption         =   "Comuna"
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
         Height          =   375
         Left            =   4830
         TabIndex        =   19
         Top             =   1515
         Width           =   1200
      End
      Begin VB.Label cod_ciu 
         BackStyle       =   0  'Transparent
         Caption         =   "Ciudad"
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
         Height          =   375
         Left            =   4830
         TabIndex        =   18
         Top             =   1200
         Width           =   1200
      End
      Begin VB.Label cod_reg 
         BackStyle       =   0  'Transparent
         Caption         =   "Región"
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
         Height          =   375
         Left            =   4830
         TabIndex        =   17
         Top             =   855
         Width           =   1200
      End
      Begin VB.Label cod_pais 
         BackStyle       =   0  'Transparent
         Caption         =   "País"
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
         Height          =   375
         Left            =   4830
         TabIndex        =   16
         Top             =   540
         Width           =   1200
      End
      Begin VB.Label nombre_clie 
         BackStyle       =   0  'Transparent
         Caption         =   "Nombre"
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
         Left            =   60
         TabIndex        =   15
         Top             =   555
         Width           =   1200
      End
      Begin VB.Label Cod_Clie 
         BackStyle       =   0  'Transparent
         Caption         =   "Código Cliente"
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
         Left            =   4830
         TabIndex        =   14
         Top             =   225
         Width           =   1440
      End
      Begin VB.Label Rut_clie 
         BackStyle       =   0  'Transparent
         Caption         =   "Rut Cliente"
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
         Left            =   60
         TabIndex        =   13
         Top             =   240
         Width           =   1200
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2250
      Left            =   15
      TabIndex        =   25
      Top             =   510
      Width           =   9030
      _Version        =   65536
      _ExtentX        =   15928
      _ExtentY        =   3969
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
      BevelOuter      =   1
      BevelInner      =   1
   End
End
Attribute VB_Name = "FrmClientesHipotecaria"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim Combos(4)


Function ValidarDatos() As Boolean
   ValidarDatos = False
   If txtrut_cliente.Text = "" Then
      Exit Function
   ElseIf txtNombre_Cliente.Text = "" Then
      Exit Function
   ElseIf txtdv_cliente.Text = "" Then
      Exit Function
   ElseIf txtdirec_cliente.Text = "" Then
      Exit Function
   ElseIf txttelefono_cliente.Text = "" Then
      Exit Function
   ElseIf txtfax_cliente.Text = "" Then
      Exit Function
'   ElseIf txtemail_cliente.Text = "" Then
'      Exit Function
   ElseIf txtcod_cliente.Text = "" Then
      Exit Function
   ElseIf CmbPais.ListIndex = -1 Then
      Exit Function
'   ElseIf CmbRegion.ListIndex = -1 Then
'      Exit Function
'   ElseIf CmbCiudad.ListIndex = -1 Then
'      Exit Function
'   ElseIf CmbComuna.ListIndex = -1 Then
'      Exit Function
   End If
   ValidarDatos = True
End Function

Private Sub CmbCiudad_Click()
 Dim nCodigo As Integer
   If CmbCiudad.ListIndex > -1 Then
      nCodigo = CmbCiudad.ItemData(CmbCiudad.ListIndex)
      Call LlenarLocalidades(CmbComuna, COMUNA, nCodigo)
      
   End If
End Sub

Private Sub CmbPais_Click()
   Dim nCodigo As Integer
   If CmbPais.ListIndex > -1 Then
      nCodigo = CmbPais.ItemData(CmbPais.ListIndex)
      Call LlenarLocalidades(CmbRegion, REGION, nCodigo)
      CmbCiudad.Clear
      CmbComuna.Clear
   End If
End Sub



Private Sub CmbRegion_Click()
   Dim nCodigo As Integer
   If CmbRegion.ListIndex > -1 Then
      nCodigo = CmbRegion.ItemData(CmbRegion.ListIndex)
      Call LlenarLocalidades(CmbCiudad, CIUDAD, nCodigo)
      CmbCiudad.ListIndex = -1
      CmbComuna.Clear
   End If
End Sub

Sub Datos_Default()

    Dim X As Integer
      
   With Me.CmbPais
      For X = 0 To .ListCount - 1
         .ListIndex = X
         If CmbPais = UCase("Chile") Then
            Combos(1) = CmbPais.ListIndex
            Exit For
         End If
      Next X
   End With
   
   With Me.CmbRegion
      For X = 0 To .ListCount - 1
         .ListIndex = X
         If CmbRegion = UCase("Metropolitana") Then
            Combos(2) = CmbRegion.ListIndex
            Exit For
         End If
      Next X
   End With
   
   With Me.CmbCiudad
      For X = 0 To .ListCount - 1
         .ListIndex = X
         If CmbCiudad = UCase("Santiago") Then
            Combos(3) = CmbCiudad.ListIndex
            Exit For
         End If
      Next X
   End With

   With Me.CmbComuna
      For X = 0 To .ListCount - 1
         .ListIndex = X
         If CmbComuna = UCase("Santiago centro") Then
            Combos(4) = CmbComuna.ListIndex
            Exit For
         End If
      Next X
   End With
End Sub

Private Sub Form_Load()
   'txtNombre_Cliente.Enabled = False
   'txtcod_cliente.Enabled = False
      
   txtrut_cliente.Enabled = True
   txtdv_cliente.Enabled = True
   Call LlenarLocalidades(CmbPais, PAISES, 0)
   Call Datos_Default
End Sub


Public Function LlenarLocalidades(oCombo As Object, nCategoria As Integer, nCodigo As Integer) As Integer
   Dim Datos()
   LlenarLocalidades = True
   
   Envia = Array()
   AddParam Envia, nCategoria
   AddParam Envia, nCodigo
   
   If Not Bac_Sql_Execute("Sp_LeerLocalidades", Envia) Then
      MsgBox "Problemas al cargar localidades.", vbCritical, TITSISTEMA
      LlenarLocalidades = False
      Exit Function
   End If
   
   oCombo.Clear
   Do While Bac_SQL_Fetch(Datos())
      oCombo.AddItem Datos(2)
      oCombo.ItemData(oCombo.NewIndex) = Datos(1)
   Loop
   oCombo.ListIndex = -1
End Function


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
      Case 1 'Grabar
         If Not ValidarDatos() Then
            MsgBox "Información Incompleta", vbInformation, TITSISTEMA
            Exit Sub
         End If
        
        Call GrabarDatos
      
      Case 2 'Limpiar
         Call Limpiar
         Call HabilitarControles(False)
         Toolbar1.Buttons(2).Enabled = True
         txtrut_cliente.SetFocus
        
      Case 3 'Eliminar
           
         If MsgBox("¿Seguro de Eliminar el Cliente?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
               
            Envia = Array()
               
            AddParam Envia, CDbl(txtrut_cliente.Text)
            AddParam Envia, CDbl(txtcod_cliente.Text)
            
            If Not Bac_Sql_Execute("SP_LETRAS_HIPOTECARIA_ELIMINAR", Envia) Then
               
               MsgBox "No se eliminó el Cliente ", vbInformation, TITSISTEMA
               Exit Sub
            
            End If
          
            MsgBox "Eliminación se realizó correctamente", vbInformation, TITSISTEMA
            
            Call Limpiar
            Call HabilitarControles(False)
            
            Toolbar1.Buttons(2).Enabled = True
            txtrut_cliente.SetFocus
                
         End If
            
      Case Else 'Salir
      
         Unload Me
       
   End Select
   
End Sub







Private Sub txtdirec_cliente_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
If KeyAscii = 13 Then
   txttelefono_cliente.SetFocus
End If
End Sub

Private Sub txtdv_cliente_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
Select Case KeyAscii
   Case 13
      Call Valida_Datos
      txtNombre_Cliente.SetFocus
End Select

End Sub

Private Sub txtemail_cliente_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(LCase(Chr(KeyAscii)))
If KeyAscii = 13 Then
   txtcod_cliente.SetFocus
End If
End Sub

Private Sub txtnombre_cliente_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   If KeyAscii = 13 Then
   txtdirec_cliente.SetFocus
End If

End Sub

Private Function BacBuscaIndiceCombo(oCombo As ComboBox, nCodigo As Long) As Double
   Dim I As Long
   For I = 0 To oCombo.ListCount - 1
      If oCombo.ItemData(I) = nCodigo Then
         BacBuscaIndiceCombo = I
         Exit Function
      End If
   Next I
    
   BacBuscaIndiceCombo = -1

End Function



Private Sub txtRut_Cliente_DblClick()
   
   BacAyuda.Tag = "LETRA_HIPOTECARIA_CLIENTE"
   BacAyuda.Show vbModal
   

   
   If giAceptar% = True Then
      txtNombre_Cliente.Text = ltNombre
      txtrut_cliente.Text = ltRutCliente
      txtdv_cliente.Text = ltDigito
      txtdirec_cliente.Text = ltDireccion
      CmbPais.ListIndex = BacBuscaIndiceCombo(CmbPais, ltPais)
      CmbRegion.ListIndex = BacBuscaIndiceCombo(CmbRegion, ltCodRegion)
      CmbCiudad.ListIndex = BacBuscaIndiceCombo(CmbCiudad, ltCiudad)
      CmbComuna.ListIndex = BacBuscaIndiceCombo(CmbComuna, ltComuna)
      txtcod_cliente.Text = ltCodCliente
      txttelefono_cliente.Text = ltTelefono
      txtfax_cliente.Text = ltFax

      txtemail_cliente.Text = ltEMail
      txtrut_cliente.Enabled = False
      txtdv_cliente.Enabled = False
      txtNombre_Cliente.Enabled = False
      txtcod_cliente.Enabled = False
   End If
End Sub

Sub Limpiar()
   LimpiaYN = True
   txtNombre_Cliente.Text = " "
   txtrut_cliente.Text = " "
   txtdv_cliente.Text = " "
   txtdirec_cliente.Text = " "
   txtcod_cliente.Text = ""
   txttelefono_cliente = ""
   txtfax_cliente.Text = ""
   txtemail_cliente.Text = ""
   
   CmbPais.ListIndex = Combos(1)
   CmbRegion.ListIndex = Combos(2)
   CmbCiudad.ListIndex = Combos(3)
   CmbComuna.ListIndex = Combos(4)
   LimpiaYN = False
   
      
'   Call Datos_Default

 
 End Sub
Function HabilitarControles(Valor As Boolean)
   
   txtrut_cliente.Enabled = Not Valor
   txtdv_cliente.Enabled = Not Valor
   txtcod_cliente.Enabled = Not Valor
   txtNombre_Cliente.Enabled = Not Valor
   txtdirec_cliente.Enabled = Not Valor
   txttelefono_cliente.Enabled = Not Valor
   txtfax_cliente.Enabled = Not Valor
   txtemail_cliente.Enabled = Not Valor

    
End Function

Sub GrabarDatos()
   Dim nPais  As Integer
   Dim nRegion  As Integer
   Dim nCiudad  As Integer
   Dim nComuna  As Integer
   Envia = Array()
   
   AddParam Envia, CDbl(txtrut_cliente.Text)                  'Rut
   AddParam Envia, Trim(txtdv_cliente.Text)                         'Dig. Verificador
   AddParam Envia, CDbl(Trim(txtcod_cliente.Text))                  'Código
   AddParam Envia, Trim(txtNombre_Cliente.Text)                     'Nombre
   AddParam Envia, Trim(txtdirec_cliente.Text)                      'direccion
   AddParam Envia, Trim(txttelefono_cliente.Text)                   'telefono
   AddParam Envia, Trim(txtfax_cliente.Text)                                'Fax
   nRegion = 0
   If CmbPais.ListCount > 0 Then
      nPais = CmbPais.ItemData(CmbPais.ListIndex)
   End If
   If CmbRegion.ListCount > 0 Then
      nRegion = CmbRegion.ItemData(CmbRegion.ListIndex)
   End If
   If CmbCiudad.ListCount > 0 Then
      nCiudad = CmbCiudad.ItemData(CmbCiudad.ListIndex)
   End If
   If CmbComuna.ListCount > 0 Then
      nComuna = CmbComuna.ItemData(CmbComuna.ListIndex)
   End If
    
   AddParam Envia, Trim(txtemail_cliente.Text)                      'e-mail
   AddParam Envia, nPais      'combo pais
   AddParam Envia, nRegion    'combo region
   AddParam Envia, nCiudad 'combo ciudad
   AddParam Envia, nComuna 'combo comuna
               


    
         If Not Bac_Sql_Execute("SP_LETRAS_HIPOTECARIA_GRABAR", Envia) Then
            
            MsgBox "Error al Grabar el Cliente", vbCritical, TITSISTEMA
            Me.MousePointer = Default
            Exit Sub
         
         End If
         
         MsgBox "Grabación se realizó correctamente", vbInformation, TITSISTEMA
      
         Me.MousePointer = 0
         Call Limpiar
         HabilitarControles False
         Toolbar1.Buttons(3).Enabled = True
         txtrut_cliente.SetFocus
         
 
End Sub

Sub Valida_Datos()
Dim Existe   As Boolean

Existe = False
   Dim Datos()
      Envia = Array()
      AddParam Envia, Me.txtrut_cliente
      AddParam Envia, Me.txtdv_cliente
      
      If Not Bac_Sql_Execute("SP_HIPOTECARIA_VALIDA", Envia) Then
         MsgBox "Problemas al leer cliente", vbCritical, TITSISTEMA
         Exit Sub
      End If

      Do While Bac_SQL_Fetch(Datos())
            If UCase(Datos(1)) = UCase("No existe") Then
               Exit Do
            End If
            Existe = True
            txtrut_cliente.Text = Datos(2)
            txtNombre_Cliente.Text = Datos(1)
            txtdv_cliente.Text = Datos(12)
            txtdirec_cliente.Text = Datos(8)
            'CmbPais.ListIndex = BacBuscaIndiceCombo(CmbPais, Datos(4))
            'CmbRegion.ListIndex = BacBuscaIndiceCombo(CmbRegion, Datos(5))
            'CmbCiudad.ListIndex = BacBuscaIndiceCombo(CmbCiudad, Datos(6))
            'CmbComuna.ListIndex = BacBuscaIndiceCombo(CmbComuna, Datos(7))
            txtcod_cliente.Text = Datos(3)
            txttelefono_cliente.Text = Datos(9)
            txtfax_cliente.Text = Datos(10)
            txtemail_cliente.Text = Datos(11)
            txtrut_cliente.Enabled = False
            txtdv_cliente.Enabled = False
            txtNombre_Cliente.Enabled = False
            txtcod_cliente.Enabled = False
      Loop
      If Existe = False Then
         'MsgBox "Cliente no Existe", vbInformation, "Bac Trader"
      End If
      On Error Resume Next
      txtNombre_Cliente.SetFocus
End Sub

Private Sub txtRut_Cliente_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
   Case 13
      If Len(txtrut_cliente.Text) > 5 Then
         txtdv_cliente.Text = BacDevuelveDig(txtrut_cliente.Text)
         txtdv_cliente.Enabled = False
         txtcod_cliente.Text = 1
         Call Valida_Datos
      End If
End Select
End Sub
Private Sub txtrut_cliente_LostFocus()
   If Len(txtrut_cliente.Text) > 5 Then
      txtdv_cliente.Text = BacDevuelveDig(txtrut_cliente.Text)
      txtdv_cliente.Enabled = False
      txtcod_cliente.Text = 1
      Call Valida_Datos
   End If
End Sub

Private Sub txttelefono_cliente_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   txtfax_cliente.SetFocus
End If
End Sub
Private Sub txtfax_cliente_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   txtemail_cliente.SetFocus
End If
End Sub


Public Function BacDevuelveDig(Rut As String) As String

   Dim I       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim multi   As Double

   BacDevuelveDig = ""
    
   rut_cliente = Format(rut_cliente, "00000000")
   D = 2
   For I = 8 To 1 Step -1
      multi = Val(Mid$(Rut, I, 1)) * D
     Suma = Suma + multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next I
    
   Divi = (Suma \ 11)
   multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacDevuelveDig = UCase(Digito)

End Function



