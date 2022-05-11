VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_REGLAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reglas de Mensaje"
   ClientHeight    =   3795
   ClientLeft      =   2925
   ClientTop       =   2565
   ClientWidth     =   7335
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "FRM_REGLAS.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3795
   ScaleWidth      =   7335
   Begin BACControles.TXTNumero Txt_Numoper 
      Height          =   285
      Left            =   2880
      TabIndex        =   3
      Top             =   3930
      Visible         =   0   'False
      Width           =   1155
      _ExtentX        =   2037
      _ExtentY        =   503
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
   Begin MSComctlLib.ImageList img_Contenedor_Imagenes_II 
      Left            =   6600
      Top             =   3015
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   10
      ImageHeight     =   10
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_REGLAS.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_REGLAS.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame fmr_Lista_Reglas 
      Height          =   3270
      Left            =   30
      TabIndex        =   1
      Top             =   495
      Width           =   7305
      Begin MSComctlLib.ListView lst_Reglas_Mensajes 
         Height          =   2970
         Left            =   90
         TabIndex        =   2
         Top             =   210
         Width           =   7125
         _ExtentX        =   12568
         _ExtentY        =   5239
         View            =   3
         LabelEdit       =   1
         MultiSelect     =   -1  'True
         LabelWrap       =   -1  'True
         HideSelection   =   -1  'True
         AllowReorder    =   -1  'True
         FullRowSelect   =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         NumItems        =   0
      End
   End
   Begin MSComctlLib.Toolbar tlb_Barra_Herramientas 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7335
      _ExtentX        =   12938
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_Contenedor_Imagenes"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "NUEVO"
            Object.ToolTipText     =   "Nueva Regla"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ELIMINAR"
            Object.ToolTipText     =   "Eliminar Regla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ACTIVAR"
            Object.ToolTipText     =   "Activar Regla"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "DESACTIVAR"
            Object.ToolTipText     =   "Desactivar Regla"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "DETALLE"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList Img_Contenedor_Imagenes 
      Left            =   6690
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_REGLAS.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_REGLAS.frx":1A88
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_REGLAS.frx":2962
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_REGLAS.frx":383C
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_REGLAS.frx":4716
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_REGLAS.frx":4A30
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_REGLAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOpcion_Local       As String
Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, ""
   PROC_CARGA_REGLAS
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

      Select Case KeyCode
         Case 107
               KeyCode = 0
               Exit Sub
         Case VbKeyNuevo
               Call tlb_Barra_Herramientas_ButtonClick(tlb_Barra_Herramientas.Buttons(1))
         Case VbKeyDetalle
               Call tlb_Barra_Herramientas_ButtonClick(tlb_Barra_Herramientas.Buttons(5))
      End Select
   End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
         
   Case vbKeyEliminar
         Call tlb_Barra_Herramientas_ButtonClick(tlb_Barra_Herramientas.Buttons(2))
   Case VbKeyActivar
         Call tlb_Barra_Herramientas_ButtonClick(tlb_Barra_Herramientas.Buttons(3))
   Case VbKeyDesactivar
         Call tlb_Barra_Herramientas_ButtonClick(tlb_Barra_Herramientas.Buttons(4))
   Case vbKeySalir
         Unload Me

   End Select

End Sub

Private Sub Form_Load()
    
    cOpcion_Local = Opt
    Me.top = 0
    Me.left = 0
    Me.Icon = Menu_Principal.Icon
    PROC_GENERA_LISTA
    PROC_CARGA_REGLAS
    Me.Caption = FRM_REGLAS.Caption
    Call LogAuditoria("07", cOpcion_Local, Me.Caption, "", "")

End Sub

Private Sub lst_Reglas_Mensajes_DblClick()
   Call tlb_Barra_Herramientas_ButtonClick(tlb_Barra_Herramientas.Buttons(5))
End Sub

Private Sub lst_Reglas_Mensajes_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Call tlb_Barra_Herramientas_ButtonClick(tlb_Barra_Herramientas.Buttons(5))
   End If
End Sub

Private Sub tlb_Barra_Herramientas_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim nContador As Integer
Dim nCantidad As Integer
Dim nNumero As Integer

