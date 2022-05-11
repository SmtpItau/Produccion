VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_AYUDA 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Ayuda"
   ClientHeight    =   5715
   ClientLeft      =   3510
   ClientTop       =   3675
   ClientWidth     =   6045
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   ForeColor       =   &H00C0C0C0&
   Icon            =   "FRM_AYUDA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5715
   ScaleWidth      =   6045
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox TxtBuscar 
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
      Left            =   1095
      TabIndex        =   1
      Top             =   600
      Width           =   4950
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6045
      _ExtentX        =   10663
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbaceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   10
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4920
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":000C
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":0473
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":0969
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":0DFC
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":12E4
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":17F7
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":1D34
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":2176
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":2630
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":2B03
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":2F47
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":34AE
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":397D
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":3D9C
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":4294
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":468D
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":4B10
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":4FD6
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":54CD
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":5983
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":5D48
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":613E
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":6535
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":693E
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_AYUDA.frx":6DFC
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSComctlLib.ListView LstAyuda 
      Height          =   4815
      Left            =   0
      TabIndex        =   2
      Top             =   915
      Width           =   6075
      _ExtentX        =   10716
      _ExtentY        =   8493
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      FullRowSelect   =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   0
   End
   Begin VB.Label LblBuscarPor 
      Caption         =   "Buscar por :"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   75
      TabIndex        =   3
      Top             =   615
      Width           =   1230
   End
End
Attribute VB_Name = "FRM_AYUDA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private oobjAyuda       As Object
Public lCodigo          As Long
Dim Datos()
Dim linicial            As Long
Dim bTitulo     As Boolean
Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me
End Sub
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

        Select Case KeyCode
            Case VbkeyAceptar 'Aceptar
                nOpcion = 1
            Case vbKeySalir 'Salir
                nOpcion = 2
        End Select
        
        If nOpcion > 0 Then
            If Toolbar1.Buttons(nOpcion).Enabled Then
                Toolbar1_ButtonClick Toolbar1.Buttons(nOpcion)
            End If
        End If
    
    End If

End Sub

Private Sub Form_Resize()

On Error Resume Next

   If Not Me.Width > 9105 Then
      LstAyuda.Width = Me.Width - 90
      TxtBuscar.Width = Me.Width - 1230
   Else
      Me.Width = 9105
   End If
   
   If Not Me.Height > 8850 Then
      LstAyuda.Height = Me.Height - 1260
   Else
      Me.Height = 8850
   End If

End Sub


Private Sub Form_Load()
     
         Screen.MousePointer = 11

         Call PROC_CARGA_LIST

         Screen.MousePointer = 0

         LstAyuda.Sorted = True
         LstAyuda.AllowColumnReorder = True

         If LstAyuda.ListItems.Count > 0 Then
            LblBuscarPor.Caption = LstAyuda.ColumnHeaders.Item(1).Text
         
         End If

         Exit Sub

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oobjAyuda = Nothing

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "ACEPTAR"
        Call TLBARACEPTAR
        
    Case "CANCELAR"
        Call TLBARCANCELAR
End Select

End Sub
Private Sub TLBARCANCELAR()
    GLB_codigo$ = ""
    GLB_Aceptar% = False
    Unload Me
End Sub

