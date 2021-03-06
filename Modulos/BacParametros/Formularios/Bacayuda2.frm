VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacAyuda 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ayuda "
   ClientHeight    =   6225
   ClientLeft      =   3045
   ClientTop       =   1095
   ClientWidth     =   6540
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillStyle       =   0  'Solid
   Icon            =   "Bacayuda2.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6225
   ScaleWidth      =   6540
   Begin Threed.SSPanel SSPanel1 
      Height          =   5715
      Left            =   0
      TabIndex        =   1
      Top             =   525
      Width           =   6555
      _Version        =   65536
      _ExtentX        =   11562
      _ExtentY        =   10081
      _StockProps     =   15
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   2
      BevelInner      =   1
      FloodColor      =   0
      Begin Threed.SSPanel SSPanel2 
         Height          =   5490
         Left            =   120
         TabIndex        =   2
         Top             =   105
         Width           =   6315
         _Version        =   65536
         _ExtentX        =   11139
         _ExtentY        =   9684
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.TextBox txtNombre 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00400000&
            Height          =   360
            Left            =   1185
            LinkTimeout     =   0
            MaxLength       =   65
            TabIndex        =   4
            Top             =   120
            Width           =   5070
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
            ForeColor       =   &H00400000&
            Height          =   4890
            ItemData        =   "Bacayuda2.frx":030A
            Left            =   60
            List            =   "Bacayuda2.frx":0311
            TabIndex        =   3
            Top             =   495
            Width           =   6180
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Buscar ..."
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00400000&
            Height          =   255
            Left            =   150
            TabIndex        =   5
            Top             =   120
            Width           =   1095
         End
      End
   End
   Begin MSComctlLib.Toolbar Botones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6540
      _ExtentX        =   11536
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
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5160
         Top             =   0
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
               Picture         =   "Bacayuda2.frx":0320
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":0774
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacAyuda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sw
Dim sPatron$
Dim Sql$
Dim Datos()
Public Mascara      As String

Private objAyuda As Object
Public parAyuda  As String    ' Ayuda de perfiles
Public parFiltro As String    ' Ayuda de Perfiles
Public Codigo    As Long
Public Glosa     As String

Private Sub llena_Riesgo()
    Dim Datos()
    If Bac_Sql_Execute("Svc_Ayd_cod_rsg") Then
        Do While Bac_SQL_Fetch(Datos)
            lstNombre.AddItem Datos(1)
        Loop
    End If
End Sub

Private Sub Llena_Feriados()
Dim iMouse%
Dim i As Integer
    
    lstNombre.Clear

    sql = "SELECT codigo_pais, nombre FROM PAIS"
    If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox "No se pudo realizar Consulta de Datos", vbInformation + vbOKOnly, TITSISTEMA
    End If
    Do While MISQL.SQL_Fetch(Datos()) = 0
        If Len(Datos(1)) < 3 Then
            xCodPais = Datos(1)
            For i = 1 To 2
                xCodPais = "0" & xCodPais
            Next
            lstNombre.AddItem xCodPais & Space(10) & Datos(2)
        Else
            lstNombre.AddItem Datos(1) & Space(10) & Datos(2)
        End If
        'lstNombre.ItemData(lstNombre.NewIndex) = Datos(1)
    Loop
    If lstNombre.ListCount >= 0 Then
        lstNombre.ListIndex = 0
    End If

    
End Sub

Private Sub Llena_Emisores()
'    Dim datos()
'    Dim sql
'    If Bac_Sql_Execute("Svc_Ayd_lst_emi") Then
'        Do While Bac_SQL_Fetch(datos())
'            lstNombre.AddItem datos(4) & Space(40 - Len(datos(4))) & "   " & datos(1) & " " & Space(9 - Len(datos(1))) & " -" & datos(3) & " " & datos(2)
'            lstNombre.ItemData(lstNombre.NewIndex) = Val(datos(1))
'        Loop
'    End If

         Set objAyuda = New clsEmisores
         Call objAyuda.LeerEmisores(txtNombre.Text, "T")
         Call MDEM_LlenaGrilla
         
End Sub

Private Sub Llena_EmisoresBonosExt()
Dim Datos()
    Dim Sql
    If Bac_Sql_Execute("BacBonosExtSuda.dbo.SVC_AYD_LST_EMI") Then
        Do While Bac_SQL_Fetch(Datos())
            lstNombre.AddItem Datos(4) & Space(40 - Len(Datos(4))) & "   " & Datos(1) & " " & Space(9 - Len(Datos(1))) & " -" & Datos(3) & " " & Datos(2)
            lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(1))
        Loop
    End If
         
End Sub

Private Sub MDSETD_LlenarGrilla()
   Dim Sql     As String
   Dim Datos()
   Sql = ""
   
   Envia = Array(CDbl(Bac_Tabla_Desarrollo.xincodigo))
   If Not Bac_Sql_Execute("sp_lee_mascara_series", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos())
       lstNombre.AddItem Trim(Datos(2)) & Space(15 + (15 - Len(Datos(2)))) & Val(Datos(1))
   Loop
End Sub

