VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form FRM_CODIGO_OPERACION_CONTABILIDAD 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Codigos de Operacion para Contabilidad"
   ClientHeight    =   4230
   ClientLeft      =   2160
   ClientTop       =   3015
   ClientWidth     =   9810
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "FRM_CODIGO_OPERACION_CONTABILIDAD.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4230
   ScaleWidth      =   9810
   Begin MSComctlLib.ImageList img_Contenedor_Imagenes 
      Left            =   5910
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
            Picture         =   "FRM_CODIGO_OPERACION_CONTABILIDAD.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CODIGO_OPERACION_CONTABILIDAD.frx":0EE6
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CODIGO_OPERACION_CONTABILIDAD.frx":1DC0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CODIGO_OPERACION_CONTABILIDAD.frx":2C9A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_CODIGO_OPERACION_CONTABILIDAD.frx":3B74
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame FMR_LLAVE1 
      Height          =   2595
      Left            =   15
      TabIndex        =   15
      Top             =   1590
      Width           =   9750
      Begin VB.CheckBox chk_Categoria 
         Alignment       =   1  'Right Justify
         Caption         =   "Mercado"
         Height          =   285
         Left            =   60
         TabIndex        =   28
         Top             =   330
         Width           =   1450
      End
      Begin VB.ComboBox CmbMercado 
         Height          =   330
         Left            =   1620
         Style           =   2  'Dropdown List
         TabIndex        =   27
         Top             =   285
         Width           =   3000
      End
      Begin VB.CheckBox chk_Reversa 
         Alignment       =   1  'Right Justify
         Caption         =   "Reversa"
         Height          =   285
         Left            =   5700
         TabIndex        =   22
         Top             =   1425
         Width           =   1065
      End
      Begin VB.CheckBox Chk_Forma_Pago 
         Alignment       =   1  'Right Justify
         Caption         =   "Forma Pago"
         Height          =   285
         Left            =   60
         TabIndex        =   21
         Top             =   1425
         Width           =   1450
      End
      Begin VB.ComboBox Cmb_Forma_Pago 
         Height          =   330
         Left            =   1620
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   1380
         Width           =   3000
      End
      Begin VB.ComboBox cmb_EventoContable 
         Height          =   330
         Left            =   4365
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   645
         Width           =   5295
      End
      Begin VB.ComboBox cmb_Instrumento 
         Height          =   330
         Left            =   1620
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   645
         Width           =   1635
      End
      Begin VB.CheckBox chk_Instrumento 
         Alignment       =   1  'Right Justify
         Caption         =   "Instrum."
         Height          =   285
         Left            =   60
         TabIndex        =   3
         Top             =   675
         Width           =   1450
      End
      Begin VB.ComboBox cmb_Moneda2 
         Height          =   330
         Left            =   4635
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1005
         Width           =   1635
      End
      Begin VB.CheckBox chk_Moneda2 
         Alignment       =   1  'Right Justify
         Caption         =   "Moneda"
         Height          =   285
         Left            =   3495
         TabIndex        =   8
         Top             =   1035
         Width           =   1065
      End
      Begin VB.ComboBox cmb_Moneda1 
         Height          =   330
         Left            =   1620
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   1005
         Width           =   1635
      End
      Begin VB.CheckBox chk_Moneda1 
         Alignment       =   1  'Right Justify
         Caption         =   "Moneda"
         Height          =   285
         Left            =   60
         TabIndex        =   6
         Top             =   1035
         Width           =   1450
      End
      Begin VB.Frame FMR_OPCIONES 
         BorderStyle     =   0  'None
         Height          =   540
         Left            =   4125
         TabIndex        =   18
         Top             =   135
         Width           =   3975
         Begin VB.OptionButton opt_Tipo_Cuenta 
            Caption         =   "Pasivo"
            Height          =   315
            Index           =   1
            Left            =   2160
            TabIndex        =   2
            Top             =   120
            Width           =   1110
         End
         Begin VB.OptionButton opt_Tipo_Cuenta 
            Caption         =   "Activo"
            Height          =   315
            Index           =   0
            Left            =   615
            TabIndex        =   1
            Top             =   120
            Value           =   -1  'True
            Width           =   1005
         End
      End
      Begin VB.TextBox txt_Descripcion 
         Height          =   315
         Left            =   1620
         MaxLength       =   50
         TabIndex        =   10
         Top             =   1755
         Width           =   8040
      End
      Begin VB.TextBox txt_Glosa_Corta 
         Height          =   315
         Left            =   1620
         MaxLength       =   15
         TabIndex        =   11
         Top             =   2100
         Width           =   1995
      End
      Begin VB.Label lbl_Evento_Contable 
         Caption         =   "Evento"
         Height          =   225
         Left            =   3495
         TabIndex        =   19
         Top             =   705
         Width           =   600
      End
      Begin VB.Label lbl_Descripcion 
         Caption         =   "Glosa"
         Height          =   285
         Left            =   120
         TabIndex        =   17
         Top             =   1800
         Width           =   1450
      End
      Begin VB.Label lbl_Glosa_Corta 
         Caption         =   "Glos.Min."
         Height          =   285
         Left            =   135
         TabIndex        =   16
         Top             =   2175
         Width           =   1450
      End
   End
   Begin VB.Frame FMR_LLAVE 
      Height          =   1110
      Left            =   15
      TabIndex        =   13
      Top             =   480
      Width           =   9750
      Begin VB.ComboBox cmb_Sistema 
         Height          =   330
         Left            =   4710
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   255
         Width           =   1860
      End
      Begin VB.ComboBox cmb_Producto 
         Height          =   330
         Left            =   1755
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   645
         Width           =   4785
      End
      Begin VB.TextBox txt_Codigo_Operacion 
         Height          =   315
         Left            =   1755
         MaxLength       =   3
         TabIndex        =   0
         Top             =   255
         Width           =   1860
      End
      Begin VB.Label lbl_Sistema 
         Caption         =   "Modulo"
         Height          =   285
         Left            =   3870
         TabIndex        =   26
         Top             =   285
         Width           =   780
      End
      Begin VB.Label lbl_Producto 
         Caption         =   "Producto"
         Height          =   285
         Left            =   105
         TabIndex        =   25
         Top             =   675
         Width           =   780
      End
      Begin VB.Label lbl_Codigo_Operacion 
         Caption         =   "Codigo Operacion"
         Height          =   225
         Left            =   90
         TabIndex        =   14
         Top             =   285
         Width           =   1560
      End
   End
   Begin MSComctlLib.Toolbar tlb_Barra_Herramienta 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   9810
      _ExtentX        =   17304
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
            Object.ToolTipText     =   "Cargar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "BUSCAR"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SALIR"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FRM_CODIGO_OPERACION_CONTABILIDAD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub FUNC_BUSCA_CODIGOS_MDTC(Codigo_Mdtc As String, Combo As Control)

   If swauxiliar = 0 Then
   
      Envia = Array()

      AddParam Envia, Codigo_Mdtc

      If Not BAC_SQL_EXECUTE("sp_leercodigos2", Envia) Then
         Exit Sub

      End If

      Do While BAC_SQL_FETCH(Datos())
         If Codigo_Mdtc = MDTC_CLASIFICACION Then
            Combo.AddItem Trim(Datos(1)) & Space((10 - Len(Datos(1)))) & Trim(Datos(2))
            Combo.ItemData(Combo.NewIndex) = Trim(Datos(2))
         Else
            Combo.AddItem Trim(Datos(3)) & Space(60) & Trim(Datos(1)) & Space(10) & Trim(Datos(2))
            Combo.ItemData(Combo.NewIndex) = Trim(Datos(2))
         End If

      Loop

   Else
      Sql = "sp_traecategoria2"

      If Not BAC_SQL_EXECUTE("sp_traecategoria2") Then
         Exit Sub

      End If

      Do While BAC_SQL_FETCH(Datos())
         Combo.AddItem Trim(Datos(2)) & Space(50) & Trim(Datos(1))
         Combo.ItemData(Combo.NewIndex) = Trim(Datos(1))
      Loop

   End If

