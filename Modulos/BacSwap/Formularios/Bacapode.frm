VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Apoderados 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Apoderados"
   ClientHeight    =   2010
   ClientLeft      =   2280
   ClientTop       =   3090
   ClientWidth     =   6105
   Icon            =   "Bacapode.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2010
   ScaleWidth      =   6105
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox Txt_Apoderado2 
      Height          =   495
      Left            =   270
      TabIndex        =   11
      Top             =   3240
      Width           =   4185
   End
   Begin VB.TextBox Txt_Apoderado1 
      Height          =   495
      Left            =   270
      TabIndex        =   10
      Top             =   2775
      Width           =   4185
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5520
      Top             =   0
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
            Picture         =   "Bacapode.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacapode.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   6105
      _ExtentX        =   10769
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Aceptar"
            Description     =   "Aceptar"
            Object.ToolTipText     =   "Aceptar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1365
      Left            =   30
      TabIndex        =   0
      Top             =   555
      Width           =   6030
      _Version        =   65536
      _ExtentX        =   10636
      _ExtentY        =   2408
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
      Begin VB.ComboBox Cmb_Apoderado2 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1785
         TabIndex        =   6
         Top             =   855
         Width           =   3990
      End
      Begin VB.ComboBox Cmb_Apoderado1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "Bacapode.frx":0A76
         Left            =   1800
         List            =   "Bacapode.frx":0A78
         TabIndex        =   5
         Top             =   285
         Width           =   3990
      End
      Begin VB.TextBox Txt_Rut2 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   180
         TabIndex        =   4
         Top             =   855
         Width           =   900
      End
      Begin VB.TextBox Txt_Digito2 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1245
         TabIndex        =   3
         Top             =   855
         Width           =   285
      End
      Begin VB.TextBox Txt_Digito1 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1245
         TabIndex        =   2
         Top             =   315
         Width           =   285
      End
      Begin VB.TextBox Txt_Rut1 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   165
         TabIndex        =   1
         Top             =   315
         Width           =   900
      End
      Begin VB.Label Lbl_Guion1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "-"
         Height          =   360
         Left            =   1125
         TabIndex        =   8
         Top             =   285
         Width           =   90
      End
      Begin VB.Label Lbl_Guion2 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "-"
         Height          =   360
         Left            =   1125
         TabIndex        =   7
         Top             =   825
         Width           =   90
      End
   End
End
Attribute VB_Name = "Bac_Apoderados"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Cmb_Apoderado1_Click()
   
   With Cmb_Apoderado1
      
      If .ItemData(.ListIndex) = Val(Txt_Rut2.Text) And Val(Txt_Rut2.Text) <> 0 Then
         MsgBox "Apoderados iguales", vbExclamation, "ERROR"
         Cmb_Apoderado1.Text = Txt_Apoderado1.Text
      Else
         Txt_Rut1.Text = .ItemData(.ListIndex)
         Txt_Digito1.Text = BacCheckRut(Txt_Rut1.Text)
      End If

      Txt_Apoderado1.Text = Cmb_Apoderado1.Text
   End With
   
End Sub

Private Sub Cmb_Apoderado1_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
   End If
   
End Sub

Private Sub Cmb_Apoderado1_LostFocus()
   Call bacBuscarCombo(Cmb_Apoderado1, Val(Txt_Rut1.Text))

End Sub

Private Sub Cmb_Apoderado2_Click()
   
   With Cmb_Apoderado2
      
      If .ItemData(.ListIndex) = Val(Txt_Rut1.Text) And Val(Txt_Rut1.Text) <> 0 Then
         MsgBox "Apoderados iguales", vbExclamation, "ERROR"
         Cmb_Apoderado2.Text = Txt_Apoderado2.Text
      Else
         Txt_Rut2.Text = .ItemData(.ListIndex)
         Txt_Digito2.Text = BacCheckRut(Txt_Rut2.Text)
      End If

      Txt_Apoderado2.Text = Cmb_Apoderado2.Text
   End With

End Sub

Private Sub Cmb_Apoderado2_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
   End If
   
End Sub

Private Sub Cmb_Apoderado2_LostFocus()
   Call bacBuscarCombo(Cmb_Apoderado2, Val(Txt_Rut2.Text))

End Sub

Private Sub cmdbuscar_Click()
   Unload Bac_Apoderados
End Sub

Private Sub Form_Load()
   
   Me.Icon = BACSwap.Icon
   Bac_Apoderados.Move 0, 1250

   Set ObjApoderado1 = New clsApoderado
   Set ObjApoderado2 = New clsApoderado
   Set ObjParametros = New clsGeneral

   If ObjParametros.DatosGenerales() = False Then
      MsgBox "No se puede conectar a la tabla de parámetros", vbExclamation
      Exit Sub
   End If

  'codigo es cero porque es rut del propietario
   If ObjApoderado1.LeeTabApo(ObjParametros.rut, 1) = False Then
      MsgBox "No se puede conectar a la tabla de apoderados", vbExclamation
      Exit Sub
   End If
   
   If ObjApoderado2.LeeTabApo(ObjParametros.rut, 1) = False Then
      MsgBox "No se puede conectar a la tabla de apoderados", vbExclamation
      Exit Sub
   End If

   If ObjApoderado1.coleccion.Count >= 1 Then
      Txt_Rut1.Text = ObjApoderado1.coleccion(1).aprutapo
      Txt_Digito1.Text = ObjApoderado1.coleccion(1).apdvapo
      
      Call ObjApoderado1.Control2Combo(Cmb_Apoderado1)
      
      Cmb_Apoderado1.AddItem " "
      Cmb_Apoderado1.ItemData(Cmb_Apoderado1.NewIndex) = 0
      
      Call bacBuscarCombo(Cmb_Apoderado1, Val(Txt_Rut1.Text))
      
      Txt_Apoderado1.Text = Cmb_Apoderado1.Text
      
      If ObjApoderado2.coleccion.Count >= 2 Then
         Txt_Rut2.Text = ObjApoderado2.coleccion(2).aprutapo
         Txt_Digito2.Text = ObjApoderado2.coleccion(2).apdvapo
         
         Call ObjApoderado2.Control2Combo(Cmb_Apoderado2)
                  
         Cmb_Apoderado2.AddItem " "
         Cmb_Apoderado2.ItemData(Cmb_Apoderado2.NewIndex) = 0
         
         Call bacBuscarCombo(Cmb_Apoderado2, Val(Txt_Rut2.Text))
         
         Txt_Apoderado2.Text = Cmb_Apoderado2.Text
      Else
         Txt_Rut2.Enabled = False
         Txt_Digito2.Enabled = False
         Cmb_Apoderado2.Enabled = False
      End If

   Else
      Txt_Rut1.Enabled = False
      Txt_Digito1.Enabled = False
      Cmb_Apoderado1.Enabled = False
      Txt_Rut2.Enabled = False
      Txt_Digito2.Enabled = False
      Cmb_Apoderado2.Enabled = False
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    
    Case 1          '"Aceptar"
        If Txt_Rut1.Text = "" Then
            Txt_Rut1.Text = 0
        End If
        If Txt_Rut2.Text = "" Then
           Txt_Rut2.Text = 0
        End If
        Bac_Apoderados.Hide
    
    Case 2      '"salir"
         SwUnload = True
         Unload Me
          
        
End Select
End Sub