Select Case UCase(Button.Key)
    Case "NUEVO"
          Txt_Numoper.Text = 0
          FRM_NUEVA_REGLA.Caption = "Nueva Regla"
          FRM_NUEVA_REGLA.Show vbModal
          PROC_CARGA_REGLAS
    Case "ELIMINAR"
            PROC_ELIMINA_REGLAS
            PROC_CARGA_REGLAS
    Case "ACTIVAR"
            PROC_ACTUALIZA_ESTADO_REGLAS ("0")
    Case "DESACTIVAR"
            PROC_ACTUALIZA_ESTADO_REGLAS ("1")
    Case "DETALLE"
            nCantidad = 0
            For nContador = 1 To lst_Reglas_Mensajes.ListItems.Count
               If lst_Reglas_Mensajes.ListItems(nContador).Selected = True Then
                  nNumero = lst_Reglas_Mensajes.ListItems(nContador)
                  nCantidad = nCantidad + 1
               End If
            Next
            If nCantidad > 1 Then
               MsgBox "Para Ver Detalle Solo Debe Selecionar Una Sola Regla", vbInformation
               DoEvents
               lst_Reglas_Mensajes.SetFocus
               Exit Sub
            Else
               
            End If
          Txt_Numoper.Text = nNumero
          FRM_NUEVA_REGLA.Caption = "Regla Nº " + Str(nNumero)
          
          
        FRM_NUEVA_REGLA.Show vbModal
        PROC_CARGA_REGLAS
    Case "SALIR"
        Unload Me
End Select
End Sub

Private Sub PROC_GENERA_LISTA()

With lst_Reglas_Mensajes
    .Sorted = True
    .AllowColumnReorder = True
    .ColumnHeaderIcons = img_Contenedor_Imagenes_II
    .ColumnHeaders.Add 1, , "Numero", 850
    .ColumnHeaders.Add 2, , "Reglas", 5000
    .ColumnHeaders.Add 3, , "Estado", 1200
    .ColumnHeaders.Add 4, , "Para", 0
    .ColumnHeaders.Add 5, , "CC", 0
    .ColumnHeaders.Add 6, , "Otros", 0
    .ColumnHeaders.Add 7, , "Asunto", 0
End With

End Sub

Private Sub PROC_CARGA_REGLAS()
Dim Datos_Recibidos()

    lst_Reglas_Mensajes.ListItems.Clear
    
    If Not BAC_SQL_EXECUTE("SP_CON_REGLA") Then
      MsgBox "Problemas al Cargar Reglas", vbCritical
      Exit Sub
    Else
    
    End If
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)

      With lst_Reglas_Mensajes
         .ListItems.Add , , Datos_Recibidos(1)
         .ListItems.item(.ListItems.Count).ListSubItems.Add (1), , Datos_Recibidos(2)
         .ListItems.item(.ListItems.Count).ListSubItems.Add (2), , IIf(Trim(Datos_Recibidos(7)) = "1", "Desactivada", "Activada")
         .ListItems.item(.ListItems.Count).ListSubItems.Add (3), , Datos_Recibidos(3)
         .ListItems.item(.ListItems.Count).ListSubItems.Add (4), , Datos_Recibidos(4)
         .ListItems.item(.ListItems.Count).ListSubItems.Add (5), , Datos_Recibidos(5)
         .ListItems.item(.ListItems.Count).ListSubItems.Add (6), , Datos_Recibidos(6)
      End With
    Loop

End Sub
Private Sub PROC_ACTUALIZA_ESTADO_REGLAS(cEstado As String)
Dim nContador As Integer
Dim Datos_Recibidos()
    
   For nContador = 1 To lst_Reglas_Mensajes.ListItems.Count
      If lst_Reglas_Mensajes.ListItems(nContador).Selected = True Then
            Envia_Parametros = Array(lst_Reglas_Mensajes.ListItems(nContador), cEstado)
            If Not BAC_SQL_EXECUTE("SP_ACT_ESTADO_REGLA ", Envia_Parametros) Then
                MsgBox "Problemas al Actualizar Estado", vbCritical
                Exit Sub
            Else
               lst_Reglas_Mensajes.ListItems(nContador).SubItems(2) = IIf(Trim(cEstado) = "1", "Desactivada", "Activada")
            End If
      End If
    
    Next

End Sub

Private Sub PROC_ELIMINA_REGLAS()
Dim nContador As Integer
Dim Datos_Recibidos()
    
   For nContador = 1 To lst_Reglas_Mensajes.ListItems.Count
      If lst_Reglas_Mensajes.ListItems(nContador).Selected = True Then
         If Trim(lst_Reglas_Mensajes.ListItems(nContador).SubItems(2)) = "Desactivada" Then
               Envia_Parametros = Array(lst_Reglas_Mensajes.ListItems(nContador))
               If Not BAC_SQL_EXECUTE("SP_ELI_REGLA ", Envia_Parametros) Then
                   MsgBox "Problemas al Eliminar Regla Nº " + lst_Reglas_Mensajes.ListItems(nContador), vbCritical
                   Exit Sub
               End If
         Else
               MsgBox "No Se Puede Elimar Regla Nº " + lst_Reglas_Mensajes.ListItems(nContador) + " Por Encontrarse Activa", vbCritical
         End If
      End If
    Next

   lst_Reglas_Mensajes.SetFocus
   
End Sub

