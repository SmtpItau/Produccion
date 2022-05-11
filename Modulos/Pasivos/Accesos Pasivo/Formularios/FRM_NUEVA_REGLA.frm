VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_NUEVA_REGLA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Nueva Regla"
   ClientHeight    =   7335
   ClientLeft      =   3030
   ClientTop       =   2475
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
   Icon            =   "FRM_NUEVA_REGLA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7335
   ScaleWidth      =   7935
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fmr_Nombre_Regla 
      Height          =   825
      Left            =   30
      TabIndex        =   16
      Top             =   495
      Width           =   7920
      Begin VB.TextBox txt_Nombre_Regla 
         Height          =   360
         Left            =   960
         MaxLength       =   100
         TabIndex        =   0
         Top             =   270
         Width           =   6855
      End
      Begin VB.Label lblNombreRegla 
         Caption         =   "Nombre :"
         Height          =   285
         Left            =   135
         TabIndex        =   17
         Top             =   360
         Width           =   780
      End
   End
   Begin VB.Frame fmr_Opciones_Menu 
      Height          =   4290
      Left            =   0
      TabIndex        =   15
      Top             =   3045
      Width           =   7920
      Begin VB.ListBox lst_Opciones2 
         Height          =   3840
         Left            =   4170
         TabIndex        =   19
         Top             =   4350
         Visible         =   0   'False
         Width           =   3660
      End
      Begin VB.ListBox lst_Check_List2 
         Height          =   3630
         Left            =   300
         TabIndex        =   18
         Top             =   4350
         Visible         =   0   'False
         Width           =   3270
      End
      Begin VB.ListBox lst_Opciones 
         Height          =   4050
         ItemData        =   "FRM_NUEVA_REGLA.frx":030A
         Left            =   4170
         List            =   "FRM_NUEVA_REGLA.frx":030C
         OLEDragMode     =   1  'Automatic
         OLEDropMode     =   1  'Manual
         TabIndex        =   6
         Top             =   180
         Width           =   3660
      End
      Begin VB.ListBox lst_Check_List 
         Height          =   4050
         Left            =   60
         OLEDragMode     =   1  'Automatic
         OLEDropMode     =   1  'Manual
         TabIndex        =   5
         Top             =   180
         Width           =   3660
      End
      Begin MSComctlLib.Toolbar tlb_Derecha 
         Height          =   510
         Left            =   3720
         TabIndex        =   10
         Top             =   1920
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   900
         ButtonWidth     =   820
         ButtonHeight    =   794
         AllowCustomize  =   0   'False
         ImageList       =   "img_Contenedor_Imagenes"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "ENVIAR"
               Object.ToolTipText     =   "Enviar"
               ImageIndex      =   3
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.Toolbar tlb_Izquierda 
         Height          =   510
         Left            =   3720
         TabIndex        =   9
         Top             =   1455
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   900
         ButtonWidth     =   1561
         ButtonHeight    =   794
         AllowCustomize  =   0   'False
         TextAlignment   =   1
         ImageList       =   "img_Contenedor_Imagenes"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "DEVOLVER"
               Object.ToolTipText     =   "No Enviar"
               ImageIndex      =   4
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame fmr_mensajes_a 
      Height          =   1770
      Left            =   30
      TabIndex        =   12
      Top             =   1275
      Width           =   7920
      Begin VB.TextBox txt_Otros 
         Height          =   360
         Left            =   1020
         MaxLength       =   255
         TabIndex        =   3
         Top             =   945
         Width           =   6735
      End
      Begin VB.TextBox txt_Asunto 
         Height          =   360
         Left            =   1020
         MaxLength       =   255
         TabIndex        =   4
         Top             =   1320
         Width           =   6735
      End
      Begin VB.TextBox txt_conCopia 
         Height          =   360
         Left            =   1020
         Locked          =   -1  'True
         MaxLength       =   255
         TabIndex        =   2
         Top             =   585
         Width           =   6735
      End
      Begin VB.TextBox txt_Para 
         Height          =   360
         Left            =   1020
         Locked          =   -1  'True
         MaxLength       =   255
         TabIndex        =   1
         Top             =   225
         Width           =   6735
      End
      Begin VB.CommandButton cmd_ConCopia 
         Caption         =   "&CC..."
         Height          =   330
         Left            =   75
         TabIndex        =   8
         ToolTipText     =   "Con Copia A:"
         Top             =   600
         Width           =   900
      End
      Begin VB.CommandButton cmd_Para 
         Caption         =   "&Para..."
         Height          =   330
         Left            =   75
         TabIndex        =   7
         ToolTipText     =   "Enviar A:"
         Top             =   210
         Width           =   900
      End
      Begin VB.Label lblOtros 
         Caption         =   "Otros :"
         Height          =   285
         Left            =   135
         TabIndex        =   14
         Top             =   1035
         Width           =   780
      End
      Begin VB.Label lblAsunto 
         Caption         =   "Asunto :"
         Height          =   285
         Left            =   135
         TabIndex        =   13
         Top             =   1410
         Width           =   780
      End
   End
   Begin MSComctlLib.Toolbar tlb_Barra_Herramientas 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   7935
      _ExtentX        =   13996
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "img_Contenedor_Imagenes"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "GRABAR"
            Object.ToolTipText     =   "Grabar Regla"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList img_Contenedor_Imagenes 
      Left            =   5310
      Top             =   -30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_NUEVA_REGLA.frx":030E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_NUEVA_REGLA.frx":11E8
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_NUEVA_REGLA.frx":1502
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_NUEVA_REGLA.frx":1954
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_NUEVA_REGLA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cNombre_Control As String
Dim bGrabacion As Boolean