End Sub

Function FUNC_ELIMINAR_CODIGO_OPERACION() As Boolean
On Error GoTo ERRELIMINARCODIGO
  FUNC_ELIMINAR_CODIGO_OPERACION = False
  
  Envia = Array()
  AddParam Envia, txt_Codigo_Operacion.Text
  
  If Not BAC_SQL_EXECUTE("SP_ELI_CODIGO_OPERACION_CONTABILIDAD", Envia) Then Exit Function
  
  If BAC_SQL_FETCH(Datos()) Then
      If Datos(1) = -1 Then
          MsgBox Datos(2), vbOKOnly + vbExclamation
          Exit Function
      End If
  End If
      
  FUNC_ELIMINAR_CODIGO_OPERACION = True

ERRELIMINARCODIGO:
        Exit Function
End Function

Function FUNC_GRABAR_CODIGO_OPERACION() As Boolean
On Error GoTo ERRGRABARCODIGO
  FUNC_GRABAR_CODIGO_OPERACION = False
  
  Envia = Array()
  AddParam Envia, txt_Codigo_Operacion.Text
  AddParam Envia, IIf(opt_Tipo_Cuenta(0).Value, "A", "P")
  AddParam Envia, Trim(right(Cmb_Sistema.Text, 5))
  AddParam Envia, Trim(right(cmb_Producto.Text, 5))
  AddParam Envia, IIf(chk_Moneda1.Value, Val(right(cmb_Moneda1.Text, 5)), -1)
  AddParam Envia, IIf(chk_Moneda2.Value, Val(right(cmb_Moneda2.Text, 5)), -1)
  AddParam Envia, IIf(chk_Instrumento.Value, Val(right(cmb_Instrumento.Text, 5)), -1)
  AddParam Envia, txt_Descripcion.Text
  AddParam Envia, txt_Glosa_Corta.Text
  AddParam Envia, right(cmb_EventoContable.Text, 3)
  AddParam Envia, IIf(Chk_Forma_Pago.Value, Val(right(Me.Cmb_Forma_Pago.Text, 5)), 0)
  AddParam Envia, IIf(chk_Reversa.Value, 0, -1)
  AddParam Envia, IIf(chk_Categoria.Value, Val(right(CmbMercado.Text, 3)), -1)
  
  If Not BAC_SQL_EXECUTE("SP_ACT_CODIGO_OPERACION_CONTABILIDAD", Envia) Then Exit Function
  
  FUNC_GRABAR_CODIGO_OPERACION = True

