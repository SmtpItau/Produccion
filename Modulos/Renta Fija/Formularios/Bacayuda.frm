VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form BacAyuda 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Ayuda"
   ClientHeight    =   4815
   ClientLeft      =   2415
   ClientTop       =   1860
   ClientWidth     =   6495
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4815
   ScaleWidth      =   6495
   ShowInTaskbar   =   0   'False
   Begin VB.ListBox LstTmp 
      Height          =   1815
      Left            =   5145
      TabIndex        =   5
      Top             =   3000
      Visible         =   0   'False
      Width           =   1350
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   6510
      _ExtentX        =   11483
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
      Top             =   540
      Width           =   6500
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
      Width           =   6500
   End
   Begin Threed.SSCommand CmdCancelar 
      Height          =   420
      Left            =   5250
      TabIndex        =   3
      Top             =   5625
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   741
      _StockProps     =   78
      Caption         =   "&Cancelar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand CmdAceptar 
      Height          =   420
      Left            =   4050
      TabIndex        =   2
      Top             =   5625
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   741
      _StockProps     =   78
      Caption         =   "&Aceptar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
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
Dim Datos()
Dim inicial          As Long
Dim u As String

Private Sub MDCIUCOM_LlenarGrillA(cod_pais As String, cod_Ciudad As String)

'   Sql = "EXECUTE sp_leercom " & Val(cod_Pais) & "," & Val(cod_Ciudad)
    Envia = Array(CDbl(cod_pais), _
            CDbl(cod_Ciudad))

    If Not Bac_Sql_Execute("SP_LEERCOM", Envia) Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
        lstNombre.AddItem Datos(2) + Space(30 - Len(Datos(2))) + Trim(Str(Val(Datos(1))))
        lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(2))
    Loop

End Sub


Private Sub SERIE_LlenaGrilla()

Dim Max, Filas, gscodigo
Dim gsmascara As String
lstNombre.Clear

   Max = objAyuda.coleccion.Count

   For Filas = 2 To Max
      gsmascara = objAyuda.coleccion(Filas).semascara
      gscodigo = objAyuda.coleccion(Filas).secodigo
      lstNombre.AddItem gsmascara & Space(3) & gscodigo
      'lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.Coleccion(FILAS).IDGLOSA

      
      
   Next Filas

End Sub


Private Sub MDCIUCIU_LlenarGrilla(cod_pais As String)

'   Sql = "EXECUTE leerciu " & Val(cod_Pais)

    Envia = Array(CDbl(cod_pais))
    
    If Not Bac_Sql_Execute("leerciu", Envia) Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
        lstNombre.AddItem Trim(Datos(1)) & Space(20 + (20 - Len(Datos(1)))) & Val(Datos(2))
        lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(2))
    Loop

End Sub

Private Sub MECC_LlenarGrilla()

'   Sql = "EXECUTE SP_LEECOR "

    If Not Bac_Sql_Execute("SP_LEECOR") Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
        lstNombre.AddItem Trim(Datos(1)) & Space(15 + (15 - Len(Datos(1)))) & Trim(Datos(3))
        lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(2))
    Loop

End Sub


Private Function HelpLeerApoderados(IdNombre As String)
Dim Filas            As Long
Dim idRut            As String * 10
Dim IdGlosa          As String * 20 '40
Dim IDCodigo         As String * 5
Dim Max              As Long
Dim IdRow            As Integer

'   Sql = "EXECUTE SP_APLEERNOMBRES1 '" & IdNombre & "'"

    Envia = Array(IdNombre)

    If Not Bac_Sql_Execute("SP_APLEERNOMBRES1", Envia) Then
        Exit Function
    End If

    lstNombre.Clear

    Do While Bac_SQL_Fetch(Datos())
        idRut = CDbl(Datos(1)) & "-" & Datos(2)
        IdGlosa = Datos(4)
        IDCodigo = CDbl(Datos(2))
        lstNombre.AddItem IdGlosa & Space(3) & idRut & Space(50) & IDCodigo
        lstNombre.ItemData(lstNombre.NewIndex) = Datos(1)
    Loop

End Function

Private Sub MEVM_LlenaGrilla()

   Dim Filas            As Long
   Dim IDCodigo         As Long
   Dim idRut            As String * 11
   Dim IdGlosa          As String * 30
   Dim idorden          As String * 10
   Dim idtipo1          As Long
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.coleccion.Count

   For Filas = 1 To Max
      IdGlosa = objAyuda.coleccion(Filas).codescri
      IDCodigo = objAyuda.coleccion(Filas).codmov
      lstNombre.AddItem IdGlosa & Space(3) & IDCodigo
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).CodMovch

   Next Filas

End Sub

Private Sub MDCD_LlenaGrilla()

   Dim Filas            As Long
   Dim idRut            As String * 11
   Dim IdGlosa          As String * 25 '40
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.coleccion.Count

   For Filas = 1 To Max
      idRut = objAyuda.coleccion(Filas).rcrut & "-" & objAyuda.coleccion(Filas).rcdv
      IdGlosa = objAyuda.coleccion(Filas).rcnombre
      lstNombre.AddItem IdGlosa & Space(3) & idRut
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).rcrut

   Next Filas

End Sub

Private Sub LlenarLetrasClientes()

   Dim Filas            As Long
   Dim idRut            As String * 8
   Dim IdGlosa          As String * 40
   Dim IDCodigo         As String * 5
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.coleccion.Count

   For Filas = 1 To Max
      idRut = objAyuda.coleccion(Filas).RutCliente & "-" & objAyuda.coleccion(Filas).Digito
      IdGlosa = objAyuda.coleccion(Filas).NOMBRE
      IDCodigo = objAyuda.coleccion(Filas).CodCliente
      lstNombre.AddItem IdGlosa & Space(3) & idRut & Space(3) & IDCodigo
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).RutCliente

   Next Filas