Private Sub cmd_ConCopia_Click()
   txt_conCopia_DblClick
End Sub
Private Sub cmd_Para_Click()
   txt_Para_DblClick
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, ""
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   Select Case KeyAscii
      Case vbKeyGrabar
            Call tlb_Barra_Herramientas_ButtonClick(tlb_Barra_Herramientas.Buttons(1))
      Case vbKeySalir
            Unload Me
   End Select
End Sub
Private Sub Form_Load()
    Me.Icon = Menu_Principal.Icon
    PROC_CARGA_LISTA
    If CDbl(FRM_REGLAS.Txt_Numoper.Text) > 0 Then
         PROC_CARGA_DATOS
    End If
End Sub
Private Sub lst_Check_List_GotFocus()
   lst_Opciones.ListIndex = -1
End Sub

Private Sub lst_Check_List_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)
   End If
End Sub
Private Sub lst_Check_List_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, Y As Single)
      Call tlb_Izquierda_ButtonClick(tlb_Izquierda.Buttons(1))
End Sub
Private Sub lst_Check_List_OLEStartDrag(Data As DataObject, AllowedEffects As Long)
   AllowedEffects = vbDropEffectMove
End Sub
Private Sub lst_Opciones_GotFocus()
   lst_Check_List.ListIndex = -1
End Sub
Private Sub lst_Opciones_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)
   End If
End Sub
Private Sub lst_Opciones_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, Y As Single)
      Call tlb_Derecha_ButtonClick(tlb_Derecha.Buttons(1))
End Sub
Private Sub lst_Opciones_OLEStartDrag(Data As DataObject, AllowedEffects As Long)
   AllowedEffects = vbDropEffectMove
End Sub
Private Sub tlb_Barra_Herramientas_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Key)
    Case "GRABAR"
            PROC_GRABAR_REGLA
            If bGrabacion = True Then
               Unload Me
            End If
    Case "SALIR"
            Unload Me
End Select
End Sub
Private Sub PROC_CARGA_LISTA()
Dim Datos_Recibidos()

    Envia_Parametros = Array("1")
    
    If Not BAC_SQL_EXECUTE("SP_CON_BUSCA_ORDEN ", Envia_Parametros) Then Exit Sub
    
    lst_Check_List.Clear
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)
        lst_Check_List.AddItem Datos_Recibidos(3) + Space(80) + Datos_Recibidos(1)
        lst_Check_List2.AddItem Datos_Recibidos(5)
    Loop