ERRGRABARCODIGO:
        Exit Function
End Function


Sub PROC_CARGA_INSTRUMENTO()
Dim Datos()

If Not BAC_SQL_EXECUTE("Sp_Trae_Instrumentos") Then Exit Sub

cmb_Instrumento.Clear

Do While BAC_SQL_FETCH(Datos())

 cmb_Instrumento.AddItem Datos(2) & Space(100) & Datos(3)

Loop


End Sub

Sub PROC_CARGA_MONEDA(Combo As Object)
Dim Datos()

 If Not BAC_SQL_EXECUTE("Sp_Leer_Moneda") Then Exit Sub
 
 Combo.Clear
 Do While BAC_SQL_FETCH(Datos())
    Combo.AddItem Datos(2) & Space(100) & Datos(1)
 Loop
End Sub

Sub PROC_HABILITA_CONTROLES(Estado As Boolean)

  txt_Codigo_Operacion.Enabled = Not Estado
  FMR_OPCIONES.Enabled = Estado
  Cmb_Sistema.Enabled = (Not Estado)
  cmb_Producto.Enabled = (Not Estado)
  chk_Instrumento.Enabled = Estado
  chk_Moneda1.Enabled = Estado
  chk_Moneda2.Enabled = Estado
  Chk_Forma_Pago.Enabled = Estado
  chk_Categoria.Enabled = Estado
  
  cmb_Instrumento.Enabled = (chk_Instrumento.Value = 1)
  cmb_Moneda1.Enabled = (chk_Moneda1.Value = 1)
  cmb_Moneda2.Enabled = (chk_Moneda2.Value = 1)
  Cmb_Forma_Pago.Enabled = (Chk_Forma_Pago.Value = 1)
  CmbMercado.Enabled = (chk_Categoria.Value = 1)
  
  txt_Descripcion.Enabled = Estado
  txt_Glosa_Corta.Enabled = Estado
  cmb_EventoContable.Enabled = Estado
  tlb_Barra_Herramienta.Buttons(2).Enabled = Estado
  tlb_Barra_Herramienta.Buttons(4).Enabled = Not Estado
  chk_Reversa.Enabled = Estado

