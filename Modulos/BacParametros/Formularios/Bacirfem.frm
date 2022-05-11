VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIrfEm 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Datos de Emisión"
   ClientHeight    =   3510
   ClientLeft      =   1020
   ClientTop       =   1635
   ClientWidth     =   6975
   ClipControls    =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacirfem.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3510
   ScaleWidth      =   6975
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   26
      Top             =   0
      Width           =   6975
      _ExtentX        =   12303
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbaceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3210
      Top             =   4770
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfem.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacirfem.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame Frame 
      Height          =   1455
      Index           =   1
      Left            =   2925
      TabIndex        =   2
      Top             =   510
      Width           =   2055
      _Version        =   65536
      _ExtentX        =   3625
      _ExtentY        =   2566
      _StockProps     =   14
      Caption         =   "Fecha"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTFecha dtbFecVct 
         Height          =   255
         Left            =   840
         TabIndex        =   24
         Top             =   960
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "09/11/2000"
      End
      Begin BACControles.TXTFecha dtbFecEmi 
         Height          =   255
         Left            =   840
         TabIndex        =   23
         Top             =   600
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "09/11/2000"
      End
      Begin VB.Label Label 
         Caption         =   "Vcto."
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   4
         Top             =   1000
         Width           =   675
      End
      Begin VB.Label Label 
         Caption         =   "Emisión"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   3
         Top             =   550
         Width           =   735
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1335
      Index           =   3
      Left            =   45
      TabIndex        =   5
      Top             =   2010
      Width           =   6855
      _Version        =   65536
      _ExtentX        =   12091
      _ExtentY        =   2355
      _StockProps     =   14
      Caption         =   "Emisor"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.TextBox txtRut 
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1215
         MaxLength       =   9
         MouseIcon       =   "Bacirfem.frx":0BAE
         MousePointer    =   99  'Custom
         TabIndex        =   9
         Top             =   360
         Width           =   1215
      End
      Begin VB.TextBox TxtNom 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1200
         TabIndex        =   8
         Top             =   780
         Width           =   5520
      End
      Begin VB.TextBox txtDig 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   2580
         MaxLength       =   1
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   7
         Top             =   360
         Visible         =   0   'False
         Width           =   315
      End
      Begin VB.TextBox TxtGen 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4720
         TabIndex        =   6
         Top             =   360
         Width           =   2000
      End
      Begin VB.Label Label 
         Caption         =   "-"
         Height          =   315
         Index           =   8
         Left            =   2460
         TabIndex        =   13
         Top             =   360
         Visible         =   0   'False
         Width           =   135
      End
      Begin VB.Label Label 
         Caption         =   "RUT"
         Height          =   255
         Index           =   6
         Left            =   240
         TabIndex        =   12
         Top             =   390
         Width           =   735
      End
      Begin VB.Label Label 
         Caption         =   "Nombre"
         Height          =   255
         Index           =   7
         Left            =   240
         TabIndex        =   11
         Top             =   840
         Width           =   735
      End
      Begin VB.Label Label 
         Caption         =   "Genérico"
         Height          =   255
         Index           =   9
         Left            =   3805
         TabIndex        =   10
         Top             =   390
         Width           =   870
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1455
      Index           =   2
      Left            =   5085
      TabIndex        =   14
      Top             =   510
      Width           =   1815
      _Version        =   65536
      _ExtentX        =   3201
      _ExtentY        =   2566
      _StockProps     =   14
      Caption         =   "Tasa"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTNumero ftbTasEmi 
         Height          =   255
         Left            =   840
         TabIndex        =   25
         Top             =   480
         Width           =   855
         _ExtentX        =   1508
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
      End
      Begin VB.ComboBox cmbBasEmi 
         Height          =   315
         ItemData        =   "Bacirfem.frx":0EB8
         Left            =   840
         List            =   "Bacirfem.frx":0EC5
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   960
         Width           =   855
      End
      Begin VB.Label Label 
         Caption         =   "Base"
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   17
         Top             =   1000
         Width           =   495
      End
      Begin VB.Label Label 
         Caption         =   "Emisión"
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   16
         Top             =   550
         Width           =   675
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1455
      Index           =   0
      Left            =   45
      TabIndex        =   18
      Top             =   510
      Width           =   2775
      _Version        =   65536
      _ExtentX        =   4895
      _ExtentY        =   2566
      _StockProps     =   14
      Caption         =   "Instrumento"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.TextBox txtNemo 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1240
         TabIndex        =   20
         Top             =   480
         Width           =   1455
      End
      Begin VB.ComboBox cmbMonEmi 
         Height          =   315
         ItemData        =   "Bacirfem.frx":0ED7
         Left            =   1200
         List            =   "Bacirfem.frx":0ED9
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   960
         Width           =   1455
      End
      Begin VB.Label Label 
         Caption         =   "Nemotécnico"
         Height          =   255
         Index           =   0
         Left            =   70
         TabIndex        =   22
         Top             =   550
         Width           =   1125
      End
      Begin VB.Label Label 
         Caption         =   "Moneda"
         Height          =   255
         Index           =   1
         Left            =   90
         TabIndex        =   21
         Top             =   1000
         Width           =   735
      End
   End
   Begin Threed.SSCommand cmdAceptar 
      Height          =   450
      Left            =   180
      TabIndex        =   1
      Top             =   4755
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Aceptar"
      ForeColor       =   8388608
      Font3D          =   3
   End
   Begin Threed.SSCommand cmdCancelar 
      Height          =   450
      Left            =   1455
      TabIndex        =   0
      Top             =   4830
      Visible         =   0   'False
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Cancelar"
      ForeColor       =   8388608
      Font3D          =   3
   End
