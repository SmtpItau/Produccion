VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{7A0B0044-A403-11D5-B8EF-000102BF8447}#1.0#0"; "BACControles.ocx"
Begin VB.Form BacMntEjecutivo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Ejecutivos"
   ClientHeight    =   3045
   ClientLeft      =   1770
   ClientTop       =   1335
   ClientWidth     =   6420
   Icon            =   "BacMntEjecutivo.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3045
   ScaleWidth      =   6420
   Begin Threed.SSPanel SSPanel1 
      Height          =   2295
      Left            =   50
      TabIndex        =   4
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
         TabIndex        =   5
         Top             =   120
         Width           =   6015
         Begin BACControles.TXTNumero txtMonto 
            Height          =   255
            Left            =   1440
            TabIndex        =   10
            Top             =   1320
            Width           =   975
            _ExtentX        =   1720
            _ExtentY        =   450
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
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox txtSucursal 
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
            Left            =   1440
            MaxLength       =   2
            MouseIcon       =   "BacMntEjecutivo.frx":030A
            MousePointer    =   99  'Custom
            TabIndex        =   3
            Top             =   960
            Width           =   975
         End
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
            Left            =   1440
            MaxLength       =   2
            MouseIcon       =   "BacMntEjecutivo.frx":045C
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   240
            Width           =   855
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
            Left            =   1440
            MaxLength       =   30
            TabIndex        =   2
            Top             =   600
            Width           =   3375
         End
         Begin VB.Label lblMonto 
            Caption         =   "Monto"
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
            TabIndex        =   9
            Top             =   1320
            Width           =   855
         End
         Begin VB.Label lblSucursal 
            Caption         =   "Sucursal"
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
            TabIndex        =   8
            Top             =   960
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
            TabIndex        =   7
            Top             =   240
            Width           =   975
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
            Top             =   600
            Width           =   975
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2400
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
            Picture         =   "BacMntEjecutivo.frx":05AE
            Key             =   "Guardar"
            Object.Tag             =   "1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntEjecutivo.frx":0A00
            Key             =   "Eliminar"
            Object.Tag             =   "2"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntEjecutivo.frx":0E52
            Key             =   "Limpiar"
            Object.Tag             =   "3"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntEjecutivo.frx":116C
            Key             =   "Ayuda"
            Object.Tag             =   "4"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntEjecutivo.frx":1486
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6420
      _ExtentX        =   11324
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
   End
End
Attribute VB_Name = "BacMntEjecutivo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub LimpiarControles()
        TxtNombre.Text = Empty
        txtCodigo.Text = Empty
        txtSucursal.Text = Empty
        txtMonto.Text = Empty
End Sub
Sub DesHabilitarControles()
    TxtNombre.Enabled = False
    txtSucursal.Enabled = False
    txtMonto.Enabled = False
    
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    
End Sub
Sub HabilitarControles()
    
    TxtNombre.Enabled = True
    txtSucursal.Enabled = True
    txtMonto.Enabled = True
    
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    
End Sub