If Filas > 1 Then
   lstNombre.SetFocus
   lstNombre.ListIndex = 0
End If

End Sub


Private Sub MDCL_LlenaGrilla()

   Dim Filas            As Long
   Dim idRut            As String * 8
   Dim IdGlosa          As String * 40
   Dim IDCodigo         As String * 5
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.coleccion.Count

   For Filas = 1 To Max
      idRut = objAyuda.coleccion(Filas).clrut & "-" & objAyuda.coleccion(Filas).cldv
      IdGlosa = objAyuda.coleccion(Filas).clnombre
      IDCodigo = objAyuda.coleccion(Filas).clcodigo
      lstNombre.AddItem IdGlosa & Space(3) & idRut & Space(3) & IDCodigo
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).clrut

   Next Filas
If Filas > 1 Then
   lstNombre.SetFocus
   lstNombre.ListIndex = 0
End If

End Sub
Private Sub BACUSER_LlenaGrilla()

   Dim Filas            As Long
   Dim Usuario          As String * 25
   Dim NOMBRE          As String * 30
   Dim Max As Long
   lstNombre.Clear

   Max = objAyuda.coleccion.Count

   For Filas = 1 To Max
      Usuario = objAyuda.coleccion(Filas).Usuario
      NOMBRE = objAyuda.coleccion(Filas).NOMBRE
      lstNombre.AddItem NOMBRE & Space(3) & Usuario
     ' lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.Coleccion(FILAS).Usuario

   Next Filas
   lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).Usuario
If Filas > 1 Then
   lstNombre.SetFocus
   lstNombre.ListIndex = 0
End If

End Sub

Private Sub MDEM_LlenaGrilla()

   Dim Filas            As Long
   Dim idRut            As String * 11
   Dim IdGlosa          As String * 25 '40
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.coleccion.Count

   For Filas = 1 To Max
      idRut = objAyuda.coleccion(Filas).emrut & "-" & objAyuda.coleccion(Filas).emdv
      IdGlosa = objAyuda.coleccion(Filas).emnombre
      lstNombre.AddItem IdGlosa & Space(3) & idRut
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).emrut

   Next Filas

End Sub

Private Sub cmdAceptar_Click()

'
'   Dim nPos&
'   Dim sText            As String
'   Dim Indice           As Integer
'
'
'   txtNombre.Text = lstNombre.List(lstNombre.ListIndex) 'antes sin las 2 lineas y sin el +1
'   txtNombre.Tag = txtNombre.Text
'
'   '-Si No tiene Elementos Listcount = 0 -'
'   If Not lstNombre.ListCount > 0 Then
'      Exit Sub
'
'   End If
'
'   If lstNombre.ListIndex < 0 Then
'      Exit Sub
'
'   End If
'
'   '-Si tiene algun elemento-'
'   Indice = BuscaListIndex(lstNombre, Trim$(txtNombre.Text)) + 1
'
'   nPos = Indice
'
'   Screen.MousePointer = 11
'
'   If (nPos >= 0) Then
'      'Toma el indice de la lista que es el mismo que la coleccion
'
'      Select Case Me.Tag
'      Case "MDCL", "MDCL_BCO"   'TABLA DE CLIENTES
'         gsrut$ = objAyuda.Coleccion(Indice).clrut
'         gsDigito$ = objAyuda.Coleccion(Indice).cldv
'         gsDescripcion$ = objAyuda.Coleccion(Indice).clnombre
'         gsvalor$ = objAyuda.Coleccion(Indice).clcodigo
'         gsfax$ = objAyuda.Coleccion(Indice).clfax
'         gsnombre$ = objAyuda.Coleccion(Indice).cldirecc
'         gsgeneric = objAyuda.Coleccion(Indice).clgeneric
'         gsdirecc = objAyuda.Coleccion(Indice).cldirecc
'         gsciudad = objAyuda.Coleccion(Indice).clciudad
'         gsPais = objAyuda.Coleccion(Indice).clpais
'         gscomuna = objAyuda.Coleccion(Indice).clcomuna
'         gsregion = objAyuda.Coleccion(Indice).clregion
'         gstipocliente = objAyuda.Coleccion(Indice).cltipocliente
'         gsEntidad = objAyuda.Coleccion(Indice).clentidad
'         gscalidadjuridica = objAyuda.Coleccion(Indice).clcalidadjuridica
'         gsGrupo = objAyuda.Coleccion(Indice).clgrupo
'         gsMercado = objAyuda.Coleccion(Indice).clmercado
'         gsapoderado = objAyuda.Coleccion(Indice).clapoderado
'         gsctacte = objAyuda.Coleccion(Indice).clctacte
'         gsfono = objAyuda.Coleccion(Indice).clfono
'         gs1Nombre = objAyuda.Coleccion(Indice).cl1nombre
'         gs2Nombre = objAyuda.Coleccion(Indice).cl2nombre
'         gs1Apellido = objAyuda.Coleccion(Indice).cl1apellido
'         gs2Apellido = objAyuda.Coleccion(Indice).cl2apellido
'         gsCtausd = objAyuda.Coleccion(Indice).clctausd
'         gsImplic = objAyuda.Coleccion(Indice).climplic
'         gsAba = objAyuda.Coleccion(Indice).claba
'         gsChips = objAyuda.Coleccion(Indice).clchips
'         gsSwift = objAyuda.Coleccion(Indice).clswift
'         gsglosa = objAyuda.Coleccion(Indice).clglosab
'         gscodigo = objAyuda.Coleccion(Indice).clcodigo
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
'      Case "MDCD"      'TABLA DE DUEÑOS DE CARTERA
'         gsrut$ = objAyuda.Coleccion(Indice).rcrut
'         gsDigito$ = objAyuda.Coleccion(Indice).rcdv
'
'      Case "MDMN"      'TABLA DE MONEDAS
'         gscodigo$ = objAyuda.Coleccion(Indice).mncodmon
'         gsDescripcion$ = objAyuda.Coleccion(Indice).mndescrip
'
'      Case "MDIN"      'TABLA DE FAMILIAS DE INSTRUMENTOS
'         gsSerie$ = objAyuda.Coleccion(Indice).inserie
'         gscodigo$ = objAyuda.Coleccion(Indice).incodigo
'         gsDescripcion$ = objAyuda.Coleccion(Indice).inglosa
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
'      End Select
'
'   Else
'      txtNombre.SetFocus
'      Exit Sub
'
'   End If
'
'   giAceptar% = True
'
'   Unload Me