End
Attribute VB_Name = "BacIrfEm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim objMonedas  As New clsMonedas
Dim objBasEmi   As New clsCodigos
Dim objEmisor   As New clsEmisor

'Flag para indicar que el Form_Activate los realizo una sola vez
Dim giLoad%

'
Public varPsSeriado As String

Private Sub Ayuda()

    If Me.Tag = "CP;FMUTUO" Then
        BacAyuda.Tag = "MDEMO2"
    Else
        BacAyuda.Tag = "MDEM"
    End If
    BacAyuda.Show 1
    BacControlWindows 12
    If giAceptar% = True Then
        txtRut.Text = gsCodigo$
        txtDig.Text = gsDigito$
        TxtNom.Text = gsDescripcion$
        TxtGen.Text = gsGenerico$
        'SendKeys "{TAB}"
    End If

End Sub

Private Function chkDatEmi() As Boolean

    'Tasa de Emisión puede ser cero siempre y cuando la referencia de nominales no sea de emision
    'Fecha de Emisión es obligatoria siempre y cuando la referencia de nominales sea de emisión
    'Fecha de Vencimiento es obligatoria siempre cuando es CI,VI.
    'Moneda siempre obligatoria
    'Base siempre obligatoria
    'RUT obligatorio
    
    chkDatEmi = False
    
    If cmbMonEmi.ListIndex = -1 And cmbMonEmi.Enabled = True Then
        MsgBox "MONEDA DE EMISION OBLIGATORIA", vbExclamation, "MENSAJE"
        cmbMonEmi.SetFocus
        Exit Function
    ElseIf Trim$(dtbFecEmi.Text) = "" And dtbFecEmi.Enabled = True And BacDatEmi.sRefNomi = "E" Then
        MsgBox "FECHA DE EMISION OBLIGATORIA PARA INSTRUMENTOS CON REFERENCIA NOMINAL DE EMISION", vbExclamation, gsBac_Version
        dtbFecEmi.SetFocus
        Exit Function
    ElseIf Trim$(dtbFecVct.Text) = "" And dtbFecVct.Enabled = True Then
        MsgBox "FECHA DE VENCIMIENTO OBLIGATORIA", vbExclamation, "MENSAJE"
        dtbFecVct.SetFocus
        Exit Function
    ElseIf Trim$(ftbTasEmi.Text) = "" And ftbTasEmi.Enabled = True And BacDatEmi.sRefNomi = "E" Then
        MsgBox "Tasa de Emisión Obligatoria para Instrumentos con referencia nominal de emisión", vbExclamation, gsBac_Version
        ftbTasEmi.SetFocus
        Exit Function
    ElseIf cmbBasEmi.ListIndex = -1 And cmbBasEmi.Enabled = True Then
        MsgBox "Base Obligatoria", vbExclamation, gsBac_Version
        cmbBasEmi.SetFocus
        Exit Function
    ElseIf Val(txtRut.Text) = 0 And txtRut.Enabled = True Then
        MsgBox "Rut emisor obligatorio", vbExclamation, gsBac_Version
        txtRut.SetFocus
        Exit Function
    End If
    
    chkDatEmi = True
    
End Function

Private Sub cmdAceptar_Click()
        
'    If chkDatEmi() = False Then
'        Exit Sub
'    End If
'
'    With BacDatEmi
'        .lRutemi = Val(txtRut.Text)
'        .iMonemi = cmbMonEmi.ItemData(cmbMonEmi.ListIndex)
'        .sFecEmi = dtbFecEmi.Text
'        .sFecvct = dtbFecVct.Text
'        .dTasEmi = Val(ftbTasEmi.Text)
'        .iBasemi = cmbBasEmi.List(cmbBasEmi.ListIndex)
'        .sGeneri = TxtGen.Text
'    End With
'
'    giAceptar% = True
'    Unload BacIrfEm
        