Sub Proc_Ayuda_Clausula_Dinamica(cSistema As String, cContratoFisico As String)

   Envia = Array()
   AddParam Envia, cSistema
   AddParam Envia, cContratoFisico
   
   If Not Bac_Sql_Execute("SP_CON_CLAUSULA_CONTRATO_DINAMICO", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar cargar los contratos dinamicos", vbCritical + vbOKOnly
      Exit Sub
   End If
   
   lstNombre.Clear
   
   Do While Bac_SQL_Fetch(Datos())
      lstNombre.AddItem Trim(Datos(3)) & Space(10 - Len(Datos(3))) & Datos(4)
   Loop
   
End Sub

Private Sub Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim aux As String
   Dim nPos&
   Dim Indice%
   Dim sLine$
   
   If BacAyuda.Tag = "CURVAS" Then
      gsNombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 20))
      gsNemo = Trim(Mid(lstNombre.List(lstNombre.ListIndex), 24, 1))
      gsDescripcion$ = Trim(Mid(lstNombre.List(lstNombre.ListIndex), 28))
      giAceptar = True
      Unload Me
      Exit Sub
   End If
   
   Select Case Button.Index
      Case 1 'aceptar
         giAceptar = False
         
         If Me.Tag = "CLAUSULA_DINAMICA" Then
            gsCodigo = ""
            gsCodigo = Trim(Left(lstNombre.List(lstNombre.ListIndex), 10))
            giAceptar = True
            Unload Me
            Exit Sub
         End If
         
         If Me.Tag = "PaisMntLocalidades" _
            Or Me.Tag = "RegionMntLocalidades" _
            Or Me.Tag = "CiudadMntLocalidades" _
            Or Me.Tag = "ComunaMntLocalidades" _
            Or Me.Tag = "RegionMntLocalidades1" _
            Or Me.Tag = "CiudadMntLocalidades1" _
            Or Me.Tag = "ComunaMntLocalidades1" _
            Or Me.Tag = "PlazaMntLocalidades" Then
            
            Screen.MousePointer = 0
            RETORNOAYUDA = Trim(Right(lstNombre, 5))
            giAceptar = True
            Unload Me
            Exit Sub
      End If
     
     If Me.Tag = "Corresponsal" Then
        gsNombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 45))
        gsCodigo = Trim(Mid(lstNombre.List(lstNombre.ListIndex), 46))
        giAceptar% = True
        Unload Me
        Exit Sub
     End If
     
      '-Si No tiene Elementos Listcount = 0 -'
      If Not lstNombre.ListCount > 0 Then
         GoTo fin
      End If
      If lstNombre.ListIndex < 0 Then
         Exit Sub
      End If
      '-Si tiene algun elemento-'
      'Indice = BuscaListIndex(lstNombre, Trim$(txtNombre.Text)) + 1
      
      Indice = lstNombre.ListIndex + 1
      Screen.MousePointer = 11
      aux = ""
      Me.Tag = UCase(Trim(Me.Tag))
      
      If InStr(Me.Tag, "TBCODIGOSCOMERCIO") > 0 Then
         aux = IIf(Val(Right(Me.Tag, 3)) > 0, Right(Me.Tag, 3), "")
         Me.Tag = "TBCODIGOSCOMERCIO"
      ElseIf InStr(Me.Tag, "TBCODIGOSOMA") > 0 Then
         aux = IIf(Val(Left(Me.Tag, 1)) > 0, Left(Me.Tag, 1), "")
         Me.Tag = "TBCODIGOSOMA"
      End If
      
      If Mid$(Me.Tag, 1, 8) = "CLIXTIPO" Then
                     gsrut$ = objAyuda.coleccion(Indice).clrut
               gsDigito$ = objAyuda.coleccion(Indice).cldv
               gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
               gsValor$ = objAyuda.coleccion(Indice).clcodigo
               gsFax$ = objAyuda.coleccion(Indice).clfax
               gsNombre$ = objAyuda.coleccion(Indice).clnombre
               gsgeneric = objAyuda.coleccion(Indice).clgeneric
               gsdirecc = objAyuda.coleccion(Indice).cldirecc
               gsciudad = objAyuda.coleccion(Indice).clciudad
               gsPais = objAyuda.coleccion(Indice).clpais
               gscomuna = objAyuda.coleccion(Indice).clcomuna
               gsregion = objAyuda.coleccion(Indice).clregion
               gstipocliente = objAyuda.coleccion(Indice).cltipocliente
               gsEntidad = objAyuda.coleccion(Indice).clentidad
               gscalidadjuridica = objAyuda.coleccion(Indice).clcalidadjuridica
               gsGrupo = objAyuda.coleccion(Indice).clgrupo
               gsMercado = objAyuda.coleccion(Indice).clmercado
               gsapoderado = objAyuda.coleccion(Indice).clapoderado
               gsctacte = objAyuda.coleccion(Indice).clctacte
               gsfono = objAyuda.coleccion(Indice).clfono
               gs1Nombre = objAyuda.coleccion(Indice).cl1nombre
               gs2Nombre = objAyuda.coleccion(Indice).cl2nombre
               gs1Apellido = objAyuda.coleccion(Indice).cl1apellido
               gs2Apellido = objAyuda.coleccion(Indice).cl2apellido
               gsCtausd = objAyuda.coleccion(Indice).clctausd
               gsImplic = objAyuda.coleccion(Indice).climplic
               gsAba = objAyuda.coleccion(Indice).claba
               gsChips = objAyuda.coleccion(Indice).clchips
               gsSwift = objAyuda.coleccion(Indice).clswift
               gsGlosa = objAyuda.coleccion(Indice).clglosab
               gsCodigo = objAyuda.coleccion(Indice).clcodigo
               gsmxcontab = objAyuda.coleccion(Indice).mxcontab
               gsEstado = objAyuda.coleccion(Indice).clVigente 'PRD-5896
               giAceptar = True
               GoTo fin
      End If
      
      Select Case UCase(Trim(Me.Tag))
         Case "MDCL_B"
            gsrut$ = objAyuda.coleccion(Indice).clrut
            gsDigito$ = objAyuda.coleccion(Indice).cldv
            gsCodigo = objAyuda.coleccion(Indice).clcodigo
            gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
            gsSwift = objAyuda.coleccion(Indice).clswift
         Case "MDCL_U":        '---- PENDIENTE
            sLine = Trim(Right(lstNombre.List(lstNombre.ListIndex), 11))
            gsCodigo = Left(sLine, Len(sLine) - 2)
            gsDigito = Right(sLine, 1)
            gsNombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 45))
            gsCodCli = CDbl(lstNombre.ItemData(lstNombre.ListIndex))
         Case "MONEDA"
            sLine = lstNombre.List(lstNombre.ListIndex)
            gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
            gsNemo = Trim(Left(sLine, 5))
            gsGlosa = Trim(Mid(sLine, 6))
         Case "MONEDAS_CTBL"
            sLine = lstNombre.List(lstNombre.ListIndex)
            gsCodigo = lstNombre.List(lstNombre.ListIndex)
            gsNemo = Trim(Left(sLine, 5))
            gsGlosa = Trim(Mid(sLine, 6))
         Case "MDMN_U"
            sLine = lstNombre.List(lstNombre.ListIndex)
            gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
            gsNemo = Trim(Left(sLine, 5))
            gsGlosa = Trim(Mid(sLine, 6))
         
         Case "MDTC_U", "MDFP_U", "MDTC_TASASMERCADO", "MDTC_TASASMONEDAS", "PAIS"
            gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
            gsGlosa = lstNombre.List(lstNombre.ListIndex)
         
         Case "MDCL_SINACOFI" ', "MDCL_BCO"   'TABLA DE CLIENTES
            gsrut$ = objAyuda.coleccion(Indice).clrut
            gsDigito$ = objAyuda.coleccion(Indice).cldv
            gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
            gsValor$ = objAyuda.coleccion(Indice).clcodigo
            gsFax$ = objAyuda.coleccion(Indice).clfax
            gsNombre$ = objAyuda.coleccion(Indice).clnombre
            gsgeneric = objAyuda.coleccion(Indice).clgeneric
            gsdirecc = objAyuda.coleccion(Indice).cldirecc
            gsciudad = objAyuda.coleccion(Indice).clciudad
            gsPais = objAyuda.coleccion(Indice).clpais
            gscomuna = objAyuda.coleccion(Indice).clcomuna
            gsregion = objAyuda.coleccion(Indice).clregion
            gstipocliente = objAyuda.coleccion(Indice).cltipocliente
            gsEntidad = objAyuda.coleccion(Indice).clentidad
            gscalidadjuridica = objAyuda.coleccion(Indice).clcalidadjuridica
            gsGrupo = objAyuda.coleccion(Indice).clgrupo
            gsMercado = objAyuda.coleccion(Indice).clmercado
            gsapoderado = objAyuda.coleccion(Indice).clapoderado
            gsctacte = objAyuda.coleccion(Indice).clctacte
            gsfono = objAyuda.coleccion(Indice).clfono
            gs1Nombre = objAyuda.coleccion(Indice).cl1nombre
            gs2Nombre = objAyuda.coleccion(Indice).cl2nombre
            gs1Apellido = objAyuda.coleccion(Indice).cl1apellido
            gs2Apellido = objAyuda.coleccion(Indice).cl2apellido
            gsCtausd = objAyuda.coleccion(Indice).clctausd
            gsImplic = objAyuda.coleccion(Indice).climplic
            gsAba = objAyuda.coleccion(Indice).claba
            gsChips = objAyuda.coleccion(Indice).clchips
            gsSwift = objAyuda.coleccion(Indice).clswift
            gsGlosa = objAyuda.coleccion(Indice).clglosab
            gsCodigo = objAyuda.coleccion(Indice).clcodigo
            gsmxcontab = objAyuda.coleccion(Indice).mxcontab
         
         Case "MDCL" ', "MDCL_BCO"   'TABLA DE CLIENTES
            If clie <> "SINACOFI" Then
               gsrut$ = objAyuda.coleccion(Indice).clrut
               gsDigito$ = objAyuda.coleccion(Indice).cldv
               gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
               gsValor$ = objAyuda.coleccion(Indice).clcodigo
               gsFax$ = objAyuda.coleccion(Indice).clfax
               gsNombre$ = objAyuda.coleccion(Indice).clnombre
               gsgeneric = objAyuda.coleccion(Indice).clgeneric
               gsdirecc = objAyuda.coleccion(Indice).cldirecc
               gsciudad = objAyuda.coleccion(Indice).clciudad
               gsPais = objAyuda.coleccion(Indice).clpais
               gscomuna = objAyuda.coleccion(Indice).clcomuna
               gsregion = objAyuda.coleccion(Indice).clregion
               gstipocliente = objAyuda.coleccion(Indice).cltipocliente
               gsEntidad = objAyuda.coleccion(Indice).clentidad
               gscalidadjuridica = objAyuda.coleccion(Indice).clcalidadjuridica
               gsGrupo = objAyuda.coleccion(Indice).clgrupo
               gsMercado = objAyuda.coleccion(Indice).clmercado
               gsapoderado = objAyuda.coleccion(Indice).clapoderado
               gsctacte = objAyuda.coleccion(Indice).clctacte
               gsfono = objAyuda.coleccion(Indice).clfono
               gs1Nombre = objAyuda.coleccion(Indice).cl1nombre
               gs2Nombre = objAyuda.coleccion(Indice).cl2nombre
               gs1Apellido = objAyuda.coleccion(Indice).cl1apellido
               gs2Apellido = objAyuda.coleccion(Indice).cl2apellido
               gsCtausd = objAyuda.coleccion(Indice).clctausd
               gsImplic = objAyuda.coleccion(Indice).climplic
               gsAba = objAyuda.coleccion(Indice).claba
               gsChips = objAyuda.coleccion(Indice).clchips
               gsSwift = objAyuda.coleccion(Indice).clswift
               gsGlosa = objAyuda.coleccion(Indice).clglosab
               gsCodigo = objAyuda.coleccion(Indice).clcodigo
               gsmxcontab = objAyuda.coleccion(Indice).mxcontab
               gsEstado = objAyuda.coleccion(Indice).clVigente 'PRD-5896
            Else
               gsCodigo$ = objAyuda.coleccion(Indice).clrut
               gsDigito$ = objAyuda.coleccion(Indice).cldv
               gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
               gsFax$ = objAyuda.coleccion(Indice).clfax
               gsCodCli = objAyuda.coleccion(Indice).clcodigo
               gsmxcontab = objAyuda.coleccion(Indice).mxcontab
               gsPais = objAyuda.coleccion(Indice).clpais
            End If
            '************************************************
         Case "MDCD"      'TABLA DE DUE?OS DE CARTERA
            'gsrut$ = objAyuda.coleccion(Indice).rcrut
            'gsDigito$ = objAyuda.coleccion(Indice).rcdv
         Case "MDMN"      'TABLA DE MONEDAS
            gsCodigo$ = objAyuda.coleccion(Indice).mncodmon
            'gsDescripcion$ = objAyuda.Coleccion(Indice).mndescrip
            gsDescripcion$ = objAyuda.coleccion(Indice).mnglosa 'arreglado
         Case "MDPC"      'TABLA DE PLAN DE CUENTAS
            gsCodigo$ = objAyuda.coleccion(Indice).pccuenta
         Case "BACUSER"      'TABLA DE PLAN DE CUENTAS
            gsDescripcion$ = objAyuda.coleccion(Indice).Usuario
         Case "METB01"      'TABLA DE CODIGOS FORMAS DE PAGO
            gsCodigo$ = objAyuda.coleccion(Indice).codmov
            gsGlosa$ = objAyuda.coleccion(Indice).codescri
            gsValor$ = objAyuda.coleccion(Indice).CodMovch
            gsDigito$ = objAyuda.coleccion(Indice).CodOrden
            gsRedondeo$ = objAyuda.coleccion(Indice).CodNum
            gsNombre$ = objAyuda.coleccion(Indice).CodTipos
            gsDescripcion$ = objAyuda.coleccion(Indice).COD2756
            gsFax$ = objAyuda.coleccion(Indice).CodAfecta
            gsSerie$ = objAyuda.coleccion(Indice).CodNumC
            gsNemo$ = objAyuda.coleccion(Indice).CodCta
         Case "MFMN"         'TABLA DE MONEDAS     PENDIENTE sacar, pertenede a Bac Forward
            gsCodigo$ = objAyuda.coleccion(Indice).mncodigo ''codmon
            gsGlosa$ = objAyuda.coleccion(Indice).mnglosa
            ' VAR DEL CLSMODULO MONEDAS
            'mncodigo ''codmon
            'mndescrip 'mnglosa
         Case "MFMNMX", "MFMNME"    'TABLA DE MONEDAS
            gsCodigo$ = objAyuda.coleccion(Indice).mncodmon ''codmon
            gsGlosa$ = objAyuda.coleccion(Indice).mnglosa
         Case "MDTC"         '---- TABLA DE PARAMETROS
            gsCodigo$ = objAyuda.coleccion(Indice).Codigo
            gsGlosa$ = objAyuda.coleccion(Indice).Glosa
         Case "MDTC_MTM"     '---- Tasas MTM
            gsCodigo$ = objAyuda.coleccion(Indice).Codigo
            gsGlosa$ = objAyuda.coleccion(Indice).Glosa
         '---- CONTABILIDAD
         Case "CUENTAS", "MOVIM"
            'glcf