End Sub

Private Sub chk_Categoria_Click()
    CmbMercado.Enabled = (chk_Categoria.Value = 1)
End Sub

Private Sub Chk_Forma_Pago_Click()
Cmb_Forma_Pago.Enabled = (Chk_Forma_Pago.Value = 1)
End Sub

Private Sub chk_Instrumento_Click()
  cmb_Instrumento.Enabled = (chk_Instrumento.Value = 1)

End Sub

Private Sub chk_Moneda1_Click()
  cmb_Moneda1.Enabled = (chk_Moneda1.Value = 1)

End Sub


Private Sub chk_Moneda2_Click()
  cmb_Moneda2.Enabled = (chk_Moneda2.Value = 1)
End Sub


Private Sub cmb_Sistema_Click()
    PROC_CARGA_PRODUCTOS
    FUNC_TRAER_RELACION_BANCO
    
    CmbMercado.Clear
    If Trim(right(Cmb_Sistema.Text, 5)) = "PSV" Then
        FUNC_BUSCA_CODIGOS_MDTC "11", CmbMercado
    Else
        FUNC_BUSCA_CODIGOS_MDTC "01", CmbMercado
    End If
    
End Sub


Function FUNC_VALIDAR_DATOS() As Boolean
Dim cMensaje As String
 FUNC_VALIDAR_DATOS = False
 
 cMensaje = ""
 
 If Trim(txt_Codigo_Operacion.Text) = "" Then
    cMensaje = cMensaje + "- Codigo Operación." & vbCrLf
 End If
 If Cmb_Sistema.ListIndex = -1 Then
    cMensaje = cMensaje + "- Módulo." & vbCrLf
 End If
 If cmb_Producto.ListIndex = -1 Then
    cMensaje = cMensaje + "- Producto." & vbCrLf
 End If
 If chk_Instrumento.Value And cmb_Instrumento.ListIndex = -1 Then
    cMensaje = cMensaje + "- Instrumento." & vbCrLf
 End If
 If chk_Moneda1.Value And cmb_Moneda1.ListIndex = -1 Then
    cMensaje = cMensaje + "- Moneda 1." & vbCrLf
 End If
 If chk_Moneda2.Value And cmb_Moneda2.ListIndex = -1 Then
    cMensaje = cMensaje + "- Moneda 2." & vbCrLf
 End If
 If Trim(txt_Descripcion.Text) = "" Then
   cMensaje = cMensaje + "- Descripción." & vbCrLf
 End If
 If Trim(txt_Glosa_Corta.Text) = "" Then
   cMensaje = cMensaje + "- Glosa mínima." & vbCrLf
 End If
 
 If Trim(cMensaje) <> "" Then
      MsgBox "No se puede grabar por que faltan los siguientes datos :" & vbCrLf & vbCrLf & cMensaje, vbOKOnly + vbExclamation
      Exit Function
 End If

 FUNC_VALIDAR_DATOS = True
End Function

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
 
 PROC_CARGA_MONEDA cmb_Moneda1
 
 PROC_CARGA_MONEDA cmb_Moneda2
 
 PROC_CARGA_INSTRUMENTO
 
 PROC_CARGA_EVENTO
 
' FUNC_TRAER_RELACION_BANCO
 
