VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form baccliente 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Ingreso de Clientes"
   ClientHeight    =   3075
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8175
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3075
   ScaleWidth      =   8175
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame SSFrame1 
      Height          =   2535
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   8175
      _Version        =   65536
      _ExtentX        =   14420
      _ExtentY        =   4471
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
      Begin VB.ComboBox cmbTipoCliente 
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
         ItemData        =   "baccliente.frx":0000
         Left            =   240
         List            =   "baccliente.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1920
         Width           =   4095
      End
      Begin Threed.SSFrame SSFrame7 
         Height          =   690
         Left            =   120
         TabIndex        =   1
         Top             =   120
         Width           =   7875
         _Version        =   65536
         _ExtentX        =   13891
         _ExtentY        =   1217
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
         Begin BACControles.TXTNumero TXTnumrut 
            Height          =   255
            Left            =   720
            TabIndex        =   12
            Top             =   240
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   450
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
         Begin VB.TextBox TxtCodigo 
            Alignment       =   1  'Right Justify
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
            Height          =   285
            Left            =   3600
            MaxLength       =   5
            TabIndex        =   6
            Text            =   "1"
            Top             =   240
            Width           =   525
         End
         Begin VB.TextBox txtDigito 
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
            Height          =   285
            Left            =   2160
            MaxLength       =   1
            TabIndex        =   5
            Top             =   240
            Width           =   255
         End
         Begin MSComctlLib.ImageList ImageList1 
            Left            =   3000
            Top             =   1560
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
                  Picture         =   "baccliente.frx":0004
                  Key             =   ""
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "baccliente.frx":0456
                  Key             =   ""
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "baccliente.frx":08A8
                  Key             =   ""
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "baccliente.frx":0BC2
                  Key             =   ""
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "baccliente.frx":0EDC
                  Key             =   ""
               EndProperty
            EndProperty
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
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
            Height          =   195
            Index           =   31
            Left            =   2790
            TabIndex        =   4
            Top             =   315
            Width           =   600
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "R.U.T."
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
            Left            =   75
            TabIndex        =   3
            Top             =   300
            Width           =   585
         End
         Begin VB.Label Label2 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   375
            Left            =   1980
            TabIndex        =   2
            Top             =   200
            Width           =   135
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   1575
         Left            =   120
         TabIndex        =   7
         Top             =   840
         Width           =   7875
         _Version        =   65536
         _ExtentX        =   13891
         _ExtentY        =   2778
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
         Begin VB.TextBox txt_telefono 
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
            Left            =   4320
            MaxLength       =   20
            TabIndex        =   24
            TabStop         =   0   'False
            Top             =   1080
            Width           =   1935
         End
         Begin VB.TextBox Txt_Apellido2 
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
            Left            =   2040
            MaxLength       =   20
            TabIndex        =   20
            TabStop         =   0   'False
            Top             =   360
            Visible         =   0   'False
            Width           =   1815
         End
         Begin VB.TextBox txt_Apellido1 
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
            Left            =   120
            MaxLength       =   20
            TabIndex        =   19
            TabStop         =   0   'False
            Top             =   360
            Visible         =   0   'False
            Width           =   1935
         End
         Begin VB.TextBox txt_Nombre2 
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
            Left            =   5760
            MaxLength       =   20
            TabIndex        =   18
            TabStop         =   0   'False
            Top             =   360
            Visible         =   0   'False
            Width           =   1935
         End
         Begin VB.TextBox Txt_Nombre1 
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
            Left            =   3840
            MaxLength       =   20
            TabIndex        =   17
            TabStop         =   0   'False
            Top             =   360
            Visible         =   0   'False
            Width           =   1935
         End
         Begin Threed.SSOption opt_Juridica 
            Height          =   255
            Left            =   6720
            TabIndex        =   16
            Top             =   1200
            Width           =   1095
            _Version        =   65536
            _ExtentX        =   1931
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Jurídica"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Value           =   -1  'True
         End
         Begin Threed.SSOption opt_natural 
            Height          =   255
            Left            =   6720
            TabIndex        =   15
            Top             =   840
            Width           =   1095
            _Version        =   65536
            _ExtentX        =   1931
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Natural"
            ForeColor       =   8388608
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
            Height          =   285
            Left            =   120
            MaxLength       =   70
            TabIndex        =   13
            TabStop         =   0   'False
            Top             =   360
            Width           =   7575
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Telefono"
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
            Index           =   5
            Left            =   4320
            TabIndex        =   25
            Top             =   720
            Width           =   765
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Materno"
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
            Left            =   2160
            TabIndex        =   23
            Top             =   120
            Width           =   705
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Paterno"
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
            Left            =   120
            TabIndex        =   22
            Top             =   120
            Width           =   675
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Nombres"
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
            Left            =   3960
            TabIndex        =   21
            Top             =   120
            Width           =   750
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Clasificación Cliente"
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
            Index           =   7
            Left            =   120
            TabIndex        =   14
            Top             =   720
            Width           =   1740
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Nombres"
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
            Index           =   21
            Left            =   120
            TabIndex        =   8
            Top             =   120
            Width           =   750
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   8175
      _ExtentX        =   14420
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cód. Contable"
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
         Left            =   7095
         TabIndex        =   11
         Top             =   630
         Width           =   1215
      End
   End
