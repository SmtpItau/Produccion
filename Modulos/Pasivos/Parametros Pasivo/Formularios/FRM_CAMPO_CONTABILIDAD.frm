VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form FRM_CAMPO_CONTABILIDAD 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Concepto Programa Contable"
   ClientHeight    =   2565
   ClientLeft      =   2370
   ClientTop       =   3390
   ClientWidth     =   7935
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "FRM_CAMPO_CONTABILIDAD.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2565
   ScaleWidth      =   7935
   Begin MSComctlLib.ImageList img_Contenedor_Imagenes 
      Left            =   5910
      Top             =   -180
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
            Picture         =   "FRM_CAMPO_CONTABILIDAD.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CAMPO_CONTABILIDAD.frx":11E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CAMPO_CONTABILIDAD.frx":20BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CAMPO_CONTABILIDAD.frx":2F98
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CAMPO_CONTABILIDAD.frx":3E72
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame FMR_LLAVE 
      Height          =   1155
      Left            =   15
      TabIndex        =   8
      Top             =   480
      Width           =   7920
      Begin VB.ComboBox cmb_Sistema 
         Height          =   330
         Left            =   930
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   705
         Width           =   1860
      End
      Begin VB.ComboBox cmb_Producto 
         Height          =   330
         Left            =   3735
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   705
         Width           =   4095
      End
      Begin VB.TextBox txt_Concepto_Programa 
         Height          =   315
         Left            =   930
         MaxLength       =   5
         TabIndex        =   0
         Top             =   255
         Width           =   1860
      End
      Begin VB.Label lbl_Sistema 
         Caption         =   "Modulo"
         Height          =   285
         Left            =   75
         TabIndex        =   13
         Top             =   735
         Width           =   780
      End
      Begin VB.Label lbl_Producto 
         Caption         =   "Producto"
         Height          =   285
         Left            =   2880
         TabIndex        =   12
         Top             =   735
         Width           =   780
      End
      Begin VB.Label lbl_Codigo_Concepto 
         Caption         =   "Concepto Programa"
         Height          =   465
         Left            =   90
         TabIndex        =   9
         Top             =   210
         Width           =   795
      End
   End
   Begin VB.Frame FMR_LLAVE1 
      Height          =   960
      Left            =   15
      TabIndex        =   7
      Top             =   1590
      Width           =   7920
      Begin VB.CheckBox chk_Negativo 
         Alignment       =   1  'Right Justify
         Caption         =   "Negativo"
         Height          =   285
         Left            =   2910
         TabIndex        =   5
         Top             =   600
         Width           =   1065
      End
      Begin VB.TextBox txt_Campo 
         Height          =   315
         Left            =   915
         Locked          =   -1  'True
         TabIndex        =   4
         Top             =   525
         Width           =   1860
      End
      Begin VB.TextBox txt_Descripcion 
         Height          =   315
         Left            =   915
         MaxLength       =   50
         TabIndex        =   3
         Top             =   180
         Width           =   6930
      End
      Begin VB.Label lbl_Nombre_Campo 
         Caption         =   "Campo"
         Height          =   285
         Left            =   105
         TabIndex        =   11
         Top             =   600
         Width           =   780
      End
      Begin VB.Label lbl_Descripcion 
         Caption         =   "Glosa"
         Height          =   285
         Left            =   105
         TabIndex        =   10
         Top             =   210
         Width           =   780
      End
   End
   Begin MSComctlLib.Toolbar tlb_Barra_Herramienta 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   7935
      _ExtentX        =   13996
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      Style           =   1
      ImageList       =   "img_Contenedor_Imagenes"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "NUEVO"
            Object.ToolTipText     =   "Nuevo Campo"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "GRABAR"
            Object.ToolTipText     =   "Grabar Campo"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "CARGAR"
            Object.ToolTipText     =   "Realizar carga"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "BUSCAR"
            Object.ToolTipText     =   "Buscar Campo"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FRM_CAMPO_CONTABILIDAD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cCampo  As String

Function FUNC_BUSCA_INDICE(Combo As Object, texto_busqueda As String) As Integer

  FUNC_BUSCA_INDICE = -1
  
  For X = 0 To Combo.ListCount - 1
     If Trim(right(Combo.List(X), 5)) = texto_busqueda Then
        FUNC_BUSCA_INDICE = X
        Exit For
     End If
  Next
  
End Function

Function FUNC_GRABAR_CAMPO_CONTABILIDAD() As Boolean
On Error GoTo ERRGRABARCAMPO
  FUNC_GRABAR_CAMPO_CONTABILIDAD = False
  
  Envia = Array()
  AddParam Envia, txt_Concepto_Programa.Text
  AddParam Envia, Trim(right(Cmb_Sistema.Text, 5))
  AddParam Envia, Trim(right(cmb_Producto.Text, 5))
  AddParam Envia, txt_Descripcion.Text
  AddParam Envia, cCampo 'Trim(Right(txt_Campo.Text, 50))
  AddParam Envia, IIf(chk_Negativo.Value = 1, "S", "N")
  
  If Not BAC_SQL_EXECUTE("SP_ACT_CAMPO_CONTABILIDAD", Envia) Then Exit Function
  
  FUNC_GRABAR_CAMPO_CONTABILIDAD = True