Private Sub TLBARACEPTAR()
   Dim cCodigo_Instrumento As String
   Dim cNom_Instrumento    As String
   Dim cCodigo_Producto    As String
   Dim nPos&
   Dim sText            As String
   Dim nIndice          As Integer
   Dim X As String
   Dim nColeccion       As Integer
   Dim Datos()
   Dim Rut
   Dim Codigo
   Dim cNomProc As String
   
   
   '-Si No tiene Elementos Listcount = 0 -'
   If Not LstAyuda.ListItems.Count > 0 Then
      Exit Sub
   End If

   '-Si tiene algun elemento-'
   nIndice = LstAyuda.SelectedItem.Index    'BuscaListIndex(lstNombre, Trim$(txtNombre.Text)) + 1
   linicial = nIndice
     
   nPos = linicial

   Screen.MousePointer = 11

   If (nPos >= 0) Then
      'Toma el indice de la lista que es el mismo que la coleccion
      Select Case cMiTag
      
      Case "MDCL"
         
         GLB_Envia = Array()
         
                Codigo = LstAyuda.ListItems.Item(nIndice).ListSubItems(2).Text 'Trim(Mid(lstNombre, 120, 50))
                Rut = LstAyuda.ListItems.Item(nIndice).ListSubItems(1).Text ' Trim(Right(lstNombre, 9))
                
                cNomProc = "SP_CON_CLIENTE_POR_RUT"
                PROC_AGREGA_PARAMETRO GLB_Envia, Rut
                PROC_AGREGA_PARAMETRO GLB_Envia, Codigo
                PROC_AGREGA_PARAMETRO GLB_Envia, 1
                
          If Not FUNC_EXECUTA_COMANDO_SQL(cNomProc, GLB_Envia) Then
                MsgBox "Error al buscar Cliente", vbInformation
                Exit Sub
          End If

          If FUNC_LEE_RETORNO_SQL(Datos()) Then
             GLB_codigo$ = Datos(3)       'clrut
             GLB_rut$ = Datos(1)          'clrut
             GLB_Digito$ = Datos(2)       'cldv
             GLB_Descripcion$ = Datos(4)  'clnombre
             GLB_fax$ = Datos(5)          'clfax
             GLB_valor$ = Datos(3)        'clcodigo
          Else
             MsgBox "Cliente no encontrado", vbInformation
          End If
     
      Case "MDEX"
         
         GLB_Envia = Array()
         
                Codigo = LstAyuda.ListItems.Item(nIndice).ListSubItems(2).Text 'Trim(Mid(lstNombre, 120, 50))
                Rut = LstAyuda.ListItems.Item(nIndice).ListSubItems(1).Text ' Trim(Right(lstNombre, 9))
                
                cNomProc = "SP_CON_CLIENTE_POR_RUT"
                PROC_AGREGA_PARAMETRO GLB_Envia, Rut
                PROC_AGREGA_PARAMETRO GLB_Envia, Codigo
                PROC_AGREGA_PARAMETRO GLB_Envia, 2
                
          If Not FUNC_EXECUTA_COMANDO_SQL(cNomProc, GLB_Envia) Then
                MsgBox "Error al buscar Cliente", vbInformation
                Exit Sub
          End If

          If FUNC_LEE_RETORNO_SQL(Datos()) Then
             GLB_codigo$ = Datos(3)       'clrut
             GLB_rut$ = Datos(1)          'clrut
             GLB_Digito$ = Datos(2)       'cldv
             GLB_Descripcion$ = Datos(4)  'clnombre
             GLB_fax$ = Datos(5)          'clfax
             GLB_valor$ = Datos(3)        'clcodigo
          Else
             MsgBox "Cliente no encontrado", vbInformation
          End If
     
     Case "CLIENTE"
         
         GLB_Envia = Array()
         
                Codigo = LstAyuda.ListItems.Item(nIndice).ListSubItems(2).Text 'Trim(Mid(lstNombre, 120, 50))
                Rut = LstAyuda.ListItems.Item(nIndice).ListSubItems(1).Text ' Trim(Right(lstNombre, 9))
                
                cNomProc = "SP_CON_CLIENTE_POR_RUT"
                PROC_AGREGA_PARAMETRO GLB_Envia, Rut
                PROC_AGREGA_PARAMETRO GLB_Envia, Codigo
                PROC_AGREGA_PARAMETRO GLB_Envia, 0
                
          If Not FUNC_EXECUTA_COMANDO_SQL(cNomProc, GLB_Envia) Then
                MsgBox "Error al buscar Cliente", vbInformation
                Exit Sub
          End If

          If FUNC_LEE_RETORNO_SQL(Datos()) Then
             GLB_codigo$ = Datos(3)       'clrut
             GLB_rut$ = Datos(1)          'clrut
             GLB_Digito$ = Datos(2)       'cldv
             GLB_Descripcion$ = Datos(4)  'clnombre
             GLB_fax$ = Datos(5)          'clfax
             GLB_valor$ = Datos(3)        'clcodigo
          Else
             MsgBox "Cliente no encontrado", vbInformation
          End If
         
     
     
      Case "MDIN"
    
         
         
         GLB_Envia = Array()
         
                cCodigo_Producto = LstAyuda.ListItems.Item(nIndice).ListSubItems(3).Text 'Trim(Mid(lstNombre, 120, 50))
                cCodigo_Instrumento = LstAyuda.ListItems.Item(nIndice).ListSubItems(1).Text     ' Trim(Right(lstNombre, 9))
                
                cNomProc = "SP_CON_INST_BONOS"
                PROC_AGREGA_PARAMETRO GLB_Envia, cCodigo_Producto
                PROC_AGREGA_PARAMETRO GLB_Envia, cCodigo_Instrumento
                
          If Not FUNC_EXECUTA_COMANDO_SQL(cNomProc, GLB_Envia) Then
                MsgBox "Error al buscar Cliente", vbInformation
                Exit Sub
          End If

          If FUNC_LEE_RETORNO_SQL(Datos()) Then
             GLB_codigo$ = Datos(1)       'codigo_instrumento
             GLB_Descripcion$ = Datos(2)  'nombre instrumento
             GLB_nombre$ = Datos(4)
          Else
             MsgBox "Instrumento no encontrado", vbInformation
          End If
      
      Case "MDEM"
         
         GLB_Envia = Array()
         
          Codigo = LstAyuda.ListItems.Item(nIndice).ListSubItems(2).Text 'Trim(Mid(lstNombre, 120, 50))
          Rut = LstAyuda.ListItems.Item(nIndice).ListSubItems(1).Text ' Trim(Right(lstNombre, 9))
                
          cNomProc = "SP_CON_EMISORES"
          PROC_AGREGA_PARAMETRO GLB_Envia, Val(Rut)
          PROC_AGREGA_PARAMETRO GLB_Envia, Val(Codigo)
                
          If Not FUNC_EXECUTA_COMANDO_SQL(cNomProc, GLB_Envia) Then
                MsgBox "Error al buscar Cliente", vbInformation
                Exit Sub
          End If

          If FUNC_LEE_RETORNO_SQL(Datos()) Then
             GLB_codigo$ = Datos(1)       'clrut
             GLB_rut$ = Datos(2)          'clrut
             GLB_Digito$ = Datos(3)       'cldv
             GLB_Descripcion$ = Datos(4)  'clnombre
             
          Else
             MsgBox "Emisor no encontrado", vbInformation
          End If
      
      
      Case "MDSE"
         
         Codigo = LstAyuda.ListItems.Item(nIndice)
         
         cNomProc = "SP_CON_SERIES"
         
         GLB_Envia = Array()
         PROC_AGREGA_PARAMETRO GLB_Envia, Val(Pbl_cCodigo_Serie)
         PROC_AGREGA_PARAMETRO GLB_Envia, Codigo
         PROC_AGREGA_PARAMETRO GLB_Envia, Pbl_cCodigo_Producto
         If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
            MsgBox "Error al buscar Cliente", vbInformation
            Exit Sub
         End If
         If FUNC_LEE_RETORNO_SQL(Datos()) Then
            GLB_codigo$ = Datos(2)        'Serie
            GLB_Instrumento$ = Datos(1)    'Código Instrumento
         Else
            MsgBox "Serie no encontrada", vbInformation
         End If
      
      
      End Select