Private Sub Form_Load()
    BacMntEjecutivo.Top = 0
    BacMntEjecutivo.Left = 0
    DesHabilitarControles
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 
 Select Case Button.Index
          
    Case 1 'Opcion Guardar
        If txtCodigo.Text = Empty Then
            MsgBox "Debe ingresar un Codigo Valido", vbInformation, "Error :"
            txtCodigo.SetFocus
        Else
         If TxtNombre.Text = Empty Then
             MsgBox "Debe ingresar un nombre Valido", vbInformation, "Error :"
             TxtNombre.SetFocus
         Else
            If txtSucursal.Text = Empty Then
                 MsgBox "Debe ingresar un Codigo Sucursal  Valido", vbInformation, "Error :"
                 txtSucursal.SetFocus
            Else
             If txtMonto.Text = Empty Then
                  MsgBox "Debe ingresar un Monto Valido", vbInformation, "Error :"
                  txtMonto.SetFocus
             Else
                             
              'If MsgBox("Desea Realmente guardar los datos de  Ejecutivo.", vbInformation + vbYesNo, "Confirmación de Guardar") = vbYes Then
                Proc_Graba_Ejecutivo
                DesHabilitarControles
                LimpiarControles
              'Else
              'End If
             End If
           End If
         End If
        End If
             
        
    Case 2 'Eliminar
        
        If MsgBox("Desea Realmente Borrar los datos de  Ejecutivo.", vbInformation + vbYesNo, "Confirmación de Borrar") = vbYes Then
            Proc_Borra_Ejecutivo
            DesHabilitarControles
            LimpiarControles
        Else
        
        End If
        
    Case 3 'Limpiar
        
        LimpiarControles
        DesHabilitarControles
        
    Case 4 ' Salir
        Unload BacMntEjecutivo
        
 End Select

End Sub
Private Sub txtCodigo_DblClick()
   
    BacAyuda.Tag = "EJE"
    BacAyuda.Show 1
    
    If TxtNombre.Text <> Empty Then
        HabilitarControles
    Else
        DesHabilitarControles
    End If

End Sub


Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
If vbKeyF3 = KeyCode Then
    Call txtCodigo_DblClick
End If
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      If txtCodigo.Text <> "" Then
        Proc_Trae_Ejecutivo
      Else
        Exit Sub
      End If
      SendKeys$ "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
    End If
End Sub
Private Sub txtMonto_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      'SendKeys$ "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
    End If
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
    BacToUCase KeyAscii
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
End Sub


Private Sub txtSucursal_DblClick()
        BacAyuda.Tag = "SS"
        BacAyuda.Show 1
    
End Sub

Private Sub txtSucursal_KeyDown(KeyCode As Integer, Shift As Integer)
If vbKeyF3 = KeyCode Then
    Call txtSucursal_DblClick
End If
End Sub

Private Sub txtSucursal_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
       Proc_Trae_Sucursal
      SendKeys$ "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
    End If
End Sub

Private Sub Proc_Trae_Ejecutivo()
    
    Bac_Sql_Execute "sp_Trae_ejecutivo" & " " & CInt(txtCodigo.Text)
          
    If Not Bac_SQL_Fetch(datos()) Then
        
        HabilitarControles
        Toolbar1.Buttons(2).Enabled = False
        TxtNombre.Text = Empty
        txtSucursal.Text = Empty
        txtMonto.Text = Empty
    Else
        HabilitarControles
        Toolbar1.Buttons(2).Enabled = True
        txtCodigo.Text = Int((datos(1)))
        TxtNombre.Text = datos(2)
        txtSucursal.Text = Int(datos(3))
        txtMonto.Text = CDbl(datos(4))
        
    End If

End Sub
Private Sub Proc_Trae_Sucursal()

If txtSucursal.Text <> Empty Then

    Bac_Sql_Execute "sp_Trae_sucursal" & " " & CInt(txtSucursal.Text)
    If Not Bac_SQL_Fetch(datos()) Then
        MsgBox "La Sucursal Ingresada no es valida.", vbInformation, "Error :"
        txtSucursal.Text = Empty
        
    Else
        
    End If
    
End If

End Sub
Private Sub Proc_Graba_Ejecutivo()
Dim cString As String

cString = "sp_graba_ejecutivo "
cString = cString + txtCodigo.Text + ", "
cString = cString + "'" + TxtNombre.Text + "', "
cString = cString + txtSucursal.Text + ", "
cString = cString + txtMonto.Text

Bac_Sql_Execute cString

MsgBox "Los datos se Guardaron satisfactoriamente.", vbInformation, "Grabacion Exitosa"

End Sub
Private Sub Proc_Borra_Ejecutivo()

Bac_Sql_Execute "sp_borra_ejecutivo" & " " & CInt(txtCodigo.Text)

End Sub