' FUNC_BUSCA_CODIGOS_MDTC "01", CmbMercado
 
 PROC_HABILITA_CONTROLES False

End Sub

Sub PROC_CARGA_EVENTO()
Dim Datos()

If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Evento") Then Exit Sub

cmb_EventoContable.Clear

Do While BAC_SQL_FETCH(Datos())

 cmb_EventoContable.AddItem Datos(1) & "---" & Datos(2) & Space(100) & Datos(1) & IIf(Len(Datos(1)) < 3, String(3 - Len(Datos(1)), " "), "")

Loop

End Sub


Private Function FUNC_TRAER_RELACION_BANCO()
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, Trim(right(Cmb_Sistema.Text, 5))
    
    
    If Not BAC_SQL_EXECUTE("SP_CON_RELACION_FORMA_PAGO", Envia) Then Exit Function
    
    Cmb_Forma_Pago.Clear
    
    Do While BAC_SQL_FETCH(Datos())
    
        Me.Cmb_Forma_Pago.AddItem Datos(2) & Space(100) & Datos(1)
    
    Loop

End Function



Sub PROC_CARGA_SISTEMA()
Dim Datos()

 If Not BAC_SQL_EXECUTE("Sp_CmbSistema") Then Exit Sub
 
 Cmb_Sistema.Clear
 
 Do While BAC_SQL_FETCH(Datos())
    Cmb_Sistema.AddItem Datos(2) & Space(100) & Datos(1)
 Loop
 

End Sub

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

Private Sub tlb_Barra_Herramienta_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Key)
        Case "NUEVO"
              PROC_LIMPIAR
        Case "GRABAR"
             If Not FUNC_VALIDAR_DATOS Then Exit Sub
             If FUNC_GRABAR_CODIGO_OPERACION Then
                  MsgBox "Grabación realizada con éxito", vbOKOnly + vbInformation
                  PROC_LIMPIAR
              Else
                  MsgBox "No se pudo realizar la grabación", vbOKOnly + vbExclamation
             End If
        Case "CARGAR"
'        Case "ELIMINAR"
'            If MsgBox("¿ Desea eliminar el registro ?", vbYesNo + vbQuestion, gsBac_Version) = vbYes Then
'             If FUNC_ELIMINAR_CODIGO_OPERACION Then
'                  MsgBox "Eliminación realizada con éxito", vbOKOnly + vbInformation
'                  PROC_LIMPIAR
'             End If
'            End If
        Case "BUSCAR"
              PROC_CONSULTAR_CODIGO_OPERACION
        Case "SALIR"
                Unload Me
End Select
End Sub
Sub PROC_CONSULTAR_CODIGO_OPERACION()
Dim Datos()

If Trim(txt_Codigo_Operacion.Text) = "" Then Exit Sub

Envia = Array()
AddParam Envia, Trim(txt_Codigo_Operacion.Text)
AddParam Envia, Trim(right(Cmb_Sistema.Text, 3))
AddParam Envia, Trim(right(cmb_Producto.Text, 5))

PROC_HABILITA_CONTROLES True

If Not BAC_SQL_EXECUTE("SP_CON_CODIGO_OPERACION_CONTABILIDAD", Envia) Then Exit Sub
If Not BAC_SQL_FETCH(Datos()) Then Exit Sub


opt_Tipo_Cuenta(0).Value = (Datos(2) = "A")
opt_Tipo_Cuenta(1).Value = (Datos(2) = "P")

Cmb_Sistema.ListIndex = FUNC_BUSCA_INDICE(Cmb_Sistema, (Datos(3)))
cmb_Producto.ListIndex = FUNC_BUSCA_INDICE(cmb_Producto, (Datos(4)))