''''            gsCodigo$ = Trim(Mid$(lstNombre.Text, 40))
            gsCodigo$ = Trim(Right(lstNombre.Text, 16))
            gsDescripcion$ = Trim(Left(lstNombre.Text, 40))
         Case "PERFIL"
            gsCodigo$ = Mid(lstNombre.Text, 1, 10)
            'gscodigo$ = Right(lstNombre.Text, 5)
            gsDescripcion$ = Mid$(lstNombre.Text, 12)
         Case "CAMPOS"
            gsCodigo$ = Val(Mid$(lstNombre.Text, 40))
            gsDescripcion$ = Trim(Left(lstNombre.Text, 40))
         Case "CONDICIONES"
            gsCodigo$ = Trim(Right(lstNombre.Text, 10))
           'gsCodigo$ = Trim(Mid$(lstNombre.Text, 42))
           'gsCodigo$ = Mid$(lstNombre.Text, 40)
            gsDescripcion$ = Trim(Left(lstNombre.Text, 40))
         Case "SISTEMAS", "SISTEMA"
            gsCodigo$ = Left(lstNombre.Text, 3)
            gsGlosa$ = Trim(Mid(lstNombre.Text, 4))
    '---- CARGA (procedimiento sin coleccion propio de este formulario)
    '*****HOLA******
         Case "MDEM"      'TABLA DE EMISORES Total
            gsCodigo$ = objAyuda.coleccion(Indice).emrut
            gsDigito$ = objAyuda.coleccion(Indice).emdv
            gsDescripcion$ = objAyuda.coleccion(Indice).emnombre
            gsGenerico$ = objAyuda.coleccion(Indice).emgeneric
            '**************
         Case "MDMN_PAIS"
            gsCodigo$ = objAyuda.coleccion(Indice).Codigo
            gsGlosa$ = objAyuda.coleccion(Indice).Glosa
         Case "MDCT"      'TABLAS GENERALES
            gsCodigo$ = objAyuda.coleccion(Indice).Codigo
            gsGlosa$ = objAyuda.coleccion(Indice).Descri
         Case "MDIN"      'TABLA DE FAMILIAS DE INSTRUMENTOS
            gsSerie$ = objAyuda.coleccion(Indice).inserie
            gsCodigo$ = objAyuda.coleccion(Indice).incodigo
            gsDescripcion$ = objAyuda.coleccion(Indice).inglosa
         Case "MDSE"
            'Dim Mascara As String
            Glosa = Trim(Right(lstNombre.Text, 15))
            Mascara = Trim(Left(lstNombre.Text, 30))
         Case "MDSETD"
            Glosa = Trim(Right(lstNombre.Text, 15))
            Mascara = Trim(Left(lstNombre.Text, 30))
         Case "TBCODIGOSOMA"
            idtipo = IIf(Val(aux) = 0, 15, 16)
            gsCodigo$ = objAyuda.coleccion(Indice).codmov
            gsDigito$ = Trim(Left(objAyuda.coleccion(Indice).CodCta, 2))
            gsValor$ = Left(Mid$(objAyuda.coleccion(Indice).CodCta & "0000000000", 3), 7)
            gsGlosa$ = objAyuda.coleccion(Indice).codescri
            Me.Tag = aux & Me.Tag
         Case "TB_CODIGOSOMADELCORP"
            idtipo = 17
            gsCodigo$ = objAyuda.coleccion(Indice).codmov
            Me.Tag = aux & Me.Tag
         Case "TBCODIGOSCOMERCIO"
            idtipo = IIf(Val(aux) = 0, 13, 14)
            gsCodigo$ = objAyuda.coleccion(Indice).codmov
            gsDigito$ = objAyuda.coleccion(Indice).CodCta
            gsGlosa$ = objAyuda.coleccion(Indice).codescri
            gsValor$ = objAyuda.coleccion(Indice).CodNum
            gsNombre$ = objAyuda.coleccion(Indice).CodOrden
            Me.Tag = Me.Tag & aux
         Case "MECLA"      'TABLA DE GLOSAS
            idtipo = 4
            gsCodigo$ = objAyuda.coleccion(Indice).CodMovch
            gsGlosa$ = objAyuda.coleccion(Indice).codescri
            gsDigito$ = objAyuda.coleccion(Indice).codmov
            gsDescripcion$ = objAyuda.coleccion(Indice).CodOrden
            gsValor$ = objAyuda.coleccion(Indice).COD2756
         '----------------------------------------------------------
         '----------- CAMBIOS REALIZADOS 01--06-2001
         '----------- Despliega los datos en textbox
         Case "EJE"      'Tabla de Ejecutivo
            Trae_Ejecutivo 'Private Sub
            BacMntEjecutivo.TxtCodigo.Text = eCodigo
            BacMntEjecutivo.txtNombre.Text = eNombre
            BacMntEjecutivo.txtSucursal.Text = eSucursal
            BacMntEjecutivo.txtMonto.Text = eMonto_Linea
         Case "SUC"      'TABLA SUCURSAL
            Trae_Sucursal 'Private Sub
            BacMntSucursales.TxtCodigo.Text = sCodigo_Sucursal
            BacMntSucursales.txtNombre.Text = sNombre
         Case "SS" 'Selecuona sucursal mediante formualrio Ejecutivo
            Trae_Sucursal 'Private Sub
            BacMntEjecutivo.txtSucursal.Text = sCodigo_Sucursal
         Case "EMISOR"
            gsrut$ = Trim(lstNombre.Text)
            
            gsCodigo$ = objAyuda.coleccion(Indice).emrut
            gsDigito$ = objAyuda.coleccion(Indice).emdv
            gsDescripcion$ = objAyuda.coleccion(Indice).emnombre
            gsGenerico$ = objAyuda.coleccion(Indice).emgeneric
            gsCodCli = objAyuda.coleccion(Indice).emcodigo
            
            
         Case "EMISOR_BONOS_EXT"
            gsrut$ = lstNombre.Text
            lstNombre.Clear
            
            
            
         Case "RIESGO"
            gsrut$ = Trim(lstNombre.Text)
         '----------------------------------------------------------
         '************************************************
         Case "PERIODOS"
            gsDescripcion$ = Left(lstNombre.List(lstNombre.ListIndex), 50)
            gsCodigo$ = lstNombre.ItemData(lstNombre.ListIndex)
            gsValor$ = Val(Right(lstNombre.List(lstNombre.ListIndex), 50))
            
         Case "FERIADOS"
         
            BacMntFeriados.txtCodPais.Text = Trim(Mid(lstNombre.Text, 1, 5))
            BacMntFeriados.txtCodPais2.Text = Int(Mid(lstNombre.Text, 1, 5))
            BacMntFeriados.txtNomPais.Text = Trim(Mid(lstNombre.Text, 6, Len(lstNombre.Text)))
         
            i = 1
            Envia = Array()
            
            AddParam Envia, BacMntFeriados.txtCodPais2.Text
            
            If Not Bac_Sql_Execute("SP_BUSCA_FERIADOS", Envia) Then
                Exit Sub
            End If
        
            Do While Bac_SQL_Fetch(Datos())
                BacMntFeriados.grilla.Rows = i + 1
                BacMntFeriados.grilla.Row = i
                BacMntFeriados.grilla.TextMatrix(i, 0) = Datos(1)
                BacMntFeriados.grilla.TextMatrix(i, 1) = Datos(2)
                BacMntFeriados.grilla.TextMatrix(i, 2) = Datos(3)
                BacMntFeriados.grilla.TextMatrix(i, 3) = Datos(4)
                BacMntFeriados.grilla.TextMatrix(i, 4) = Datos(5)
                BacMntFeriados.grilla.TextMatrix(i, 5) = Datos(6)
                BacMntFeriados.grilla.TextMatrix(i, 6) = "Cambio"
                BacMntFeriados.grilla.TextMatrix(i, 7) = Datos(7)
                BacMntFeriados.grilla.TextMatrix(i, 8) = Datos(8)
                BacMntFeriados.grilla.TextMatrix(i, 9) = Datos(9)
                i = i + 1
            Loop
           
         Case Else
            GoTo fin
      End Select
      giAceptar = True
fin:
   Screen.MousePointer = 0
   Unload Me
Case 2
   giAceptar = False
   Unload Me
End Select
End Sub
'----------------------------------------------------------
'Listo
Private Sub Trae_Ejecutivo()
Dim eSQL, eCriterio As String

txtNombre.Text = lstNombre

eCriterio = Trim(Right(txtNombre.Text, 4))
eSQL = "sp_trae_ejecutivo" & " " & eCriterio
    
    Bac_Sql_Execute (eSQL)
    Do While Bac_SQL_Fetch(Datos())
        eCodigo = Datos(1)
        eNombre = UCase(Datos(2))
        eSucursal = Datos(3)
        eMonto_Linea = Datos(4)
    Loop
        
End Sub
Private Sub Trae_Sucursal()
Dim sSQL, sCriterio As String

txtNombre.Text = lstNombre

sCriterio = Trim(Right(txtNombre.Text, 4))
sSQL = "sp_trae_sucursal" & " " & sCriterio
    
    Bac_Sql_Execute (sSQL)
    Do While Bac_SQL_Fetch(Datos())
        sNombre = UCase(Datos(2))
        sCodigo_Sucursal = Datos(1)
    Loop
End Sub
'----------------------------------------------------------

Private Function Aceptar() As Boolean
    Unload Me
End Function

Private Sub CargarCurvasMTM(ByVal sFiltro As String)
   On Error GoTo ErrReadCurvas
   Dim Datos()
   Dim bExist  As Boolean
   
   Let bExist = False
   
   Let Envia = Array()
   Call AddParam(Envia, CDbl(4))
   Call AddParam(Envia, "")
   Call AddParam(Envia, "")
   Call AddParam(Envia, sFiltro)
   If Not Bac_Sql_Execute("SP_MNT_DEFINICION_CURVAS", Envia) Then
      GoTo ErrReadCurvas
   End If
   lstNombre.Clear
   Do While Bac_SQL_Fetch(Datos())
      lstNombre.AddItem Left(Datos(1), 20) & String(20 - Len(Left(Datos(1), 20)), " ") & " - " & Datos(3) & " - " & Datos(2)
      bExist = True
   Loop
   
   If bExist = False Then
      lstNombre.AddItem "No Existen Curvas Creadas"
   End If
   
   On Error GoTo 0
Exit Sub
ErrReadCurvas:
   On Error GoTo 0
End Sub


Private Sub Form_Activate()
 Dim Datos()
 Dim aux As String
 Dim tipo As Integer
    
 On Error GoTo ErrorF:
    
    lstNombre.Clear
   
   If BacAyuda.Tag = "CURVAS" Then
      Call CargarCurvasMTM("")
      Exit Sub
   End If
   
   If BacAyuda.Tag = "CURVAS_T" Then
      Call CargarCurvasMTM("T")
      BacAyuda.Tag = "CURVAS"
      Exit Sub
   End If
   If BacAyuda.Tag = "CURVAS_S" Then
      Call CargarCurvasMTM("S")
      BacAyuda.Tag = "CURVAS"
      Exit Sub
   End If
   
   If BacAyuda.Tag = "CLAUSULA_DINAMICA" Then
      Call Proc_Ayuda_Clausula_Dinamica(Trim(Left(gsCodigo, 5)), Trim(Mid(gsCodigo, 6, 10)))
      BacAyuda.Tag = "CLAUSULA_DINAMICA"
      Exit Sub
   End If
   
   'Garantias inicio
   If BacAyuda.Tag = "MDEM" Then
        Set objAyuda = New clsEmisores
        Call objAyuda.LeerEmisores("", "O")
        Call MDEM_LlenaGrilla
        Exit Sub
    End If
    'Garantias fin
   
    If UCase(Trim$(BacAyuda.Tag)) = "CUENTAS" Then
        BacAyuda.Width = BacAyuda.Width + 1200
        SSPanel1.Width = SSPanel1.Width + 1200
        SSPanel2.Width = SSPanel2.Width + 1200
        lstNombre.Width = lstNombre.Width + 1200
    End If

    BacControlWindows 12
    
    txtNombre.Visible = False 'PARA REFRESCAR EL OBJETO
    txtNombre.Visible = True

    Screen.MousePointer = vbHourglass
   
    If Mid$(BacAyuda.Tag, 1, 8) = "CLIXTIPO" Then
        'Buscar Clientes por Tipo
        tipo = CInt(Mid$(BacAyuda.Tag, 9))
        Set objAyuda = New clsClientes
        Call objAyuda.LeerClientesPorTipo(tipo, "", 50)
        Call objAyuda.Coleccion2Control(Lstnombre)
        Call mdcl_LlenaGrilla
        Screen.MousePointer = vbDefault
        TxtNombre.SetFocus
        Exit Sub
    End If
   
    If Me.Tag = "PaisMntLocalidades" _
        Or Me.Tag = "RegionMntLocalidades" _
        Or Me.Tag = "CiudadMntLocalidades" _
        Or Me.Tag = "ComunaMntLocalidades" _
        Or Me.Tag = "RegionMntLocalidades1" _
        Or Me.Tag = "CiudadMntLocalidades1" _
        Or Me.Tag = "ComunaMntLocalidades1" _
        Or Me.Tag = "PlazaMntLocalidades" _
        Or Me.Tag = "Corresponsal" _
        Then
        Dim SUPERSW As Boolean
        SUPERSW = False
        Sql = ""
        Select Case Me.Tag
            Case "PaisMntLocalidades"
                Sql = "SP_MOSTRAR_PAIS"
                SUPERSW = True
            Case "RegionMntLocalidades"
                Sql = "SP_MOSTRAR_REGION"
            Case "RegionMntLocalidades1"
                Sql = "SP_MOSTRAR_REGION " & PARAMETRO1
            Case "CiudadMntLocalidades"
                Sql = "SP_MOSTRAR_CIUDAD" '& PARAMETRO1
            Case "CiudadMntLocalidades1"
                Sql = "SP_MOSTRAR_CIUDAD " & PARAMETRO1
            Case "ComunaMntLocalidades"
                Sql = "SP_MOSTRAR_COMUNA"
            Case "ComunaMntLocalidades1"
                Sql = "SP_MOSTRAR_COMUNA " & PARAMETRO1
            Case "PlazaMntLocalidades"
                Sql = "SP_MOSTRAR_PLAZA"
            Case "Corresponsal"
                Sql = "Sp_Muestra_Corresponsales " & PARAMETRO1
        End Select
        
        If Not Bac_Sql_Execute(Sql) Then
            
            Screen.MousePointer = 0
            Unload Me
            Exit Sub
        
        End If
    
        Do While Bac_SQL_Fetch(Datos())
            
            If SUPERSW = True Then
                
                lstNombre.AddItem UCase(Datos(2)) & Space(100) & Datos(1)
            
            ElseIf Me.Tag = "Corresponsal" Then
            
                lstNombre.AddItem Mid(UCase(Datos(2)) & Space(30), 1, 35) & Space(10) & Datos(1)
            Else
                
                lstNombre.AddItem UCase(Datos(3)) & Space(100) & Datos(1)
            
            End If
            'obj.ItemData(obj.NewIndex) = Val(DATOS(2))
        
        Loop
        
        Screen.MousePointer = 0
        txtNombre.SetFocus
        Exit Sub
    
    End If
    
    If Me.Tag = "CIUDADESMntLocalidades" Then
        
        If Not Bac_Sql_Execute("SP_BUSCA_PAISES") Then
            
            Exit Sub
        
        End If
    
        Do While Bac_SQL_Fetch(Datos())
            
            lstNombre.AddItem UCase(Datos(2)) & Space(100) & Datos(1)
            'obj.ItemData(obj.NewIndex) = Val(DATOS(2))
        
        Loop
        
    End If
    
    
    aux = ""
    Me.Tag = UCase(Trim(Me.Tag))
    If InStr(Me.Tag, "TBCODIGOSCOMERCIO") > 0 Then
        If Val(Right(Me.Tag, 4)) > 0 Then
            aux = Right(Me.Tag, 3)
            gsCodigo = aux
            gsDigito = Val(Left(Right(Me.Tag, 4), 1))
        End If
        Me.Tag = "TBCODIGOSCOMERCIO"
    ElseIf InStr(Me.Tag, "TBCODIGOSOMA") > 0 Then
        aux = IIf(Val(Left(Me.Tag, 1)) > 0, Left(Me.Tag, 1), "")
        Me.Tag = "TBCODIGOSOMA"
    End If
    
    Select Case UCase(Trim$(Me.Tag))

    '----------------------------------------------------------
    '----------- CAMBIOS REALIZADOS 01--06-2001
    '----------- Busca los daotos
    '----------- Listo
        Case "EJE" 'TABLA EJECUTIVO
                
            LlenarGrillaEJE
            
        Case "SUC" 'TABLA SUCURSAL
                      
            LlenarGrillaSUC
                       
        Case "SS" 'Selecciona sucursal mediante formualrio Ejecutivo
            
            LlenarGrillaSS
            
        Case "EMISOR"
           Llena_Emisores 'Seleccion los emisores
            
        Case "EMISOR_BONOS_EXT"
           Llena_EmisoresBonosExt 'Seleccion los emisores
            
            
    '----------------------------------------------------------
    '---- CONTABILIDAD
   Case "CUENTAS", "PERFIL", "CAMPOS", "CONDICIONES", "SISTEMAS", "MONEDAS_CTBL"
      Call Carga_Tablas_Perfiles(parAyuda, parFiltro)
   Case "MDCL_B"
      Set objAyuda = New clsClientes
      Call objAyuda.LeerClientesBanco
      Call objAyuda.Coleccion2Control(lstNombre)
      Call mdcl_LlenaGrilla
   Case "MDCL"
      Set objAyuda = New clsClientes
      Call objAyuda.LeerClientes("", "N")
      Call objAyuda.Coleccion2Control(lstNombre)
      Call mdcl_LlenaGrilla
   Case "MDCL_SINACOFI"
      Set objAyuda = New clsClientes
      Call objAyuda.LeerClienteSinacofi("")
      Call objAyuda.Coleccion2Control(lstNombre)
      Call mdcl_LlenaGrilla
   Case "MDCL_U"
      Set objAyuda = New clsCliente
      If Not objAyuda.Ayuda("") Then
         Exit Sub
      End If
   Case "MDMN_U"
         Set objAyuda = New clsMoneda
          If Not objAyuda.Ayuda("") Then
             Exit Sub
          End If

   Case "MDFP_U"

     Set objAyuda = New clsForPago
      If Not objAyuda.CargaObjectos(BacAyuda.lstNombre) Then
         Screen.MousePointer = 0
        ' MsgBox "    No hay informacion para Ayuda   ", vbCritical, Msj

         Exit Sub
      End If


  Case "MDTC_TASASMERCADO"
         Set objAyuda = New clsCodigo
        If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_MTM) Then
            MsgBox "No es posible cargar informaci?n de Ayuda", vbExclamation, TITSISTEMA
            Exit Sub
        End If

  Case "MDTC_TASASMONEDAS"

          Set objAyuda = New clsCodigo
         If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_TASAS) Then
             MsgBox "No es posible cargar informaci?n de Ayuda", vbExclamation, TITSISTEMA
             Exit Sub
         End If

           '---- Elimina Tasa Fija
        If bacBuscarCombo(BacAyuda.lstNombre, "FIJA") <> 0 Then
           BacAyuda.lstNombre.RemoveItem bacBuscarCombo(BacAyuda.lstNombre, "FIJA")
           BacAyuda.txtNombre.Text = ""
        End If

    Case "PAIS"
        
        Set objAyuda = New clsCodigo
        If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_Pais) Then
            MsgBox "No hay informacion de Paises", vbInformation, TITSISTEMA
            Exit Sub
        End If



   Case "MDCLAPO"
            ' Set objAyuda = New clsClientes2
            ' Call objAyuda.LeerClientes("")
            ' Call MDCL_LlenaGrilla

    Case "MDCD"
           ' Set objAyuda = New clsDCarteras
           ' Call objAyuda.LeerDCarteras("")
           ' Call objAyuda.Coleccion2Control(Lstnombre)
           ' Call MDCD_LlenaGrilla

    Case "MDMN"
            Set objAyuda = New clsMonedas
            Call objAyuda.LeerMonedas
            Call objAyuda.Coleccion2Control(lstNombre)

        Case "BACUSER"
            'Set objAyuda = New ClsUsuarios
            'Call objAyuda.LeerUsuarios
            'Call objAyuda.ColeccionUControl(Lstnombre)

        Case "METB01"
            'Set objAyuda = New clsHelpges
            'Call objAyuda.leemoned("")
            'Call objAyuda.Coleccion2Control(Lstnombre)
            'Call MEVM_LlenaGrilla

        Case "MFMN"       '---- PENDIENTE sacar , es de BacForward
          '  Set objAyuda = New clsMonedas2
          '  objAyuda.LeerMonedas ("")
          '  Call objAyuda.Coleccion2Control(Lstnombre)

        Case "MDTC"                 '---- Tasas
         '  Set objAyuda = New clscodtabs
         '  If (objAyuda.LeerCodigos(MDTC_TASAS)) = True Then
         '     Call objAyuda.Coleccion2Control(Lstnombre)
         '  Else
         '     MsgBox " Problemas Lectura Sp  ", 16, "Bac-Parametros"
         '     Unload Me
         '     Screen.MousePointer = 0
         '     Exit Sub
         '  End If

        Case "MDTC_MTM"             '---- Tasas Mtm
           'Set objAyuda = New clscodtabs
           'If (objAyuda.LeerCodigos(MDTC_MTM)) = True Then
           'Call objAyuda.Coleccion2Control(Lstnombre)
           'Else
          '    MsgBox " Problemas Lectura Sp  ", 16, "Bac-Parametros"
          '    Unload Me
          '    Screen.MousePointer = 0
          '    Exit Sub
          ' End If



        Case "MDMN_PAIS"

           '    Set objAyuda = New clscodtabs
           '    If (objAyuda.LeerCodigos(MDTC_PAIS)) = True Then
           '        Call objAyuda.Coleccion2Control(Lstnombre)
           '    Else
           '       MsgBox " Problemas Lectura Sp  ", 16, "Bac-Parametros"
           '       Unload Me
            '      Screen.MousePointer = 0
            '      Exit Sub
            '   End If
        '******insertado 21/12/2000*********
        Case "EMISOR"
            Set objAyuda = New clsEmisores
            Call objAyuda.LeerEmisores("", "T")
            'Call objAyuda.Coleccion2Control(lstNombre)
            Call MDEM_LlenaGrilla
        
          Case "MDCT" 'Ayuda de categor?as
            Set objAyuda = New clsCategorias
            Call objAyuda.leeCategoria(0)
            Call objAyuda.Coleccion2Control(lstNombre)
            Call MDCT_LlenaGrilla
        '****************************
        Case "MDIN"
            Set objAyuda = New clsFamilias
            Call objAyuda.LeerFamilias
            Call objAyuda.Coleccion2Control(lstNombre)
            
        Case "MDSE"
           MDSE_LlenarGrilla
           
        Case "MDSETD"
           MDSETD_LlenarGrilla
           
        Case "TBCODIGOSOMA"
        
            idtipo = IIf(Val(aux) = 0, 15, 16)
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            Call MEVM_LlenaGrilla
            Me.Caption = Me.Caption & "    Codigos OMA"
            Me.Tag = aux & Me.Tag
            
        Case "TB_CODIGOSOMADELCORP"
        
            idtipo = 17
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            Call MEVM_LlenaGrilla
            Me.Caption = Me.Caption & "    Clasificaci?n OMA"
            Me.Tag = aux & Me.Tag
            
            
       Case "TBCODIGOSCOMERCIO"
            idtipo = IIf(Val(aux) = 0, 13, 14)
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            Call Codigos_Comercio
            Me.Caption = "C?digos de Comercio y Conceptos"
            Me.Tag = Me.Tag & aux


        Case "MECLA"
            idtipo = 4
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            'Call objAyuda.Coleccion2Control(Lstnombre)
            Call MEVM_LlenaGrilla
            Me.Caption = Me.Caption & "          Tabla de Glosas"
        
        '*******************************
        Case "MFMNME"
            Set objAyuda = New clsMonedas
            objAyuda.LeerMonedas
            Call objAyuda.Coleccion2Control2(2, lstNombre)
            
        Case "MDEM"
           Set objAyuda = New clsEmisores
           Call objAyuda.LeerEmisores("", "T")
           Call objAyuda.Coleccion2Control(lstNombre)
            
        Case "RIESGO"
            Set objAyuda = New clsEmisores
            Call objAyuda.LeerEmisores("", "T")
            Call llena_Riesgo
            
        Case "FERIADOS"
            Set objAyuda = New clscodtabs
            Call Llena_Feriados
            
            
        Case Else               '---- Carga otros
            Call Carga(Me.Tag)
        
    '' willl
    
        
    End Select
   

    Screen.MousePointer = vbDefault
    txtNombre.SetFocus

ErrorF:

End Sub



Private Sub Form_Unload(Cancel As Integer)
        
    Set objAyuda = Nothing
        

End Sub

Private Sub lstNombre_Click()
   If BacAyuda.Tag = "CURVAS" Or BacAyuda.Tag = "CLAUSULA_DINAMICA" Then
      Exit Sub
   End If
   
   If Sw <> 1 Then
      If "GEN_TABLAS1" = BacAyuda.parAyuda Then
         txtNombre.Text = lstNombre
      Else
         txtNombre.Text = Trim(Mid$(lstNombre, 1, 20))
      End If
   End If
End Sub

Private Sub lstNombre_DblClick()
   If BacAyuda.Tag = "CURVAS" Then
      txtNombre.Text = lstNombre.List(lstNombre.ListIndex)
   End If
   
   Call Botones_ButtonClick(Botones.Buttons(1))

End Sub

Private Sub lstNombre_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 27 Then
         Call Botones_ButtonClick(Botones.Buttons(2))
    End If
    
    If KeyAscii = 13 Then
        Call Botones_ButtonClick(Botones.Buttons(1))
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
            txtNombre.Text = ""
            Sw = 1
            txtNombre.Text = UCase(Chr(KeyAscii))
            If Len(txtNombre.Text) = 1 Then
               txtNombre.SelStart = 1
            End If
            
            On Error GoTo fin
            txtNombre.SetFocus
      
    End If
fin:
End Sub

Private Sub TxtNombre_Change()

   On Error GoTo ErrorF:

   Dim SUPERSW          As Boolean
   Dim aux              As String
   Dim nPos             As Long
   Dim sText            As String
   Dim n                As Long
   Dim codTipo          As Integer
   Dim Datos()

   nPos = -1

   If txtNombre.Text <> "" Then
      For n = 0 To lstNombre.ListCount - 1
         If Mid(lstNombre.List(n), Len(txtNombre.Text), 1) <> "" Then
            If Mid$(Trim(lstNombre.List(n)), 1, Len(txtNombre.Text)) = txtNombre.Text Then 'Or Mid$(lstNombre.List(n), 14, Len(txtNombre.Text)) = txtNombre.Text Then
               nPos = n
               Exit For
            End If
         End If
      Next n
   End If

   If nPos > -1 Then
      Sw = 1
      lstNombre.ListIndex = nPos
   End If

   If Me.Tag = "CLAUSULA_DINAMICA" And nPos = -1 Then
      For n = 0 To lstNombre.ListCount - 1
         If Mid(lstNombre.List(n), Len(txtNombre.Text), 1) <> "" Then
            If Mid$(Trim(lstNombre.List(n)), 11, Len(txtNombre.Text)) = txtNombre.Text Then
               nPos = n
               Exit For
            End If
         End If
      Next n
      
      If nPos > -1 Then
         Sw = 1
         lstNombre.ListIndex = nPos
      End If
   
   End If

   If nPos = -1 Then
      If Me.Tag = "CURVAS" Or Me.Tag = "CLAUSULA_DINAMICA" Then
         Exit Sub
      End If
      
      
      lstNombre.Clear
      
      BacControlWindows 12
      Screen.MousePointer = 11
      
      If Me.Tag = "PaisMntLocalidades" Or Me.Tag = "RegionMntLocalidades" Or Me.Tag = "CiudadMntLocalidades" Or Me.Tag = "ComunaMntLocalidades" Or Me.Tag = "RegionMntLocalidades1" Or Me.Tag = "CiudadMntLocalidades1" Or Me.Tag = "ComunaMntLocalidades1" Or Me.Tag = "PlazaMntLocalidades" Then
         SUPERSW = False

         Sql = ""

         Select Case Me.Tag
         Case "PaisMntLocalidades"
            Sql = "SP_MOSTRAR_PAIS"
            SUPERSW = True

         Case "RegionMntLocalidades"
            Sql = "SP_MOSTRAR_REGION"

         Case "RegionMntLocalidades1"
            Sql = "SP_MOSTRAR_REGION " & PARAMETRO1

         Case "CiudadMntLocalidades"
            Sql = "SP_MOSTRAR_CIUDAD" '& PARAMETRO1

         Case "CiudadMntLocalidades1"
            Sql = "SP_MOSTRAR_CIUDAD " & PARAMETRO1

         Case "ComunaMntLocalidades"
            Sql = "SP_MOSTRAR_COMUNA"

         Case "ComunaMntLocalidades1"
            Sql = "SP_MOSTRAR_COMUNA " & PARAMETRO1

         Case "PlazaMntLocalidades"
            Sql = "SP_MOSTRAR_PLAZA"

         End Select

         If Not Bac_Sql_Execute(Sql) Then
            Screen.MousePointer = 0
            Unload Me
            Exit Sub


         End If

         Do While Bac_SQL_Fetch(Datos())
            If SUPERSW = True Then
               lstNombre.AddItem UCase(Datos(2)) & Space(100) & Datos(1)

            Else
               lstNombre.AddItem UCase(Datos(3)) & Space(100) & Datos(1)

            End If

         Loop

         Screen.MousePointer = 0
         Exit Sub

      End If

      If Me.Tag = "CIUDADESMntLocalidades" Then
         If Not Bac_Sql_Execute("SP_BUSCA_PAISES") Then
            Exit Sub

         End If

         Do While Bac_SQL_Fetch(Datos())
            lstNombre.AddItem UCase(Datos(2)) & Space(100) & Datos(1)

         Loop

      End If


      aux = ""
      Me.Tag = UCase(Trim(Me.Tag))

      If InStr(Me.Tag, "TBCODIGOSCOMERCIO") > 0 Then
         If Val(Right(Me.Tag, 4)) > 0 Then
            aux = Right(Me.Tag, 3)
            gsCodigo = aux
            gsDigito = Val(Left(Right(Me.Tag, 4), 1))

         End If

         Me.Tag = "TBCODIGOSCOMERCIO"

      ElseIf InStr(Me.Tag, "TBCODIGOSOMA") > 0 Then
         aux = IIf(Val(Left(Me.Tag, 1)) > 0, Left(Me.Tag, 1), "")
         Me.Tag = "TBCODIGOSOMA"

      End If

      'Caso de Clientes por Tipo - PRD-6066
      If Mid$(Me.Tag, 1, 8) = "CLIXTIPO" Then
            codTipo = CInt(Mid$(Me.Tag, 9))
            Set objAyuda = New clsClientes
            Call objAyuda.LeerClientesPorTipo(codTipo, Trim(TxtNombre.Text), 50)
            Call objAyuda.Coleccion2Control(Lstnombre)
            Call mdcl_LlenaGrilla
            Screen.MousePointer = 0
            TxtNombre.SetFocus
            Exit Sub
      End If

      Select Case UCase(Trim$(Me.Tag))
      '----------------------------------------------------------
      '----------- CAMBIOS REALIZADOS 01--06-2001
      '----------- Busca los daotos
      '----------- Listo
      Case "EJE" 'TABLA EJECUTIVO
         LlenarGrillaEJE

      Case "SUC" 'TABLA SUCURSAL
         LlenarGrillaSUC

      Case "SS" 'Selecciona sucursal mediante formualrio Ejecutivo
         LlenarGrillaSS

      '----------------------------------------------------------
      '---- CONTABILIDAD
      Case "CUENTAS", "PERFIL", "CAMPOS", "CONDICIONES", "SISTEMAS"
         Call Carga_Tablas_Perfiles(parAyuda, parFiltro)

      Case "MDCL"
         Set objAyuda = New clsClientes
         Call objAyuda.LeerClientes(txtNombre.Text, "N")
         Call objAyuda.Coleccion2Control(lstNombre)
         Call mdcl_LlenaGrilla

      Case "MDCL_U"
         Set objAyuda = New clsCliente

         If Not objAyuda.Ayuda("") Then
            Exit Sub

         End If

      Case "MDMN_U"
         Set objAyuda = New clsMoneda

         If Not objAyuda.Ayuda("") Then
            Exit Sub

         End If

      Case "MDFP_U"
         Set objAyuda = New clsForPago

         If Not objAyuda.CargaObjectos(BacAyuda.lstNombre) Then
            Screen.MousePointer = 0
            Exit Sub

         End If

      Case "MDTC_TASASMERCADO"
         Set objAyuda = New clsCodigo

         If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_MTM) Then
            MsgBox "No es posible cargar informaci?n de Ayuda", vbExclamation, TITSISTEMA
            Exit Sub

         End If

      Case "MDTC_TASASMONEDAS"
         Set objAyuda = New clsCodigo

         If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_TASAS) Then
            MsgBox "No es posible cargar informaci?n de Ayuda", vbExclamation, TITSISTEMA
            Exit Sub

         End If

         '---- Elimina Tasa Fija
         If bacBuscarCombo(BacAyuda.lstNombre, "FIJA") >= 0 Then
            BacAyuda.lstNombre.RemoveItem bacBuscarCombo(BacAyuda.lstNombre, "FIJA")
            BacAyuda.txtNombre.Text = ""

         End If

      Case "PAIS"
         Set objAyuda = New clsCodigo

         If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_Pais) Then
            MsgBox "No hay informacion de Paises", vbInformation, TITSISTEMA
            Exit Sub

         End If

      Case "MDMN"
         Set objAyuda = New clsMonedas
         Call objAyuda.LeerMonedas
         Call objAyuda.Coleccion2Control(lstNombre)

      Case "EMISOR"
         Set objAyuda = New clsEmisores
         Call objAyuda.LeerEmisores(txtNombre.Text, "T")
         Call MDEM_LlenaGrilla

      Case "EMISOR_BONOS_EXT"
           Llena_EmisoresBonosExt 'Seleccion los emisores





      Case "MDCT" 'Ayuda de categor?as
         Set objAyuda = New clsCategorias
         Call objAyuda.leeCategoria(0)
         Call objAyuda.Coleccion2Control(lstNombre)
         Call MDCT_LlenaGrilla

      '****************************
      Case "MDIN"
         Set objAyuda = New clsFamilias
         Call objAyuda.LeerFamilias
         Call objAyuda.Coleccion2Control(lstNombre)

      Case "MDSE"
         MDSE_LlenarGrilla

      Case "MDSETD"
         MDSETD_LlenarGrilla

      Case "TBCODIGOSOMA"
         idtipo = IIf(Val(aux) = 0, 15, 16)
         Set objAyuda = New clsHelpges
         Call objAyuda.leemonedcambio("")
         Call MEVM_LlenaGrilla
         If Not (Me.Caption Like "*Codigos OMA") Then
            Me.Caption = Me.Caption & "    Codigos OMA"
         End If
         Me.Tag = aux & Me.Tag
         
      Case "TB_CODIGOSOMADELCORP"
            idtipo = 17
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            Call MEVM_LlenaGrilla
            If Not (Me.Caption Like "*Clasificaci?n OMA") Then
               Me.Caption = Me.Caption & "    Clasificaci?n OMA"
            End If
            Me.Tag = aux & Me.Tag
           

      Case "TBCODIGOSCOMERCIO"
'         idtipo = IIf(Val(aux) = 0, 13, 14)
'         Set objAyuda = New clsHelpges
'         Call objAyuda.leemonedcambio("")
'         Call MEVM_LlenaGrilla
'         Me.Caption = "C?digos de Comercio y Conceptos"
'         Me.Tag = Me.Tag & aux

            idtipo = IIf(Val(aux) = 0, 13, 14)
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            Call Codigos_Comercio
            Me.Caption = "C?digos de Comercio y Conceptos"
            Me.Tag = Me.Tag & aux
            
      Case "MECLA"
         idtipo = 4
         Set objAyuda = New clsHelpges
         Call objAyuda.leemonedcambio("")
         Call objAyuda.Coleccion2Control(lstNombre)
         Call MEVM_LlenaGrilla
         If Not (Me.Caption Like "*Tabla de Glosas") Then
            Me.Caption = Me.Caption & "          Tabla de Glosas"
         End If
      '*******************************
      Case "MFMNME"
         Set objAyuda = New clsMonedas
         objAyuda.LeerMonedas
         Call objAyuda.Coleccion2Control2(2, lstNombre)
         
      Case "MDEM"
      
      
      Set objAyuda = New clsEmisores
      Call objAyuda.LeerEmisores("", "T")
     Call objAyuda.Coleccion2Control(lstNombre)
         
         
         
         Case Else               '---- Carga otros
         Call Carga(Me.Tag)

      End Select

      Screen.MousePointer = 0

      txtNombre.SetFocus

   End If

   On Error GoTo 0

   Exit Sub
 
ErrorF:
   On Error GoTo 0

End Sub

Private Sub txtNombre_GotFocus()
'    Sw = 1
'    If Len(txtNombre.Text) > 45 Then
'        txtNombre.Text = ""
'    End If
'    txtNombre.SelStart = Len(txtNombre.Text)
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
   If KeyAscii = 27 Then
         Call Botones_ButtonClick(Botones.Buttons(2))
    End If
    
   If KeyAscii% = vbKeyReturn Then
            Call Botones_ButtonClick(Botones.Buttons(1))
          
    Else
      KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))

   End If
   
   If KeyAscii = 8 Then
      If Len(txtNombre.Text) = 1 And lstNombre.ListCount > 0 Then
            lstNombre.ListIndex = 0
      End If
   End If

End Sub

Private Sub TxtNombre_KeyUp(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDown Or KeyCode = vbKeyUp Then
        lstNombre.SetFocus
    End If

End Sub

Private Sub txtNombre_LostFocus()
    Sw = 0
End Sub

Public Function BuscaListIndex(Combo As Object, BUSCA As String) As Integer

'Tiene que verificar en todo el list para encontrar
'el indice que pertenece a la Opcion seleccionada ''blas
'======================================================
 
 Dim Lin As Integer
 
 BuscaListIndex = 0              ' Nada en el ComboList
 
  With Combo

    linea = lstNombre.ListIndex
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

Sub Carga_Tablas_Perfiles(pareSTipo_ayuda As String, pareSTipo_filtro As String)
    Dim Datos()
    Dim Comando As String
    Dim Paso As String
    Dim i As Integer
    Dim Largo_Codigo As Integer
    Dim Numero_Campos As Integer
    Dim Glosa As String * 40

    Screen.MousePointer = vbHourglass

    Envia = Array(pareSTipo_ayuda, pareSTipo_filtro)

    Select Case UCase(pareSTipo_ayuda)
    Case "CON_MON_CUENTAS"
        Numero_Campos = 2
        Largo_Codigo = 11
        
    Case CON_MON_CUENTAS
        Numero_Campos = 1
        Largo_Codigo = 5
        
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
        
    Case "BAC_CNT_SISTEMAS"
        Numero_Campos = 1
        Largo_Codigo = 3
        
    Case "BAC_CNT_CAMPOS"
        Numero_Campos = 2
        Largo_Codigo = 3
    Case "CON_PLAN_CUENTAS"
        Numero_Campos = 2
        Largo_Codigo = 16
        
    End Select

    If Bac_Sql_Execute("sp_consulta_tablas ", Envia) Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            If parAyuda = "BAC_CNT_SISTEMAS" Then
                
                Paso = Datos(2) & Space(Abs(Largo_Codigo - Len(Datos(2)))) & " " & Datos(1)
            
            ElseIf pareSTipo_ayuda = "BAC_CNT_PERFIL" Then
            
                Glosa = Datos(2)
                Paso = Datos(1) & Space(10) & Glosa
                
            ElseIf pareSTipo_ayuda = "CON_MON_CUENTAS" Then
                Glosa = Datos(1)
                Paso = Glosa
                
            ElseIf pareSTipo_ayuda = "CON_PLAN_CUENTAS" Then
                Glosa = Trim(Datos(2))
                Paso = Glosa & Space(10) & Space(Largo_Codigo - Len(Trim(Datos(1)))) + Datos(1)
                
            Else
                Glosa = Datos(2)
                Paso = Glosa & Space(10) & Datos(1)
            End If
              
            For i = 2 To Numero_Campos
                  If pareSTipo_ayuda = "BAC_CNT_PERFIL" And i% = 2 Then
                    Paso = Paso + " " & Space(60) & Val(Datos(i%))
                  End If
            
            Next i%
          
            lstNombre.AddItem Paso
       Loop
    
    End If

    Screen.MousePointer = vbDefault
    
End Sub

Private Sub mdcl_LlenaGrilla()

Dim Filas   As Long
Dim idRut   As String * 12
Dim IdGlosa As String * 20 '40
Dim IDCodigo As String * 5
 
Dim Max     As Long
          
    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
    For Filas = 1 To Max
        idRut = objAyuda.coleccion(Filas).clrut & "-" & objAyuda.coleccion(Filas).cldv
        IdGlosa = UCase(objAyuda.coleccion(Filas).clnombre)
        IDCodigo = objAyuda.coleccion(Filas).clcodigo
        lstNombre.AddItem IdGlosa & Space(3) & idRut & Space(3) & IDCodigo
        lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).clrut
    Next Filas

End Sub

Private Sub MDCT_LlenaGrilla()

Dim Filas       As Long
Dim IDCodigo    As Integer
Dim IdGlosa     As String * 25
Dim Max         As Long
          
    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
 For Filas = 1 To Max
  IdGlosa = objAyuda.coleccion(Filas).Descri
  IDCodigo = objAyuda.coleccion(Filas).Codigo
   
   lstNombre.AddItem IdGlosa & Space(3) & IDCodigo
   lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).Codigo
 Next Filas

End Sub

Private Sub MDEM_LlenaGrilla()

Dim Filas   As Long
Dim idRut   As String * 11
Dim IdGlosa As String * 25 '40
Dim Max     As Long
          
    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    'aqui
    For Filas = 1 To Max
        idRut = objAyuda.coleccion(Filas).emrut & "-" & objAyuda.coleccion(Filas).emdv
        IdGlosa = objAyuda.coleccion(Filas).emnombre
        IDCodigo = objAyuda.coleccion(Filas).emcodigo
        lstNombre.AddItem IdGlosa & Space(3) & idRut '& Space(40) & Trim(IDCodigo)
        lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).emrut
    Next Filas
 
End Sub

Private Sub MDSE_LlenarGrilla()

Dim Sql As String
Dim Datos()
Sql = ""

'BacMntSe.xincodigo = 20
'Sql = "execute sp_lee_mascara_series " & BacMntSe.xincodigo

Envia = Array(CDbl(BacMntSe.xincodigo))

If Not Bac_Sql_Execute("sp_lee_mascara_series", Envia) Then
    
    Exit Sub

End If
  
Do While Bac_SQL_Fetch(Datos())
    
    lstNombre.AddItem Trim(Datos(2)) & Space(15 + (15 - Len(Datos(2)))) & Val(Datos(1))
'   lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(2))

Loop

End Sub

Private Sub MEVM_LlenaGrilla()
Dim Filas       As Long
Dim IdGlosa     As String * 50 '20
Dim idorden     As String * 40
Dim Max         As Long
         
lstNombre.Clear
    
Max = objAyuda.coleccion.Count
    
 For Filas = 1 To Max
  IdGlosa = objAyuda.coleccion(Filas).codescri
  idorden = objAyuda.coleccion(Filas).CodOrden
   lstNombre.AddItem IdGlosa & Space(3) & idorden
   lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).CodMovch
 Next Filas

End Sub

Private Sub Codigos_Comercio()
Dim Filas       As Long
Dim Idcodi      As String * 6
Dim IdConc      As String * 3
Dim IdGlosa     As String * 40

Dim Max         As Long
         
lstNombre.Clear
    
Max = objAyuda.coleccion.Count
    
 For Filas = 1 To Max
  Idcodi = objAyuda.coleccion(Filas).codmov
  IdConc = objAyuda.coleccion(Filas).CodCta
  IdGlosa = objAyuda.coleccion(Filas).codescri
  lstNombre.AddItem Idcodi & Space(2) & IdGlosa
  lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).CodMovch
 Next Filas

End Sub

Sub CargaPeriodos()
    Dim iMouse%
    
   lstNombre.Clear

   Sql = "SELECT Codigo , Glosa , Dias FROM PERIODO_AMORTIZACION WHERE Sistema = 'PCS' AND tabla = '1044' ORDER BY Codigo "
   If MISQL.SQL_Execute(Sql) <> 0 Then
      MsgBox "No se pudo realizar Consulta de Datos", vbInformation + vbOKOnly, TITSISTEMA
   End If
   Do While MISQL.SQL_Fetch(Datos()) = 0
      lstNombre.AddItem Datos(2) & Space(100) & Datos(3)
      lstNombre.ItemData(lstNombre.NewIndex) = Datos(1)
   Loop
   If lstNombre.ListCount >= 0 Then
      lstNombre.ListIndex = 0
   End If
End Sub

Sub Carga(sTabla$)
Dim iMouse%

   If sTabla$ = UCase("Periodos") Then
      Call CargaPeriodos
      Exit Sub
   End If
   
    iMouse = Me.MousePointer
    Me.MousePointer = 11

    lstNombre.Clear
    
    '---- Definici?n de Carga para Listas
    Sql = "SELECT tbcodigo1,tbglosa FROM Tabla_General_Detalle "
    Select Case sTabla
    Case Else
        MsgBox "No se ha definido Ayuda para Consultar de Datos", vbInformation + vbOKOnly, TITSISTEMA
        GoTo fin
        
    End Select
    
    '---- Carga de Lista
    If MISQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "No se pudo realizar Consulta de Datos", vbInformation + vbOKOnly, TITSISTEMA
        GoTo fin
    End If
    
    Do While MISQL.SQL_Fetch(Datos()) = 0
        lstNombre.AddItem Left(Datos(2) & Space(60), 60) & Left(Datos(3) + Space(3), 3) & IIf(UBound(Datos()) >= 4, Datos(4), "")
        lstNombre.ItemData(lstNombre.NewIndex) = Datos(1)
    Loop
    
    If lstNombre.ListCount >= 0 Then
        lstNombre.ListIndex = 0
    End If

fin:
    Me.MousePointer = iMouse

End Sub

Private Sub LlenarGrillaEJE()
Dim eLargo As Double

    Bac_Sql_Execute ("sp_trae_todos_ejecutivo")
              
    Do While Bac_SQL_Fetch(Datos())
           
       eLargo = 30 - Len(Datos(2))
       If eLargo = 0 Then
        lstNombre.AddItem Datos(2) & Space(3) & UCase(Datos(1))
       Else
        lstNombre.AddItem Datos(2) & Space(eLargo + 3) & UCase(Datos(1))
       End If
                            
    Loop
    
End Sub
Private Sub LlenarGrillaSUC()
Dim sLargo As Double
Bac_Sql_Execute ("Sp_Trae_Todos_Sucursal")
 
    Do While Bac_SQL_Fetch(Datos())
             sLargo = 30 - Len(Datos(2))
       If sLargo = 0 Then
        lstNombre.AddItem Datos(2) & Space(3) & UCase(Datos(1))
       Else
        lstNombre.AddItem Datos(2) & Space(sLargo + 3) & UCase(Datos(1))
       End If
                                          
    Loop
End Sub
Private Sub LlenarGrillaSS()
Dim ssLargo As Double
Bac_Sql_Execute ("Sp_Trae_Todos_Sucursal")
Do While Bac_SQL_Fetch(Datos())
      ssLargo = 30 - Len(Datos(2))
       If ssLargo = 0 Then
        lstNombre.AddItem Datos(2) & Space(3) & UCase(Datos(1))
       Else
        lstNombre.AddItem Datos(2) & Space(ssLargo + 3) & UCase(Datos(1))
       End If
Loop
            
End Sub

