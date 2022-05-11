VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Baccorrespon2 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Corresponsales"
   ClientHeight    =   3645
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8865
   Icon            =   "BacCorrespon2.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3645
   ScaleWidth      =   8865
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4200
      Top             =   0
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
            Picture         =   "BacCorrespon2.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCorrespon2.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCorrespon2.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCorrespon2.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCorrespon2.frx":11E2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9000
      _ExtentX        =   15875
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
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
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.TextBox txtCodMon 
         Height          =   285
         Left            =   2310
         TabIndex        =   12
         Text            =   "Text1"
         Top             =   240
         Visible         =   0   'False
         Width           =   1245
      End
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
   Begin Threed.SSFrame SSFrame2 
      Height          =   1575
      Left            =   135
      TabIndex        =   13
      Top             =   1965
      Width           =   8640
      _Version        =   65536
      _ExtentX        =   15240
      _ExtentY        =   2778
      _StockProps     =   14
      Caption         =   "Datos Corresponsal"
      ForeColor       =   128
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtCtaCte 
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
         Left            =   5145
         MaxLength       =   30
         TabIndex        =   7
         Top             =   495
         Width           =   3420
      End
      Begin VB.TextBox txtCorresponsal 
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
         Left            =   165
         MaxLength       =   45
         TabIndex        =   6
         Top             =   495
         Width           =   4950
      End
      Begin VB.TextBox txtMoneda 
         Alignment       =   2  'Center
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
         Left            =   5370
         MaxLength       =   9
         MouseIcon       =   "BacCorrespon2.frx":14FC
         MousePointer    =   99  'Custom
         TabIndex        =   10
         Tag             =   "13"
         Text            =   "USD"
         ToolTipText     =   "Haga doble click para ayuda"
         Top             =   1125
         Width           =   930
      End
      Begin VB.TextBox txtCodcc 
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
         Left            =   150
         MaxLength       =   4
         TabIndex        =   8
         Top             =   1125
         Width           =   1890
      End
      Begin VB.TextBox txtCodSwift 
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
         Left            =   2910
         MaxLength       =   11
         TabIndex        =   9
         Top             =   1125
         Width           =   1890
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Corresponsal"
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
         Index           =   25
         Left            =   225
         TabIndex        =   18
         Top             =   285
         Width           =   1110
      End
      Begin VB.Label Label 
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
         Index           =   27
         Left            =   5145
         TabIndex        =   17
         Top             =   285
         Width           =   615
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
         Index           =   5
         Left            =   210
         TabIndex        =   16
         Top             =   885
         Width           =   600
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código Swift "
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
         Index           =   30
         Left            =   2970
         TabIndex        =   15
         Top             =   885
         Width           =   1140
      End
      Begin VB.Label Label 
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
         Index           =   0
         Left            =   5370
         TabIndex        =   14
         Top             =   885
         Width           =   690
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1170
      Index           =   1
      Left            =   135
      TabIndex        =   19
      Top             =   705
      Width           =   8625
      _Version        =   65536
      _ExtentX        =   15214
      _ExtentY        =   2064
      _StockProps     =   14
      Caption         =   "Datos del Cliente"
      ForeColor       =   16512
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtgeneric 
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
         Left            =   5940
         MaxLength       =   5
         TabIndex        =   4
         Top             =   315
         Width           =   1185
      End
      Begin VB.TextBox txtrut 
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
         Height          =   285
         Left            =   915
         MaxLength       =   9
         MouseIcon       =   "BacCorrespon2.frx":1806
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   1
         ToolTipText     =   "Haga doble click para ayuda"
         Top             =   315
         Width           =   1125
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
         Left            =   2115
         MaxLength       =   1
         TabIndex        =   2
         Top             =   315
         Width           =   255
      End
      Begin VB.TextBox TxtCodigo 
         Alignment       =   2  'Center
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
         Left            =   3735
         MaxLength       =   5
         TabIndex        =   3
         Text            =   "1"
         Top             =   315
         Width           =   645
      End
      Begin VB.TextBox TxtNombre 
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
         Left            =   915
         MaxLength       =   40
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   675
         Width           =   7575
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Generico"
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
         Left            =   5025
         TabIndex        =   23
         Top             =   315
         Width           =   780
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
         Index           =   4
         Left            =   180
         TabIndex        =   22
         Top             =   315
         Width           =   585
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
         Left            =   3015
         TabIndex        =   21
         Top             =   315
         Width           =   600
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
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
         Height          =   195
         Index           =   2
         Left            =   180
         TabIndex        =   20
         Top             =   705
         Width           =   660
      End
   End