FIN:
   
    Else
        Exit Sub
    End If

    Screen.MousePointer = 0
    GLB_Aceptar% = True
    Unload Me
   
End Sub


' ************************ Nuevos Cambios

Private Sub PROC_CARGA_LIST()
Dim Arreglo()
Dim Datos()
Dim Titulo      As Boolean
Dim cNomProc    As String

   bTitulo = True

   With LstAyuda
      
      .ListItems.Clear
      .ColumnHeaders.Clear
   
        GLB_Envia = Array()
          
        GLB_codigo$ = ""
        GLB_Instrumento$ = Empty
        On Error Resume Next

        PROC_CONTROLVENTA 12
        Screen.MousePointer = 11
      
        Select Case Trim$(cMiTag)
        
        Case "MDCL"
            cNomProc = ""
            GLB_Envia = Array()
            cNomProc = "SP_CON_CLIENTES"
            PROC_AGREGA_PARAMETRO GLB_Envia, 1
            PROC_AGREGA_PARAMETRO GLB_Envia, 1

        Case "CLIENTE"
            cNomProc = ""
            GLB_Envia = Array()
            cNomProc = "SP_CON_CLIENTES"
            PROC_AGREGA_PARAMETRO GLB_Envia, 0
            PROC_AGREGA_PARAMETRO GLB_Envia, 0

        Case "MDEX"
            cNomProc = ""
            GLB_Envia = Array()
            cNomProc = "SP_CON_CLIENTES"
            PROC_AGREGA_PARAMETRO GLB_Envia, 1
            PROC_AGREGA_PARAMETRO GLB_Envia, 2

        Case "MDIN"
            cNomProc = ""
            GLB_Envia = Array()
            cNomProc = "SP_CON_INSTRUMENTOS"
            PROC_AGREGA_PARAMETRO GLB_Envia, Pbl_cTipo_Instrumento
            
        Case "MDSE"
            cNomProc = ""
            GLB_Envia = Array()
            cNomProc = "SP_CON_SERIES"
            PROC_AGREGA_PARAMETRO GLB_Envia, Val(Pbl_cCodigo_Serie)
            PROC_AGREGA_PARAMETRO GLB_Envia, ""
            PROC_AGREGA_PARAMETRO GLB_Envia, Pbl_cCodigo_Producto
            
        Case "MDEM"
            cNomProc = ""
            GLB_Envia = Array()
            cNomProc = "SP_CON_EMISORES"
            PROC_AGREGA_PARAMETRO GLB_Envia, 0
            PROC_AGREGA_PARAMETRO GLB_Envia, 0

        End Select
      
        Dim Espacio0
        Dim Espacio1
                  
                    
        If Not FUNC_EXECUTA_COMANDO_SQL(cNomProc, GLB_Envia) Then
            MousePointer = 0
            Exit Sub
        End If
                    
            Dim Sw As Boolean
            Sw = False
                    
            Do While FUNC_LEE_RETORNO_SQL(Datos())
                       
                If Datos(1) <> "ERROR" Then
                           
                        Sw = True
                        
                        If UCase(cMiTag) = "MDCL" Or UCase(cMiTag) = "MDEX" Or UCase(cMiTag) = "CLIENTE" Then
                            If bTitulo Then
                                GLB_Envia = Array()
                                PROC_ELEMENTO_LIST GLB_Envia, "Cliente"
                                PROC_ELEMENTO_LIST GLB_Envia, "Rut"
                                PROC_ELEMENTO_LIST GLB_Envia, "Codigo"
                                Call PROC_LLENADO_LIST(GLB_Envia, True)
                                bTitulo = False
                            End If
                              
                            LstAyuda.Sorted = False
                            LstAyuda.AllowColumnReorder = False

                            LstAyuda.ListItems.Add , , Datos(4)
                            LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(1)
                            LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(3)

                        ElseIf UCase(cMiTag) = "MDIN" Then
                            If bTitulo Then
                                GLB_Envia = Array()
                                PROC_ELEMENTO_LIST GLB_Envia, "Instrumento"
                                PROC_ELEMENTO_LIST GLB_Envia, "Código"
                                PROC_ELEMENTO_LIST GLB_Envia, "Glosa Instrumento"
                                PROC_ELEMENTO_LIST GLB_Envia, "Codigo Producto"
                                Call PROC_LLENADO_LIST(GLB_Envia, True)
                                bTitulo = False
                            End If
                              
                            LstAyuda.Sorted = False
                            LstAyuda.AllowColumnReorder = False

                            LstAyuda.ListItems.Add , , Datos(2)
                            LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(1)
                            LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(4)
                            LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(3)
                            
                        ElseIf UCase(cMiTag) = "MDSE" Then
                            If bTitulo Then
                                GLB_Envia = Array()
                                PROC_ELEMENTO_LIST GLB_Envia, "Nombre Serie"
                                PROC_ELEMENTO_LIST GLB_Envia, "Código Instrumento"
                                Call PROC_LLENADO_LIST(GLB_Envia, True)
                                bTitulo = False
                            End If
                              
                            LstAyuda.Sorted = False
                            LstAyuda.AllowColumnReorder = False

                            LstAyuda.ListItems.Add , , Datos(2)
                            LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(1)
                            
                        ElseIf UCase(cMiTag) = "MDEM" Then
                            If bTitulo Then
                                GLB_Envia = Array()
                                PROC_ELEMENTO_LIST GLB_Envia, "Emisor"
                                PROC_ELEMENTO_LIST GLB_Envia, "Rut Emisor"
                                PROC_ELEMENTO_LIST GLB_Envia, "Codigo Emisor"
                                Call PROC_LLENADO_LIST(GLB_Envia, True)
                                bTitulo = False
                            End If
                              
                            LstAyuda.Sorted = False
                            LstAyuda.AllowColumnReorder = False

                            LstAyuda.ListItems.Add , , Datos(4)
                            LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(2)
                            LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(1)


                        End If


                End If
            Loop
        
    
       Screen.MousePointer = 0
          