End Sub

Private Sub cmdCancelar_Click()

'   gscodigo$ = ""
'   giAceptar% = False
'
'   Unload Me

End Sub

Private Sub Form_Activate()

On Error Resume Next
   lstNombre.Clear


    Select Case Trim$(Me.Tag)
    Case "MDCAP"
        txtNombre.Enabled = False
    Case "MDRIC"
        txtNombre.Enabled = False
    End Select

    

   BacControlWindows 12

   Screen.MousePointer = 11

   Select Case Trim$(Me.Tag)
   Case "MDCL"
      Set objAyuda = New clsClientes
      Call objAyuda.LeerClientes("", "N")
      Call objAyuda.Coleccion2Control(lstNombre)
      Call MDCL_LlenaGrilla
      
   Case "LETRA_HIPOTECARIA_CLIENTE"
      Set objAyuda = New BacLetrasHip
      Call objAyuda.LeerClientes("")
      Call objAyuda.Coleccion2Control(lstNombre)
      Call LlenarLetrasClientes

   Case "MDCL_BCO"
      Set objAyuda = New clsClientes
      Call objAyuda.LeerClientes("", "S")
      Call objAyuda.Coleccion2Control(lstNombre)
      Call MDCL_LlenaGrilla

   Case "CUENTAS", "PERFIL", "CAMPOS", "CONDICIONES"
      Call Carga_Tablas_Perfiles(parAyuda, parFiltro)

   Case "MDEM"
      Set objAyuda = New clsEmisores
      Call objAyuda.LeerEmisores("", "T")
      Call MDEM_LlenaGrilla

   Case "MDEMO"
      Set objAyuda = New clsEmisores
      Call objAyuda.LeerEmisores("", "O")
      Call MDEM_LlenaGrilla
'FM ini 19-05-2008
   Case "MDEMO2"
      Set objAyuda = New clsEmisores
      Call objAyuda.LeerEmisoresFM("", "T")
      Call MDEM_LlenaGrilla
'FM fin 19-05-2008
   
   Case "MDCL_U"
       Set objAyuda = New clsCliente
       If Not objAyuda.Ayuda("") Then
        Exit Sub
       End If
   
   Case "MDCD"
      Set objAyuda = New clsDCarteras
      Call objAyuda.LeerDCarteras("")
      Call MDCD_LlenaGrilla

   Case "MDMN"
      Set objAyuda = New ClsMonedas
      Call objAyuda.LeerMonedas
      Call objAyuda.Coleccion2Control(lstNombre)

   Case "MDMN2"
      Set objAyuda = New clsMonedas2
      Call objAyuda.LeerMonedas
      Call objAyuda.Coleccion2Control(lstNombre)

   Case "MDIN"
      Set objAyuda = New clsFamilias
      Call objAyuda.LeerFamilias
      Call objAyuda.Coleccion2Control(lstNombre)
      
     

   Case "MDIN2"
      Set objAyuda = New clsFamilias
      Call objAyuda.LeerFamilias
      Call objAyuda.Coleccion2Control(lstNombre)

   Case "METB01"
      Set objAyuda = New clsHelpges
      Call objAyuda.leemoned("")
      Call objAyuda.Coleccion2Control(lstNombre)
      Call MEVM_LlenaGrilla

   Case "MDAP"
      Call HelpLeerApoderados("")

   Case "MDCT" 'Ayuda de categorías
      Set objAyuda = New clsCategorias
      Call objAyuda.leeCategoria(0)
      Call objAyuda.Coleccion2Control(lstNombre)
      Call MDCT_LlenaGrilla