End
Attribute VB_Name = "Baccorrespon2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim LimpiaYN As Boolean
Dim sql$, Datos(), Sw%, Norepi%, VarPais%
Dim I%
Dim swauxiliar
Dim Digito As String
Public Generico As String

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Dim sql           As String
   Dim Datos()       As String

   
   Select Case Button.Index
   
      Case 1
      
         Me.MousePointer = 11
   
         If Not ValidarDatos() Then
            Me.MousePointer = 0
            Exit Sub
         End If
     
         Envia = Array()
   
         AddParam Envia, CDbl(Trim(txtrut.Text))
         AddParam Envia, Trim(txtMoneda)
         AddParam Envia, Trim(txtCorresponsal.Text)
         AddParam Envia, Trim(txtCtaCte.Text)
         AddParam Envia, Trim(txtCodSwift.Text)
         AddParam Envia, Trim(txtCodcc.Text)
         AddParam Envia, Trim(txtCodigo.Text)
    
         If Not Bac_Sql_Execute("SP_GRABA_CORRESPONSAL", Envia) Then
            
            MsgBox "Error al Grabar el Cliente", vbCritical, TITSISTEMA
            Me.MousePointer = Default
            Exit Sub
         
         End If
         
         MsgBox "Grabación se realizó correctamente", vbInformation, TITSISTEMA
      
         Me.MousePointer = 0
         Call Limpiar
         HabilitarControles False
         Toolbar1.Buttons(3).Enabled = True
         txtrut.SetFocus
         
      Case 2
                                  
               Envia = Array()
               AddParam Envia, CDbl(txtrut.Text)
               AddParam Envia, CDbl(txtCodigo.Text)
               
               If MsgBox("¿Está Seguro de Eliminar los Datos del Corresponsal?.", vbInformation + vbYesNo, "Eliminar") = vbYes Then
            
                 If Not Bac_Sql_Execute("SP_ELIMINA_CORRESPONSAL", Envia) Then
                  
                      MsgBox "Error : No se Pudo Eliminar al Corresponsal ", vbCritical, TITSISTEMA
                      Exit Sub
    
                 Else
               
                      MsgBox "Los Datos Corresponsal, se han Eliminado", vbInformation, TITSISTEMA
                        
                      Call Limpiar
                      Call HabilitarControles(False)
                      Toolbar1.Buttons(3).Enabled = True
                      txtrut.SetFocus
                 End If
            
                Else
                      Exit Sub
                End If
            
            
            
      Case 3
         
         Call Limpiar
         Call HabilitarControles(False)
         Toolbar1.Buttons(3).Enabled = True
         
         txtrut.SetFocus
      
      Case 4
         
         Unload Me
   
   End Select

End Sub

Private Sub txtCodcc_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{tab}"
 ElseIf Not (KeyAscii <> 32) Then
   KeyAscii = 0
End If

End Sub

Private Sub TxtCodigo_LostFocus()

   Dim idRut     As Long
   Dim IdDig     As String
   Dim IdCod     As Long
   Dim Bandera   As Integer
   Dim I As Long
   
   If Val(txtrut.Text) = 0 Or Trim(txtDigito.Text) = "" Then Exit Sub
   
  Bandera = True
  
  If Trim(txtCodigo) = "" Or Trim(txtrut) = "" Then
      
      If Val(txtCodigo) = 0 Then
         MsgBox "Error : El código no puede ser 0 ", 16, TITSISTEMA
      Else
         MsgBox "Error : Datos en Blanco ", 16, TITSISTEMA
      End If
      
      Call Limpiar
      Call HabilitarControles(False)
      txtrut.SetFocus
      
      Exit Sub
 End If
 
 idRut = txtrut.Text
 IdDig = txtDigito.Text
 IdCod = txtCodigo

 Call Busca_Cliente(idRut, IdDig, IdCod)

End Sub

Private Sub txtCodMon_LostFocus()

Dim IDCodigo As Long
On Error GoTo Label1
    MousePointer = 11
    
    If txtCodMon.Text = "" Then
        
        MousePointer = 0
        Exit Sub
    
    End If
    
    If CDbl(txtCodMon.Text) = 0 Then
        
        MousePointer = 0
        Exit Sub
    
    End If
    
    IDCodigo = txtCodMon.Text
    Call LeerPorCodigo(IDCodigo)
    MousePointer = 0
    Exit Sub
Label1:
    If swa <> 1000 Then
      MousePointer = 0
      txtMoneda.Enabled = True
      
      Toolbar1.Buttons(1).Enabled = True
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = True
    Else
      MousePointer = 0
      txtMoneda.Enabled = True
      
      Toolbar1.Buttons(1).Enabled = True
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = True
    End If
    Sw = 0
End Sub

Private Sub txtCodSwift_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{tab}"
 ElseIf Not (KeyAscii <> 32) Then
   KeyAscii = 0