End Sub

Private Sub PROC_CARGA_DATOS()
Dim Datos_Recibidos()
Dim nCantidad As Integer
Dim nContador As Integer
    
    Envia_Parametros = Array(CDbl(FRM_REGLAS.Txt_Numoper.Text))
    
    If Not BAC_SQL_EXECUTE("SP_CON_REGLA_DETALLE ", Envia_Parametros) Then Exit Sub
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)
        txt_Nombre_Regla.Text = Trim(Datos_Recibidos(2))
        txt_Para = Trim(Datos_Recibidos(3))
        txt_conCopia = Trim(Datos_Recibidos(4))
        txt_Otros = Trim(Datos_Recibidos(5))
        txt_Asunto = Trim(Datos_Recibidos(6))
    Loop
    
    Envia_Parametros = Array(CDbl(FRM_REGLAS.Txt_Numoper.Text))
    
    If Not BAC_SQL_EXECUTE("SP_CON_REGLA_DETALLE_SWITCH ", Envia_Parametros) Then Exit Sub
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)
        lst_Opciones.AddItem Datos_Recibidos(4) + Space(80) + Datos_Recibidos(3)
        lst_Opciones2.AddItem Datos_Recibidos(2)
            
            nCantidad = 0
            For nContador = 0 To lst_Check_List.ListCount - 1
               lst_Check_List.ListIndex = nContador
               If Trim(lst_Check_List.Text) = Trim(Datos_Recibidos(4) + Space(80) + Datos_Recibidos(3)) Then
                  lst_Check_List.RemoveItem (nContador)
                  lst_Check_List2.RemoveItem (nContador)
                  Exit For
               End If
            Next
    Loop
    
    
End Sub

Private Sub tlb_Derecha_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim cDescripcion_1 As String
Dim cDescripcion_2 As String
Dim nContador As Integer

Select Case UCase(Button.Key)
    Case "ENVIAR"
            If lst_Check_List.ListIndex = -1 Then
               Exit Sub
            End If
            
            nUbicacion = lst_Check_List.ListIndex
            
            cDescripcion_1 = lst_Check_List.List(nUbicacion)
            cDescripcion_2 = lst_Check_List2.List(nUbicacion)
            lst_Check_List.RemoveItem nUbicacion
            lst_Check_List2.RemoveItem nUbicacion
            lst_Opciones.AddItem cDescripcion_1
            lst_Opciones2.AddItem cDescripcion_2
            DoEvents
            lst_Check_List.SetFocus
            If lst_Check_List.ListCount > 0 And nUbicacion = 0 Then
               lst_Check_List.ListIndex = nUbicacion
            Else
               lst_Check_List.ListIndex = nUbicacion - 1
            End If
End Select

End Sub

Private Sub tlb_Izquierda_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim nUbicacion As Integer
Dim cDescripcion_1 As String
Dim cDescripcion_2 As String
Dim nContador As Integer

Select Case UCase(Button.Key)
    Case "DEVOLVER"
            If lst_Opciones.ListIndex = -1 Then
               Exit Sub
            End If
            
            nUbicacion = lst_Opciones.ListIndex
            
            cDescripcion_1 = lst_Opciones.List(nUbicacion)
            cDescripcion_2 = lst_Opciones2.List(nUbicacion)
            lst_Opciones.RemoveItem nUbicacion
            lst_Opciones2.RemoveItem nUbicacion
            lst_Check_List.AddItem cDescripcion_1
            lst_Check_List2.AddItem cDescripcion_2
            DoEvents
            lst_Opciones.SetFocus
            If lst_Opciones.ListCount > 0 And nUbicacion = 0 Then
               lst_Opciones.ListIndex = nUbicacion
            Else
               lst_Opciones.ListIndex = nUbicacion - 1
            End If
End Select