'   Case "MDCIUCOM"
'      MDCIUCOM_LlenarGrillA BacMNTComuna.lblCodigo.Tag, BacMNTComuna.lblCodigo.Caption
'
'   Case "MDCIUCIU"
'      MDCIUCIU_LlenarGrilla BacMntCiu.lblCodigo.Caption

   Case "MECC"
      MECC_LlenarGrilla

   ' VB+ 29/05/2000 Se agrega función para leer por nombre ingresado
   Case "MDCLN"
      Set objAyuda = New clsClientes
      Call objAyuda.LeerGenericos(parFiltro)
      Call objAyuda.Coleccion2Control(lstNombre)
      Call MDCL_LlenaGrilla
      
   Case "BACUSER"
      Set objAyuda = New ClsUsuarios
      Call objAyuda.LeerUsuarios
      Call objAyuda.ColeccionUControl(lstNombre)
      Call BACUSER_LlenaGrilla
   ' VB-
   Case "MDSE"
      MDSE_LlenarGrilla

   Case "CUENTAS VOUCHER"
      LISTAR_CUENTAS
      
   Case "NUMOPE"
      
      Listar_N_Operaciones
      
   Case "INSTRU"
   
      Listar_Instrumentos
   
   Case "INSTRU_CAR"
   
      Listar_Instrumentos_Car
   
   Case "INSTRU2"
   
      Listar_Instrumentos
      
   Case "NEMOTEC"
      
      Listar_Series
      
   Case "SERIE"
      
      Busca_Serie
      
   Case "SUCURSAL"
      
      Busca_Sucursal
   
   Case "FILTRO_CL2"
        Call TRAE_CLIENTE2
   
   Case "FILTRO_CL"
        Call Trae_Cliente
   
   Case "DESCREP"
      Dim Datos()
      
      
      Envia = Array()
      AddParam Envia, CDbl(0)
      If Not Bac_Sql_Execute("bacparamsuda..SP_AYUDA_DISCREPANCIAS", Envia) Then
         Exit Sub
      End If
      lstNombre.Clear
      Do While Bac_SQL_Fetch(Datos())
         lstNombre.AddItem Datos(1) & String(10 - Len(Datos(1)), " ") & Datos(2)
         lstNombre.ItemData(lstNombre.NewIndex) = Datos(1)
      Loop

    Case "MDCAP"
        
        Me.Width = 9795
        Me.ScaleWidth = 9705
        lstNombre.Width = 9630
        txtNombre.Width = 9630
        Toolbar1.Width = 9630
        
        Call Busca_Operaciones_DAP
   
   Case "INSTRUMENTO"
          Call Instrumento
   
   End Select

   Screen.MousePointer = 0
   
   txtNombre.SetFocus

End Sub

Sub Busca_Operaciones_DAP()
    With recompras_anticipadas_captaciones
        
        Envia = Array(.Cmb_Moneda.ItemData(.Cmb_Moneda.ListIndex), .Msk_Fecha_Vcto.text)
        If Bac_Sql_Execute("Sp_BuscaOperacionesDAP", Envia) Then
            Call Pociona_ListOculta
            lstNombre.Visible = False
        Do While Bac_SQL_Fetch(Datos())
            lstNombre.AddItem (Datos(1) & Space(10 - Len(Datos(1))) & Space(2) & _
                               Datos(2) & Space(40 - Len(Datos(2))) & Space(2) & _
                               Datos(3) & Space(12 - Len(Datos(3))) & Space(2) & _
                               Datos(4) & Space(8 - Len(Datos(4))) & Space(2) & _
                               Datos(5)) '+++jcamposd se suma control según necesidad cliente
                                
        Loop
            lstNombre.Visible = True
            LstTmp.Visible = False
        End If
    End With
End Sub


Private Sub Form_Load()

   gscodigo$ = ""

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set objAyuda = Nothing

End Sub

Sub PROC_CARGA_AYUDA_CUENTAS(name_lst As Object)

   Dim Base_Fox         As Database
   Dim Tabla_Fox        As Recordset

   On Error GoTo Error_Carga:

   Screen.MousePointer = 11

   Set Base_Fox = OpenDatabase(gsPath_Fox, False, False, "FoxPro 2.6")
   Set Tabla_Fox = Base_Fox.OpenRecordset("conmaect")

   If Tabla_Fox.RecordCount > 0 Then
      Tabla_Fox.MoveFirst

      Do While Not Tabla_Fox.EOF
         lstNombre.AddItem Tabla_Fox!Entidad & Tabla_Fox!Moneda & Tabla_Fox!Cuenta & Space(2) & Tabla_Fox!Glosal
         Tabla_Fox.MoveNext

      Loop

   End If

   Screen.MousePointer = 0

   Exit Sub

Error_Carga:
   Screen.MousePointer = 0

   MsgBox Error(err), vbCritical, gsBac_Version

   Exit Sub

End Sub

Sub Carga_Tablas_Perfiles(pareSTipo_ayuda As String, pareSTipo_filtro As String)
Dim Paso             As String
Dim i                As Integer
Dim Largo_Codigo     As Integer
Dim Numero_Campos    As Integer

    Screen.MousePointer = 11

