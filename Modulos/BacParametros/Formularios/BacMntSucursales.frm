VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form BacMntSucursales 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Sucursales"
   ClientHeight    =   3015
   ClientLeft      =   3525
   ClientTop       =   2175
   ClientWidth     =   6375
   Icon            =   "BacMntSucursales.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3015
   ScaleWidth      =   6375
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2880
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
            Picture         =   "BacMntSucursales.frx":030A
            Key             =   "Guardar"
            Object.Tag             =   "1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntSucursales.frx":075C
            Key             =   "Eliminar"
            Object.Tag             =   "2"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntSucursales.frx":0BAE
            Key             =   "Limpiar"
            Object.Tag             =   "3"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntSucursales.frx":0EC8
            Key             =   "Ayuda"
            Object.Tag             =   "4"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntSucursales.frx":11E2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2295
      Left            =   50
      TabIndex        =   0
      Top             =   600
      Width           =   6255
      _Version        =   65536
      _ExtentX        =   11033
      _ExtentY        =   4048
      _StockProps     =   15
      BackColor       =   12632256
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
         Height          =   2055
         Left            =   120
         TabIndex        =   4
         Top             =   120
         Width           =   6015
         Begin VB.TextBox txtCodigo 
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
            Left            =   1320
            MaxLength       =   2
            MouseIcon       =   "BacMntSucursales.frx":1634
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   480
            Width           =   975
         End
         Begin VB.TextBox txtNombre 
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
            Left            =   1320
            MaxLength       =   30
            TabIndex        =   2
            Top             =   840
            Width           =   3495
         End
         Begin VB.Label lblNombre 
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
            Height          =   255
            Left            =   240
            TabIndex        =   6
            Top             =   840
            Width           =   975
         End
         Begin VB.Label lblCodigo 
            Caption         =   "Codigo"
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
            Top             =   480
            Width           =   975
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   6375
      _ExtentX        =   11245
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
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
            Object.ToolTipText     =   "Borrar"
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
   End
End
Attribute VB_Name = "BacMntSucursales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub LimpiarControles()
    txtNombre.Text = Empty
    txtCodigo.Text = Empty
End Sub
Sub DesHabilitarControles()
    txtNombre.Enabled = False
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
End Sub
Sub HabilitarControles()
    txtNombre.Enabled = True
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    
End Sub

Private Sub Form_Load()
    BacMntSucursales.Top = 0
    BacMntSucursales.Left = 0
    DesHabilitarControles
    
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
        
     Case 1 'Opcion Guardar
      If txtCodigo.Text = Empty Then
            MsgBox "Debe ingresar un Codigo Valido", vbInformation, "Error :"
            txtCodigo.SetFocus
      Else
        
        If txtNombre.Text = Empty Then
            MsgBox "Debe ingresar un Nombre Valido", vbInformation, "Error :"
            txtNombre.SetFocus
        Else
        
         'If MsgBox("Desea Realmente guardar los datos de Sucursal.", vbInformation + vbYesNo, "Confirmación de Guardar") = vbYes Then
            Proc_Guardar_Sucursal
            LimpiarControles
            DesHabilitarControles
         'Else
         'End If
         
        End If
       End If
                
    Case 2  'Opcion eliminar
        If MsgBox("Desea Realmente eliminar los datos de Sucursal.", vbInformation + vbYesNo, "Confirmación de Eliminar") = vbYes Then
            Proc_Borrar_Sucursal
            LimpiarControles
            DesHabilitarControles
        Else
            
            
        End If
        
    Case 3  'Opcion limpiar
        
        LimpiarControles
        DesHabilitarControles
        
    Case 4  ''Opcion salir
        Unload BacMntSucursales
        
 End Select

End Sub
Private Sub txtCodigo_DblClick()
   
    BacAyuda.Tag = "SUC"
    
    BacAyuda.Show 1
        
    If txtNombre.Text <> Empty Then
        HabilitarControles
    Else
        DesHabilitarControles
    End If
    
    
End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF3 Then
    Call txtCodigo_DblClick
End If
   
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
If Keykode = vbKeyF3 Then
    Call txtCodigo_DblClick
End If
   
   
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Proc_Trae_Sucursal
      SendKeys$ "{TAB}"
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
   End If
End Sub
Private Sub txtNombre_KeyPress(KeyAscii As Integer)
 BacToUCase KeyAscii
    If KeyAscii% = vbKeyReturn Then
      
      KeyAscii% = 0
      'Proc_Trae_Sucursal
      
      'SendKeys$ "{TAB}"
   End If
End Sub

Private Sub Proc_Trae_Sucursal()
    
If txtCodigo.Text <> Empty Then
    
    Bac_Sql_Execute "sp_Trae_sucursal" & " " & CInt(txtCodigo.Text)
          
    If Not Bac_SQL_Fetch(datos()) Then
        
        HabilitarControles
        Toolbar1.Buttons(2).Enabled = False
        txtNombre.Text = Empty

    Else
        HabilitarControles
        Toolbar1.Buttons(2).Enabled = True
        txtCodigo.Text = Int((datos(1)))
        txtNombre.Text = datos(2)
    End If
End If

End Sub
Private Sub Proc_Guardar_Sucursal()
Dim cString As String
   
cString = "sp_graba_sucursal "
cString = cString + txtCodigo.Text + ", "
cString = cString + "'" + txtNombre.Text + "'"

Bac_Sql_Execute cString
        
MsgBox "Los datos se Guardaron satisfactoriamente.", vbInformation, "Grabacion Exitosa"
        
End Sub
Private Sub Proc_Borrar_Sucursal()
    
    Bac_Sql_Execute "sp_borra_sucursal" & " " & CInt(txtCodigo.Text)
    
    
End Sub