cmb_Moneda1.ListIndex = FUNC_BUSCA_INDICE(cmb_Moneda1, (Datos(5)))
cmb_Moneda2.ListIndex = FUNC_BUSCA_INDICE(cmb_Moneda2, (Datos(6)))
cmb_Instrumento.ListIndex = FUNC_BUSCA_INDICE(cmb_Instrumento, (Datos(7)))
cmb_EventoContable.ListIndex = FUNC_BUSCA_INDICE(cmb_EventoContable, (Datos(10)))
Cmb_Forma_Pago.ListIndex = FUNC_BUSCA_INDICE(Me.Cmb_Forma_Pago, (Datos(11)))
CmbMercado.ListIndex = FUNC_BUSCA_INDICE(CmbMercado, (Datos(13)))

chk_Moneda1.Value = IIf(cmb_Moneda1.ListIndex <> -1, 1, 0)
chk_Moneda2.Value = IIf(cmb_Moneda2.ListIndex <> -1, 1, 0)
chk_Instrumento.Value = IIf(cmb_Instrumento.ListIndex <> -1, 1, 0)
Chk_Forma_Pago.Value = IIf(Cmb_Forma_Pago.ListIndex <> -1, 1, 0)
chk_Reversa.Value = IIf(Datos(12) = 0, 1, 0)
chk_Categoria.Value = IIf(CmbMercado.ListIndex <> -1, 1, 0)


txt_Descripcion.Text = Datos(8)
txt_Glosa_Corta.Text = Datos(9)

tlb_Barra_Herramienta.Buttons(3).Enabled = True
tlb_Barra_Herramienta.Buttons(4).Enabled = False

End Sub


Function FUNC_BUSCA_INDICE(Combo As Object, texto_busqueda As String) As Integer

  FUNC_BUSCA_INDICE = -1
  
  For X = 0 To Combo.ListCount - 1
     If Trim(right(Combo.List(X), 5)) = texto_busqueda Then
        FUNC_BUSCA_INDICE = X
        Exit For
     End If
  Next
  
End Function

Private Sub txt_Concepto_Programa_Change()

End Sub

Sub PROC_LIMPIAR()

  PROC_HABILITA_CONTROLES False
  
  txt_Codigo_Operacion.Text = ""
  Cmb_Sistema.ListIndex = -1
  cmb_Producto.ListIndex = -1
  chk_Moneda1.Value = False
  chk_Moneda2.Value = False
  Chk_Forma_Pago.Value = False
  chk_Instrumento.Value = False
  chk_Reversa.Value = False
  chk_Categoria.Value = False
  
  tlb_Barra_Herramienta.Buttons(3).Enabled = False
  
  cmb_Instrumento.Enabled = (chk_Instrumento.Value = 1)
  cmb_Moneda1.Enabled = (chk_Moneda1.Value = 1)
  cmb_Moneda2.Enabled = (chk_Moneda2.Value = 1)
  Cmb_Forma_Pago.Enabled = (Chk_Forma_Pago.Value = 1)
  CmbMercado.Enabled = (chk_Categoria.Value = 1)
  
  cmb_EventoContable.ListIndex = -1
  cmb_Instrumento.ListIndex = -1
  cmb_Moneda1.ListIndex = -1
  cmb_Moneda2.ListIndex = -1
  CmbMercado.ListIndex = -1
  Me.Cmb_Forma_Pago.ListIndex = -1
  txt_Descripcion.Text = ""
  txt_Glosa_Corta.Text = ""
  
End Sub

Private Sub txt_Codigo_Operacion_DblClick()
   MiTag = "CODIGO_OPERACION_CONTABILIDAD"
   BacAyuda.Show vbModal
   
   If giAceptar Then
   
      txt_Codigo_Operacion.Text = gsCodigo
      
      PROC_CONSULTAR_CODIGO_OPERACION
      
   End If

End Sub

Private Sub txt_Codigo_Operacion_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then txt_Codigo_Operacion_DblClick
End Sub


Private Sub txt_Codigo_Operacion_KeyPress(KeyAscii As Integer)
 BacToUCase KeyAscii
End Sub


Private Sub txt_Descripcion_KeyPress(KeyAscii As Integer)
 BacToUCase KeyAscii
End Sub


Private Sub txt_Glosa_Corta_KeyPress(KeyAscii As Integer)
 BacToUCase KeyAscii
End Sub

