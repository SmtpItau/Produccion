VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacAyuda 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Ayuda"
   ClientHeight    =   4860
   ClientLeft      =   3135
   ClientTop       =   915
   ClientWidth     =   7170
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4860
   ScaleWidth      =   7170
   ShowInTaskbar   =   0   'False
   Begin VB.ListBox LstTmp 
      Height          =   1815
      Left            =   5145
      TabIndex        =   3
      Top             =   3000
      Visible         =   0   'False
      Width           =   1350
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   7170
      _ExtentX        =   12647
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
            Key             =   "cmbaceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   1185
      Top             =   -15
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
            Picture         =   "Bacayuda.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacayuda.frx":0452
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.TextBox txtNombre 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   7155
   End
   Begin VB.ListBox lstNombre 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3840
      ItemData        =   "Bacayuda.frx":08A4
      Left            =   0
      List            =   "Bacayuda.frx":08AB
      TabIndex        =   1
      Top             =   960
      Width           =   7155
   End
End
Attribute VB_Name = "BacAyuda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

''Const WM_USER = &H400
''Const LB_SELECTSTRING = (WM_USER + 13)

Dim sPatron             As String

Private objAyuda        As Object

Public parAyuda         As String    ' Ayuda de perfiles
Public parFiltro        As String    ' Ayuda de Perfiles
Public Codigo           As Long
Public Mascara          As String
Public Glosa            As String
Dim Sql                 As String
Dim datos()
Dim inicial             As Long
Dim lastPos()           As Integer
Dim u As String

Function Instru_LlenaGrilla()

End Function

Function Llena_Bonos_Exterior()

    Dim Sql As String
    Dim datos()
    
    lstNombre.Clear
        
    If Bac_Sql_Execute("SVC_GEN_LEE_SER") Then
    
        Do While Bac_SQL_Fetch(datos)
            lstNombre.AddItem datos(2) & Space(15 - Len(datos(2))) & "(" & Format(datos(3), "dd/mm/yyyy") & ")"
        Loop
        
    End If

End Function


Private Sub llena_Emisores()
    Dim datos()
    Dim Sql
    If Bac_Sql_Execute("SVC_AYD_LST_EMI") Then
        Do While Bac_SQL_Fetch(datos())
            lstNombre.AddItem datos(4) & Space(40 - Len(datos(4))) & "   " & datos(1) & " " & Space(9 - Len(datos(1))) & " -" & datos(3) & " " & datos(2)
            lstNombre.ItemData(lstNombre.NewIndex) = Val(datos(1))
        Loop
    End If
End Sub

Function llena_instrumentos()
    Dim Sql As String
    Dim datos()
    
    lstNombre.Clear
        
    If Bac_Sql_Execute("SVC_GEN_LEE_SER") Then
        Do While Bac_SQL_Fetch(datos)
            lstNombre.AddItem datos(2) & Space(49 - Len(datos(2))) & "(" & Format(datos(3), "dd/mm/yyyy") & ")"
            lstNombre.ItemData(lstNombre.NewIndex) = Val(datos(1))
        Loop
        
    End If
End Function

Private Sub llena_Riesgo()
    Dim datos()
    If Bac_Sql_Execute("SVC_AYD_COD_RSG") Then
        Do While Bac_SQL_Fetch(datos)
            lstNombre.AddItem datos(1)
        Loop
    End If
End Sub

Private Sub MDCIUCOM_LlenarGrillA(cod_pais As String, cod_Ciudad As String)

'   Sql = "EXECUTE sp_leercom " & Val(cod_Pais) & "," & Val(cod_Ciudad)
    envia = Array(CDbl(cod_pais), _
            CDbl(cod_Ciudad))

    If Not Bac_Sql_Execute("sp_leercom", envia) Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(datos())
        lstNombre.AddItem datos(2) + Space(30 - Len(datos(2))) + Trim(Str(CDbl(datos(1))))
        lstNombre.ItemData(lstNombre.NewIndex) = Val(datos(2))
    Loop

End Sub


Private Sub SERIE_LlenaGrilla()

Dim Max, FILAS, gscodigo
Dim gsmascara As String
lstNombre.Clear

   Max = objAyuda.Coleccion.Count

   For FILAS = 2 To Max
      gsmascara = objAyuda.Coleccion(FILAS).semascara
      gscodigo = objAyuda.Coleccion(FILAS).secodigo
      lstNombre.AddItem gsmascara & Space(3) & gscodigo
      'lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.Coleccion(FILAS).IDGLOSA

      
      
   Next FILAS

End Sub


Private Sub MDCIUCIU_LlenarGrilla(cod_pais As String)

'   Sql = "EXECUTE leerciu " & Val(cod_Pais)

    envia = Array(CDbl(cod_pais))
    
    If Not Bac_Sql_Execute("leerciu", envia) Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(datos())
        lstNombre.AddItem Trim(datos(1)) & Space(20 + (20 - Len(datos(1)))) & Val(datos(2))
        lstNombre.ItemData(lstNombre.NewIndex) = Val(datos(2))
    Loop

