VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form FRM_MAN_CODIGO_TRAN_SWIFT 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantencion de Codigo Transaccion Swift"
   ClientHeight    =   2490
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5025
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2490
   ScaleWidth      =   5025
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4650
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CODIGO_TRAN_SWIFT.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CODIGO_TRAN_SWIFT.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CODIGO_TRAN_SWIFT.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CODIGO_TRAN_SWIFT.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_CODIGO_TRAN_SWIFT.frx":2FA8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5025
      _ExtentX        =   8864
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   2040
      Index           =   0
      Left            =   -15
      TabIndex        =   1
      Top             =   420
      Width           =   5025
      _Version        =   65536
      _ExtentX        =   8864
      _ExtentY        =   3598
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
      Begin VB.TextBox txt_Glosa 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1200
         TabIndex        =   7
         Top             =   1620
         Width           =   3555
      End
      Begin VB.TextBox txt_Codigo 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1200
         TabIndex        =   6
         Top             =   1275
         Width           =   1635
      End
      Begin VB.ComboBox box_Producto 
         Height          =   330
         Left            =   1200
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   600
         Width           =   2580
      End
      Begin VB.ComboBox box_Sistema 
         Height          =   330
         Left            =   1200
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   240
         Width           =   2565
      End
      Begin VB.Line Line1 
         BorderColor     =   &H80000004&
         Index           =   1
         X1              =   180
         X2              =   4590
         Y1              =   1080
         Y2              =   1080
      End
      Begin VB.Line Line1 
         Index           =   0
         X1              =   195
         X2              =   4605
         Y1              =   1065
         Y2              =   1065
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Glosa"
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   240
         TabIndex        =   9
         Top             =   1665
         Width           =   465
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Codigo"
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   240
         TabIndex        =   8
         Top             =   1320
         Width           =   585
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Productos"
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   2
         Left            =   240
         TabIndex        =   5
         Top             =   645
         Width           =   855
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   3
         Left            =   240
         TabIndex        =   4
         Top             =   300
         Width           =   675
      End
   End
End
Attribute VB_Name = "FRM_MAN_CODIGO_TRAN_SWIFT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function FUNC_Buscar_SiStemas()

If BAC_SQL_EXECUTE("SP_CON_SISTEMA") Then
    
    box_Sistema.Clear
    Do While BAC_SQL_FETCH(Datos())
        
        box_Sistema.AddItem Datos(2) & Space(70) & Datos(1)
        
    Loop
    
End If

End Function

Function FUNC_Buscar_Producto()

Envia = Array()
AddParam Envia, Trim(right(box_Sistema.Text, 5))

If BAC_SQL_EXECUTE("SP_CON_PRODUCTO", Envia) Then
    
    box_Producto.Clear
    Do While BAC_SQL_FETCH(Datos())
        
        box_Producto.AddItem Datos(3) & Space(70) & Datos(2)
        
    Loop
    
End If

End Function
Function FUNC_Buscar_Info() As Boolean

Envia = Array()
AddParam Envia, Trim(right(box_Sistema.Text, 3))
AddParam Envia, Trim(right(box_Producto.Text, 5))

If Not BAC_SQL_EXECUTE("SP_CON_CODIGO_TRANSACCION_SWIFT", Envia) Then
    FUNC_Buscar_Info = False
Else
    FUNC_Buscar_Info = True
    
    Do While BAC_SQL_FETCH(Datos())
        
        txt_Codigo.Text = Datos(3)
        Txt_Glosa.Text = Datos(4)
    
    Loop
    
End If

End Function

Function FUNC_Controles(lSw As Boolean)

box_Sistema.Enabled = lSw
box_Producto.Enabled = lSw
txt_Codigo.Enabled = (Not lSw)
Txt_Glosa.Enabled = (Not lSw)

If lSw Then
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = True
Else
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True
    Toolbar1.Buttons(4).Enabled = False
End If

End Function

Function FUNC_Eliminar_Datos()

Envia = Array()
AddParam Envia, Trim(right(box_Sistema.Text, 3))
AddParam Envia, Trim(right(box_Producto.Text, 5))

If Not BAC_SQL_EXECUTE("SP_ELI_CODIGO_TRANSACCION_SWIFT", Envia) Then
    MsgBox "Problemas al Borrar informacion", vbExclamation
Else
    MsgBox "Informacion Borrada en forma correcta", vbInformation
End If

End Function

Function FUNC_Grabar_Datos()

Envia = Array()
AddParam Envia, Trim(right(box_Sistema.Text, 3))
AddParam Envia, Trim(right(box_Producto.Text, 5))
AddParam Envia, CDec(txt_Codigo)
AddParam Envia, Txt_Glosa

If Not BAC_SQL_EXECUTE("SP_ACT_CODIGO_TRANSACCION_SWIFT", Envia) Then
    MsgBox "Problemas al grabar informacion", vbExclamation
Else
    MsgBox "Grabacion realizada correctamente", vbInformation
End If

End Function

Private Sub box_Sistema_Change()
    Call FUNC_Buscar_Producto
End Sub

Private Sub box_Sistema_Click()
    Call FUNC_Buscar_Producto
End Sub


Private Sub Form_Activate()
    PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err

   nOpcion = 0
  
   If KeyCode = vbKeyF2 Then
      KeyCode = 0
   End If
   
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode

           Case vbKeyLimpiar:
                              nOpcion = 1
            Case vbKeyGrabar:
                              nOpcion = 2
            Case vbKeyEliminar:
                              nOpcion = 3
            Case vbKeyBuscar:
                              nOpcion = 4
            Case vbKeySalir:
                              nOpcion = 5
                      
      End Select

      If nOpcion <> 0 Then
            If Toolbar1.Buttons(nOpcion).Enabled Then
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(nOpcion))
            End If
            KeyCode = 0
      End If
      
   End If
Exit Sub
err:
  Resume Next

End Sub

Private Sub Form_Load()

Me.Icon = BAC_Parametros.Icon
Call FUNC_Buscar_SiStemas
Call FUNC_Controles(True)

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case UCase(Button.Key)
    Case "LIMPIAR"
        txt_Codigo.Text = ""
        Txt_Glosa.Text = ""
        box_Sistema.ListIndex = -1
        box_Producto.ListIndex = -1
        
        Call FUNC_Controles(True)
        
    Case "GRABAR"
        Call FUNC_Grabar_Datos
        
    Case "ELIMINAR"
        Call FUNC_Eliminar_Datos
            
    Case "BUSCAR"
        Call FUNC_Buscar_Info
        Call FUNC_Controles(False)
        
    Case "SALIR"
        Unload Me
End Select

End Sub