'    Sql = "EXECUTE SP_CONSULTA_TABLAS '" & pareSTipo_ayuda
'    Sql = Sql & "', '" & pareSTipo_filtro & "'"
    
    Envia = Array(pareSTipo_ayuda, _
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

    If Bac_Sql_Execute("SP_CONSULTA_TABLAS", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
      
            Paso = Datos(1) & Space(Abs(Largo_Codigo - Len(Datos(1)))) & " "

            For i = 2 To Numero_Campos
                If pareSTipo_ayuda = "BAC_CNT_PERFIL" And i% = 3 Then
                    Paso = Paso + " " & Space(60) & Val(Datos(i%))
                Else
                    Paso = Paso + " " + Datos(i%)
                End If
            Next i%

            lstNombre.AddItem Paso

        Loop

    End If

    Screen.MousePointer = 0

End Sub

Private Sub lstNombre_DblClick()

   txtNombre.text = lstNombre.List(lstNombre.ListIndex)
   txtNombre.Tag = txtNombre.text
   inicial = lstNombre.ListIndex
   Call TLBARACEPTAR

End Sub

Private Sub lstNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
      txtNombre.text = lstNombre.List(lstNombre.ListIndex)
      txtNombre.Tag = txtNombre.text
      Call TLBARACEPTAR

   End If

   If KeyAscii = 27 Then Unload Me

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
   Dim indice           As Integer
   Dim X As String
   'u = "1"
   txtNombre.text = lstNombre.List(lstNombre.ListIndex)  'antes sin las 2 lineas y sin el +1
   txtNombre.Tag = txtNombre.text

   '-Si No tiene Elementos Listcount = 0 -'
   If Not lstNombre.ListCount > 0 Then
      Exit Sub
   End If

   If lstNombre.ListIndex < 0 Then
      Exit Sub

   End If

   '-Si tiene algun elemento-'
   If Me.Tag = "MDCL" Or Me.Tag = "MDCL_BCO" Then
      indice = lstNombre.ListIndex + 1 'BuscaListIndex(lstNombre, Trim$(TxtNombre.Text)) + 2
      inicial = indice
   Else
      
      If Me.Tag = "NEMOTEC" Or Me.Tag = "CUENTAS VOUCHER" Then
      
         indice = lstNombre.ListIndex
         
      Else
      
         indice = BuscaListIndex(lstNombre, Trim$(txtNombre.text)) + 1
         inicial = indice
                  
      End If
      
   End If
  
   nPos = inicial

   Screen.MousePointer = 11

   If (nPos >= 0) Then
      'Toma el indice de la lista que es el mismo que la coleccion

      Select Case Me.Tag
      Case "MDCL", "MDCL_BCO"   'TABLA DE CLIENTES
         gsrut$ = objAyuda.coleccion(indice).clrut
         gsDigito$ = objAyuda.coleccion(indice).cldv
         gsDescripcion$ = objAyuda.coleccion(indice).clnombre
         gsvalor$ = objAyuda.coleccion(indice).clcodigo
         gsfax$ = objAyuda.coleccion(indice).clfax
         gsnombre$ = objAyuda.coleccion(indice).cldirecc
         gsgeneric = objAyuda.coleccion(indice).clgeneric
         gsdirecc = objAyuda.coleccion(indice).cldirecc
         gsciudad = objAyuda.coleccion(indice).clciudad
         gsPais = objAyuda.coleccion(indice).clpais
         gscomuna = objAyuda.coleccion(indice).clcomuna
         gsregion = objAyuda.coleccion(indice).clregion
         gstipocliente = objAyuda.coleccion(indice).cltipocliente
         gsEntidad = objAyuda.coleccion(indice).clentidad
         gscalidadjuridica = objAyuda.coleccion(indice).clcalidadjuridica
         gsGrupo = objAyuda.coleccion(indice).clgrupo
         gsMercado = objAyuda.coleccion(indice).clmercado
         gsapoderado = objAyuda.coleccion(indice).clapoderado
         gsctacte = objAyuda.coleccion(indice).clctacte
         gsfono = objAyuda.coleccion(indice).clfono
         gs1Nombre = objAyuda.coleccion(indice).cl1nombre
         gs2Nombre = objAyuda.coleccion(indice).cl2nombre
         gs1Apellido = objAyuda.coleccion(indice).cl1apellido
         gs2Apellido = objAyuda.coleccion(indice).cl2apellido
         gsCtausd = objAyuda.coleccion(indice).clctausd
         gsImplic = objAyuda.coleccion(indice).climplic
         gsAba = objAyuda.coleccion(indice).claba
         gsChips = objAyuda.coleccion(indice).clchips
         gsSwift = objAyuda.coleccion(indice).clswift
         gsglosa = objAyuda.coleccion(indice).clglosab
         gscodigo = objAyuda.coleccion(indice).clcodigo
      
      Case "LETRA_HIPOTECARIA_CLIENTE"   'TABLA DE LETRAS DE CLIENTES
         ltRutCliente = objAyuda.coleccion(indice).RutCliente
         ltDigito = objAyuda.coleccion(indice).Digito
         ltNombre = objAyuda.coleccion(indice).NOMBRE
         ltDireccion = objAyuda.coleccion(indice).direccion
         ltComuna = objAyuda.coleccion(indice).COMUNA
         ltCiudad = objAyuda.coleccion(indice).CIUDAD
         ltPais = objAyuda.coleccion(indice).PAIS
         ltCodCliente = objAyuda.coleccion(indice).CodCliente
         ltTelefono = objAyuda.coleccion(indice).telefono
         ltFax = objAyuda.coleccion(indice).fax
         ltEMail = objAyuda.coleccion(indice).Email
         ltCodRegion = objAyuda.coleccion(indice).CodRegion
         
      Case "MDEM"      'TABLA DE EMISORES Total
         gscodigo$ = objAyuda.coleccion(indice).emrut
         gsDigito$ = objAyuda.coleccion(indice).emdv
         gsDescripcion$ = objAyuda.coleccion(indice).emnombre
         gsGenerico$ = objAyuda.coleccion(indice).emgeneric

      Case "MDEMO"      'TABLA DE EMISORES Solo Bancos
         gscodigo$ = objAyuda.coleccion(indice).emrut
         gsDigito$ = objAyuda.coleccion(indice).emdv
         gsDescripcion$ = objAyuda.coleccion(indice).emnombre
         gsGenerico$ = objAyuda.coleccion(indice).emgeneric
      
      Case "MDEMO2"      'TABLA DE EMISORES Solo Bancos
         gscodigo$ = objAyuda.coleccion(indice).emrut
         gsDigito$ = objAyuda.coleccion(indice).emdv
         gsDescripcion$ = objAyuda.coleccion(indice).emnombre
         gsGenerico$ = objAyuda.coleccion(indice).emgeneric
      
      Case "MDCL_U":
     'Dim sLine, gscodcli       As String '---- PENDIENTE
      Dim sLine                 As String
        sLine = Trim(Right(lstNombre.List(lstNombre.ListIndex), 11))
        gscodigo = Left(sLine, Len(sLine) - 2)
        gsDigito = Right(sLine, 1)
        gsnombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 45))
        gsCodCli = CDbl(lstNombre.ItemData(lstNombre.ListIndex))
        
      Case "MDCD"      'TABLA DE DUEÑOS DE CARTERA
         gsrut$ = objAyuda.coleccion(indice).rcrut
         gsDigito$ = objAyuda.coleccion(indice).rcdv

      Case "MDMN"      'TABLA DE MONEDAS
         gscodigo$ = objAyuda.coleccion(indice).mncodmon
         gsDescripcion$ = objAyuda.coleccion(indice).mndescrip
         gsSerie = Trim(Mid(lstNombre, 4, 6))

      Case "MDMN2"      'TABLA DE MONEDAS
         gscodigo$ = objAyuda.coleccion(indice).mncodmon
         gsDescripcion$ = objAyuda.coleccion(indice).mndescrip
         gsSerie = Trim(Mid(lstNombre, 4, 6))


      Case "MDIN"      'TABLA DE FAMILIAS DE INSTRUMENTOS
         gsSerie$ = objAyuda.coleccion(indice).inserie
         gscodigo$ = objAyuda.coleccion(indice).incodigo
         gsDescripcion$ = objAyuda.coleccion(indice).inglosa
    
      

      Case "MDPC"      'TABLA DE PLAN DE CUENTAS
         gscodigo$ = objAyuda.coleccion(indice).pccuenta

      Case "BACUSER"      'TABLA DE PLAN DE CUENTAS
         gsDescripcion$ = objAyuda.coleccion(indice).Usuario

      Case "METB01"      'TABLA DE CODIGOS FORMAS DE PAGO
         gscodigo$ = objAyuda.coleccion(indice).codmov
         gsglosa$ = objAyuda.coleccion(indice).codescri
         gsvalor$ = objAyuda.coleccion(indice).CodMovch
         gsDigito$ = objAyuda.coleccion(indice).CodOrden
         gsredondeo$ = objAyuda.coleccion(indice).CodNum
         gsnombre$ = objAyuda.coleccion(indice).CodTipos
         gsDescripcion$ = objAyuda.coleccion(indice).COD2756
         gsfax$ = objAyuda.coleccion(indice).CodAfecta
         gsSerie$ = objAyuda.coleccion(indice).CodNumC
         gsnemo$ = objAyuda.coleccion(indice).CodCta

      Case "MDAP"      'TABLA DE REPRESENTANTES
         sText = lstNombre.text
         gsrut = CDbl(Mid$(sText, 21, (InStr(21, sText, "-")) - 21))
         gsDescripcion$ = Mid$(sText, 1, 20)
         gscodigo$ = CDbl(Right(sText, 10))

      Case "CUENTAS", "MOVIM"
         gscodigo$ = Left(lstNombre.text, 12)
         gsDescripcion$ = Mid$(lstNombre.text, 14)

      Case "PERFIL"
         gscodigo$ = Mid(lstNombre.text, 1, 10)
         gsDescripcion$ = Mid$(lstNombre.text, 12)

      Case "CAMPOS"
         gscodigo$ = Left(lstNombre.text, 5)
         gsDescripcion$ = Mid$(lstNombre.text, 6)

      Case "CONDICIONES"
         gscodigo$ = Left(lstNombre.text, 3)
         gsDescripcion$ = Mid$(lstNombre.text, 4)

      Case "MDCT"      'TABLAS GENERALES
         gscodigo$ = objAyuda.coleccion(indice).Codigo
         gsglosa$ = objAyuda.coleccion(indice).Descri

      Case "MDCIUCOM"
         Codigo = Trim(Right(lstNombre.text, 6))
         Glosa = Trim(Left(lstNombre.text, 30))
    
      
      Case "MDCIUCIU"
         Codigo = Trim(Right(lstNombre.text, 6))
         Glosa = Trim(Left(lstNombre.text, 30))

      Case "MECC"
         gsglosa$ = Trim(Right(lstNombre.text, 15))

      ' VB+- 29/05/2000 Nueva busqueda
      Case "MDCLN"
         gsrut$ = objAyuda.coleccion(indice).clrut
         gsDigito$ = objAyuda.coleccion(indice).cldv
         gsDescripcion$ = objAyuda.coleccion(indice).clnombre
         gsvalor$ = objAyuda.coleccion(indice).clcodigo

      ' VB+- 29/05/2000
      Case "MDSE"
         Glosa = Trim(Right(lstNombre.text, 15))
         Mascara = Trim(Left(lstNombre.text, 30))

      Case "CUENTAS VOUCHER"
         Analisis_voucher.Tag = Mid$(lstNombre.text, 10, Len(lstNombre.text))
         giAceptar% = True
      
      Case "NUMOPE"
      
         BacMntco.Tag = Trim(Left(lstNombre.text, 5))
      
      Case "INSTRU"
      
         BacDCV.Tag = lstNombre.text
         gsrut$ = Trim(Mid(lstNombre.text, 10, 15))
         gscodigo = Trim(Left(lstNombre.text, 3))
      
      Case "INSTRU_CAR"
         BacDCV.Tag = lstNombre.text
         gsrut$ = Trim(Mid(lstNombre.text, 10, 15))
         gscodigo = Trim(Left(lstNombre.text, 3))
      
      Case "INSTRU2"
      
         gsrut$ = Trim(Mid(lstNombre.text, 10, 10))
         gscodigo = Trim(Left(lstNombre.text, 3))
      
      Case "NEMOTEC"
      
         BacDCV.Tag = lstNombre.text
      
      Case "SERIE"
      
         gsSerie = Left(lstNombre.text, 15)
         gscodigo = Trim(Right(lstNombre.text, 10))
      
      Case "DESCREP"
     
         gscodigo$ = lstNombre.ItemData(lstNombre.ListIndex)
         gsglosa$ = Trim(Mid(lstNombre.List(lstNombre.ListIndex), 11))
         gsDescripcion$ = Trim(Mid(lstNombre.List(lstNombre.ListIndex), 11))

        Case "MDCAP"
            gsrut = CDbl(Mid$(lstNombre.text, 1, 10))

        Case "FILTRO_CL"
            sLine = Trim(Right(lstNombre.List(lstNombre.ListIndex), 10))
            gscodigo = Left(sLine, Len(sLine) - 2)
            gsDigito = Right(sLine, 1)
            gsnombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 64))
            gsCodCli = CDbl(lstNombre.ItemData(lstNombre.ListIndex))
        Case "FILTRO_CL2"
            sLine = Trim(Right(lstNombre.List(lstNombre.ListIndex), 10))
            gscodigo = Left(sLine, Len(sLine) - 2)
            gsDigito = Right(sLine, 1)
            gsnombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 64))
            gsCodCli = CDbl(lstNombre.ItemData(lstNombre.ListIndex))
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
'If u = "1" Then Exit Sub
   Dim nPos             As Long
   Dim sText            As String
   Dim n                As Long
   Dim nLargo           As Long


    Select Case Trim$(Me.Tag)
    Case "MDCAP"
        txtNombre.Enabled = False
        Exit Sub
    Case "MDRIC"
        txtNombre.Enabled = False
        Exit Sub
    End Select


   inicial = lstNombre.ListIndex
   sText = Trim$(txtNombre.text)

   nLargo = Len(sText)

   nPos = -1

   
   If Me.Tag = "NEMOTEC" Then
      
      Exit Sub
      
   End If

      
   If sText <> "" Then
      For n = 0 To lstNombre.ListCount '- 1
         If Mid$(lstNombre.List(n), 1, nLargo) = sText Then
            nPos = n
            Exit For

         End If

      Next n

   End If

   If (nPos& < 0) Then
      sText = Trim$(txtNombre.text)

      Select Case Trim$(Me.Tag)
      Case "MDCL"
         Set objAyuda = New clsClientes
         Call objAyuda.LeerClientes(sText, "N")
         Call MDCL_LlenaGrilla
      
      Case "MDEM"
         Set objAyuda = New clsEmisores
         Call objAyuda.LeerEmisores(sText, "T")
         Call objAyuda.Coleccion2Control(lstNombre)
         Call MDEM_LlenaGrilla

      Case "MDEMO"
         Set objAyuda = New clsEmisores
         Call objAyuda.LeerEmisores(sText, "O")
         Call objAyuda.Coleccion2Control(lstNombre)
         Call MDEM_LlenaGrilla

      Case "MDCD"
         Set objAyuda = New clsDCarteras
         Call objAyuda.LeerDCarteras("")
         Call objAyuda.Coleccion2Control(lstNombre)
         Call MDCD_LlenaGrilla

      Case "MDMN"
         Set objAyuda = New ClsMonedas
         Call objAyuda.LeerMonedas
         Call objAyuda.Coleccion2Control(lstNombre)

      Case "MDMN2"
         Set objAyuda = New clsMonedas2
         Call objAyuda.LeerMonedas
         Call objAyuda.Coleccion2Control(lstNombre)

      Case "MDIN"
         Set objAyuda = New clsFamilias
         Call objAyuda.LeerFamilias
         Call objAyuda.Coleccion2Control(lstNombre)
         
      End Select

      lstNombre.ListIndex = 0

   Else
      lstNombre.ListIndex = nPos

   End If

   txtNombre.Tag = txtNombre.text
   txtNombre.SetFocus