End Sub

Private Sub MECC_LlenarGrilla()

'   Sql = "EXECUTE sp_leecor "

    If Not Bac_Sql_Execute("sp_leecor") Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(datos())
        lstNombre.AddItem Trim(datos(1)) & Space(15 + (15 - Len(datos(1)))) & Trim(datos(3))
        lstNombre.ItemData(lstNombre.NewIndex) = Val(datos(2))
    Loop

End Sub


Private Function HelpLeerApoderados(IdNombre As String)
Dim FILAS            As Long
Dim idRut            As String * 10
Dim IDGLOSA          As String * 20 '40
Dim IDCodigo         As String * 5
Dim Max              As Long
Dim IdRow            As Integer

'   Sql = "EXECUTE sp_apleernombres1 '" & IdNombre & "'"

    envia = Array(IdNombre)

    If Not Bac_Sql_Execute("sp_apleernombres1", envia) Then
        Exit Function
    End If

    lstNombre.Clear

    Do While Bac_SQL_Fetch(datos())
        idRut = CDbl(datos(1)) & "-" & datos(2)
        IDGLOSA = datos(4)
        IDCodigo = CDbl(datos(2))
        lstNombre.AddItem IDGLOSA & Space(3) & idRut & Space(50) & IDCodigo
        lstNombre.ItemData(lstNombre.NewIndex) = datos(1)
    Loop

End Function

Private Sub MEVM_LlenaGrilla()

   Dim FILAS            As Long
   Dim IDCodigo         As Long
   Dim idRut            As String * 11
   Dim IDGLOSA          As String * 30
   Dim idorden          As String * 10
   Dim idtipo1          As Long
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.Coleccion.Count

   For FILAS = 1 To Max
      IDGLOSA = objAyuda.Coleccion(FILAS).codescri
      IDCodigo = objAyuda.Coleccion(FILAS).codmov
      lstNombre.AddItem IDGLOSA & Space(3) & IDCodigo
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.Coleccion(FILAS).CodMovch

   Next FILAS

End Sub

Private Sub MDCD_LlenaGrilla()

   Dim FILAS            As Long
   Dim idRut            As String * 11
   Dim IDGLOSA          As String * 25 '40
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.Coleccion.Count

   For FILAS = 1 To Max
      idRut = objAyuda.Coleccion(FILAS).rcrut & "-" & objAyuda.Coleccion(FILAS).rcdv
      IDGLOSA = objAyuda.Coleccion(FILAS).rcnombre
      lstNombre.AddItem IDGLOSA & Space(3) & idRut
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.Coleccion(FILAS).rcrut

   Next FILAS

End Sub

Private Sub LlenarLetrasClientes()

   Dim FILAS            As Long
   Dim idRut            As String * 8
   Dim IDGLOSA          As String * 40
   Dim IDCodigo         As String * 5
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.Coleccion.Count

   For FILAS = 1 To Max
      idRut = objAyuda.Coleccion(FILAS).RutCliente & "-" & objAyuda.Coleccion(FILAS).Digito
      IDGLOSA = objAyuda.Coleccion(FILAS).NOMBRE
      IDCodigo = objAyuda.Coleccion(FILAS).CodCliente
      lstNombre.AddItem IDGLOSA & Space(3) & idRut & Space(3) & IDCodigo
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.Coleccion(FILAS).RutCliente

   Next FILAS
If FILAS > 1 Then
   lstNombre.SetFocus
   lstNombre.ListIndex = 0
End If

End Sub


Private Sub MDCL_LlenaGrilla()

   Dim FILAS            As Long
   Dim idRut            As String * 8
   Dim IDGLOSA          As String * 40
   Dim IDCodigo         As String * 5
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.Coleccion.Count

   For FILAS = 1 To Max
      idRut = objAyuda.Coleccion(FILAS).clrut & "-" & objAyuda.Coleccion(FILAS).cldv
      IDGLOSA = objAyuda.Coleccion(FILAS).clnombre
      IDCodigo = objAyuda.Coleccion(FILAS).clcodigo
      lstNombre.AddItem IDGLOSA & Space(3) & idRut & Space(3) & IDCodigo
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.Coleccion(FILAS).clrut

   Next FILAS
If FILAS > 1 Then
   lstNombre.SetFocus
   lstNombre.ListIndex = 0
End If

End Sub

Private Sub MDEM_LlenaGrilla()

   Dim FILAS            As Long
   Dim idRut            As String * 11
   Dim IDGLOSA          As String * 25 '40
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.Coleccion.Count

   For FILAS = 1 To Max
      idRut = objAyuda.Coleccion(FILAS).emrut & "-" & objAyuda.Coleccion(FILAS).emdv
      IDGLOSA = objAyuda.Coleccion(FILAS).emnombre
      lstNombre.AddItem IDGLOSA & Space(3) & idRut
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.Coleccion(FILAS).emrut

   Next FILAS