End Sub
Private Sub txt_Asunto_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)
   End If
    If KeyAscii = 39 Or KeyAscii = 34 Then
        KeyAscii = 0
    End If
End Sub

Private Sub txt_conCopia_DblClick()
    FRM_AYUDA.Tag = "USER"
    FRM_AYUDA.Caption = "Usuarios CC "
    FRM_AYUDA.Show 1
    
    If giAceptar% = True Then
      txt_conCopia.Text = gsDescripcion$
      gsDescripcion$ = ""
      DoEvents
      txt_conCopia.SetFocus
    End If
End Sub

Private Sub txt_conCopia_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
       txt_conCopia_DblClick
   Else
      If KeyCode <> 36 And KeyCode <> 35 And KeyCode <> 39 And KeyCode <> 37 Then
         KeyCode = 0
      End If
   End If
End Sub
Private Sub txt_conCopia_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)
   Else
        KeyAscii = 0
    End If
End Sub

Private Sub txt_Nombre_Regla_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)
   End If
    If KeyAscii = 39 Or KeyAscii = 34 Then
        KeyAscii = 0
    End If
End Sub

Private Sub txt_Otros_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)
   End If
    If KeyAscii = 39 Or KeyAscii = 34 Then
        KeyAscii = 0
    End If
End Sub
Private Sub txt_Otros_LostFocus()
Dim nLargo As Integer
Dim nContador As Integer
Dim cPorcion As String
Dim cPorcion_2 As String
Dim cPorcion_3 As String
Dim nUbicacion As Integer
Dim nUbicacion_2 As Integer
Dim nUbicacion_3 As Integer

   If Trim(txt_Otros.Text) = "" Then Exit Sub
   
   If InStr(1, Trim(txt_Otros.Text), ".@") > 0 Or InStr(1, Trim(txt_Otros.Text), "@.") > 0 Then
      MsgBox "Verifique Que su Direccion de Correo Este Correcta (.@) o (@.)", vbExclamation
         DoEvents
         txt_Otros.SetFocus
         Exit Sub
   End If
   
   nLargo = Len(Trim(txt_Otros.Text))
   nContador = 1
   While nContador < nLargo
      nUbicacion = InStr(nContador, Trim(txt_Otros.Text), ";")
      
      If nUbicacion = 0 Then
         nUbicacion = nLargo
      End If
      
      If nUbicacion = nLargo Then
         cPorcion = Mid(Trim(txt_Otros.Text), nContador, nUbicacion)
      Else
         cPorcion = Mid(Trim(txt_Otros.Text), nContador, nUbicacion - 1)
      End If
      
      nUbicacion_3 = InStr(1, Trim(cPorcion), "@")
      
      If nUbicacion_3 = 0 Then
         MsgBox "Verifique Que su Direccion de Correo Contenga el Caracter @ ", vbExclamation
         DoEvents
         txt_Otros.SetFocus
         Exit Sub
      End If
      
      nUbicacion_2 = InStr(nUbicacion_3, Trim(cPorcion), ".")
      
      If nUbicacion_2 = 0 Then
         MsgBox "Verifique Que su Direccion de Correo Contenga Punto ", vbExclamation
         DoEvents
         txt_Otros.SetFocus
         Exit Sub
      End If
      
      If nUbicacion = nLargo Then
         cPorcion_2 = Mid(Trim(cPorcion), nUbicacion_2 + 1, nUbicacion)
      Else
         cPorcion_2 = Mid(Trim(cPorcion), nUbicacion_2 + 1, nUbicacion - 1)
      End If
      
      cPorcion_3 = Mid(Trim(cPorcion), (nUbicacion_3 + 1), ((nUbicacion_2 - 1) - (nUbicacion_3)))
      
      If InStr(1, Trim(cPorcion), ".") = 0 Then
         MsgBox "Verifique Que su Direccion de Correo Contenga Punto ", vbExclamation
         DoEvents
         txt_Otros.SetFocus
         Exit Sub
      End If
      
      If cPorcion_2 = "" Then
         MsgBox "Su Direccion De Correo Debe Tener Una Extencion Despues Del Punto", vbExclamation
         DoEvents
         txt_Otros.SetFocus
         Exit Sub
      End If
      
      If cPorcion_3 = "" Then
         MsgBox "Su Direccion De Correo Debe Tener Host", vbExclamation
         DoEvents
         txt_Otros.SetFocus
         Exit Sub
      End If
      
      If IsNumeric(Mid(cPorcion, 1, 1)) Then
         MsgBox "Su Direccion De Correo No Debe Empesar Con Un Numero", vbExclamation
         DoEvents
         txt_Otros.SetFocus
         Exit Sub
      End If
      
      
      nContador = nUbicacion + 1
      
   Wend
   