End If

End Sub

Private Sub txtCorresponsal_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{tab}"
End If
End Sub
Private Sub txtctacte_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{tab}"
 ElseIf Not (KeyAscii <> 32) Then
   KeyAscii = 0
End If

End Sub

Private Sub txtMoneda_DblClick()
    auxilio = 100
   Call CodigoMo
   If txtMoneda.Enabled = True Then
        txtMoneda.SetFocus
   End If

End Sub

Sub CodigoMo()
On Error GoTo Label1
    MousePointer = 11
    BacAyuda.Tag = "MDMN"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txtCodMon.Text = gsCodigo$
        txtCodMon_LostFocus
    End If
    MousePointer = 0
    txtCodcc.SetFocus
Exit Sub
Label1:
   
End Sub

Private Sub txtMoneda_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{tab}"
 ElseIf Not (KeyAscii <> 32) Then
   KeyAscii = 0
End If
End Sub

Private Sub txtRut_DblClick()
BacControlWindows 100
'BacAyuda.Tag = "MDCL"
'BacAyuda.Show 1
'Arm Se implementa nuevo formulario ayuda

BacAyudaCliente.Tag = "MDCL"
BacAyudaCliente.Show 1

If giAceptar% = True Then
   txtrut.Text = Val(gsrut$)
   txtDigito.Text = gsDigito$
   txtNombre.Text = gsNombre$
   txtgeneric.Text = gsgeneric$
  Call HabilitarControles(True)
   txtrut.Enabled = True
   txtDigito.Enabled = True
   txtCodigo.Enabled = True
   txtDigito.SetFocus
  Call HabilitarControles(True)
    SendKeys "{TAB}"
   giAceptar% = False
End If
End Sub

Function HabilitarControles(Valor As Boolean)
   txtrut.Enabled = Not Valor
   txtDigito.Enabled = Not Valor
   txtCodigo.Enabled = Not Valor
   txtNombre.Enabled = Valor
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   txtCodcc.Enabled = Valor
   txtCodSwift.Enabled = Valor
      
End Function
Private Sub txtrut_LostFocus()
   
If Len(txtrut.Text) > 5 Then
   Digito = BacDevuelveDig(txtrut.Text)
   txtDigito.Enabled = True
End If
   
End Sub
Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
    
    If KeyCode = vbKeyF3 Then Call txtRut_DblClick
    
End Sub
Private Sub txtRut_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      txtDigito.Enabled = True
      txtDigito.SetFocus
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
   End If
   BacCaracterNumerico KeyAscii
   
End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
      txtCodigo.Enabled = True
        txtCodigo.SetFocus
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
      KeyAscii = 0
   End If

   BacToUCase KeyAscii

End Sub
Private Sub txtDigito_LostFocus()

If txtrut.Text <> "" Then
If Digito <> txtDigito.Text Then
    MsgBox "Digito No corresponde al RUT.", vbOKOnly + vbExclamation, TITSISTEMA
    txtDigito.Text = ""
    If txtDigito.Enabled Then txtDigito.SetFocus
Else
End If
End If
End Sub

Function ValidarDatos() As Boolean

   ValidarDatos = True
 
   If Trim$(txtCodigo) = "" Then
      MsgBox "ERROR : Codigo Generico  vacio", 16, TITSISTEMA
      txtCodigo.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   If txtCorresponsal.Text = "" Then
      MsgBox "ERROR : Nombre Corresponsal vacio", 16, TITSISTEMA
      txtCorresponsal.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   If txtCtaCte.Text = "" Then
      MsgBox "ERROR : Cuenta esta vacia", 16, TITSISTEMA
      txtCtaCte.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   If txtCodcc.Text = "" Then
      MsgBox "ERROR : Código está vacio", 16, TITSISTEMA
      txtCodcc.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   If txtCodSwift.Text = "" Then
      MsgBox "ERROR : Código Swift está vacio", 16, TITSISTEMA
      txtCodSwift.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
    Dim largo
    largo = txtCodSwift
    Dim largo2
   If Len(txtCodSwift.Text) <> 8 Then
        If Len(txtCodSwift.Text) <> 11 Then
       MsgBox "ERROR : La Cantidad de Carácteres del Código Swift debe ser Ocho u Once", 16, TITSISTEMA
       txtCodSwift.SetFocus
       ValidarDatos = False
       
       End If
   End If
   
   If txtMoneda.Text = "" Then
      MsgBox "ERROR : Moneda esta vacia", 16, TITSISTEMA
      txtMoneda.SetFocus
      ValidarDatos = False
      Exit Function
   End If

End Function

