VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacAyuda3 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   " Ayuda  de  BacParametros"
   ClientHeight    =   5100
   ClientLeft      =   480
   ClientTop       =   2190
   ClientWidth     =   5655
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacayuda.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5100
   ScaleWidth      =   5655
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   4605
      Left            =   0
      TabIndex        =   1
      Top             =   495
      Width           =   5640
      _Version        =   65536
      _ExtentX        =   9948
      _ExtentY        =   8123
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ListBox Lstnombre 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00400000&
         Height          =   3180
         Left            =   330
         TabIndex        =   3
         Top             =   930
         Width           =   4995
      End
      Begin VB.Frame Frame1 
         Height          =   690
         Left            =   180
         TabIndex        =   2
         Top             =   30
         Width           =   5295
         Begin VB.Label lblnombre 
            BackColor       =   &H80000009&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00400000&
            Height          =   290
            Left            =   150
            TabIndex        =   5
            Top             =   210
            Width           =   5010
         End
      End
      Begin VB.Frame Frame2 
         Height          =   3570
         Left            =   180
         TabIndex        =   4
         Top             =   720
         Width           =   5310
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2745
      Top             =   45
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
            Picture         =   "Bacayuda.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacayuda.frx":075E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5640
      _ExtentX        =   9948
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacAyuda3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim sPatron$
Dim Sql$
Dim DATOS()
Public Mascara      As String

Private objAyuda As Object
Public parAyuda  As String    ' Ayuda de perfiles
Public parFiltro As String    ' Ayuda de Perfiles
'Public idtipo    As Integer      '-- Indica ID tipo de Ayuda a desplegar
Public codigo    As Long
Public glosa     As String
'INSERTADO
Private Sub MDSE_LlenarGrilla()

Dim Sql As String
Dim DATOS()
Sql = ""

'BacMntSe.xincodigo = 20
'Sql = "execute sp_lee_mascara_series " & BacMntSe.xincodigo

Envia = Array(CDbl(BacMntSe.xincodigo))

If Not Bac_Sql_Execute("sp_lee_mascara_series", Envia) Then
    
    Exit Sub

End If
  
Do While Bac_SQL_Fetch(DATOS())
    
    lstNombre.AddItem Trim(DATOS(2)) & Space(15 + (15 - Len(DATOS(2)))) & Val(DATOS(1))
'   lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(2))

Loop

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


Private Sub MDCIUCIU_LlenarGrilla(cod_Pais As String)

Dim Sql As String
Dim DATOS()
Sql = ""
Sql = "execute leerciu "
Sql = Sql & Val(cod_Pais)
If MISQL.SQL_Execute(Sql) <> 0 Then
    Exit Sub
End If
  
Do While MISQL.SQL_Fetch(DATOS()) = 0
    lstNombre.AddItem Trim(DATOS(1)) & Space(20 + (20 - Len(DATOS(1)))) & Val(DATOS(2))
   lstNombre.ItemData(lstNombre.NewIndex) = Val(DATOS(2))
Loop

End Sub

Private Sub MDCIUCOM_LlenarGrillA(cod_Pais As String, cod_Ciudad As String)

Dim Sql As String
Dim DATOS()