End Sub
Private Sub txt_Para_DblClick()
    FRM_AYUDA.Tag = "USER"
    FRM_AYUDA.Caption = "Usuarios Para "
    FRM_AYUDA.Show 1
    
    If giAceptar% = True Then
      txt_Para.Text = gsDescripcion$
      gsDescripcion$ = ""
      DoEvents
      txt_Para.SetFocus
    End If
End Sub

Private Sub txt_Para_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
      txt_Para_DblClick
   Else
      If KeyCode <> 36 And KeyCode <> 35 And KeyCode <> 39 And KeyCode <> 37 Then
         KeyCode = 0
      End If
   End If
End Sub

Private Sub txt_Para_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)
   Else
        KeyAscii = 0
    End If
End Sub
Private Sub PROC_GRABAR_REGLA()
Dim Datos_Recibidos()
Dim nContador                 As Integer
Dim nNumero_Operacion         As Double
Dim cMensaje                  As String
    
    bGrabacion = False
    
   If Trim(txt_Nombre_Regla.Text) = "" Then
      MsgBox "Debe Ingresar Un Nombre a Para La Regla", vbCritical
      Exit Sub
   ElseIf Trim(txt_Para.Text) = "" Then
      MsgBox "Debe Ingresar Un Usuario De Envio a la Regla", vbExclamation
      Exit Sub
   ElseIf lst_Opciones.ListCount = 0 Then
      MsgBox "Debe Ingresar Una Opcion de Menu a Enviar", vbExclamation
      Exit Sub
   End If
   
   If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then
         MsgBox "Problemas al Iniciar Grabacion de Regla ", vbCritical
   Else
         Screen.MousePointer = 11
   End If
    
    Envia_Parametros = Array(CDbl(FRM_REGLAS.Txt_Numoper.Text), Trim(txt_Nombre_Regla.Text), Trim(txt_Para.Text), Trim(txt_conCopia.Text), Trim(txt_Otros.Text), Trim(txt_Asunto), "0")
   
    If Not BAC_SQL_EXECUTE("SP_ACT_REGLA ", Envia_Parametros) Then
         If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
         End If
         MsgBox "Problemas al Grabar Regla ", vbCritical
         Screen.MousePointer = 0
         Exit Sub
    Else
         Do While BAC_SQL_FETCH(Datos_Recibidos)
            nNumero_Operacion = CDbl(Datos_Recibidos(1))
            cMensaje = Trim(Datos_Recibidos(2))
         Loop
    End If
    
    For nContador = 0 To lst_Opciones.ListCount - 1

        Envia_Parametros = Array(nNumero_Operacion, Trim(right(lst_Opciones.List(nContador), 20)), Trim(left(lst_Opciones2.List(nContador), 3)), nContador)

        If Not BAC_SQL_EXECUTE("SP_ACT_REGLA_DETALLE ", Envia_Parametros) Then
            If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
            End If
            MsgBox "Problemas al Grabar Regla ", vbCritical
            Screen.MousePointer = 0
            Exit Sub
        
        End If

    Next
    
    If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then
    End If

   MsgBox "Regla " + Trim(cMensaje) + " Con el Numero " & nNumero_Operacion, vbInformation
   bGrabacion = True
End Sub