FIN:
      
      .Sorted = True
      .AllowColumnReorder = True
   
   End With

End Sub

Private Sub LstAyuda_DblClick()

   Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))

End Sub



Private Sub LstAyuda_KeyDown(KeyAscii As Integer, Shift As Integer)

   If KeyAscii = vbKeyUp Or KeyAscii = vbKeyDown Or KeyAscii = vbKeyLeft Or KeyAscii = vbKeyRight Or KeyAscii = vbKeyPageUp Or KeyAscii = vbKeyPageDown Then
      Call LstAyuda_Click
      LstAyuda.SetFocus
      Exit Sub
   End If

End Sub

Private Sub LstAyuda_KeyUp(KeyAscii As Integer, Shift As Integer)

   If KeyAscii = vbKeyUp Or KeyAscii = vbKeyDown Or KeyAscii = vbKeyLeft Or KeyAscii = vbKeyRight Or KeyAscii = vbKeyPageUp Or KeyAscii = vbKeyPageDown Then
      Call LstAyuda_Click
      LstAyuda.SetFocus
      Exit Sub
   End If

End Sub


Private Sub TxtBuscar_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyUp Or KeyCode = vbKeyDown Then
   
      TxtBuscar_KeyPress vbKeyReturn
      LstAyuda_KeyDown KeyCode, Shift
   
   End If