ERRGRABARCAMPO:
        Exit Function
End Function


Function FUNC_ELIMINAR_CAMPO_CONTABILIDAD() As Boolean
On Error GoTo ERRGRABARCAMPO
  FUNC_ELIMINAR_CAMPO_CONTABILIDAD = False
  
  Envia = Array()
  AddParam Envia, txt_Concepto_Programa.Text
  AddParam Envia, Trim(right(Cmb_Sistema.Text, 5))
  AddParam Envia, Trim(right(cmb_Producto.Text, 5))
  
  If Not BAC_SQL_EXECUTE("SP_ELI_CAMPO_CONTABILIDAD", Envia) Then Exit Function
  
  If BAC_SQL_FETCH(Datos()) Then
      If Datos(1) = -1 Then
          MsgBox Datos(2), vbOKOnly + vbExclamation
          Exit Function
      End If
  End If
  
  
  FUNC_ELIMINAR_CAMPO_CONTABILIDAD = True

ERRGRABARCAMPO:
        Exit Function
End Function

Function FUNC_VALIDAR_DATOS() As Boolean
Dim cMensaje As String
 FUNC_VALIDAR_DATOS = False
 
 cMensaje = ""
 
 If Trim(txt_Concepto_Programa.Text) = "" Then
    cMensaje = cMensaje + "- Concepto Programa." & vbCrLf
 End If
 If Cmb_Sistema.ListIndex = -1 Then
    cMensaje = cMensaje + "- Modulo." & vbCrLf
 End If
 If cmb_Producto.ListIndex = -1 Then
    cMensaje = cMensaje + "- Producto." & vbCrLf
 End If
 If Trim(txt_Descripcion.Text) = "" Then
   cMensaje = cMensaje + "- Descripcion." & vbCrLf
 End If
 If Trim(txt_Campo.Text) = "" Then
   cMensaje = cMensaje + "- Campo." & vbCrLf
 End If
 
 If Trim(cMensaje) <> "" Then
      MsgBox "No se puede grabar por que faltan los siguientes datos :" & vbCrLf & vbCrLf & cMensaje, vbOKOnly + vbExclamation
      Exit Function
 End If

 FUNC_VALIDAR_DATOS = True
End Function

Sub PROC_CARGA_PRODUCTOS()
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, Trim(right(Cmb_Sistema.Text, 5))
    
    If Not BAC_SQL_EXECUTE("Sp_Leer_Productos_Sistemas", Envia) Then Exit Sub
    
    cmb_Producto.Clear
    
    Do While BAC_SQL_FETCH(Datos())
    
       cmb_Producto.AddItem Datos(2) & Space(100) & Datos(1)
    
    Loop

End Sub

Sub PROC_CARGA_SISTEMA()
Dim Datos()

 If Not BAC_SQL_EXECUTE("Sp_CmbSistema") Then Exit Sub
 
 Cmb_Sistema.Clear
 
 Do While BAC_SQL_FETCH(Datos())
    Cmb_Sistema.AddItem Datos(2) & Space(100) & Datos(1)
 Loop
 

End Sub

Sub PROC_CONSULTAR_CAMPO_CONTABILIDAD()
Dim Datos()

If Trim(txt_Concepto_Programa.Text) = "" Then Exit Sub
If Trim(right(Cmb_Sistema.Text, 5)) = "" Then Exit Sub
If Trim(right(cmb_Producto.Text, 5)) = "" Then Exit Sub

Envia = Array()
AddParam Envia, Trim(txt_Concepto_Programa.Text)
AddParam Envia, Trim(right(Cmb_Sistema.Text, 5))
AddParam Envia, Trim(right(cmb_Producto.Text, 5))

PROC_HABILITA_CONTROLES True

If Not BAC_SQL_EXECUTE("SP_CON_CAMPO_CONTABILIDAD", Envia) Then Exit Sub
If Not BAC_SQL_FETCH(Datos()) Then Exit Sub

Cmb_Sistema.ListIndex = FUNC_BUSCA_INDICE(Cmb_Sistema, (Datos(2)))
cmb_Producto.ListIndex = FUNC_BUSCA_INDICE(cmb_Producto, (Datos(3)))
txt_Descripcion.Text = Datos(4)
txt_Campo.Text = Trim(left(Datos(5), 100))
cCampo = Trim(right(Datos(5), 100))
chk_Negativo.Value = IIf(Datos(6) = "S", 1, 0)