End Sub

Private Sub txtNombre_GotFocus()

   txtNombre.Tag = txtNombre.text

End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And Len(Trim(txtNombre.text)) = 0 Then Beep: Exit Sub
   If KeyAscii% = vbKeyReturn Then
      Call TLBARACEPTAR
      Unload Me
   Else
      KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
      txtNombre.SetFocus
   End If

If KeyAscii = 27 Then Unload Me

End Sub

Private Sub MDCT_LlenaGrilla()

   Dim Filas            As Long
   Dim IDCodigo         As Integer
   Dim IdGlosa          As String * 25
   Dim Max              As Long

   lstNombre.Clear

   Max = objAyuda.coleccion.Count

   For Filas = 1 To Max
      IdGlosa = objAyuda.coleccion(Filas).Descri
      IDCodigo = objAyuda.coleccion(Filas).Codigo

      lstNombre.AddItem IdGlosa & Space(3) & IDCodigo
      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).Codigo

   Next Filas

End Sub

Private Sub MDSE_LlenarGrilla()

'   Sql = "EXECUTE SP_LEE_MASCARA_SERIES " & BacMntSe.xincodigo
'
'   If Bac_SQL_Execute(" ",Envia) <> 0 Then
'      Exit Sub
'
'   End If
'
'   Do While Bac_SQL_Fetch(Datos())
'      lstNombre.AddItem Trim(datos(2)) & Space(15 + (15 - Len(datos(2)))) & Val(datos(1))
'
'   Loop