End
Attribute VB_Name = "baccliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Digito As String
Dim Datos()
Private Sub HabilitaJuridica(valor As Boolean)
            Label(21).Visible = valor
            Label(2).Visible = Not valor
            Label(3).Visible = Not valor
            Label(4).Visible = Not valor
            Txt_Nombre1.Visible = Not valor
            txt_Nombre2.Visible = Not valor
            txt_Apellido1.Visible = Not valor
            Txt_Apellido2.Visible = Not valor
            TxtNombre.Visible = valor
            

End Sub

Private Sub Grabar()
Envia = Array()
AddParam Envia, CDbl(TXTnumrut.Text)
AddParam Envia, txtDigito.Text
AddParam Envia, TxtCodigo.Text
AddParam Envia, TxtNombre.Text
AddParam Envia, cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex)
AddParam Envia, Format(gsBac_Fecp, "YYYYMMDD")
AddParam Envia, Txt_Nombre1.Text
AddParam Envia, txt_Nombre2.Text
AddParam Envia, txt_Apellido1.Text
AddParam Envia, Txt_Apellido2.Text
AddParam Envia, IIf(opt_Juridica.Value, "J", "N")
AddParam Envia, txt_telefono.Text

If Not Bac_Sql_Execute("SP_GRABAR_CLIENTE", Envia) Then
        MsgBox "Falla al grabar Cliente", vbCritical
        Exit Sub
End If
        
Do While Bac_SQL_Fetch(Datos())
     If Datos(1) = "OK" Then
       MsgBox "Cliente Grabado OK", vbExclamation
       BacIrfGr.txtRutCli = CDbl(TXTnumrut.Text)
       Unload Me
     End If
Loop
    

End Sub

Private Sub Limpiar()
   TxtNombre.Text = ""
   TxtNombre.Tag = ""
   cmbTipoCliente.ListIndex = 4
   opt_Juridica.Value = True
   opt_natural.Value = False
   HabilitaJuridica (True)
   txt_telefono.Text = ""
   
End Sub

Private Sub Form_Activate()
If TXTnumrut.Text <> " " Then
        Call BacValidaRut(Str(TXTnumrut.Text), 0)
        txtDigito.Text = devolver
        cmbTipoCliente.ListIndex = 4
        TxtNombre.SetFocus
End If
End Sub

Private Sub Form_Load()
 
     Envia = Array()
     
     AddParam Envia, 72
     If Not Bac_Sql_Execute(gsSQL_Database_comun & "..sp_leercodigos", Envia) Then Exit Sub
     
     Do While Bac_SQL_Fetch(Datos())
             cmbTipoCliente.AddItem Trim(Datos(6)) & Space(60) & Trim(Datos(1)) & Space(10) & Trim(Datos(2))
             cmbTipoCliente.ItemData(cmbTipoCliente.NewIndex) = Datos(2)
     
     Loop
         
    opt_Juridica.Value = True
    opt_natural.Value = False
     
    HabilitaJuridica (True)
     
End Sub

Private Sub opt_Juridica_Click(Value As Integer)
        HabilitaJuridica (1)
            
End Sub