End Sub


Private Sub LstAyuda_Click()
On Error Resume Next

   If Val(LblBuscarPor.Tag) = 0 Then
      TxtBuscar.Text = LstAyuda.SelectedItem.Text

   Else
      TxtBuscar.Text = LstAyuda.SelectedItem.ListSubItems.Item(Val(LblBuscarPor.Tag)).Text
   
   End If


End Sub

Private Sub LstAyuda_ColumnClick(ByVal ColumnHeader As MSComctlLib.ColumnHeader)

   
   LblBuscarPor.Caption = ColumnHeader.Text
   LblBuscarPor.Tag = ColumnHeader.Index - 1
   TxtBuscar.Text = ""
   
   Call PROC_ORDEN_LIST(ColumnHeader.Index)
   
   
End Sub

Private Sub LstAyuda_KeyPress(KeyAscii As Integer)


   If KeyAscii = vbKeyUp Or KeyAscii = vbKeyDown Or KeyAscii = vbKeyLeft Or KeyAscii = vbKeyRight Or KeyAscii = vbKeyPageUp Or KeyAscii = vbKeyPageDown Then
      Call LstAyuda_Click
      Exit Sub
   End If

   If KeyAscii = vbKeyReturn Then
      Call LstAyuda_DblClick
      Exit Sub
   End If

   TxtBuscar.Text = UCase(Chr(KeyAscii))
   TxtBuscar.SetFocus
   