End Sub

'Tiene que verificar en todo el list para encontrar
'el indice que pertenece a la Opcion seleccionada ''blas
'======================================================
Public Function BuscaListIndex(Combo As Object, busca As String) As Integer

   Dim Lin              As Integer

   BuscaListIndex = 0              ' Nada en el ComboList

   With Combo
      If .ListCount <> 0 Then       ' = 0 Nada
         For Lin = 0 To .ListCount - 1
            .ListIndex = Lin
            If Trim$(Left(UCase(Trim$(.List(.ListIndex))), 25)) = Trim$(Left(UCase(busca), 25)) Then
               BuscaListIndex = Lin
               Exit Function

            End If

         Next Lin

      End If

   End With

End Function

Sub LISTAR_CUENTAS()
Dim Datos()

'   Sql = "SP_ANALISIS_VOUCHER_LLENA_DATOS 'CUENTA',''"
    Envia = Array("CUENTA", "")
   
    Pociona_ListOculta
    lstNombre.Visible = False
    
    If Bac_Sql_Execute("SP_ANALISIS_VOUCHER_LLENA_DATOS", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            lstNombre.AddItem (Datos(1) & Space(15 - Len(Datos(1))) & Datos(2))
        Loop
    End If
   
   lstNombre.Visible = True
   LstTmp.Visible = False
   
End Sub


Sub Listar_N_Operaciones()

    If Bac_Sql_Execute("SP_MANTENCION_DE_CORTES_TRAENUMOPE") Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            lstNombre.AddItem (Datos(1) & Space(15 - Len(Datos(1))) & Datos(2) & Space(15 - Len(Datos(2))) & Datos(3))
        
        Loop
    
    End If

End Sub

Sub Listar_Instrumentos()

    If Bac_Sql_Execute("SP_BACDCV_TRAEINSTRUMENTOS") Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            lstNombre.AddItem (Datos(1) & Space(10 - Len(Datos(1))) & Datos(2) & Space(10 - Len(Datos(2))) & Datos(3))
        
        Loop
    
    End If

End Sub

Sub Listar_Instrumentos_Car()

    If Bac_Sql_Execute("SP_BACDCV_TRAEINSTRUMENTOSCAR") Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            lstNombre.AddItem (Datos(1) & Space(10 - Len(Datos(1))) & Datos(2) & Space(10 - Len(Datos(2))) & Datos(3))
        
        Loop
    
    End If

End Sub


Sub Listar_Series()


    Envia = Array()
    AddParam Envia, CDbl(Trim(BacDCV.Tag))

    If Bac_Sql_Execute("SP_BACDCV_TRAE_SERIES", Envia) Then
        
        Call Pociona_ListOculta
        lstNombre.Visible = False
        
        Do While Bac_SQL_Fetch(Datos())
            
            lstNombre.AddItem (Datos(1) & Space(10 - Len(Datos(1))) & Datos(2) & Space(10 - Len(Datos(2))) & Datos(3))
        
        Loop
    
        lstNombre.Visible = True
        LstTmp.Visible = False
    
    End If

End Sub


Sub Busca_Serie()

    If Bac_Sql_Execute("SP_FRMMANTENEDORSERIES_TRAEDATOS") Then
        
        Call Pociona_ListOculta
        lstNombre.Visible = False
        
        Do While Bac_SQL_Fetch(Datos())
            
            lstNombre.AddItem (Datos(1) & Space(20 - Len(Datos(1))) & Datos(2))
        
        Loop
    
        lstNombre.Visible = True
        LstTmp.Visible = False
    
    End If

End Sub

Sub Busca_Sucursal()

    If Bac_Sql_Execute("SP_FRMMANTENEDORSUCURSAL_TRAEDATOS") Then
        
        Call Pociona_ListOculta
        lstNombre.Visible = False
        
        Do While Bac_SQL_Fetch(Datos())
            
            lstNombre.AddItem (Datos(1) & Space(20 - Len(Datos(1))) & Datos(2))
        
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
Function TRAE_CLIENTE2() As Boolean

    TRAE_CLIENTE2 = False
    Dim sCadena As String
    Dim Datos()
    
    lstNombre.Clear
    
    Envia = Array()
    AddParam Envia, Tipo_Cliente
        
    If Not Bac_Sql_Execute("SP_CLIENTES2 ", Envia) Then
        Exit Function
    End If
           
    Do While Bac_SQL_Fetch(Datos())
        sCadena = Right(Space(15) & Val(Datos(1)) & "-" & Datos(2), 15)
        sCadena = Left(Datos(4) & Space(57), 57) & Space(3) & sCadena
        lstNombre.AddItem sCadena
        lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(3))
        TRAE_CLIENTE2 = True
    Loop
    