tlb_Barra_Herramienta.Buttons(3).Enabled = True
tlb_Barra_Herramienta.Buttons(4).Enabled = False
End Sub

Sub PROC_HABILITA_CONTROLES(Estado As Boolean)
  
  txt_Concepto_Programa.Enabled = Not Estado
  Cmb_Sistema.Enabled = Not Estado
  cmb_Producto.Enabled = Not Estado
  txt_Descripcion.Enabled = Estado
  txt_Campo.Enabled = Estado
  chk_Negativo.Enabled = Estado
  
  tlb_Barra_Herramienta.Buttons(2).Enabled = Estado
  tlb_Barra_Herramienta.Buttons(4).Enabled = Not Estado

End Sub

Sub PROC_LIMPIAR()

  PROC_HABILITA_CONTROLES False
  
  txt_Concepto_Programa.Text = ""
  Cmb_Sistema.ListIndex = -1
  cmb_Producto.ListIndex = -1
  txt_Descripcion.Text = ""
  txt_Campo.Text = ""
  chk_Negativo.Value = 0
  cCampo = ""
  tlb_Barra_Herramienta.Buttons(3).Enabled = False
  
End Sub


Private Sub cmb_Sistema_Click()

  PROC_CARGA_PRODUCTOS
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer
If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeyEliminar
               opcion = 3
               
         Case vbKeyBuscar
               opcion = 4
         
         Case vbKeySalir
               opcion = 5
   End Select

   If opcion <> 0 Then
      If tlb_Barra_Herramienta.Buttons(opcion).Enabled Then
         Call tlb_Barra_Herramienta_ButtonClick(tlb_Barra_Herramienta.Buttons(opcion))
      End If

   End If

End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
  If KeyAscii = vbKeyReturn Then
     Bac_SendKey vbKeyTab
  End If
End Sub

Private Sub Form_Load()

 Me.Icon = BAC_Parametros.Icon
 Me.top = 0
 Me.left = 0
 
 PROC_CARGA_SISTEMA

 PROC_HABILITA_CONTROLES False
End Sub

Private Sub tlb_Barra_Herramienta_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Key)
        Case "NUEVO"
              PROC_LIMPIAR
        Case "GRABAR"
             If Not FUNC_VALIDAR_DATOS Then Exit Sub
             If FUNC_GRABAR_CAMPO_CONTABILIDAD Then
                  MsgBox "Grabacion realizada con éxito", vbOKOnly + vbInformation
                  PROC_LIMPIAR
              Else
                  MsgBox "No se pudo realizar la grabación", vbOKOnly + vbExclamation
             End If
        Case "ELIMINAR"
           If MsgBox("¿ Desea eliminar el registro ?", vbYesNo + vbQuestion) = vbYes Then
             If FUNC_ELIMINAR_CAMPO_CONTABILIDAD Then
                  MsgBox "Eliminación realizada con éxito", vbOKOnly + vbInformation
                  PROC_LIMPIAR
             End If
           End If
        Case "BUSCAR"
              PROC_CONSULTAR_CAMPO_CONTABILIDAD
        Case "SALIR"
                Unload Me
End Select

End Sub


Private Sub txt_Campo_DblClick()
 MiTag = "NOMBRE_CAMPO_CONTABILIDAD"
 cCAMPO_CONTABILIDAD_SISTEMA = Trim(right(Cmb_Sistema.Text, 5))
 cCAMPO_CONTABILIDAD_CODIGO_PRODUCTO = Trim(right(cmb_Producto.Text, 5))
 
 BacAyuda.Show vbModal
 
   If giAceptar% Then
   
      txt_Campo.Text = gsCodigo '& Space(100) & gsGlosa
      cCampo = gsGlosa
   
   End If
 
End Sub


Private Sub txt_Campo_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then txt_Campo_DblClick
End Sub


Private Sub txt_Concepto_Programa_DblClick()
   
   MiTag = "CAMPO_CONTABILIDAD"
   BacAyuda.Show vbModal
   
   If giAceptar Then
   
      txt_Concepto_Programa.Text = gsCodigo
      Cmb_Sistema.ListIndex = FUNC_BUSCA_INDICE(Cmb_Sistema, gsGlosa)
      cmb_Producto.ListIndex = FUNC_BUSCA_INDICE(cmb_Producto, gsDescripcion)
      
      PROC_CONSULTAR_CAMPO_CONTABILIDAD
      
   End If

End Sub

Private Sub txt_Concepto_Programa_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then txt_Concepto_Programa_DblClick
End Sub


Private Sub txt_Concepto_Programa_KeyPress(KeyAscii As Integer)
  BacToUCase KeyAscii
End Sub


Private Sub txt_Descripcion_KeyPress(KeyAscii As Integer)
    BacToUCase KeyAscii
End Sub