End Sub

Private Sub cmdCancelar_Click()

'    giAceptar% = False
'    Unload Me
'
End Sub

'Private Sub dtbFecVct_Change()
'    If Not CDate(BacEsHabil(dtbFecVct.Text)) Then
'        MsgBox "Fecha de Vencimiento no es dia habil"
'        dtbFecVct.SetFocus
'        giAceptar% = False
'    ElseIf CDate(dtbFecVct.Text) <= CDate(gsBac_Fecp) Then
'        MsgBox "Fecha de Vencimiento no puede ser menor a Fecha de Proceso"
'        dtbFecVct.SetFocus
'        giAceptar% = False
'    Else
'        giAceptar% = True
'    End If
'
'End Sub

'Private Sub dtbFecVct_KeyPress(KeyAscii As Integer)
'
'    If Not CDate(BacEsHabil(dtbFecVct.Text)) Then
'        MsgBox "Fecha de Vencimiento no es dia habil"
'        dtbFecVct.SetFocus
'        giAceptar% = False
'    ElseIf CDate(dtbFecVct.Text) <= CDate(gsBac_Fecp) Then
'        MsgBox "Fecha de Vencimiento no puede ser menor a Fecha de Proceso"
'        dtbFecVct.SetFocus
'        giAceptar% = False
'    Else
'        giAceptar% = True
'    End If
'
'End Sub

Private Sub dtbFecVct_LostFocus()
    If Not CDate(BacEsHabilGar(dtbFecVct.Text)) Then
       'MsgBox "Fecha de Vencimiento no es dia habil"
        If dtbFecVct.Enabled Then
            dtbFecVct.SetFocus
        End If
        giAceptar% = False
        giAceptar% = True '--> Ha solicitud de Mascareño con Correo del Día 13-01-2009.-
                          '--> Asunto : -- MEJORA --- Papeles con Fecha de Vcto en dia no habil
    ElseIf CDate(dtbFecVct.Text) <= CDate(gsbac_fecp) Then
        MsgBox "Fecha de Vencimiento no puede ser menor a Fecha de Proceso"
        dtbFecVct.SetFocus
        giAceptar% = False
    Else
        giAceptar% = True
    End If

End Sub

Private Sub Form_Activate()
    
    '¿Viene del evento Load?
    If giLoad% = False Then
        'No
        Exit Sub
    End If
    
    BacControlWindows 100
    
    Call objMonedas.LeerMonedas
    Call objMonedas.Coleccion2Combo(cmbMonEmi)
    Call objEmisor.LeerPorRut(BacDatEmi.lRutemi, "O")
  ' Falta cargar Correctamente las bases
  ' =====================================
  ' Call objBasEmi.LeerCodigos(11)
  ' Call objBasEmi.Coleccion2Control(cmbBasEmi)
  '
    BacControlWindows 100
    
    txtNemo.Text = BacDatEmi.sInstSer
    dtbFecEmi.Text = BacDatEmi.sFecEmi
    dtbFecVct.Text = BacDatEmi.sFecvct
    ftbTasEmi.Text = BacDatEmi.dTasEmi
    
    txtRut.Text = objEmisor.emrut
    txtDig.Text = objEmisor.emdv
    TxtNom.Text = objEmisor.emnombre
    TxtGen.Text = objEmisor.emgeneric
    TxtGen.Tag = objEmisor.emcodigo
    
    cmbMonEmi.ListIndex = BacBuscaComboIndice(cmbMonEmi, BacDatEmi.iMonemi)
    cmbBasEmi.ListIndex = BacBuscaComboGlosa(cmbBasEmi, BacDatEmi.iBasemi)
    
    'Deshabilita controles de los que ya se tiene el dato
    
    If Trim$(dtbFecEmi.Text) <> "" Then dtbFecEmi.Enabled = False
    If Trim$(dtbFecVct.Text) <> "" Then dtbFecVct.Enabled = False
    If ftbTasEmi.Text > 0 Then ftbTasEmi.Enabled = False
    
    If txtRut.Text > 0 Then
        txtRut.Enabled = False
        txtDig.Enabled = False
    End If
    
    If cmbMonEmi.ListIndex <> -1 Then cmbMonEmi.Enabled = False
    If cmbBasEmi.ListIndex <> -1 Then cmbBasEmi.Enabled = False
    
    
' Vb+ 31/03/1999 se desabilita fecha de emision para papeles no seriados
    If varPsSeriado = "N" Then
        Label(2).Visible = False
        dtbFecEmi.Visible = False
    Else
        Label(2).Visible = True
        dtbFecEmi.Visible = True
    End If