End Function

Function Instrumento() As Boolean
    Instrumento = False
    Dim sCadena As String
    Dim Datos()
    
    lstNombre.Clear
    
       
    If Not Bac_Sql_Execute("Sp_BUSCA_INSTRUMENTO ") Then
        Exit Function
    End If
           
    Do While Bac_SQL_Fetch(Datos())
        sCadena = (Datos(1))
        sCadena = RELLENA_STRING((Datos(3)), "D", 7) + Space(2) + Left(Datos(2) & Space(40), 40) & Space(3) & sCadena
        lstNombre.AddItem sCadena
        lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(1))
        Instrumento = True
    Loop

End Function

Function Trae_Cliente() As Boolean
    Trae_Cliente = False
    Dim sCadena As String
    Dim Datos()
    
    lstNombre.Clear
    
    Envia = Array()
    AddParam Envia, Tipo_Cliente
    AddParam Envia, Sector_Economico
       
    If Not Bac_Sql_Execute("SP_CLIENTES ", Envia) Then
        Exit Function
    End If
           
    Do While Bac_SQL_Fetch(Datos())
        sCadena = Right(Space(15) & Val(Datos(1)) & "-" & Datos(2), 15)
        ' Cristian Bravo 08/05/2003
        sCadena = Left(Datos(4) & Space(57), 57) & Space(3) & sCadena
        lstNombre.AddItem sCadena
        lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(3))
        Trae_Cliente = True
    Loop
    
End Function
