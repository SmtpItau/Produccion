VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BacInfSe 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Series"
   ClientHeight    =   1365
   ClientLeft      =   2970
   ClientTop       =   3360
   ClientWidth     =   2355
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacinfse.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1365
   ScaleWidth      =   2355
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   2355
      _ExtentX        =   4154
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel Panel 
      Height          =   795
      Index           =   1
      Left            =   -45
      TabIndex        =   1
      Top             =   585
      Width           =   2430
      _Version        =   65536
      _ExtentX        =   4286
      _ExtentY        =   1402
      _StockProps     =   15
      ForeColor       =   -2147483640
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Alignment       =   1
      Begin VB.TextBox txtMascara 
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
         Height          =   360
         Left            =   90
         MaxLength       =   10
         TabIndex        =   0
         Top             =   280
         Width           =   2205
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Máscara"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   90
         TabIndex        =   2
         Top             =   30
         Width           =   690
      End
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   1770
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfse.frx":2EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfse.frx":3361
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfse.frx":3857
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfse.frx":3CEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfse.frx":41D2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfse.frx":46E5
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfse.frx":4BB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfse.frx":507E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInfSe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal As String
Private objInfSerie      As Object
Private objInfMensajesSE As Object
Private objFamilia       As Object

Public proOrigen         As String
Function funcGeneraTablaDesarrollo(cMascara As String)
Dim cSql As String
Dim Datos()

    'cSql = "EXECUTE sp_creaprc '" & cMascara & "'"
    
    Envia = Array(cMascara)
    
    If Not BAC_SQL_EXECUTE("sp_creaprc", Envia) Then Exit Function
    'BacMnSe1.proOrigense = "CT"
    'BacMnSe1.Tag = cMascara
    'BacMnSe1.Show 1
    
End Function

Private Sub cmdImprimir_Click()
    Dim TitRpt
    If proOrigen = "PRN" Then
 '       Call Llenar_Parametros("INFORME DE SERIES")
    
        If objInfSerie.LeerSerie(txtMascara.Text) Then
            If objFamilia.LeerPorCodigo(objInfSerie.secodigo) Then
            
                If MsgBox("Desea imprimir serie : " + txtMascara.Text, 4, TITSISTEMA) = vbYes Then
                
                End If
            End If
        End If
        
        txtMascara.Text = ""
        
    End If
    
    If proOrigen = "MNT" Then
    
        If Mid$(txtMascara.Text, 1, 4) <> "PRC-" Then
            MsgBox "Iniciales de Mnemotecnico es erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        If Val(Mid$(txtMascara.Text, 5, 1)) < 1 And Val(Mid$(txtMascara.Text, 5, 1)) > 9 Then
            MsgBox "Indicador de tasa y cupones es erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        
        If Mid$(txtMascara.Text, 6, 1) <> "A" And Mid$(txtMascara.Text, 6, 1) <> "B" And Mid$(txtMascara.Text, 6, 1) <> "C" And Mid$(txtMascara.Text, 6, 1) <> "D" Then
            MsgBox "Indicador de cortes es erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        
        If Val(Mid$(txtMascara.Text, 7, 2)) < 1 And Val(Mid$(txtMascara.Text, 7, 2)) > 12 Then
            MsgBox "Mes de Emision es Erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        
        If Not IsNumeric(Mid$(txtMascara.Text, 9, 2)) Then
            MsgBox "Año de Emisión es erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        
        Call funcGeneraTablaDesarrollo(txtMascara.Text)
        
    End If
End Sub


Private Sub cmdSalir_Click()
        
        
        
End Sub


Private Sub Form_Activate()

   Screen.MousePointer = 0
   PROC_CARGA_AYUDA Me, " "
    If Me.proOrigen = "MNT" Then
        Me.Caption = "Generador Tabla Desarrollo PRC"
    Else
        Me.Caption = "Informe de Series"
    End If
    
End Sub

Private Sub Form_Load()
    Me.top = 0
    Me.left = 0

    OptLocal = Opt
    Set objFamilia = New clsFamilia
    Set objInfSerie = New clsSerie
    Set objInfMensajesSE = New ClsMsg
    
    Call objInfMensajesSE.Valores
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    
    Set objInfSerie = Nothing
    Set objInfMensajesSE = Nothing
   ' Set objFamilia = Nothing
   
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
            Dim TitRpt
    If proOrigen = "PRN" Then
        
        'Call Llenar_Parametros("INFORME DE SERIES")
        If objInfSerie.LeerSerie(txtMascara.Text) Then
            If objFamilia.LeerPorCodigo(objInfSerie.secodigo) Then
                If MsgBox("Desea imprimir serie : " + txtMascara.Text, 4, TITSISTEMA) = vbYes Then
                
                End If
            End If
        End If
        
        txtMascara.Text = ""
        Toolbar1.Buttons(1).Enabled = False
        
    End If
    
    If proOrigen = "MNT" Then
    
        If Mid$(txtMascara.Text, 1, 4) <> "PRC-" Then
            MsgBox "Iniciales de Mnemotecnico es erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        If Val(Mid$(txtMascara.Text, 5, 1)) < 1 And Val(Mid$(txtMascara.Text, 5, 1)) > 9 Then
            MsgBox "Indicador de tasa y cupones es erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        
        If Mid$(txtMascara.Text, 6, 1) <> "A" And Mid$(txtMascara.Text, 6, 1) <> "B" And Mid$(txtMascara.Text, 6, 1) <> "C" And Mid$(txtMascara.Text, 6, 1) <> "D" Then
            MsgBox "Indicador de cortes es erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        
        If Val(Mid$(txtMascara.Text, 7, 2)) < 1 And Val(Mid$(txtMascara.Text, 7, 2)) > 12 Then
            MsgBox "Mes de Emision es Erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        
        If Not IsNumeric(Mid$(txtMascara.Text, 9, 2)) Then
            MsgBox "Año de Emisión es erroneo", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        
        Call funcGeneraTablaDesarrollo(txtMascara.Text)
        
    End If
 
 Case 2
 
    Unload Me
    
 End Select
 
End Sub

Private Sub txtMascara_KeyPress(KeyAscii As Integer)
    BacToUCase KeyAscii
    If KeyAscii <> 13 Then
       Exit Sub
    End If
    
    KeyAscii = 0
    If objInfSerie.LeerSerie(Trim$(txtMascara.Text)) = True Then
         txtMascara.Text = objInfSerie.semascara
         If Trim$(objInfSerie.semascara) <> "" Then
         Else
            'MsgBox "No Existe La Serie " & Trim$(txtMascara.Text), 64, TITSISTEMA
            Exit Sub
         End If
    Else
         Call objInfMensajesSE.BacLeeMensaje(objInfMensajesSE.MSG_SEConeccion)
         txtMascara.Text = ""
         txtMascara.SetFocus
    End If

End Sub