' VB- 31/03/1999

    If Me.Tag = "VP" Or Me.Tag = "VI" Then
        Frame(0).Enabled = False
        Frame(1).Enabled = False
        Frame(2).Enabled = False
        Frame(3).Enabled = False
        'cmdAceptar.Enabled = False
        Toolbar1.Buttons(2).Enabled = False
    ElseIf Me.Tag = "CP;FMUTUO" Then
        Me.dtbFecVct.Text = DateAdd("d", 1, gsbac_fecp) ' CDate(gsBac_Fecp)
        Me.txtRut.Enabled = True
        Me.dtbFecVct.Enabled = True
    End If
    
    giLoad% = False
    Screen.MousePointer = 0
    
End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)

        If KeyAscii% = vbKeyReturn Then
                SendKeys "{TAB}"
                KeyAscii% = 0
        End If
        
End Sub

Private Sub Form_Load()
   
    BacCentrarPantalla Me
    giAceptar% = False
    giLoad% = True
    Tipo_Carga = "MN"
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
  
  If Tipo_Carga = "AU" And giAceptar% <> True Then
      Cancel = 1
      MsgBox "Debe Ingresar un Emisor para Continuar con la Carga Automatica ", vbCritical, TITSISTEMA
      giAceptar% = False
      Exit Sub
  End If

    
    
    
    Set objMonedas = Nothing
    Set objBasEmi = Nothing
    Set objEmisor = Nothing
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Call dtbFecVct_LostFocus
If giAceptar% Then
    Select Case UCase(Button.Description)
        
        Case "ACEPTAR"
            Call TBACEPTAR
        Case "CANCELAR"
                giAceptar% = False
                Unload Me
        
    End Select
End If
End Sub
Private Sub TBACEPTAR()
If chkDatEmi() = False Then
        Exit Sub
    End If
            
    With BacDatEmi
        .lRutemi = Val(txtRut.Text)
        .lCodemi = Val(TxtGen.Tag)
        .iMonemi = cmbMonEmi.ItemData(cmbMonEmi.ListIndex)
        .sNemo = cmbMonEmi.List(cmbMonEmi.ListIndex)
        .sFecEmi = dtbFecEmi.Text
        .sFecvct = dtbFecVct.Text
        .dTasEmi = Val(ftbTasEmi.Text)
        .iBasemi = cmbBasEmi.List(cmbBasEmi.ListIndex)
        .sGeneri = TxtGen.Text

    End With
    
    giAceptar% = True
    Unload BacIrfEm
End Sub

Private Sub TxtRut_DblClick()

    Call Ayuda
    Screen.MousePointer = 0
End Sub

Private Sub TxtRut_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = vbKeyF3 Then
        Call Ayuda
        Screen.MousePointer = 0
    End If

End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)

    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 Then
        KeyAscii = 0
    End If
    
End Sub

Private Sub txtrut_LostFocus()
    

    If Val(Trim$(txtRut.Text)) <> 0 Then
       ' VB+- 23/02/2000 Se desabilita port que debe tomar la información ingresada
       ' Call objEmisor.LeerPorRut(BacDatEmi.lRutemi)

         Call objEmisor.LeerPorRut(txtRut.Text, "O")
        
        If Val(objEmisor.emrut) = 0 Then
            MsgBox "Emisor ingresado no existe en maestro de emisores ", vbExclamation, "BAC Trader"
            txtRut.Text = ""
            'cmdAceptar.Enabled = False
            Toolbar1.Buttons(2).Enabled = False
            txtRut.SetFocus
        Else
            TxtNom.Text = objEmisor.emnombre
            TxtGen.Text = objEmisor.emgeneric
            TxtGen.Tag = objEmisor.emcodigo
            
            'cmdAceptar.Enabled = True
            Toolbar1.Buttons(2).Enabled = True
        End If
    End If
    
End Sub

Function BacBuscaComboGlosa(hCombo As ComboBox, ByVal Glosa As String) As Long

Dim i%

    For i = 0 To hCombo.ListCount - 1
        If Trim$(hCombo.List(i)) = Trim$(Glosa) Then
            BacBuscaComboGlosa = i
            Exit Function
        End If
    Next i
    
    BacBuscaComboGlosa = -1

End Function

Function BacBuscaComboIndice(hCombo As ComboBox, ByVal Codigo As Long) As Long

Dim i%

    For i = 0 To hCombo.ListCount - 1
        If hCombo.ItemData(i) = Codigo Then
            BacBuscaComboIndice = i
            Exit Function
        End If
    Next i
    
    BacBuscaComboIndice = -1

End Function