Private Sub opt_natural_Click(Value As Integer)
        HabilitaJuridica (0)
        
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 Dim NOMBRE        As String * 40
 Dim fecingr       As Date
 Dim OPTI          As String
 Dim TipoCliente   As String
 Select Case Button.Index
      Case 1
      
         Me.MousePointer = 11
         If cmbTipoCliente.ListIndex >= 0 Then
            TipoCliente = cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex)
         Else
            TipoCliente = 0
         End If
         
         If opt_natural.Value Then
            
            If Txt_Nombre1.Text = "" Or txt_Nombre2.Text = "" Or txt_Apellido1.Text = "" Or Txt_Apellido2.Text = "" Then
                MsgBox "Nombre Incompleto", vbCritical
                Exit Sub
            End If
         
            TxtNombre.Text = Txt_Nombre1.Text & " " & txt_Nombre2.Text & " " & txt_Apellido1.Text & " " & Txt_Apellido2.Text
            
         End If
         
         If Trim(txt_telefono.Text) = "" Then
            MsgBox "Ingrese Telefono", vbCritical
            Exit Sub
         End If
         
         If Trim(TxtNombre.Text) = "" Then
            MsgBox "Ingrese Nombre", vbCritical
            Me.MousePointer = 0
            TxtNombre.SetFocus
            Exit Sub
         End If
         
         Call Grabar
         
   Case 2
        Call Limpiar
        
   Case 3
        Unload Me
        
 End Select
End Sub

Private Sub txt_Apellido1_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub Txt_Apellido2_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub Txt_Nombre1_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_Nombre2_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
      BacCaracterNumerico KeyAscii
   End If
     
   
End Sub

Private Sub TxtCodigo_LostFocus()
   Dim idRut     As Long
   Dim IdDig     As String
   Dim IdCod     As Long
   Dim Bandera   As Integer
   Dim I As Long

   If Val(TXTnumrut.Text) = 0 Or Trim(txtDigito.Text) = "" Then Exit Sub
   
  Bandera = True
  
  If Trim(TxtCodigo.Text) = "" Or TXTnumrut.Text = 0 Then
      
      If Val(TxtCodigo) = 0 Then
         MsgBox "Error : El código no puede ser 0 ", 16, TITSISTEMA
      Else
         MsgBox "Error : Datos en Blanco ", 16, TITSISTEMA
      End If
      
      Call Limpiar
'      Call HabilitarControles(False)
      TXTnumrut.SetFocus
      
      Exit Sub
 End If
 
 idRut = TXTnumrut.Text
 IdDig = txtDigito.Text
 IdCod = TxtCodigo

 Call Busca_Cliente(idRut, IdDig, IdCod)
 
 'txtgeneric.SetFocus

End Sub
Function Busca_Cliente(nRut As Long, nDigito As String, nCodigo As Long) As Boolean
Dim Sql As String
Dim Datos()
Dim datosSTR As String
Dim nCont As Integer

Screen.MousePointer = 11

    Busca_Cliente = False
        
    Envia = Array()
    
    AddParam Envia, CDbl(nRut)
    AddParam Envia, nDigito
    AddParam Envia, CDbl(nCodigo)
          
    If Not Bac_Sql_Execute("bacparamsuda..SP_MDCLLEERRUT", Envia) Then
        
        MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
        Exit Function
    
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
    
    'TEXTOS
      TXTnumrut.Text = Datos(1)
      txtDigito.Text = Datos(2)
      TxtCodigo.Text = Val(Datos(3))
      TxtNombre.Text = Datos(4)
      TxtNombre.Tag = TxtNombre.Text
      opt_Juridica.Value = IIf(Datos(32) = "J", True, False)
      opt_natural.Value = IIf(Datos(32) = "N", True, False)
      txt_telefono.Text = Datos(12)
      
      If opt_natural.Value Then
         Txt_Nombre1.Text = Datos(22)
         txt_Nombre2.Text = Datos(23)
         txt_Apellido1.Text = Datos(24)
         Txt_Apellido2.Text = Datos(25)
      
      End If


      If cmbTipoCliente.ListIndex >= 0 Then
         
         For nCont = 0 To cmbTipoCliente.ListCount - 1
            
            If cmbTipoCliente.ItemData(nCont) = Datos(14) Then
               cmbTipoCliente.ListIndex = nCont
               Exit For
            End If
            
         Next
         
      End If
          
     Screen.MousePointer = 0
    End If
End Function


Private Sub txtDigito_KeyPress(KeyAscii As Integer)
BacToUCase KeyAscii
If KeyAscii = 13 Then
  If BacValidaRut(Str(TXTnumrut.Text), txtDigito.Text) = False Then
     MsgBox "Nº RUT. invalido", vbOKOnly + vbExclamation, TITSISTEMA
     txtDigito.Text = ""
     'TXTNumRut.Text = 0
     TXTnumrut.SetFocus
    Else
     TxtCodigo.SetFocus
  End If
End If

End Sub

Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    cmbTipoCliente.SetFocus
End If
End Sub

Private Sub TxtNombre_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TXTNumRut_KeyPress(KeyAscii As Integer)
 If KeyAscii = vbKeyReturn Then
     txtDigito.SetFocus
 End If
End Sub