End Sub

Private Sub TxtBuscar_GotFocus()

   TxtBuscar.SelStart = Len(TxtBuscar.Text)

End Sub
Private Sub PROC_ORDEN_LIST(nIndice As Integer)
Dim nColumna    As Integer
Dim Arreglo()
'
'   For nColumna = 1 To LstAyuda.ColumnHeaders.Count
'
'      LstAyuda.ColumnHeaders.Item(nColumna).Icon = 0
'
'   Next nColumna
'
'   LstAyuda.SortKey = nIndice - 1
'
'   If LstAyuda.SortOrder = 0 Then
'
'      LstAyuda.SortOrder = lvwDescending
'      LstAyuda.ColumnHeaders.Item(nIndice).Icon = 1
'
'   Else
'      LstAyuda.SortOrder = lvwAscending
'      LstAyuda.ColumnHeaders.Item(nIndice).Icon = 2
'
'   End If

End Sub

Private Sub PROC_LLENADO_LIST(Arreglo As Variant, Titulos As Boolean)
Dim nRegistro As Integer

   With LstAyuda
      
      For nRegistro = 0 To UBound(Arreglo)
      
         If Titulos Then
         
            .ColumnHeaders.Add nRegistro + 1, , Arreglo(nRegistro), 2000
                  
            If nRegistro = 0 Then
               LblBuscarPor.Caption = Arreglo(nRegistro)
            End If
            
         
         Else
         
            If nRegistro = 0 Then
               .ListItems.Add , , Arreglo(nRegistro)
         
            Else
               .ListItems.Item(.ListItems.Count).ListSubItems.Add , , Arreglo(nRegistro)
         
            End If
         
         End If

      Next nRegistro

   End With

End Sub

Private Sub PROC_BUSCA_ELEMENTO(Elemento As String)
Dim nFila As Integer

On Error Resume Next

   Elemento = UCase(Elemento)

   With LstAyuda
   
      For nFila = 1 To .ListItems.Count
   
         If Val(LblBuscarPor.Tag) = 0 Then
      
            If UCase(Mid(.ListItems.Item(nFila).Text, 1, Len(Elemento))) = Elemento Then
               .ListItems.Item(nFila).Selected = True
               FUNC_ENVIA_TECLA vbKeyLeft
               .SetFocus
               Exit For
            
            End If
   
         Else
   
            If UCase(Mid(.ListItems(nFila).ListSubItems.Item(Val(LblBuscarPor.Tag)).Text, 1, Len(Elemento))) = Elemento Then
               .ListItems.Item(nFila).Selected = True
               .SetFocus
               FUNC_ENVIA_TECLA vbKeyLeft
               Exit For
            
            End If
   
         End If
   
      Next nFila
   
   End With

End Sub



Private Sub PROC_ELEMENTO_LIST(ByRef Arreglo As Variant, Parametro As Variant)
Dim nCuenta As Integer
   
   On Error GoTo Errorcuenta:
   
   nCuenta = UBound(Arreglo) + 1
   ReDim Preserve Arreglo(nCuenta)
   Arreglo(nCuenta) = Parametro
   
   Exit Sub

Errorcuenta:
   
   nCuenta = 1
   Resume Next

End Sub

Private Sub TxtBuscar_KeyPress(KeyAscii As Integer)
   
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

   If KeyAscii = vbKeyReturn Then
      PROC_BUSCA_ELEMENTO TxtBuscar.Text
   End If

End Sub