Sub Limpiar()
   LimpiaYN = True
        txtrut.Text = ""
        txtDigito.Text = ""
        txtNombre.Text = ""
        txtNombre.Tag = ""
        txtgeneric.Text = ""
        txtCtaCte.Text = ""
        txtCorresponsal.Text = ""
        txtCodcc.Text = ""
        txtCodSwift.Text = ""
                
LimpiaYN = False
 
 End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

Norepi = 0

Me.Icon = BACSwapParametros.Icon

If KeyAscii = 13 Then SendKeys "{TAB}"

End Sub

Private Sub Form_Load()

On Error GoTo ErrMDB

   Me.Top = 0
   Me.Left = 0
   
   LimpiaYN = False
  
   swauxiliar = 0
       
   Call Grabar_Log_AUDITORIA(gsEntidad _
                                 , gsbac_fecp _
                                 , gsTerminal _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_790" _
                                 , "07" _
                                 , "INGRESO A OPCION" _
                                 , " " _
                                 , " " _
                                 , " ")
   
   Call HabilitarControles(False)
   txtNombre.Enabled = False
   
         Call Limpiar

         Call HabilitarControles(False)
         Toolbar1.Buttons(3).Enabled = True
         
Exit Sub

ErrMDB:

   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   
   Unload Me
   
   Exit Sub
   
End Sub

Private Sub Form_Unload(Cancel As Integer)
   
   Call Grabar_Log_AUDITORIA(gsEntidad _
                                 , gsbac_fecp _
                                 , gsTerminal _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_790" _
                                 , "08" _
                                 , "SALE DE OPCION" _
                                 , " " _
                                 , " " _
                                 , " ")

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

Function Busca_Cliente(nRut As Long, nDigito As String, nCodigo As Long) As Boolean
Dim sql As String
Dim Datos()

Screen.MousePointer = 11

    Busca_Cliente = False
    
    Envia = Array()
    
    AddParam Envia, CDbl(nRut)
    AddParam Envia, Trim(nDigito)
    AddParam Envia, CDbl(nCodigo)
          
    If Not Bac_Sql_Execute("SP_EXTRAE_DATOS_CLIENTE", Envia) Then
        
        MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
        Screen.MousePointer = 0
        Exit Function
    
    End If
       
    If Bac_SQL_Fetch(Datos()) Then
    
'      txtRut.Text = Val(Datos(1))
'      txtDigito.Text = Datos(2)
'      txtCodigo.Text = Val(Datos(3))
'      txtNombre.Text = Datos(4)
      txtgeneric.Text = Datos(5)
       
      txtRut.Text = Val(gsrut$)
      txtDigito.Text = gsDigito$
      txtNombre.Text = gsNombre$
      txtCodigo.Text = gsValor
       
      '************************************************************************************
      Envia = Array()
    
      AddParam Envia, CDbl(nRut)
      AddParam Envia, nCodigo
         
      If Not Bac_Sql_Execute("SP_BUSCA_CORRESPONSAL", Envia) Then
        
        MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
        Screen.MousePointer = 0
        Exit Function
    
      End If
         
      If Bac_SQL_Fetch(Datos()) Then
    
       txtMoneda.Text = Datos(3)
       txtCorresponsal.Text = Datos(5)
       txtCtaCte.Text = Datos(6)
       txtCodSwift.Text = Datos(7)
       txtCodcc.Text = Datos(4)
        
      End If
      
    Else
      ' No encontro cliente
      MsgBox "El Cliente no se Encuentra de Base de Datos SQL", vbCritical, TITSISTEMA
        Screen.MousePointer = 0
        Call Limpiar
        txtrut.SetFocus
      Exit Function
    End If
      
    HabilitarControles True

    If txtgeneric.Text = "" Then
       txtgeneric.Enabled = False
    End If
    
    Screen.MousePointer = 0
     
End Function


Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
  SendKeys "{tab}"
End If
End Sub

Public Function BacDevuelveDig(rut As String) As String

   Dim I       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""
    
   rut = Format(rut, "000000000")
   D = 2
   For I = 9 To 1 Step -1
      Multi = Val(Mid$(rut, I, 1)) * D
     Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next I
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacDevuelveDig = UCase(Digito)

End Function

Private Function LeerPorCodigo(CodMon As Long) As Boolean
Dim sql As String
    LeerPorCodigo = False
    Envia = Array()
    AddParam Envia, CodMon
    
    If Not Bac_Sql_Execute("SP_EXTRAE_MONEDA ", Envia) Then
       MsgBox "no se ejecuto la consulta", vbCritical
       Exit Function
    End If

    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
      txtMoneda.Text = Datos(2)
    Else
      swa = 1000
    
      txtMoneda.Text = ""
    
    End If
    
    LeerPorCodigo = True
    
End Function