'''''''''Sql = ""
'''''''''Sql = "execute sp_leercom "
'''''''''Sql = Sql & Val(cod_Pais) & "," & Val(cod_Ciudad)

Envia = Array(CDbl(cod_Pais), CDbl(cod_Ciudad))

If Not Bac_Sql_Execute("execute sp_leercom ", Envia) Then
   
  Exit Sub

End If
  
Do While Bac_SQL_Fetch(DATOS())
   
   lstNombre.AddItem DATOS(2) + Space(30 - Len(DATOS(2))) + Trim(Str(Val(DATOS(1))))
   lstNombre.ItemData(lstNombre.NewIndex) = Val(DATOS(2))
   
Loop


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
  IDCodigo = objAyuda.coleccion(Filas).codigo
   
   lstNombre.AddItem IdGlosa & Space(3) & IDCodigo
   lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).codigo
 Next Filas

End Sub
Private Function HelpLeerApoderados(IdNombre As String)

Dim Filas       As Long
Dim idRut       As String * 10
Dim IdGlosa     As String * 20 '40
Dim IDCodigo    As String * 5
Dim Max         As Long
Dim IdRow       As Integer
Dim varvData()
Dim varssql As String
    'LeerClientes = False
''''''''''''    varssql = ""
''''''''''''    varssql = "EXECUTE sp_apleernombres1 '" & IdNombre & "'"
          
    Envia = Array(IdNombre)
          
    If Not Bac_Sql_Execute("sp_apleernombres1", Envia) Then
       
       Exit Function
    
    End If
    
    lstNombre.Clear
    
    Do While Bac_SQL_Fetch(varvData())
            
        idRut = CDbl(varvData(1)) & "-" & varvData(2)
        IdGlosa = varvData(4)
        IDCodigo = CDbl(varvData(2))
        lstNombre.AddItem IdGlosa & Space(3) & idRut & Space(50) & IDCodigo
        lstNombre.ItemData(lstNombre.NewIndex) = varvData(1)
    Loop
    

End Function
 
Private Sub MDCD_LlenaGrilla()

Dim Filas   As Long
Dim idRut   As String * 11
Dim IdGlosa As String * 25 '40
Dim Max     As Long
          
    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
    For Filas = 1 To Max
        idRut = objAyuda.coleccion(Filas).rcrut & "-" & objAyuda.coleccion(Filas).rcdv
        IdGlosa = objAyuda.coleccion(Filas).rcnombre
        lstNombre.AddItem IdGlosa & Space(3) & idRut
        lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).rcrut
    Next Filas

End Sub
Private Sub MDEM_LlenaGrilla()

Dim Filas   As Long
Dim idRut   As String * 11
Dim IdGlosa As String * 25 '40
Dim Max     As Long
          
    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
    For Filas = 1 To Max
        idRut = objAyuda.coleccion(Filas).emrut & "-" & objAyuda.coleccion(Filas).emdv
        IdGlosa = objAyuda.coleccion(Filas).emnombre
        lstNombre.AddItem IdGlosa & Space(3) & idRut
        lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).emrut
    Next Filas
 
End Sub

Sub Carga(sTabla$)
Dim iMouse%

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
    
    Do While MISQL.SQL_Fetch(DATOS()) = 0
        lstNombre.AddItem Left(DATOS(2) & Space(60), 60) & Left(DATOS(3) + Space(3), 3) & IIf(UBound(DATOS()) >= 4, DATOS(4), "")
        lstNombre.ItemData(lstNombre.NewIndex) = DATOS(1)
    Loop
    
    If lstNombre.ListCount >= 0 Then
        lstNombre.ListIndex = 0
    End If

fin:
    Me.MousePointer = iMouse

End Sub

Sub Carga_Tablas_Perfiles(pareSTipo_ayuda As String, pareSTipo_filtro As String)
Dim DATOS()
Dim Comando As String
Dim Paso As String
Dim i As Integer
Dim Largo_Codigo As Integer
Dim Numero_Campos As Integer

    Screen.MousePointer = 11

    'Comando = "EXECUTE sp_consulta_tablas '" & pareSTipo_ayuda & "', '" & pareSTipo_filtro & "'"

    Envia = Array(pareSTipo_ayuda, pareSTipo_filtro)

    Select Case UCase(pareSTipo_ayuda)
    Case "CON_PLAN_CUENTAS"
        Numero_Campos = 2
        Largo_Codigo = 11
        
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
        
    End Select

    If Bac_Sql_Execute("sp_consulta_tablas ", Envia) Then
        
        Do While Bac_SQL_Fetch(DATOS())
            
            If parAyuda = "BAC_CNT_SISTEMAS" Then
                
                Paso = DATOS(2) & Space(Abs(Largo_Codigo - Len(DATOS(2)))) & " " & DATOS(1)
            
            Else
                
                Paso = IIf(Right(DATOS(1), gsc_PuntoDecim & "0") = 0, DATOS(1), Val(DATOS(1)))
                Paso = Right(Space(Largo_Codigo) & Paso, Largo_Codigo) & " "
            
            End If
              
            For i = 2 To Numero_Campos
                
                If pareSTipo_ayuda = "BAC_CNT_PERFIL" And i% = 3 Then
                    
                    Paso = Paso + " " & Space(60) & Val(DATOS(i%))
                
                Else
                    
                    Paso = Paso + " " + DATOS(i%)
                
                End If
            
            Next i%
          
            lstNombre.AddItem Paso
       Loop
    
    End If

    Screen.MousePointer = 0
    
End Sub
Private Sub MEVM_LlenaGrilla()
Dim Filas       As Long
Dim IDCodigo    As String
Dim idRut       As String * 11
Dim IdGlosa     As String * 30
Dim idorden     As String * 10
Dim idtipo1     As Long
Dim Max         As Long

          
    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
 For Filas = 1 To Max
  IdGlosa = objAyuda.coleccion(Filas).codescri
  IDCodigo = objAyuda.coleccion(Filas).codmov
   lstNombre.AddItem IdGlosa & Space(3) & IDCodigo
   lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).CodMovch
 Next Filas

End Sub


Private Sub mdcl_LlenaGrilla()

Dim Filas   As Long
Dim idRut   As String * 8
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

Private Sub cmdAceptar_Click()

Dim aux As String


Dim nPos&
Dim Indice%
Dim sLine$

    giAceptar% = False

    '-Si No tiene Elementos Listcount = 0 -'
    If Not lstNombre.ListCount > 0 Then
        GoTo fin
    End If

    If lstNombre.ListIndex < 0 Then
        Exit Sub
    End If

    '-Si tiene algun elemento-'
    Indice = BuscaListIndex(lstNombre, Trim$(lblnombre.Caption)) + 1

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

    Select Case UCase(Trim(Me.Tag))

    Case "MDCL_U":        '---- PENDIENTE
        sLine = Trim(Right(lstNombre.List(lstNombre.ListIndex), 11))
        gsCodigo = Left(sLine, Len(sLine) - 2)
        gsDigito = Right(sLine, 1)
        gsNombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 45))
        gsCodCli = CDbl(lstNombre.ItemData(lstNombre.ListIndex))

    Case "MDMN_U"
        sLine = lstNombre.List(lstNombre.ListIndex)
        gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
        gsNemo = Trim(Left(sLine, 5))
        gsGlosa = Trim(Mid(sLine, 6))

    Case "MDTC_U", "MDFP_U", "MDTC_TASASMERCADO", "MDTC_TASASMONEDAS", "PAIS"
        gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
        gsGlosa = lstNombre.List(lstNombre.ListIndex)

    Case "MDCLAPO"      'TABLA DE APODERADOS
      '  gsCodigo$ = objAyuda.coleccion(Indice).clrut
      '  gsDigito$ = objAyuda.coleccion(Indice).cldv
      '  gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
      '  gsFax$ = objAyuda.coleccion(Indice).clfax
      '  gsValor$ = objAyuda.coleccion(Indice).clcodigo
      '  gsCodCli$ = objAyuda.coleccion(Indice).clcodigo

    'Case "MDCL"      'TABLA DE CLIENTES
        'gsrut$ = objAyuda.coleccion(Indice).clrut
        'gsDigito$ = objAyuda.coleccion(Indice).cldv
        'gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
        'gsValor$ = objAyuda.coleccion(Indice).clcodigo
    '************************************************
    Case "MDCL" ', "MDCL_BCO"   'TABLA DE CLIENTES
    If clie <> "SINACOFI" Then
                    gsrut$ = objAyuda.coleccion(Indice).clrut
                    gsDigito$ = objAyuda.coleccion(Indice).cldv
                    gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
                    gsValor$ = objAyuda.coleccion(Indice).clcodigo
                    gsFax$ = objAyuda.coleccion(Indice).clfax
                    gsNombre$ = objAyuda.coleccion(Indice).cldirecc
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
                                     
         Else
                    gsCodigo$ = objAyuda.coleccion(Indice).clrut
                    gsDigito$ = objAyuda.coleccion(Indice).cldv
                    gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
                    gsFax$ = objAyuda.coleccion(Indice).clfax
                    gsCodCli = objAyuda.coleccion(Indice).clcodigo
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
        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa

    Case "MDTC_MTM"     '---- Tasas MTM
        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa

    '---- CONTABILIDAD
    Case "CUENTAS", "MOVIM"
        gsCodigo$ = Trim(Left(lstNombre.Text, 12))
        gsDescripcion$ = Trim(Mid$(lstNombre.Text, 14))

    Case "PERFIL"
        gsCodigo$ = Mid(lstNombre.Text, 1, 10)
        'gscodigo$ = Right(lstNombre.Text, 5)
        gsDescripcion$ = Mid$(lstNombre.Text, 12)

    Case "CAMPOS"
        gsCodigo$ = Val(Left(lstNombre.Text, 5))
        gsDescripcion$ = Mid$(lstNombre.Text, 6)

    Case "CONDICIONES"
        gsCodigo$ = Left(lstNombre.Text, 6)
        gsDescripcion$ = Trim(Mid$(lstNombre.Text, 7))

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

        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa
   
   Case "MDCT"      'TABLAS GENERALES
                gsCodigo$ = objAyuda.coleccion(Indice).codigo
                gsGlosa$ = objAyuda.coleccion(Indice).Descri
                
    Case "MDIN"      'TABLA DE FAMILIAS DE INSTRUMENTOS
                gsSerie$ = objAyuda.coleccion(Indice).inserie
                gsCodigo$ = objAyuda.coleccion(Indice).incodigo
                gsDescripcion$ = objAyuda.coleccion(Indice).inglosa
         
    Case "MDSE"
    'Dim Mascara As String
                glosa = Trim(Right(lstNombre.Text, 15))
                Mascara = Trim(Left(lstNombre.Text, 30))
                
                
    Case "TBCODIGOSOMA"
                idtipo = IIf(Val(aux) = 0, 15, 16)
                gsCodigo$ = objAyuda.coleccion(Indice).codmov
                gsDigito$ = Trim(Left(objAyuda.coleccion(Indice).CodCta, 2))
                gsValor$ = Left(Mid$(objAyuda.coleccion(Indice).CodCta & "0000000000", 3), 7)
                gsGlosa$ = objAyuda.coleccion(Indice).codescri
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
            
    '************************************************
    Case Else
        GoTo fin

 End Select

    giAceptar% = True

fin:
    Screen.MousePointer = 0
    Unload Me

End Sub
Private Sub cmdCancelar_Click()

    giAceptar% = False
    Unload Me
    
End Sub
 Private Sub Form_Activate()
 Dim DATOS()
 Dim aux As String
    
    lstNombre.Clear

    BacControlWindows 12

    Screen.MousePointer = 11
    
    If Me.Tag = "PaisMntLocalidades" _
        Or Me.Tag = "RegionMntLocalidades" _
        Or Me.Tag = "CiudadMntLocalidades" _
        Or Me.Tag = "ComunaMntLocalidades" _
        Or Me.Tag = "RegionMntLocalidades1" _
        Or Me.Tag = "CiudadMntLocalidades1" _
        Or Me.Tag = "ComunaMntLocalidades1" _
        Or Me.Tag = "PlazaMntLocalidades" Then
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
        End Select
        
        If Not Bac_Sql_Execute(Sql) Then
            
            Screen.MousePointer = 0
            Unload Me
            Exit Sub
        
        End If
    
        Do While Bac_SQL_Fetch(DATOS())
            
            If SUPERSW = True Then
                
                lstNombre.AddItem UCase(DATOS(2)) & Space(100) & DATOS(1)
            
            Else
                
                lstNombre.AddItem UCase(DATOS(3)) & Space(100) & DATOS(1)
            
            End If
            'obj.ItemData(obj.NewIndex) = Val(DATOS(2))
        
        Loop
        
        Screen.MousePointer = 0
        Exit Sub
    
    End If
    
    If Me.Tag = "CIUDADESMntLocalidades" Then
        
        If Not Bac_Sql_Execute("SP_BUSCA_PAISES") Then
            
            Exit Sub
        
        End If
    
        Do While Bac_SQL_Fetch(DATOS())
            
            lstNombre.AddItem UCase(DATOS(2)) & Space(100) & DATOS(1)
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

    '---- CONTABILIDAD

    Case "CUENTAS", "PERFIL", "CAMPOS", "CONDICIONES", "SISTEMAS"

        Call Carga_Tablas_Perfiles(parAyuda, parFiltro)
    Case "MDCL"
            Set objAyuda = New clsClientes
            Call objAyuda.LeerClientes("", "N")
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
        If bacBuscarCombo(BacAyuda.lstNombre, "FIJA") >= 0 Then
           BacAyuda.lstNombre.RemoveItem bacBuscarCombo(BacAyuda.lstNombre, "FIJA")
           BacAyuda.TxtNombre.Text = ""
        End If

    Case "PAIS"
        
        Set objAyuda = New clsCodigo
        If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_Pais) Then
            MsgBox "No hay informacion de Paises", vbInformation, TITSISTEMA
            Exit Sub
        End If


   Case "MDCL"

           ' Set objAyuda = New clsClientes
           ' Call objAyuda.LeerClientes("")
           ' Call objAyuda.Coleccion2Control(Lstnombre)
           ' Call MDCL_LlenaGrilla

            '==========================
            ' Apoderados y Operadores
            '==========================

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
        Case "MDEM"
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
           
           
        Case "TBCODIGOSOMA"
        
            idtipo = IIf(Val(aux) = 0, 15, 16)
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            Call MEVM_LlenaGrilla
            Me.Caption = Me.Caption & "    Codigos OMA"
            Me.Tag = aux & Me.Tag
            
            
       Case "TBCODIGOSCOMERCIO"
            idtipo = IIf(Val(aux) = 0, 13, 14)
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            Call MEVM_LlenaGrilla
            Me.Caption = "C?digos de Comercio y Conceptos"
            Me.Tag = Me.Tag & aux


        Case "MECLA"
            idtipo = 4
            Set objAyuda = New clsHelpges
            Call objAyuda.leemonedcambio("")
            Call objAyuda.Coleccion2Control(lstNombre)
            Call MEVM_LlenaGrilla
            Me.Caption = Me.Caption & "          Tabla de Glosas"

        '*******************************
        Case "MFMNME"
      Set objAyuda = New clsMonedas
      objAyuda.LeerMonedas
     Call objAyuda.Coleccion2Control2(2, lstNombre)
        Case Else               '---- Carga otros
            Call Carga(Me.Tag)

    End Select


    Screen.MousePointer = 0

     If lstNombre.ListCount <> 0 Then
          lstNombre.ListIndex = 0
    End If


End Sub

Private Sub Form_Unload(Cancel As Integer)
        
    Set objAyuda = Nothing
        
End Sub


Private Sub LblNombre_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub lstNombre_Click()
    lblnombre.Caption = "  " & Trim$(lstNombre.List(lstNombre.ListIndex))
End Sub

Private Sub lstNombre_DblClick()
    
  'Call cmdAceptar_Click
   'Devolver_Ayuda
   Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))
End Sub

Private Sub Lstnombre_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    'Call cmdAceptar_Click
    Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))
End If
End Sub

Private Sub lstNombre_KeyPress(KeyAscii As Integer)
lblnombre.Caption = "  " & Trim$(lstNombre.List(lstNombre.ListIndex))
End Sub

Private Sub Lstnombre_KeyUp(KeyCode As Integer, Shift As Integer)
'Dim Fila As Integer
'
'    With Lstnombre
'
'        If Not .ListCount > 0 Then  ' Si No tiene Elementos
'            Exit Sub
'        End If
'
'        For Fila = 0 To .ListCount - 1
'            If UCase(Left(Lstnombre.List(Fila), 1)) = UCase(Chr(KeyCode)) Then
'                Lstnombre.ListIndex = Fila
'                Exit For
'            End If
'        Next Fila
'
'    End With
'
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
    Case 1
        
        Dim aux As String
        Dim nPos&
        Dim Indice%
        Dim sLine$

    giAceptar% = False
    
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
    Indice = BuscaListIndex(lstNombre, Trim$(lblnombre.Caption)) + 1

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

    Select Case UCase(Trim(Me.Tag))

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
        
    Case "MDMN_U"
        sLine = lstNombre.List(lstNombre.ListIndex)
        gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
        gsNemo = Trim(Left(sLine, 5))
        gsGlosa = Trim(Mid(sLine, 6))

    Case "MDTC_U", "MDFP_U", "MDTC_TASASMERCADO", "MDTC_TASASMONEDAS", "PAIS"
        gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
        gsGlosa = lstNombre.List(lstNombre.ListIndex)

    Case "MDCLAPO"      'TABLA DE APODERADOS
      '  gsCodigo$ = objAyuda.coleccion(Indice).clrut
      '  gsDigito$ = objAyuda.coleccion(Indice).cldv
      '  gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
      '  gsFax$ = objAyuda.coleccion(Indice).clfax
      '  gsValor$ = objAyuda.coleccion(Indice).clcodigo
      '  gsCodCli$ = objAyuda.coleccion(Indice).clcodigo

    'Case "MDCL"      'TABLA DE CLIENTES
        'gsrut$ = objAyuda.coleccion(Indice).clrut
        'gsDigito$ = objAyuda.coleccion(Indice).cldv
        'gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
        'gsValor$ = objAyuda.coleccion(Indice).clcodigo
    '************************************************
    Case "MDCL" ', "MDCL_BCO"   'TABLA DE CLIENTES
    If clie <> "SINACOFI" Then
                    gsrut$ = objAyuda.coleccion(Indice).clrut
                    gsDigito$ = objAyuda.coleccion(Indice).cldv
                    gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
                    gsValor$ = objAyuda.coleccion(Indice).clcodigo
                    gsFax$ = objAyuda.coleccion(Indice).clfax
                    gsNombre$ = objAyuda.coleccion(Indice).cldirecc
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
         Else
                    gsCodigo$ = objAyuda.coleccion(Indice).clrut
                    gsDigito$ = objAyuda.coleccion(Indice).cldv
                    gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
                    gsFax$ = objAyuda.coleccion(Indice).clfax
                    gsCodCli = objAyuda.coleccion(Indice).clcodigo
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
        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa

    Case "MDTC_MTM"     '---- Tasas MTM
        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa

    '---- CONTABILIDAD
    Case "CUENTAS", "MOVIM"
        gsCodigo$ = Trim(Left(lstNombre.Text, 12))
        gsDescripcion$ = Trim(Mid$(lstNombre.Text, 14))

    Case "PERFIL"
        gsCodigo$ = Mid(lstNombre.Text, 1, 10)
        'gscodigo$ = Right(lstNombre.Text, 5)
        gsDescripcion$ = Mid$(lstNombre.Text, 12)

    Case "CAMPOS"
        gsCodigo$ = Val(Left(lstNombre.Text, 5))
        gsDescripcion$ = Mid$(lstNombre.Text, 6)

    Case "CONDICIONES"
        gsCodigo$ = Left(lstNombre.Text, 6)
        gsDescripcion$ = Trim(Mid$(lstNombre.Text, 7))

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

        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa
   
   Case "MDCT"      'TABLAS GENERALES
                gsCodigo$ = objAyuda.coleccion(Indice).codigo
                gsGlosa$ = objAyuda.coleccion(Indice).Descri
                
    Case "MDIN"      'TABLA DE FAMILIAS DE INSTRUMENTOS
                gsSerie$ = objAyuda.coleccion(Indice).inserie
                gsCodigo$ = objAyuda.coleccion(Indice).incodigo
                gsDescripcion$ = objAyuda.coleccion(Indice).inglosa
         
    Case "MDSE"
    'Dim Mascara As String
                glosa = Trim(Right(lstNombre.Text, 15))
                Mascara = Trim(Left(lstNombre.Text, 30))
                
                
    Case "TBCODIGOSOMA"
                idtipo = IIf(Val(aux) = 0, 15, 16)
                gsCodigo$ = objAyuda.coleccion(Indice).codmov
                gsDigito$ = Trim(Left(objAyuda.coleccion(Indice).CodCta, 2))
                gsValor$ = Left(Mid$(objAyuda.coleccion(Indice).CodCta & "0000000000", 3), 7)
                gsGlosa$ = objAyuda.coleccion(Indice).codescri
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
            
    '************************************************
    Case Else
        GoTo fin

 End Select

    giAceptar% = True

fin:
    Screen.MousePointer = 0
    Unload Me

Case 2
    giAceptar% = False
    Unload Me

End Select
End Sub


Sub Devolver_Ayuda()
Dim aux As String


Dim nPos&
Dim Indice%
Dim sLine$

    giAceptar% = False

    '-Si No tiene Elementos Listcount = 0 -'
    If Not lstNombre.ListCount > 0 Then
        GoTo fin
    End If

    If lstNombre.ListIndex < 0 Then
        Exit Sub
    End If

    '-Si tiene algun elemento-'
    Indice = BuscaListIndex(lstNombre, Trim$(lblnombre.Caption)) + 1

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

    Select Case UCase(Trim(Me.Tag))

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
        
    Case "MDMN_U"
        sLine = lstNombre.List(lstNombre.ListIndex)
        gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
        gsNemo = Trim(Left(sLine, 5))
        gsGlosa = Trim(Mid(sLine, 6))

    Case "MDTC_U", "MDFP_U", "MDTC_TASASMERCADO", "MDTC_TASASMONEDAS", "PAIS"
        gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
        gsGlosa = lstNombre.List(lstNombre.ListIndex)

    Case "MDCLAPO"      'TABLA DE APODERADOS
      '  gsCodigo$ = objAyuda.coleccion(Indice).clrut
      '  gsDigito$ = objAyuda.coleccion(Indice).cldv
      '  gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
      '  gsFax$ = objAyuda.coleccion(Indice).clfax
      '  gsValor$ = objAyuda.coleccion(Indice).clcodigo
      '  gsCodCli$ = objAyuda.coleccion(Indice).clcodigo

    'Case "MDCL"      'TABLA DE CLIENTES
        'gsrut$ = objAyuda.coleccion(Indice).clrut
        'gsDigito$ = objAyuda.coleccion(Indice).cldv
        'gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
        'gsValor$ = objAyuda.coleccion(Indice).clcodigo
    '************************************************
    Case "MDCL" ', "MDCL_BCO"   'TABLA DE CLIENTES
    If clie <> "SINACOFI" Then
                    gsrut$ = objAyuda.coleccion(Indice).clrut
                    gsDigito$ = objAyuda.coleccion(Indice).cldv
                    gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
                    gsValor$ = objAyuda.coleccion(Indice).clcodigo
                    gsFax$ = objAyuda.coleccion(Indice).clfax
                    gsNombre$ = objAyuda.coleccion(Indice).cldirecc
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
         Else
                    gsCodigo$ = objAyuda.coleccion(Indice).clrut
                    gsDigito$ = objAyuda.coleccion(Indice).cldv
                    gsDescripcion$ = objAyuda.coleccion(Indice).clnombre
                    gsFax$ = objAyuda.coleccion(Indice).clfax
                    gsCodCli = objAyuda.coleccion(Indice).clcodigo
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
        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa

    Case "MDTC_MTM"     '---- Tasas MTM
        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa

    '---- CONTABILIDAD
    Case "CUENTAS", "MOVIM"
        gsCodigo$ = Trim(Left(lstNombre.Text, 12))
        gsDescripcion$ = Trim(Mid$(lstNombre.Text, 14))

    Case "PERFIL"
        gsCodigo$ = Mid(lstNombre.Text, 1, 10)
        'gscodigo$ = Right(lstNombre.Text, 5)
        gsDescripcion$ = Mid$(lstNombre.Text, 12)

    Case "CAMPOS"
        gsCodigo$ = Val(Left(lstNombre.Text, 5))
        gsDescripcion$ = Mid$(lstNombre.Text, 6)

    Case "CONDICIONES"
        gsCodigo$ = Left(lstNombre.Text, 6)
        gsDescripcion$ = Trim(Mid$(lstNombre.Text, 7))

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

        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa
   
   Case "MDCT"      'TABLAS GENERALES
                gsCodigo$ = objAyuda.coleccion(Indice).codigo
                gsGlosa$ = objAyuda.coleccion(Indice).Descri
                
    Case "MDIN"      'TABLA DE FAMILIAS DE INSTRUMENTOS
                gsSerie$ = objAyuda.coleccion(Indice).inserie
                gsCodigo$ = objAyuda.coleccion(Indice).incodigo
                gsDescripcion$ = objAyuda.coleccion(Indice).inglosa
         
    Case "MDSE"
    'Dim Mascara As String
                glosa = Trim(Right(lstNombre.Text, 15))
                Mascara = Trim(Left(lstNombre.Text, 30))
                
                
    Case "TBCODIGOSOMA"
                idtipo = IIf(Val(aux) = 0, 15, 16)
                gsCodigo$ = objAyuda.coleccion(Indice).codmov
                gsDigito$ = Trim(Left(objAyuda.coleccion(Indice).CodCta, 2))
                gsValor$ = Left(Mid$(objAyuda.coleccion(Indice).CodCta & "0000000000", 3), 7)
                gsGlosa$ = objAyuda.coleccion(Indice).codescri
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
            
    '************************************************
    Case Else
        GoTo fin

 End Select

    giAceptar% = True

fin:
    Screen.MousePointer = 0
    Unload Me


End Sub