End Sub

Private Sub Form_Activate()

On Error Resume Next
   lstNombre.Clear

'  BacControlWindows 12

   Screen.MousePointer = 11

   Select Case Trim$(Me.Tag)
   Case "MDCL"
      Set objAyuda = New clsClientes
      Call objAyuda.LeerClientes("", "N")
      Call MDCL_LlenaGrilla
   Case "INSTRU"
     Call llena_instrumentos
    Call Instru_LlenaGrilla
   Case "CORR"
      LLena_Corresponsales
      
   Case "BONEX"
      Llena_Bonos_Exterior
      
   Case "EMISOR"
      llena_Emisores
      
   Case "RIESGO"
      llena_Riesgo
'   Case "LETRA_HIPOTECARIA_CLIENTE"
'      Set objAyuda = New BacLetrasHip
'      Call objAyuda.LeerClientes("")
'      Call objAyuda.Coleccion2Control(lstNombre)
'      Call LlenarLetrasClientes
'
'   Case "MDCL_BCO"
'      Set objAyuda = New clsClientes
'      Call objAyuda.LeerClientes("", "S")
'      Call objAyuda.Coleccion2Control(lstNombre)
'      Call MDCL_LlenaGrilla
'
'   Case "CUENTAS", "PERFIL", "CAMPOS", "CONDICIONES"
'      Call Carga_Tablas_Perfiles(parAyuda, parFiltro)
'
'   Case "MDEM"
'      Set objAyuda = New clsEmisores
'      Call objAyuda.LeerEmisores("", "T")
'      Call MDEM_LlenaGrilla
'
'   Case "MDEMO"
'      Set objAyuda = New clsEmisores
'      Call objAyuda.LeerEmisores("", "O")
'      Call MDEM_LlenaGrilla
'
'   Case "MDCL_U"
'       Set objAyuda = New clsCliente
'       If Not objAyuda.Ayuda("") Then
'        Exit Sub
'       End If
'
'   Case "MDCD"
'      Set objAyuda = New clsDCarteras
'      Call objAyuda.LeerDCarteras("")
'      Call MDCD_LlenaGrilla
'
'   Case "MDMN"
'      Set objAyuda = New clsMonedas
'      Call objAyuda.LeerMonedas
'      Call objAyuda.Coleccion2Control(lstNombre)
'
'   Case "MDMN2"
'      Set objAyuda = New clsMonedas2
'      Call objAyuda.LeerMonedas
'      Call objAyuda.Coleccion2Control(lstNombre)
'
'   Case "MDIN"
'      Set objAyuda = New clsFamilias
'      Call objAyuda.LeerFamilias
'      Call objAyuda.Coleccion2Control(lstNombre)
'
'
'
'   Case "MDIN2"
'      Set objAyuda = New clsFamilias
'      Call objAyuda.LeerFamilias
'      Call objAyuda.Coleccion2Control(lstNombre)
'
'   Case "METB01"
'      Set objAyuda = New clsHelpges
'      Call objAyuda.leemoned("")
'      Call objAyuda.Coleccion2Control(lstNombre)
'      Call MEVM_LlenaGrilla
'
'   Case "MDAP"
'      Call HelpLeerApoderados("")
'
'   Case "MDCT" 'Ayuda de categorías
'      Set objAyuda = New clsCategorias
'      Call objAyuda.leeCategoria(0)
'      Call objAyuda.Coleccion2Control(lstNombre)
'      Call MDCT_LlenaGrilla
'   Case "BACUSER" ''''
'        Set objAyuda = New ClsUsuarios
'        Call objAyuda.LeerUsuarios
'         Call objAyuda.ColeccionUControl(lstNombre)
''   Case "MDCIUCOM"
''      MDCIUCOM_LlenarGrillA BacMNTComuna.lblCodigo.Tag, BacMNTComuna.lblCodigo.Caption
''
''   Case "MDCIUCIU"
''      MDCIUCIU_LlenarGrilla BacMntCiu.lblCodigo.Caption
'
'   Case "MECC"
'      MECC_LlenarGrilla
'
'   ' VB+ 29/05/2000 Se agrega función para leer por nombre ingresado
'   Case "MDCLN"
'      Set objAyuda = New clsClientes
'      Call objAyuda.LeerGenericos(parFiltro)
'      Call objAyuda.Coleccion2Control(lstNombre)
'      Call MDCL_LlenaGrilla
'
'
'   ' VB-

      

'   Case "CUENTAS VOUCHER"
'      LISTAR_CUENTAS
'
'   Case "NUMOPE"
'
'      Listar_N_Operaciones
'
'   Case "INSTRU"
'
'      Listar_Instrumentos
'
'   Case "INSTRU2"
'
'      Listar_Instrumentos
'
'   Case "INSTRU3"
'
'      Listar_Instrumentos
'
'
'   Case "SERIE"
'
'      Busca_Serie
'
'   Case "SUCURSAL"
'
'      Busca_Sucursal
'
'    Case "OPMANUAL"
'
'        Call busca_OpManual
        
   End Select

   Screen.MousePointer = 0
   
   txtNombre.SetFocus

End Sub

Private Sub Form_Load()

   gscodigo$ = ""

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set objAyuda = Nothing

End Sub

Sub PROC_CARGA_AYUDA_CUENTAS(name_lst As Object)

   Dim Base_Fox         As DataBase
   Dim Tabla_Fox        As Recordset

  ''On Error GoTo Error_Carga:

   Screen.MousePointer = 11

   Set Base_Fox = OpenDatabase(gsPath_Fox, False, False, "FoxPro 2.6")
   Set Tabla_Fox = Base_Fox.OpenRecordset("conmaect")

   If Tabla_Fox.RecordCount > 0 Then
      Tabla_Fox.MoveFirst

      Do While Not Tabla_Fox.EOF
         lstNombre.AddItem Tabla_Fox!Entidad & Tabla_Fox!Moneda & Tabla_Fox!cuenta & Space(2) & Tabla_Fox!Glosal
         Tabla_Fox.MoveNext

      Loop

   End If

   Screen.MousePointer = 0

   Exit Sub

Error_Carga:
   Screen.MousePointer = 0

   MsgBox Error(Err), vbCritical, gsBac_Version

   Exit Sub

End Sub

Sub Carga_Tablas_Perfiles(pareSTipo_ayuda As String, pareSTipo_filtro As String)
Dim paso             As String
Dim i                As Integer
Dim Largo_Codigo     As Integer
Dim Numero_Campos    As Integer

    Screen.MousePointer = 11

'    Sql = "EXECUTE sp_consulta_tablas '" & pareSTipo_ayuda
'    Sql = Sql & "', '" & pareSTipo_filtro & "'"
    
    envia = Array(pareSTipo_ayuda, _
            pareSTipo_filtro)

    Select Case UCase(pareSTipo_ayuda)
        Case "CON_PLAN_CUENTAS"
            Numero_Campos = 2
            Largo_Codigo = 12

        Case "CON_CAMPOS_PERFIL"
            Numero_Campos = 2
            Largo_Codigo = 3

        Case "PERFIL"
            Numero_Campos = 2
            Largo_Codigo = 9

        Case "BAC_CNT_PERFIL"
            Numero_Campos = 2
            Largo_Codigo = 9

        Case "CONDICIONES"
            Numero_Campos = 2
            Largo_Codigo = 3

        Case "GEN_TABLAS"
            Numero_Campos = 2
            Largo_Codigo = 4

        Case "GEN_TABLAS1"
            Numero_Campos = 2
            Largo_Codigo = 6

    End Select

    If Bac_Sql_Execute("sp_consulta_tablas", envia) Then
        Do While Bac_SQL_Fetch(datos())
      
            paso = datos(1) & Space(Abs(Largo_Codigo - Len(datos(1)))) & " "

            For i = 2 To Numero_Campos
                If pareSTipo_ayuda = "BAC_CNT_PERFIL" And i% = 3 Then
                    paso = paso + " " & Space(60) & Val(datos(i%))
                Else
                    paso = paso + " " + datos(i%)
                End If
            Next i%

            lstNombre.AddItem paso

        Loop

    End If

    Screen.MousePointer = 0

End Sub

Private Sub lstNombre_DblClick()

   txtNombre.Text = lstNombre.List(lstNombre.ListIndex)
   txtNombre.Tag = txtNombre.Text
   inicial = lstNombre.ListIndex
   Call TLBARACEPTAR

End Sub

Private Sub lstNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
      txtNombre.Text = lstNombre.List(lstNombre.ListIndex)
      txtNombre.Tag = txtNombre.Text
      Call TLBARACEPTAR

   End If

   If KeyAscii = 27 Then
    Unload Me
    giAceptar% = False
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "ACEPTAR"
        Call TLBARACEPTAR
    Case "CANCELAR"
        Call TLBARCANCELAR
End Select
'Toolbar1.Buttons(2).Enabled = True
End Sub
Private Sub TLBARCANCELAR()
    gscodigo$ = ""
    giAceptar% = False
    Unload Me
End Sub

Private Sub TLBARACEPTAR()
   
   Dim nPos&
   Dim sText            As String
   Dim Indice           As Integer
   Dim X As String
   'u = "1"
   txtNombre.Text = lstNombre.List(lstNombre.ListIndex)  'antes sin las 2 lineas y sin el +1
   txtNombre.Tag = txtNombre.Text

   '-Si No tiene Elementos Listcount = 0 -'
   If Not lstNombre.ListCount > 0 Then
      Exit Sub
   End If

   If lstNombre.ListIndex < 0 Then
      Exit Sub

   End If

   '-Si tiene algun elemento-'
   If Me.Tag = "MDCL" Or Me.Tag = "MDCL_BCO" Then
      Indice = lstNombre.ListIndex + 1 'BuscaListIndex(lstNombre, Trim$(TxtNombre.Text)) + 2
      inicial = Indice
   Else
      
      Indice = BuscaListIndex(lstNombre, Trim$(txtNombre.Text)) + 1
      inicial = Indice
                  
      
   End If
  
   nPos = inicial

   Screen.MousePointer = 11

   If (nPos >= 0) Then
      'Toma el indice de la lista que es el mismo que la coleccion

        Select Case Me.Tag
        Case "MDCL", "MDCL_BCO"   'TABLA DE CLIENTES
            gsrut$ = objAyuda.Coleccion(Indice).clrut
            gsDigito$ = objAyuda.Coleccion(Indice).cldv
            gsDescripcion$ = objAyuda.Coleccion(Indice).clnombre
            gsvalor$ = objAyuda.Coleccion(Indice).clcodigo
            gsfax$ = objAyuda.Coleccion(Indice).clfax
            gsnombre$ = objAyuda.Coleccion(Indice).cldirecc
            gsgeneric = objAyuda.Coleccion(Indice).clgeneric
            gsdirecc = objAyuda.Coleccion(Indice).cldirecc
            gsciudad = objAyuda.Coleccion(Indice).clciudad
            gsPais = objAyuda.Coleccion(Indice).clpais
            gscomuna = objAyuda.Coleccion(Indice).clcomuna
            gsregion = objAyuda.Coleccion(Indice).clregion
            gstipocliente = objAyuda.Coleccion(Indice).cltipocliente
            gsEntidad = objAyuda.Coleccion(Indice).clentidad
            gscalidadjuridica = objAyuda.Coleccion(Indice).clcalidadjuridica
            gsGrupo = objAyuda.Coleccion(Indice).clgrupo
            gsMercado = objAyuda.Coleccion(Indice).clmercado
            gsapoderado = objAyuda.Coleccion(Indice).clapoderado
            gsctacte = objAyuda.Coleccion(Indice).clctacte
            gsfono = objAyuda.Coleccion(Indice).clfono
            gs1Nombre = objAyuda.Coleccion(Indice).cl1nombre
            gs2Nombre = objAyuda.Coleccion(Indice).cl2nombre
            gs1Apellido = objAyuda.Coleccion(Indice).cl1apellido
            gs2Apellido = objAyuda.Coleccion(Indice).cl2apellido
            gsCtausd = objAyuda.Coleccion(Indice).clctausd
            gsImplic = objAyuda.Coleccion(Indice).climplic
            gsAba = objAyuda.Coleccion(Indice).claba
            gsChips = objAyuda.Coleccion(Indice).clchips
            gsSwift = objAyuda.Coleccion(Indice).clswift
            gsglosa = objAyuda.Coleccion(Indice).clglosab
            gscodigo = objAyuda.Coleccion(Indice).clcodigo
         
        Case "CORR"
            gsDescripcion$ = Trim(lstNombre.Text)
            
        Case "BONEX"
            gsBac_VarString = Trim(Mid$(lstNombre.Text, 1, 20))
            gsBac_VarString2 = Trim(Mid$(lstNombre.Text, 22, 10))
        Case "INSTRU"
            gsBac_VarString = Trim(Mid$(lstNombre.Text, 1, 20))
            gsBac_VarString2 = Trim(Mid$(lstNombre.Text, 51, 10))
       
'      Case "LETRA_HIPOTECARIA_CLIENTE"   'TABLA DE LETRAS DE CLIENTES
'         ltRutCliente = objAyuda.Coleccion(Indice).RutCliente
'         ltDigito = objAyuda.Coleccion(Indice).Digito
'         ltNombre = objAyuda.Coleccion(Indice).NOMBRE
'         ltDireccion = objAyuda.Coleccion(Indice).direccion
'         ltComuna = objAyuda.Coleccion(Indice).COMUNA
'         ltCiudad = objAyuda.Coleccion(Indice).CIUDAD
'         ltPais = objAyuda.Coleccion(Indice).PAIS
'         ltCodCliente = objAyuda.Coleccion(Indice).CodCliente
'         ltTelefono = objAyuda.Coleccion(Indice).telefono
'         ltFax = objAyuda.Coleccion(Indice).fax
'         ltEMail = objAyuda.Coleccion(Indice).email
'         ltCodRegion = objAyuda.Coleccion(Indice).CodRegion
'
'      Case "MDEM"      'TABLA DE EMISORES Total
'         gscodigo$ = objAyuda.Coleccion(Indice).emrut
'         gsDigito$ = objAyuda.Coleccion(Indice).emdv
'         gsDescripcion$ = objAyuda.Coleccion(Indice).emnombre
'         gsGenerico$ = objAyuda.Coleccion(Indice).emgeneric
'
'      Case "MDEMO"      'TABLA DE EMISORES Solo Bancos
'         gscodigo$ = objAyuda.Coleccion(Indice).emrut
'         gsDigito$ = objAyuda.Coleccion(Indice).emdv
'         gsDescripcion$ = objAyuda.Coleccion(Indice).emnombre
'         gsGenerico$ = objAyuda.Coleccion(Indice).emgeneric
'
'      Case "MDCL_U":
'      Dim SLINE, gsCodCli As String '---- PENDIENTE
'        SLINE = Trim(Right(lstNombre.List(lstNombre.ListIndex), 11))
'        gscodigo = Left(SLINE, Len(SLINE) - 2)
'        gsDigito = Right(SLINE, 1)
'        gsnombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 45))
'        gsCodCli = CDbl(lstNombre.ItemData(lstNombre.ListIndex))
'
'      Case "MDCD"      'TABLA DE DUEÑOS DE CARTERA
'         gsrut$ = objAyuda.Coleccion(Indice).rcrut
'         gsDigito$ = objAyuda.Coleccion(Indice).rcdv
'
'      Case "MDMN"      'TABLA DE MONEDAS
'         gscodigo$ = objAyuda.Coleccion(Indice).mncodmon
'         gsDescripcion$ = objAyuda.Coleccion(Indice).mndescrip
'         gsSerie = Trim(Mid(lstNombre, 4, 6))
'
'      Case "MDMN2"      'TABLA DE MONEDAS
'         gscodigo$ = objAyuda.Coleccion(Indice).mncodmon
'         gsDescripcion$ = objAyuda.Coleccion(Indice).mndescrip
'         gsSerie = Trim(Mid(lstNombre, 4, 6))
'
'
'      Case "MDIN"      'TABLA DE FAMILIAS DE INSTRUMENTOS
'         gsSerie$ = objAyuda.Coleccion(Indice).inserie
'         gscodigo$ = objAyuda.Coleccion(Indice).incodigo
'         gsDescripcion$ = objAyuda.Coleccion(Indice).inglosa
'
'
'
'      Case "MDPC"      'TABLA DE PLAN DE CUENTAS
'         gscodigo$ = objAyuda.Coleccion(Indice).pccuenta
'
'      Case "BACUSER"      'TABLA DE PLAN DE CUENTAS
'         gsDescripcion$ = objAyuda.Coleccion(Indice).usuario
'
'      Case "METB01"      'TABLA DE CODIGOS FORMAS DE PAGO
'         gscodigo$ = objAyuda.Coleccion(Indice).codmov
'         gsglosa$ = objAyuda.Coleccion(Indice).codescri
'         gsvalor$ = objAyuda.Coleccion(Indice).CodMovch
'         gsDigito$ = objAyuda.Coleccion(Indice).CodOrden
'         gsredondeo$ = objAyuda.Coleccion(Indice).CodNum
'         gsnombre$ = objAyuda.Coleccion(Indice).CodTipos
'         gsDescripcion$ = objAyuda.Coleccion(Indice).COD2756
'         gsfax$ = objAyuda.Coleccion(Indice).CodAfecta
'         gsSerie$ = objAyuda.Coleccion(Indice).CodNumC
'         gsnemo$ = objAyuda.Coleccion(Indice).CodCta
'
'      Case "MDAP"      'TABLA DE REPRESENTANTES
'         sText = lstNombre.Text
'         gsrut = CDbl(Mid$(sText, 21, (InStr(21, sText, "-")) - 21))
'         gsDescripcion$ = Mid$(sText, 1, 20)
'         gscodigo$ = CDbl(Right(sText, 10))
'
'      Case "CUENTAS", "MOVIM"
'         gscodigo$ = Left(lstNombre.Text, 12)
'         gsDescripcion$ = Mid$(lstNombre.Text, 14)
'
'      Case "PERFIL"
'         gscodigo$ = Mid(lstNombre.Text, 1, 10)
'         gsDescripcion$ = Mid$(lstNombre.Text, 12)
'
'      Case "CAMPOS"
'         gscodigo$ = Left(lstNombre.Text, 5)
'         gsDescripcion$ = Mid$(lstNombre.Text, 6)
'
'      Case "CONDICIONES"
'         gscodigo$ = Left(lstNombre.Text, 3)
'         gsDescripcion$ = Mid$(lstNombre.Text, 4)
'
'      Case "MDCT"      'TABLAS GENERALES
'         gscodigo$ = objAyuda.Coleccion(Indice).Codigo
'         gsglosa$ = objAyuda.Coleccion(Indice).Descri
'
'      Case "MDCIUCOM"
'         Codigo = Trim(Right(lstNombre.Text, 6))
'         Glosa = Trim(Left(lstNombre.Text, 30))
'
'
'      Case "MDCIUCIU"
'         Codigo = Trim(Right(lstNombre.Text, 6))
'         Glosa = Trim(Left(lstNombre.Text, 30))
'
'      Case "MECC"
'         gsglosa$ = Trim(Right(lstNombre.Text, 15))
'
'      ' VB+- 29/05/2000 Nueva busqueda
'      Case "MDCLN"
'         gsrut$ = objAyuda.Coleccion(Indice).clrut
'         gsDigito$ = objAyuda.Coleccion(Indice).cldv
'         gsDescripcion$ = objAyuda.Coleccion(Indice).clnombre
'         gsvalor$ = objAyuda.Coleccion(Indice).clcodigo
'
'      ' VB+- 29/05/2000
'      Case "MDSE"
'         Glosa = Trim(Right(lstNombre.Text, 15))
'         Mascara = Trim(Left(lstNombre.Text, 30))
'
'      Case "NUMOPE"
'
'         BacMntco.Tag = Trim(Left(lstNombre.Text, 5))
'
'
'      Case "INSTRU2"
'
'         gsrut$ = Trim(Mid(lstNombre.Text, 10, 10))
'         gscodigo = Trim(Left(lstNombre.Text, 3))
'
'      Case "INSTRU3"
'           RepMin94.Text1.Tag = Mid(lstNombre.Text, 11, 8)
'
'
'
'      Case "SERIE"
'
'         gsSerie = Left(lstNombre.Text, 15)
'         gscodigo = Trim(Right(lstNombre.Text, 10))
'
'      Case "OPMANUAL"
'
'        gsDescripcion$ = Left(lstNombre.Text, 15)
'
       Case Is = "EMISOR"
         gsrut$ = lstNombre.Text
        lstNombre.Clear
       Case Is = "RIESGO"
         gsrut$ = Trim(lstNombre.Text)
         
      End Select

   Else
      txtNombre.SetFocus
      Exit Sub

   End If

   Screen.MousePointer = 0
   
   giAceptar% = True

   Unload Me
   
End Sub
Private Sub txtNombre_Change()

   Dim nPos             As Long
   Dim sText            As String
   Dim n                As Long
   Dim nLargo           As Long
   
   sText = Trim$(txtNombre.Text)
    
    ReDim Preserve lastPos(0 To Len(txtNombre.Text))
    
    lastPos(0) = 0
    
   nLargo = Len(sText)

   nPos = -1

   
   If Me.Tag = "NEMOTEC" Then
      
      Exit Sub
      
   End If

   'calido que el control tenga datos
   If sText <> "" Then
                  
        'ciclo de ultima pos al total de items en el list
        For n = lastPos(Len(txtNombre.Text)) To lstNombre.ListCount   '- 1
            
            If Mid$(lstNombre.List(n), 1, nLargo) = sText Then
                
                nPos = n
                lastPos(Len(txtNombre.Text)) = nPos
                
                Exit For

            End If

        Next n
        
   End If

   'If (nPos& < 0) Then
      'sText = Trim$(txtNombre.Text)
'
     
 '
 '     Case "MDEM"
 '        Set objAyuda = New clsEmisores
 '        Call objAyuda.LeerEmisores(sText, "T")
 ''        Call objAyuda.Coleccion2Control(lstNombre)
 '        Call MDEM_LlenaGrilla''

      'Case "MDEMO"
       '  Set objAyuda = New clsEmisores
       '  Call objAyuda.LeerEmisores(sText, "O")
       '  Call objAyuda.Coleccion2Control(lstNombre)
       '  Call MDEM_LlenaGrilla'

      'Case "MDCD"
       '  Set objAyuda = New clsDCarteras
         'Call objAyuda.LeerDCarteras("")
         'Call objAyuda.Coleccion2Control(lstNombre)
         'Call MDCD_LlenaGrilla

'      Case "MDMN"
'         Set objAyuda = New clsMonedas
'         Call objAyuda.LeerMonedas
'         Call objAyuda.Coleccion2Control(lstNombre)'

      'Case "MDMN2"
       '  Set objAyuda = New clsMonedas2
        ' Call objAyuda.LeerMonedas
         'Call objAyuda.Coleccion2Control(lstNombre)'

'      Case "MDIN"
 '        Set objAyuda = New clsFamilias
  '       Call objAyuda.LeerFamilias
   '      Call objAyuda.Coleccion2Control(lstNombre)
    '
     

      'lstNombre.ListIndex = 0

   'Else
    '  lstNombre.ListIndex = nPos

   'End If
    lstNombre.ListIndex = nPos
    If lstNombre.Text <> "" Then
    If nPos = -1 Then
        
        If UBound(lastPos) > 0 Then
            
            lastPos(Len(txtNombre.Text)) = lastPos(Len(txtNombre.Text) - 1)
            
            lstNombre.ListIndex = lastPos(Len(txtNombre.Text))
        Else
            
            lstNombre.ListIndex = 0
        End If
        
        Beep
    End If
    End If
    If nPos > -1 Then lstNombre.ListIndex = nPos
   
    txtNombre.Visible = True
    txtNombre.Tag = txtNombre.Text
    txtNombre.SetFocus

End Sub

Private Sub txtNombre_GotFocus()

   txtNombre.Tag = txtNombre.Text

End Sub

Private Sub TxtNombre_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And Len(Trim(txtNombre.Text)) = 0 Then Beep: Exit Sub
   If KeyAscii% = vbKeyReturn Then
      Call TLBARACEPTAR
      Unload Me
   Else
      KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
      Select Case Trim$(Me.Tag)
      Case "MDCL"
         Set objAyuda = New clsClientes
         Call objAyuda.LeerClientes(txtNombre.Text, "N")
         Call MDCL_LlenaGrilla
       End Select
      txtNombre.SetFocus
   End If

If KeyAscii = 27 Then
    Unload Me
    giAceptar% = False
End If

End Sub

Private Sub LLena_Corresponsales()

    envia = Array()
    AddParam envia, Val(gsrut$)
    AddParam envia, Val(gsvalor$)
    AddParam envia, Val(gsmoneda)
    AddParam envia, ""
    
    If Bac_Sql_Execute("SVC_AYD_DAT_COR", envia) Then
        Do While Bac_SQL_Fetch(datos())
            lstNombre.AddItem Trim(datos(1))
        Loop
    End If

End Sub

'Tiene que verificar en todo el list para encontrar
'el indice que pertenece a la Opcion seleccionada ''blas
'======================================================
Public Function BuscaListIndex(COMBO As Object, BUSCA As String) As Integer

   Dim Lin              As Integer

   BuscaListIndex = 0              ' Nada en el ComboList

   With COMBO
      If .ListCount <> 0 Then       ' = 0 Nada
         For Lin = 0 To .ListCount - 1
            .ListIndex = Lin
            If Trim$(Left(UCase(Trim$(.List(.ListIndex))), 25)) = Trim$(Left(UCase(BUSCA), 25)) Then
               BuscaListIndex = Lin
               Exit Function

            End If

         Next Lin

      End If

   End With

End Function

Sub LISTAR_CUENTAS()
Dim datos()

'   Sql = "SP_ANALISIS_VOUCHER_LLENA_DATOS 'CUENTA',''"
    envia = Array("CUENTA", "")
   
    Pociona_ListOculta
    lstNombre.Visible = False
    
    If Bac_Sql_Execute("SP_ANALISIS_VOUCHER_LLENA_DATOS", envia) Then
        Do While Bac_SQL_Fetch(datos())
            lstNombre.AddItem (datos(1) & Space(15 - Len(datos(1))) & datos(2))
        Loop
    End If
   
   lstNombre.Visible = True
   LstTmp.Visible = False
   
End Sub


Sub Listar_N_Operaciones()

    If Bac_Sql_Execute("Sp_Mantencion_de_Cortes_TraeNumOpe") Then
        
        Do While Bac_SQL_Fetch(datos())
            
            lstNombre.AddItem (datos(1) & Space(15 - Len(datos(1))) & datos(2) & Space(15 - Len(datos(2))) & datos(3))
        
        Loop
    
    End If

End Sub

Sub Listar_Instrumentos()

    If Bac_Sql_Execute("Sp_BacDCV_TraeInstrumentos") Then
        
        Do While Bac_SQL_Fetch(datos())
            
            lstNombre.AddItem (datos(1) & Space(10 - Len(datos(1))) & datos(2) & Space(10 - Len(datos(2))) & datos(3))
        
        Loop
    
    End If

End Sub


Sub Busca_Serie()

    If Bac_Sql_Execute("Sp_FrmMantenedorSeries_TraeDatos") Then
        
        Call Pociona_ListOculta
        lstNombre.Visible = False
        
        Do While Bac_SQL_Fetch(datos())
            
            lstNombre.AddItem (datos(1) & Space(20 - Len(datos(1))) & datos(2))
        
        Loop
    
        lstNombre.Visible = True
        LstTmp.Visible = False
    
    End If

End Sub

Sub busca_OpManual()
    
    'llamo sp
    If Bac_Sql_Execute("sp_OpeManualLeeExistentes") Then
        
        'posiciono objeto
        Call Pociona_ListOculta
        
        'muestro lista
        lstNombre.Visible = False
        
        'recorro registros
        Do While Bac_SQL_Fetch(datos())
            
            'agrego datos a la lista
            lstNombre.AddItem (datos(1))
        
        Loop
    
        lstNombre.Visible = True
        LstTmp.Visible = False
    
    End If

End Sub

Sub Busca_Sucursal()

    If Bac_Sql_Execute("Sp_FrmMantenedorSucursal_TraeDatos") Then
        
        Call Pociona_ListOculta
        lstNombre.Visible = False
        
        Do While Bac_SQL_Fetch(datos())
            
            lstNombre.AddItem (datos(1) & Space(20 - Len(datos(1))) & datos(2))
        
        Loop
    
        lstNombre.Visible = True
        LstTmp.Visible = False
    
    End If

End Sub

Sub Pociona_ListOculta()

        LstTmp.Top = lstNombre.Top
        LstTmp.Left = lstNombre.Left
        LstTmp.Width = lstNombre.Width
        LstTmp.Height = lstNombre.Height
        LstTmp.Visible = True

End Sub
