VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacAyuda 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Ayuda "
   ClientHeight    =   5730
   ClientLeft      =   2205
   ClientTop       =   2430
   ClientWidth     =   6000
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillStyle       =   0  'Solid
   Icon            =   "Bacayuda2.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5730
   ScaleWidth      =   6000
   ShowInTaskbar   =   0   'False
   Begin VB.Frame FraBuscaCliente 
      Height          =   5205
      Left            =   -30
      TabIndex        =   4
      Top             =   480
      Visible         =   0   'False
      Width           =   6045
      Begin VB.TextBox TxtBuscarCliente 
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
         Left            =   1350
         TabIndex        =   5
         Top             =   660
         Width           =   4665
      End
      Begin MSComctlLib.ListView LstAyudaCliente 
         Height          =   4155
         Left            =   30
         TabIndex        =   6
         Top             =   960
         Width           =   5955
         _ExtentX        =   10504
         _ExtentY        =   7329
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
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   450
         Left            =   120
         TabIndex        =   7
         Top             =   120
         Width           =   5925
         _ExtentX        =   10451
         _ExtentY        =   794
         ButtonWidth     =   820
         ButtonHeight    =   794
         AllowCustomize  =   0   'False
         Style           =   1
         ImageList       =   "Img_opciones"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   3
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.Visible         =   0   'False
               Style           =   3
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "ACEPTAR"
               Description     =   "ACEPTAR"
               Object.ToolTipText     =   "Aceptar"
               ImageIndex      =   11
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "cmdSalir"
               Description     =   "Salir"
               Object.ToolTipText     =   "Salr de la Ventana"
               ImageIndex      =   13
            EndProperty
         EndProperty
      End
      Begin VB.Label LblBuscaCliente 
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
         ForeColor       =   &H80000007&
         Height          =   315
         Left            =   120
         TabIndex        =   8
         Top             =   720
         Width           =   1170
      End
   End
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
      Left            =   1470
      TabIndex        =   0
      Top             =   600
      Width           =   4530
   End
   Begin MSComctlLib.ListView LstAyuda 
      Height          =   4815
      Left            =   0
      TabIndex        =   1
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
   Begin MSComctlLib.Toolbar Botones 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   6000
      _ExtentX        =   10583
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbaceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Detalle"
            Description     =   "Detalle"
            Object.ToolTipText     =   "Detalle"
            ImageIndex      =   12
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   13
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   8085
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   13
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":0771
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":0C67
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":10FA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":15E2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":1AF5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":1FC8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":248E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":2985
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":2D7E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":3174
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":36B1
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacayuda2.frx":3B72
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   8085
      Top             =   3270
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
            Picture         =   "Bacayuda2.frx":3FB6
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacayuda2.frx":4408
            Key             =   ""
         EndProperty
      EndProperty
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
      Left            =   90
      TabIndex        =   3
      Top             =   615
      Width           =   1230
   End
End
Attribute VB_Name = "BacAyuda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SW
Dim sPatron$
Dim Sql$
Dim Datos()
Public Mascara      As String
Private objAyuda As Object
Public parAyuda  As String    ' Ayuda de perfiles
Public parFiltro As String    ' Ayuda de Perfiles
Public parTipoMo As String    ' Ayuda de Perfiles
Public parTipoOp As String    ' Ayuda de Perfiles
'Public idtipo    As Integer      '-- Indica ID tipo de Ayuda a desplegar
Public codigo    As Long
Public glosa     As String

Private Sub Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim nColeccion  As Integer

Select Case Button.Index

         Dim Rut
         Dim codigo
         Dim NomProc As String
         Dim Datos()
    
    Case 1
        
        Dim Aux As String
        Dim nPos&
        Dim Indice%
        Dim sLine$

    
    giAceptar% = False
    
    If LstAyuda.ListItems.Count = 0 Then
       Exit Sub
    
    End If
    
    
    Indice = LstAyuda.SelectedItem.Index
    
    
    If MiTag = "PaisMntLocalidades" _
        Or MiTag = "RegionMntLocalidades" _
        Or MiTag = "CiudadMntLocalidades" _
        Or MiTag = "ComunaMntLocalidades" _
        Or MiTag = "RegionMntLocalidades1" _
        Or MiTag = "CiudadMntLocalidades1" _
        Or MiTag = "ComunaMntLocalidades1" _
        Or MiTag = "PlazaMntLocalidades" _
        Or MiTag = "Sucursales" _
        Or MiTag = "EmisoresMnt" _
        Or MiTag = "PlazosMnt" _
        Or MiTag = "CategoriasMnt" Then
        Screen.MousePointer = 0
        RETORNOAYUDA = LstAyuda.ListItems.Item(Indice).ListSubItems(1).Text 'Trim(Right(lstNombre, 5))
        giAceptar% = True
        Unload Me
        Exit Sub
    End If
 
    '-Si No tiene Elementos Listcount = 0 -'
    If Not LstAyuda.ListItems.Count > 0 Then
        GoTo fin
    End If

    If LstAyuda.ListItems.Count < 0 Then
        Exit Sub
    End If

    '-Si tiene algun elemento-'
    
    'Indice = BuscaListIndex(lstNombre, Trim$(txtNombre.Text)) + 1


    Screen.MousePointer = 11
    Aux = ""
        MiTag = UCase(Trim(MiTag))
        If InStr(MiTag, "TBCODIGOSCOMERCIO") > 0 Then
            Aux = IIf(Val(right(MiTag, 3)) > 0, right(MiTag, 3), "")
            MiTag = "TBCODIGOSCOMERCIO"
        ElseIf InStr(MiTag, "TBCODIGOSOMA") > 0 Then
            Aux = IIf(Val(left(MiTag, 1)) > 0, left(MiTag, 1), "")
            MiTag = "TBCODIGOSOMA"
        End If

    Select Case UCase(Trim(MiTag))


    Case "MDCL_U":        '---- PENDIENTE
         
         Envia = Array()
    
         'If clie <> "SINACOFI" Then 'MDCL
         
                codigo = LstAyuda.ListItems.Item(Indice).ListSubItems(2).Text
                Rut = LstAyuda.ListItems.Item(Indice).ListSubItems(1).Text
                
                NomProc = "sp_Busca_Cliente_Rut"
                AddParam Envia, Rut
                AddParam Envia, codigo

                
          If Not BAC_SQL_EXECUTE(NomProc, Envia) Then
                MsgBox "Error al buscar Cliente", vbInformation
                Exit Sub
          End If

          If BAC_SQL_FETCH(Datos()) Then
             gsCodigo$ = Datos(1)       'clrut
             gsrut$ = Datos(1)       'clrut
             gsDigito$ = Datos(2)        'cldv
             gsDescripcion$ = Datos(4)  'clnombre
             gsFax$ = Datos(5)           'clfax
             gsCodCli = Datos(3)        'clcodigo
             gsValor$ = Datos(3)        'clcodigo
          Else
             MsgBox "Cliente no encontrado", vbInformation
          End If
          
    
        '************************************************

     
'    Case "MDCL_BANCOS":        '---- PENDIENTE
'        sLine = Trim(Right(lstNombre.List(lstNombre.ListIndex), 11))
'        gsCodigo = Left(sLine, Len(sLine) - 2)
'        gsDigito = Right(sLine, 1)
'        gsNombre = Trim(Left(lstNombre.List(lstNombre.ListIndex), 45))
'        gsCodCli = CDbl(lstNombre.ItemData(lstNombre.ListIndex))
     
'     Case "MONEDA"
'        sLine = lstNombre.List(lstNombre.ListIndex)
'        gsCodigo = lstNombre.ItemData(lstNombre.ListIndex)
'        gsNemo = Trim(Left(sLine, 5))
'        gsGlosa = Trim(Mid(sLine, 6))
        
    Case "MDMN_U"
        'sLine = lstNombre.List(lstNombre.ListIndex)
        
        gsCodigo = Val(LstAyuda.ListItems(Indice).Text) 'lstNombre.ItemData(lstNombre.ListIndex)
        gsNemo = LstAyuda.ListItems(Indice).ListSubItems(2).Text    'Trim(Left(sLine, 5))
        gsGlosa = LstAyuda.ListItems(Indice).ListSubItems(1).Text    'Trim(Mid(sLine, 6))

    Case "MDTC_U", "MDFP_U", "MDTC_TASASMERCADO", "MDTC_TASASMONEDAS", "PAIS"
        gsCodigo = Val(LstAyuda.ListItems(Indice).Text)   'lstNombre.ItemData(lstNombre.ListIndex)
        gsGlosa = LstAyuda.ListItems(Indice).ListSubItems(1).Text    'lstNombre.List(lstNombre.ListIndex)


    Case "PROD_CAMPOS", "PROD_CAMPOSLOGICOS", "XPROD_CAMPOSLOGICOS"
'        gsCodigo = Trim(Mid(lstNombre.Text, 1, 10))
'        gsGlosa = Trim(Mid(lstNombre.Text, 8, Len(lstNombre.Text)))

        gsCodigo = Val(LstAyuda.ListItems(Indice).Text)   'lstNombre.ItemData(lstNombre.ListIndex)
        gsGlosa = LstAyuda.ListItems(Indice).ListSubItems(1).Text    'lstNombre.List(lstNombre.ListIndex)


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
    Case "MDCL", "MATRIZ" ', "MDCL_BCO"   'TABLA DE CLIENTES
    
         Envia = Array()
    
         'If clie <> "SINACOFI" Then 'MDCL
         
                codigo = LstAyuda.ListItems.Item(Indice).ListSubItems(2).Text
                Rut = LstAyuda.ListItems.Item(Indice).ListSubItems(1).Text
                
                NomProc = "sp_Busca_Cliente_Rut"
                AddParam Envia, Rut
                AddParam Envia, codigo

                
          If Not BAC_SQL_EXECUTE(NomProc, Envia) Then
                MsgBox "Error al buscar Cliente", vbInformation
                Exit Sub
          End If

          If BAC_SQL_FETCH(Datos()) Then
             gsCodigo$ = Datos(1)       'clrut
             gsrut$ = Datos(1)       'clrut
             gsDigito$ = Datos(2)        'cldv
             gsDescripcion$ = Datos(4)  'clnombre
             gsFax$ = Datos(5)           'clfax
             gsCodCli = Datos(3)        'clcodigo
             gsValor$ = Datos(3)        'clcodigo
          Else
             MsgBox "Cliente no encontrado", vbInformation
          End If
          
    
        '************************************************

    Case "MDCD"      'TABLA DE DUEÑOS DE CARTERA
          'gsrut$ = objAyuda.coleccion(Indice).rcrut
          'gsDigito$ = objAyuda.coleccion(Indice).rcdv

    Case "MDMN"      'TABLA DE MONEDAS
        gsCodigo$ = Val(LstAyuda.ListItems(Indice).Text)   'objAyuda.coleccion(indice).mncodmon
        gsDescripcion$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text   'objAyuda.coleccion(indice).mnglosa 'arreglado

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
         gsCodigo$ = Val(LstAyuda.ListItems(Indice).Text)  'objAyuda.coleccion(indice).mncodmon ''codmon
         gsGlosa$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text   'objAyuda.coleccion(indice).mnglosa
         
    Case "MDTC"         '---- TABLA DE PARAMETROS
        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa

    Case "MDTC_MTM"     '---- Tasas MTM
        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa

    '---- CONTABILIDAD
    Case "CUENTAS", "MOVIM"
        gsCodigo$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text  'Trim(Left(lstNombre.Text, 12))
        gsDescripcion$ = LstAyuda.ListItems(Indice).Text 'Trim(Mid$(lstNombre.Text, 14))

    Case "PERFIL", "PERFIL_SALDO"
        gsDescripcion$ = LstAyuda.ListItems(Indice).Text   'Mid$(lstNombre.Text, 1, 60)
        gsCodigo$ = Val(LstAyuda.ListItems(Indice).ListSubItems(1).Text)  'Mid(lstNombre.Text, 61, 9)
        'gscodigo$ = Right(lstNombre.Text, 5)

   

    Case "CAMPOS"
        gsCodigo$ = Val(LstAyuda.ListItems(Indice).ListSubItems(1).Text)
        gsDescripcion$ = LstAyuda.ListItems(Indice).Text

    Case "CONDICIONES"
        gsCodigo$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text
        gsDescripcion$ = LstAyuda.ListItems(Indice).Text

    Case "SISTEMAS", "SISTEMA"
        gsCodigo$ = LstAyuda.ListItems(Indice).Text
        gsGlosa$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text

    '---- CARGA (procedimiento sin coleccion propio de este formulario)

    '*****HOLA******
     Case "MDEM"      'TABLA DE EMISORES Total
                 
                For nColeccion = 1 To objAyuda.coleccion.Count
                   If objAyuda.coleccion(nColeccion).emrut = CDbl(LstAyuda.ListItems(Indice).ListSubItems(1).Text) Then
                      Indice = nColeccion
                      Exit For
                   End If
                Next nColeccion
                               
                gsCodigo$ = objAyuda.coleccion(Indice).emrut
                gsDigito$ = objAyuda.coleccion(Indice).emdv
                gsDescripcion$ = objAyuda.coleccion(Indice).emnombre
                gsGenerico$ = objAyuda.coleccion(Indice).emgeneric
                gsrut$ = objAyuda.coleccion(Indice).emcodigo
    '**************
   Case "MDMN_PAIS"

        gsCodigo$ = objAyuda.coleccion(Indice).codigo
        gsGlosa$ = objAyuda.coleccion(Indice).glosa
   
   Case "MDCT"      'TABLAS GENERALES
                gsCodigo$ = objAyuda.coleccion(Indice).codigo
                gsGlosa$ = objAyuda.coleccion(Indice).Descri
                
    Case "MDIN"      'TABLA DE FAMILIAS DE INSTRUMENTOS
                For nColeccion = 1 To objAyuda.coleccion.Count
                   If objAyuda.coleccion(nColeccion).inserie = LstAyuda.ListItems(Indice).Text Then
                      Indice = nColeccion
                      Exit For
                   End If
                Next nColeccion
                
                gsSerie$ = objAyuda.coleccion(Indice).inserie
                gsCodigo$ = objAyuda.coleccion(Indice).incodigo
                gsDescripcion$ = objAyuda.coleccion(Indice).inglosa
         
    Case "MDSE"
    'Dim Mascara As String
                gsSerie$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text 'Trim(Right(lstNombre.Text, 15))
                gsCodigo$ = LstAyuda.ListItems(Indice).Text  'Trim(Left(lstNombre.Text, 30))
                
                
    Case "TBCODIGOSOMA"
                For nColeccion = 1 To objAyuda.coleccion.Count
                   If objAyuda.coleccion(nColeccion).codmov = LstAyuda.ListItems(Indice).ListSubItems(1).Text Then
                      Indice = nColeccion
                      Exit For
                   End If
                Next nColeccion
                
                idtipo = IIf(Val(Aux) = 0, 15, 16)
                gsCodigo$ = objAyuda.coleccion(Indice).codmov
                gsDigito$ = Trim(left(objAyuda.coleccion(Indice).CodCta, 2))
                gsValor$ = left(Mid$(objAyuda.coleccion(Indice).CodCta & "0000000000", 3), 7)
                gsGlosa$ = objAyuda.coleccion(Indice).codescri
                MiTag = Aux & MiTag
                
                
                
    Case "TBCODIGOSCOMERCIO"

         Envia = Array()
    
        
                codigo = LstAyuda.ListItems(Indice).Text  'Trim(Left(lstNombre, 6))
                
                NomProc = "Sp_Leer_Codigos_Comercio"
                AddParam Envia, codigo

                
          If Not BAC_SQL_EXECUTE(NomProc, Envia) Then
                MsgBox "Error al codigo Comercio", vbInformation
                Exit Sub
          End If

          If BAC_SQL_FETCH(Datos()) Then
                gsCodigo$ = Datos(1)
                gsGlosa$ = Datos(2)
                gsValor$ = Datos(3)
                gsNombre$ = Datos(4)
          Else
             MsgBox "Código no encontrado", vbInformation
          End If
                                           
                
    Case "MECLA"      'TABLA DE GLOSAS
                idtipo = 4
                gsCodigo$ = objAyuda.coleccion(Indice).CodMovch
                gsGlosa$ = objAyuda.coleccion(Indice).codescri
                gsDigito$ = objAyuda.coleccion(Indice).codmov
                gsDescripcion$ = objAyuda.coleccion(Indice).CodOrden
                gsValor$ = objAyuda.coleccion(Indice).COD2756
                
                
'    Case "COMERCIO"
'               gsCodigo$ = Trim(Left(lstNombre, 6))
'               gsGlosa$ = Trim(Mid(lstNombre, 8, Len(lstNombre)))
               
            
    '************************************************
    Case "CAMPO_CONTABILIDAD"
        gsCodigo$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text
        gsGlosa$ = LstAyuda.ListItems(Indice).ListSubItems(2).Text
        gsDescripcion$ = LstAyuda.ListItems(Indice).ListSubItems(3).Text
        
    Case "CODIGO_OPERACION_CONTABILIDAD"
        gsCodigo$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text
        
    Case "NOMBRE_CAMPO_CONTABILIDAD"
        gsCodigo$ = LstAyuda.ListItems(Indice).Text
        gsGlosa$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text
    
    Case "CONCEPTO_CONTABILIDAD"
                gsCodigo$ = LstAyuda.ListItems(LstAyuda.SelectedItem.Index).Text
    Case "FFMM"
        gsNemo$ = LstAyuda.ListItems(Indice).Text
        
        gsNombre$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text
        gsCodigo$ = LstAyuda.ListItems(Indice).ListSubItems(2).Text
        gsGlosa$ = LstAyuda.ListItems(Indice).ListSubItems(3).Text
        
    Case "MDCL_FFMM"
        gsrut$ = LstAyuda.ListItems(Indice).ListSubItems(1).Text       'clrut
        gsCodCli = LstAyuda.ListItems(Indice).ListSubItems(2).Text     'clcodigo
        
    Case Else
        GoTo fin

 End Select

        giAceptar% = True

fin:
    Screen.MousePointer = 0
    Unload Me

Case 2
   TxtBuscarCliente.Text = ""
   Call PROC_DETALLE

Case 3
    giAceptar% = False
    Unload Me

End Select

End Sub

Private Function Aceptar() As Boolean
    Unload Me
End Function


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
'   Me.TxtNombre.Text = ""
    TxtBuscar.SetFocus
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) And FraBuscaCliente.Visible = False Then
   
      opcion = 0
      
      Select Case KeyCode
   
            Case vbKeyF10
                  opcion = 1
            Case vbKeyDetalle
                  opcion = 2
            Case vbKeySalir
                  opcion = 3
      End Select
   
      If opcion <> 0 Then
         If Botones.Buttons(opcion).Enabled Then
            Call Botones_ButtonClick(Botones.Buttons(opcion))
            KeyCode = 0
         End If
   
      End If
      Exit Sub
   End If

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) And FraBuscaCliente.Visible = True Then

        Select Case KeyCode
            Case vbkeyAceptar 'Aceptar
                opcion = 2
            Case vbKeySalir   'Salir
                opcion = 3
        End Select
        
        If opcion > 0 Then
            If Toolbar2.Buttons(opcion).Enabled Then
                Toolbar2_ButtonClick Toolbar2.Buttons(opcion)
            End If
        End If

        Exit Sub

    End If

End Sub

Private Sub Form_Load()
    
      Dim Arreglo()
      
      Screen.MousePointer = 11

      Call PROC_CARGA_LIST

      Screen.MousePointer = 0

      LstAyuda.Sorted = True
      LstAyuda.AllowColumnReorder = True
      LstAyuda.ColumnHeaderIcons = ImageList2


      If LstAyuda.ListItems.Count > 0 Then
         LblBuscarPor.Caption = LstAyuda.ColumnHeaders.Item(1).Text
         If MiTag = "FFMM" Then
            Exit Sub
         End If
      End If

      Arreglo = Array()
      PROC_ELEMENTO_LIST Arreglo, "Cliente"
      PROC_ELEMENTO_LIST Arreglo, "Rut"
      PROC_ELEMENTO_LIST Arreglo, "Codigo"
      Call PROC_LLENADO_LIST_CLIENTE(Arreglo, True)

End Sub

Private Sub Form_Resize()

 On Error Resume Next

   If Not Me.Width > 9105 Then
      LstAyuda.Width = Me.Width - 90
      TxtBuscar.Width = Me.Width - 1230
  

   Else

      Me.Width = 9105
        Exit Sub
   End If

   If Not Me.Height > 8850 Then
      LstAyuda.Height = Me.Height - 1260

   Else

      Me.Height = 8850

   End If

End Sub

Private Sub Form_Unload(Cancel As Integer)
        
    'lstNombre.Tag = ""
     Set objAyuda = Nothing
        
End Sub


Private Sub LstAyuda_DblClick()
On Error Resume Next

   Call Botones_ButtonClick(Botones.Buttons(1))

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


Private Sub TxtBuscar_Change()
    PROC_BUSCA_ELEMENTO_PARCIAL TxtBuscar.Text
End Sub

Private Sub TxtBuscar_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyUp Or KeyCode = vbKeyDown Then
   
      TxtBuscar_KeyPress vbKeyReturn
      LstAyuda_KeyDown KeyCode, Shift
   
   End If

End Sub


Public Function BuscaListIndex(Combo As Object, BUSCA As String) As Integer

'Tiene que verificar en todo el list para encontrar
'el indice que pertenece a la Opcion seleccionada ''blas
'======================================================
 
 Dim Lin As Integer
 
 BuscaListIndex = 0              ' Nada en el ComboList
 
'  With Combo
'
'    Linea = lstNombre.ListIndex
'    If .ListCount <> 0 Then       ' = 0 Nada
'
'        For Lin = 0 To .ListCount - 1
'            .ListIndex = Lin
'            If Trim$(Left(UCase(Trim$(.List(.ListIndex))), 25)) = Trim$(Left(UCase(BUSCA), 25)) Then
'                     BuscaListIndex = Lin
'                     Exit Function
'            End If
'        Next Lin
'
'    End If
'
' End With
      
End Function

Sub Carga_Tablas_Perfiles(pareSTipo_ayuda As String, pareSTipo_filtro As String, pareSTipo_Mo As String, pareSTipo_Op As String)
Dim Datos()
Dim Comando As String
Dim Paso As String
Dim i As Integer
Dim Largo_Codigo As Integer
Dim Numero_Campos As Integer
Dim Id_Sistema       As String
Dim Titulo        As Boolean

    LstAyuda.Sorted = False
    LstAyuda.AllowColumnReorder = False

    Screen.MousePointer = 11
    
    If Mid(pareSTipo_ayuda, 1, Len(pareSTipo_ayuda) - 3) = "BAC_CNT_PERFIL" Then

        Id_Sistema = right(pareSTipo_ayuda, 3)
        pareSTipo_ayuda = "BAC_CNT_PERFIL"

    Else
        Id_Sistema = ""

    End If

    Titulo = True

    Envia = Array()
    AddParam Envia, pareSTipo_ayuda
    AddParam Envia, Trim(left(pareSTipo_filtro, 45))
    AddParam Envia, pareSTipo_Mo
    AddParam Envia, pareSTipo_Op
    
    
    Select Case UCase(pareSTipo_ayuda)
    Case "CON_PLAN_CUENTAS"
        Numero_Campos = 2
        Largo_Codigo = 11
        
    Case "CON_CAMPOS_PERFIL"
        Numero_Campos = 2
        Largo_Codigo = 3
      
    Case "PERFIL"
        Numero_Campos = 0
        Largo_Codigo = 60
        
    Case "BAC_CNT_PERFIL"
        Numero_Campos = 0
        Largo_Codigo = 60
        'AddParam Envia, ""
        'AddParam Envia, Id_Sistema
        
    Case "CONDICIONES"
        Numero_Campos = 2
        Largo_Codigo = 3
        
    Case "GEN_TABLAS"
        Numero_Campos = 2
        Largo_Codigo = 4
        
    Case "GEN_TABLAS1"
        Numero_Campos = 2
        Largo_Codigo = 15
        'AddParam Envia, Trim(right(pareSTipo_filtro, 45))
        
    Case "BAC_CNT_SISTEMAS"
        Numero_Campos = 1
        Largo_Codigo = 3
        
    Case "BAC_CNT_CAMPOS"
        Numero_Campos = 2
        Largo_Codigo = 3
        
    End Select

    If BAC_SQL_EXECUTE("sp_consulta_tablas ", Envia) Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            If parAyuda = "BAC_CNT_SISTEMAS" Then
                
               If Titulo Then
                   
                  Arreglo = Array()
                  PROC_ELEMENTO_LIST Arreglo, "Sistema"
                  PROC_ELEMENTO_LIST Arreglo, "Id Sistema"
                  Call PROC_LLENADO_LIST(Arreglo, True)
                  Titulo = False
                
                  Arreglo = Array()
                  PROC_ELEMENTO_LIST Arreglo, Datos(2)
                  PROC_ELEMENTO_LIST Arreglo, Datos(1)
                  Call PROC_LLENADO_LIST(Arreglo, False)
                
               Else
                  Arreglo = Array()
                  PROC_ELEMENTO_LIST Arreglo, Datos(2)
                  PROC_ELEMENTO_LIST Arreglo, Datos(1)
                  Call PROC_LLENADO_LIST(Arreglo, False)
               
               End If
                
                
                Paso = Datos(2) & Space(Abs(Largo_Codigo - Len(Datos(2)))) & " " & Datos(1)
            
            Else
               If Titulo Then
                   
                  Arreglo = Array()
                  PROC_ELEMENTO_LIST Arreglo, "Nombre"
                  PROC_ELEMENTO_LIST Arreglo, "Codigo"
                  If Numero_Campos >= 2 Then
                     PROC_ELEMENTO_LIST Arreglo, "Adicional"
                  End If
                  Call PROC_LLENADO_LIST(Arreglo, True)
                  
                  Titulo = False
                
                  Arreglo = Array()
                  PROC_ELEMENTO_LIST Arreglo, Datos(2)
                  PROC_ELEMENTO_LIST Arreglo, Datos(1)
                  If Numero_Campos >= 2 Then
                     PROC_ELEMENTO_LIST Arreglo, Datos(Numero_Campos)
                  End If
                  
                  Call PROC_LLENADO_LIST(Arreglo, False)
                
               Else
                  Arreglo = Array()
                  PROC_ELEMENTO_LIST Arreglo, Datos(2)
                  PROC_ELEMENTO_LIST Arreglo, Datos(1)
                  
                  If Numero_Campos >= 2 Then
                     PROC_ELEMENTO_LIST Arreglo, Datos(Numero_Campos)
                  End If
                  
                  Call PROC_LLENADO_LIST(Arreglo, False)
               
               End If
                
                
                 Paso = Datos(2) & Space(Abs(Largo_Codigo - Len(Datos(2)))) & " " & Datos(1)
            
            End If
              
            For i = 2 To Numero_Campos
                
                If pareSTipo_ayuda = "BAC_CNT_PERFIL" And i% = 3 Then
                    
                    Paso = Paso + " " & Space(60) & Val(Datos(i%))
                
                ElseIf i% > 0 Then
                    
                        Paso = Paso + " " + Datos(i%)
                
                End If
            
            Next i%
          
'            lstNombre.AddItem Paso
       Loop
    
    End If

    Screen.MousePointer = 0
    
End Sub

Sub Carga_Tablas_Perfiles_Saldos(pareSTipo_ayuda As String, pareSTipo_filtro As String)
Dim Datos()
Dim Comando As String
Dim Paso As String
Dim i As Integer
Dim Largo_Codigo As Integer
Dim Numero_Campos As Integer
Dim Id_Sistema       As String

    Screen.MousePointer = 11

    'Comando = "EXECUTE sp_consulta_tablas '" & pareSTipo_ayuda & "', '" & pareSTipo_filtro & "'"

    'Envia = Array(pareSTipo_ayuda, pareSTipo_filtro)

    If Mid(pareSTipo_ayuda, 1, Len(pareSTipo_ayuda) - 3) = "BAC_CNT_PERFIL" Then

        Id_Sistema = right(pareSTipo_ayuda, 3)
        pareSTipo_ayuda = "BAC_CNT_PERFIL"

    Else
        Id_Sistema = ""

    End If



    Envia = Array()
    AddParam Envia, pareSTipo_ayuda
    AddParam Envia, Trim(left(pareSTipo_filtro, 45))
    

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
        AddParam Envia, ""
        AddParam Envia, Id_Sistema
        
    Case "CONDICIONES"
        Numero_Campos = 2
        Largo_Codigo = 3
        
    Case "GEN_TABLAS"
        Numero_Campos = 2
        Largo_Codigo = 4
        
    Case "GEN_TABLAS1"
        Numero_Campos = 2
        Largo_Codigo = 15
        AddParam Envia, Trim(right(pareSTipo_filtro, 45))
        
    Case "BAC_CNT_SISTEMAS"
        Numero_Campos = 1
        Largo_Codigo = 3
        
    Case "BAC_CNT_CAMPOS"
        Numero_Campos = 2
        Largo_Codigo = 3
        
    End Select

    If BAC_SQL_EXECUTE("Sp_Consulta_Tablas_Saldos ", Envia) Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            If parAyuda = "BAC_CNT_SISTEMAS" Then
                
                Paso = Datos(2) & Space(Abs(Largo_Codigo - Len(Datos(2)))) & " " & Datos(1)
            
            Else
                
'                Paso = IIf(Right(DATOS(1), gsc_PuntoDecim & "0") = 0, DATOS(1), Val(DATOS(1)))
                               
                  Paso = Datos(1)
                  Paso = right(Space(Largo_Codigo) & Paso, Largo_Codigo) & " "
            
            End If
              
            For i = 2 To Numero_Campos
                
                If pareSTipo_ayuda = "BAC_CNT_PERFIL" And i% = 3 Then
                    
                    Paso = Paso + " " & Space(60) & Val(Datos(i%))
                
                Else
                    
                        Paso = Paso + " " + Datos(i%)
                
                End If
            
            Next i%
          
'            lstNombre.AddItem Paso
       Loop
    
    End If

    Screen.MousePointer = 0
    
End Sub


Private Sub mdcl_LlenaGrilla()

Dim Filas   As Long
Dim idRut   As String * 12
Dim IdGlosa As String * 35 '40
Dim IDCodigo As String * 5
 
Dim Max     As Long
          
'    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
    For Filas = 1 To Max
        
        idRut = objAyuda.coleccion(Filas).clrut & "-" & objAyuda.coleccion(Filas).cldv
        IdGlosa = Trim(UCase(objAyuda.coleccion(Filas).clnombre))
        IDCodigo = objAyuda.coleccion(Filas).clcodigo
'        lstNombre.AddItem Trim(IdGlosa) & Space(50 - Len(Trim(IdGlosa))) & Trim(idRut) & Space(20 - Len(Trim(idRut))) & Trim(IDCodigo)
'        lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).clrut
        
        A$ = Len(Trim(IdGlosa)) + 50 - Len(Trim(IdGlosa))
    
    Next Filas

End Sub

Private Sub MDCT_LlenaGrilla()

Dim Filas       As Long
Dim IDCodigo    As Integer
Dim IdGlosa     As String * 25
Dim Max         As Long
          
'    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
 For Filas = 1 To Max
  IdGlosa = objAyuda.coleccion(Filas).Descri
  IDCodigo = objAyuda.coleccion(Filas).codigo
   
'   lstNombre.AddItem IdGlosa & Space(3) & IDCodigo
'   lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).codigo
 Next Filas

End Sub

Private Sub MDEM_LlenaGrilla()

Dim Filas   As Long
Dim idRut   As String * 11
Dim IdGlosa As String * 25 '40
Dim Max     As Long
          
    'lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
   Arreglo = Array()
   PROC_ELEMENTO_LIST Arreglo, "Nombre"
   PROC_ELEMENTO_LIST Arreglo, "Rut"
   
   Call PROC_LLENADO_LIST(Arreglo, True)
        
    
    For Filas = 1 To Max
        
        
        idRut = objAyuda.coleccion(Filas).emrut '& "-" & objAyuda.coleccion(Filas).emdv
        IdGlosa = objAyuda.coleccion(Filas).emnombre
        
         Arreglo = Array()
         PROC_ELEMENTO_LIST Arreglo, IdGlosa
         PROC_ELEMENTO_LIST Arreglo, idRut
         
         Call PROC_LLENADO_LIST(Arreglo, False)
        
    Next Filas
 
End Sub

Private Sub MDSE_LlenarGrilla()

Dim Sql As String
Dim Datos()
Sql = ""

'BacMntSe.xincodigo = 20
'Sql = "execute sp_lee_mascara_series " & BacMntSe.xincodigo

   Envia = Array(CDbl(BacMntSe.xincodigo))
   
   If Not BAC_SQL_EXECUTE("sp_lee_mascara_series", Envia) Then
       
       Exit Sub
   
   End If
     
   Arreglo = Array()
   PROC_ELEMENTO_LIST Arreglo, "Mascara"
   PROC_ELEMENTO_LIST Arreglo, "Codigo Instrumento"
   
   Call PROC_LLENADO_LIST(Arreglo, True)
   
     
   Do While BAC_SQL_FETCH(Datos())
       
      Arreglo = Array()
      PROC_ELEMENTO_LIST Arreglo, Datos(2)
      PROC_ELEMENTO_LIST Arreglo, Datos(1)
      Call PROC_LLENADO_LIST(Arreglo, False)
      
       'lstNombre.AddItem Trim(Datos(2)) & Space(15 + (15 - Len(Datos(2)))) & Val(Datos(1))
   '   lstNombre.ItemData(lstNombre.NewIndex) = Val(Datos(2))
   
   Loop

End Sub

Private Sub MEVM_LlenaGrilla()
Dim Filas       As Long
Dim IDCodigo    As String
Dim idRut       As String * 11
Dim IdGlosa     As String * 30
Dim idorden     As String * 10
Dim idtipo1     As Long
Dim Max         As Long

'    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
   Arreglo = Array()
   PROC_ELEMENTO_LIST Arreglo, "Descripción"
   PROC_ELEMENTO_LIST Arreglo, "Codigo"
   
   Call PROC_LLENADO_LIST(Arreglo, True)
        
    
 For Filas = 1 To Max
      IdGlosa = objAyuda.coleccion(Filas).codescri
      IDCodigo = objAyuda.coleccion(Filas).codmov
      
      Arreglo = Array()
      PROC_ELEMENTO_LIST Arreglo, IdGlosa
      PROC_ELEMENTO_LIST Arreglo, IDCodigo
      
      Call PROC_LLENADO_LIST(Arreglo, False)
      
'      lstNombre.AddItem IdGlosa & Space(3) & IDCodigo
'      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).CodMovch
 Next Filas

End Sub

Private Sub MEVM_LlenaGrillaX()
Dim Filas       As Long
Dim IDCodigo    As String
Dim idRut       As String * 11
Dim IdGlosa     As String * 30
Dim idorden     As String * 10
Dim idtipo1     As Long
Dim Max         As Long

'    lstNombre.Clear
    
    Max = objAyuda.coleccion.Count
    
 For Filas = 1 To Max
      IdGlosa = objAyuda.coleccion(Filas).codescri
      'IDCodigo = objAyuda.coleccion(Filas).codmov
      'lstNombre.AddItem IdGlosa & Space(3) & IDCodigo
'      lstNombre.AddItem IDCodigo & Space(3) & IdGlosa
'      lstNombre.ItemData(lstNombre.NewIndex) = objAyuda.coleccion(Filas).CodMovch
 Next Filas

End Sub

Private Sub Fondos_Mutuos_LlenarGrilla()

Dim Sql As String
Dim Datos()

   
   
   If Not BAC_SQL_EXECUTE("SP_LEE_SERIE_FONDOS_MUTUOS") Then
       
       Exit Sub
   
   End If
     
   Arreglo = Array()
   PROC_ELEMENTO_LIST Arreglo, "Nemotécnico"
   PROC_ELEMENTO_LIST Arreglo, "Cliente"
   PROC_ELEMENTO_LIST Arreglo, "Cod. Cliente"
   PROC_ELEMENTO_LIST Arreglo, "MOneda"
   
   Call PROC_LLENADO_LIST(Arreglo, True)
   
     
   Do While BAC_SQL_FETCH(Datos())
       
      Arreglo = Array()
      PROC_ELEMENTO_LIST Arreglo, Datos(1)
      PROC_ELEMENTO_LIST Arreglo, Datos(2)
      PROC_ELEMENTO_LIST Arreglo, Datos(3)
      PROC_ELEMENTO_LIST Arreglo, Datos(4)
      Call PROC_LLENADO_LIST(Arreglo, False)
      

   
   Loop

End Sub


Sub Carga(sTabla$)
Dim iMouse%

    iMouse = Me.MousePointer
    Me.MousePointer = 11

'    lstNombre.Clear
    
    '---- Definición de Carga para Listas
    Sql = "SELECT tbcodigo1,tbglosa FROM Tabla_General_Detalle "
    Select Case sTabla
    Case Else
        MsgBox "No se ha definido Ayuda para Consultar de Datos", vbInformation + vbOKOnly
        GoTo fin
        
    End Select
    
    '---- Carga de Lista
    If Not BAC_SQL_EXECUTE(Sql) Then
        MsgBox "No se pudo realizar Consulta de Datos", vbInformation + vbOKOnly
        GoTo fin
    End If
    
    Do While BAC_SQL_FETCH(Datos())
'        lstNombre.AddItem Left(Datos(2) & Space(60), 60) & Left(Datos(3) + Space(3), 3) & IIf(UBound(Datos()) >= 4, Datos(4), "")
'        lstNombre.ItemData(lstNombre.NewIndex) = Datos(1)
    Loop
    
'    If lstNombre.ListCount >= 0 Then
'        lstNombre.ListIndex = 0
'    End If

fin:
    Me.MousePointer = iMouse

End Sub


Sub Carga_Comercio()

   If BAC_SQL_EXECUTE("Sp_Ayuda_Codigo_Comercio") Then
   
      While BAC_SQL_FETCH(Datos())
      
'         lstNombre.AddItem Datos(1) + "   " + UCase(Datos(2))
      
      Wend
      
   End If

End Sub

Sub Carga_Campos_Productos()

   If BAC_SQL_EXECUTE("Sp_ProdxCampos_LeeCampos_cabecera") Then
   
      Arreglo = Array()
      PROC_ELEMENTO_LIST Arreglo, "Código"
      PROC_ELEMENTO_LIST Arreglo, "Descripción"
      
      Call PROC_LLENADO_LIST(Arreglo, True)
      
      While BAC_SQL_FETCH(Datos())
      
         'lstNombre.AddItem Datos(1) + Space(15 - Len(Datos(1))) + Datos(2)
         Arreglo = Array()
         PROC_ELEMENTO_LIST Arreglo, Datos(1)
         PROC_ELEMENTO_LIST Arreglo, Datos(2)
         
         Call PROC_LLENADO_LIST(Arreglo, False)
         
      
      Wend
      
   End If

End Sub


Sub Carga_CamposLogicos_Productos()

   If BAC_SQL_EXECUTE("Sp_ProdxCamposLogicos_LeeCampos") Then
   
      Arreglo = Array()
      PROC_ELEMENTO_LIST Arreglo, "Código"
      PROC_ELEMENTO_LIST Arreglo, "Descripción"
      PROC_ELEMENTO_LIST Arreglo, "Condición"
      
      Call PROC_LLENADO_LIST(Arreglo, True)
   
      While BAC_SQL_FETCH(Datos())
      
         Arreglo = Array()
         PROC_ELEMENTO_LIST Arreglo, Datos(1)
         PROC_ELEMENTO_LIST Arreglo, Datos(2)
         
         Call PROC_LLENADO_LIST(Arreglo, False)
      
'         lstNombre.AddItem Datos(1) + "    " + Datos(3) + Space(100 - Len(Datos(1))) + Datos(2)
      
      Wend
      
   End If

End Sub


Sub Carga_CamposLogicos_x_Productos()

   Envia = Array()
   AddParam Envia, parFiltro

   If BAC_SQL_EXECUTE("Sp_Campo_cnt_logico_X_Producto", Envia) Then
   
      While BAC_SQL_FETCH(Datos())
      
'         lstNombre.AddItem Datos(1) + Space(15 - Len(Datos(1))) + Trim(Datos(2)) + Space(100 - Len(Datos(1))) + Datos(2)
      
      Wend
      
   End If

End Sub

' ************************ Nuevos Cambios

Private Sub PROC_CARGA_LIST()
Dim Arreglo()
Dim Datos()
Dim Aux        As String
Dim NomProc    As String
Dim SUPERSW    As Boolean
Dim Titulo     As Boolean

   Titulo = True

   With LstAyuda
      
      .ListItems.Clear
      .ColumnHeaders.Clear
      
      
      If UCase(MiTag) = UCase("PaisMntLocalidades") _
          Or UCase(MiTag) = UCase("RegionMntLocalidades") _
          Or UCase(MiTag) = UCase("CiudadMntLocalidades") _
          Or UCase(MiTag) = UCase("ComunaMntLocalidades") _
          Or UCase(MiTag) = UCase("RegionMntLocalidades1") _
          Or UCase(MiTag) = UCase("CiudadMntLocalidades1") _
          Or UCase(MiTag) = UCase("ComunaMntLocalidades1") _
          Or UCase(MiTag) = UCase("PlazaMntLocalidades") _
          Or UCase(MiTag) = UCase("Sucursales") _
          Or UCase(MiTag) = UCase("EmisoresMnt") _
          Or UCase(MiTag) = UCase("PlazosMnt") _
          Or UCase(MiTag) = UCase("MDSE") _
          Or UCase(MiTag) = UCase("CategoriasMnt") Then
          
          SUPERSW = False
          Sql = ""
          
          Select Case UCase(MiTag)
              Case UCase("PaisMntLocalidades")
                  Sql = "SP_MOSTRAR_PAIS"
                  SUPERSW = True
              Case UCase("RegionMntLocalidades")
                  Sql = "SP_MOSTRAR_REGION"
                  SUPERSW = False
              Case UCase("RegionMntLocalidades1")
                  Sql = "SP_MOSTRAR_REGION " & PARAMETRO1
                  SUPERSW = True
              Case UCase("CiudadMntLocalidades")
                  Sql = "SP_MOSTRAR_CIUDAD" '& PARAMETRO1
                  SUPERSW = False
              Case UCase("CiudadMntLocalidades1")
                  Sql = "SP_MOSTRAR_CIUDAD " & PARAMETRO1
                  SUPERSW = True
              Case UCase("ComunaMntLocalidades")
                  Sql = "SP_MOSTRAR_COMUNA"
                  SUPERSW = False
              Case UCase("ComunaMntLocalidades1")
                  Sql = "SP_MOSTRAR_COMUNA " & PARAMETRO1
                  SUPERSW = True
              Case UCase("PlazaMntLocalidades")
                  Sql = "SP_MOSTRAR_PLAZA"
                  SUPERSW = False
              Case UCase("Sucursales")
                  Sql = "Sp_Mostrar_Sucursal"
                  SUPERSW = True
              Case UCase("EmisoresMnt")
                  Sql = "Sp_Mostrar_Emisores"
                  SUPERSW = True
              Case UCase("PlazosMnt")
                  Sql = "Sp_Mostrar_Plazos"
                  SUPERSW = True
              Case UCase("CategoriasMnt")
                  Sql = "Sp_Mostrar_Categorias"
                  SUPERSW = True
              Case "MDSE"
                Sql = "SP_CON_SERIES"
                SUPERSW = True
          End Select
          
          If Not BAC_SQL_EXECUTE(Sql) Then
              Screen.MousePointer = 0
              Unload Me
              Exit Sub
          End If
      
         Arreglo = Array()
         PROC_ELEMENTO_LIST Arreglo, "Nombre"
         PROC_ELEMENTO_LIST Arreglo, "Codigo"
         
         Call PROC_LLENADO_LIST(Arreglo, True)
      
          Do While BAC_SQL_FETCH(Datos())
              If SUPERSW = True Then
                                             
                  Arreglo = Array()
                  PROC_ELEMENTO_LIST Arreglo, Datos(2)
                  PROC_ELEMENTO_LIST Arreglo, Datos(1)
                  
                  Call PROC_LLENADO_LIST(Arreglo, False)
                  
              Else
                  
                  Arreglo = Array()
                  PROC_ELEMENTO_LIST Arreglo, Datos(3)
                  PROC_ELEMENTO_LIST Arreglo, Datos(1)
                  
                  Call PROC_LLENADO_LIST(Arreglo, False)
                  
                  
              End If
          Loop
          
          Exit Sub
      
      End If
      
      If MiTag = "CONCEPTO_CONTABILIDAD" Then
         
         Arreglo = Array()
         PROC_ELEMENTO_LIST Arreglo, "Código"
         PROC_ELEMENTO_LIST Arreglo, "Nombre"
         
         Call PROC_LLENADO_LIST(Arreglo, True)
             
         If Not BAC_SQL_EXECUTE("SP_CON_CONCEPTO_CONTABILIDAD") Then
             Exit Sub
         End If
         
         Do While BAC_SQL_FETCH(Datos())
             
            Arreglo = Array()
            PROC_ELEMENTO_LIST Arreglo, Datos(1)
            PROC_ELEMENTO_LIST Arreglo, Datos(2)
            
            Call PROC_LLENADO_LIST(Arreglo, False)
             
         Loop
         
         Exit Sub
      
      End If
      
      If MiTag = "CIUDADESMntLocalidades" Then
          
         Arreglo = Array()
         PROC_ELEMENTO_LIST Arreglo, "Nombre"
         PROC_ELEMENTO_LIST Arreglo, "Codigo"
         
         Call PROC_LLENADO_LIST(Arreglo, True)
          
         If Not BAC_SQL_EXECUTE("SP_BUSCA_PAISES") Then
             Exit Sub
         End If
         
         Do While BAC_SQL_FETCH(Datos())
             
            Arreglo = Array()
            PROC_ELEMENTO_LIST Arreglo, Datos(2)
            PROC_ELEMENTO_LIST Arreglo, Datos(1)
            
            Call PROC_LLENADO_LIST(Arreglo, False)
             
         Loop
      
      End If
      
      Aux = ""
      MiTag = UCase(Trim(MiTag))
      If InStr(MiTag, "TBCODIGOSCOMERCIO") > 0 Then
          If Val(right(MiTag, 4)) > 0 Then
              Aux = right(MiTag, 3)
              gsCodigo = Aux
              gsDigito = Val(left(right(MiTag, 4), 1))
      
          End If
          MiTag = "TBCODIGOSCOMERCIO"
      ElseIf InStr(MiTag, "TBCODIGOSOMA") > 0 Then
          Aux = IIf(Val(left(MiTag, 1)) > 0, left(MiTag, 1), "")
          MiTag = "TBCODIGOSOMA"
      End If
      
      Select Case UCase(Trim$(MiTag))
      '---- CONTABILIDAD
      
         Case "CUENTAS", "PERFIL", "CAMPOS", "CONDICIONES", "SISTEMAS"
         
                Call Carga_Tablas_Perfiles(parAyuda, parFiltro, parTipoMo, parTipoOp)
             
         Case "MATRIZ"
                 
                 NomProc = ""
                 Envia = Array()
                 NomProc = "Sp_Ayuda_Clientes"
                 AddParam Envia, "CASA MATRIZ TODAS"
                 AddParam Envia, 0
                 
         Case "MDCL"
         
                 NomProc = ""
                 Envia = Array()
                 NomProc = "Sp_ClLeerNombresX"
                 AddParam Envia, ""
                 AddParam Envia, 0
         
         Case "MDCL_U"
                 NomProc = ""
                 Envia = Array()
                 NomProc = "Sp_ClLeerNombresX"
                 AddParam Envia, ""
                 AddParam Envia, 0
         
         Case "MDCL_BANCOS"
         
            Set objAyuda = New clsCliente
            If Not objAyuda.AyudaBancos("") Then
             Exit Sub
            End If
         
         Case "MDMN_U"
              Set objAyuda = New clsMonedas
              Call objAyuda.LeerMonedas
              Call objAyuda.ColeccionListView(LstAyuda)
               
'               If Not objAyuda.Ayuda("") Then
'                  Exit Sub
'               End If
         
         Case "MDFP_U"
             Set objAyuda = New clsForPago
'              If Not objAyuda.CargaObjectos(BacAyuda.lstNombre) Then
              If Not objAyuda.CargaListView(LstAyuda) Then
                 Screen.MousePointer = 0
            
                 Exit Sub
              End If
         
         
'         Case "MDTC_TASASMERCADO"
'               Set objAyuda = New clsCodigo
'               If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_MTM) Then
'
'                   MsgBox "No es posible cargar información de Ayuda", vbExclamation
'                   Exit Sub
'               End If
         
'         Case "MDTC_TASASMONEDAS"
'
'               Set objAyuda = New clsCodigo
'              If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_TASAS) Then
'                  MsgBox "No es posible cargar información de Ayuda", vbExclamation
'                  Exit Sub
'              End If
         
                '---- Elimina Tasa Fija
'             If bacBuscarCombo(BacAyuda.lstNombre, "FIJA") >= 0 Then
'                BacAyuda.lstNombre.RemoveItem bacBuscarCombo(BacAyuda.lstNombre, "FIJA")
'                BacAyuda.TxtNombre.Text = ""
'             End If
         
'         Case "PAIS"
'
'             Set objAyuda = New clsCodigo
'             If Not objAyuda.CargaObjetos(BacAyuda.lstNombre, MDTC_Pais) Then
'                 MsgBox "No hay informacion de Paises", vbInformation
'                 Exit Sub
'             End If
         
         Case "MDMN"
                 Set objAyuda = New clsMonedas
                 Call objAyuda.LeerMonedas
'                 Call objAyuda.Coleccion2Control(lstNombre)
                 Call objAyuda.ColeccionListView(LstAyuda)
         Case "MDEM"
                  Set objAyuda = New clsEmisores
                  Call objAyuda.LeerEmisores("", "T")
                  Call MDEM_LlenaGrilla
            
         Case "MDCT" 'Ayuda de categorías
                  Set objAyuda = New clsCategorias
                  Call objAyuda.leeCategoria(0)
                  'Call objAyuda.Coleccion2Control(lstNombre)
                  Call MDCT_LlenaGrilla
            
         Case "MDIN"
                  Set objAyuda = New clsFamilias
                  Call objAyuda.LeerFamilias
                  Call objAyuda.ColeccionListView(LstAyuda)
                  'Call objAyuda.Coleccion2Control(lstNombre)
              
         Case "MDSE"
                   MDSE_LlenarGrilla
             
             
         Case "PROD_CAMPOS"
                    Call Carga_Campos_Productos
             
         Case "PROD_CAMPOSLOGICOS"
                    Call Carga_CamposLogicos_Productos
            
         Case "XPROD_CAMPOSLOGICOS"
                    Call Carga_CamposLogicos_x_Productos
             
         Case "TBCODIGOSOMA"
                     idtipo = IIf(Val(Aux) = 0, 15, 16)
                     Set objAyuda = New clsHelpges
                     Call objAyuda.leemonedcambio("")
                     Call MEVM_LlenaGrilla
                     Me.Caption = Me.Caption & "    Codigos OMA"
                     MiTag = Aux & MiTag
                 
                 
         Case "TBCODIGOSCOMERCIO"
                     MiTag = "TBCODIGOSCOMERCIO"
                     
                     NomProc = ""
                     Envia = Array()
                     NomProc = "sp_leer_codigos_comercio"
                     AddParam Envia, ""
                     Me.Caption = "Códigos de Comercio y Conceptos"
      
         Case "COMERCIO"
                    Call Carga_Comercio
      
         
         Case "MECLA"
                     idtipo = 4
                     Set objAyuda = New clsHelpges
                     Call objAyuda.leemonedcambio("")
                     'Call objAyuda.Coleccion2Control(lstNombre)
                     Call MEVM_LlenaGrilla
                     Me.Caption = Me.Caption & "          Tabla de Glosas"
         
         Case "MFMNME"
                     Set objAyuda = New clsMonedas
                     objAyuda.LeerMonedas
'                     Call objAyuda.Coleccion2Control2(2, lstNombre)
                     Call objAyuda.ColeccionListView(LstAyuda)
         Case "CAMPO_CONTABILIDAD"
         
                 NomProc = ""
                 NomProc = "SP_CON_CAMPO_CONTABILIDAD"
                 
         Case "CODIGO_OPERACION_CONTABILIDAD"
                 
                 NomProc = ""
                 NomProc = "SP_CON_CODIGO_OPERACION_CONTABILIDAD"
                 
         Case "NOMBRE_CAMPO_CONTABILIDAD"
         
                 NomProc = ""
                 NomProc = "SP_CON_NOMBRE_CAMPO_CONTABILIDAD"
                 Envia = Array()
                 AddParam Envia, cCAMPO_CONTABILIDAD_SISTEMA
                 AddParam Envia, cCAMPO_CONTABILIDAD_CODIGO_PRODUCTO
        Case "FFMM"
                Call Fondos_Mutuos_LlenarGrilla
                     
        Case "MDCL_FFMM"
                 NomProc = ""
                 Envia = Array()
                 NomProc = "Sp_ClLeerNombres"
                 AddParam Envia, ""
                 AddParam Envia, 5
         Case Else               '---- Carga otros
             
                     Call Carga(MiTag)
      
      End Select
      
   Dim Espacio0
   Dim Espacio1
   Dim TRUT As String
       
   If Trim$(UCase(MiTag)) = "MDCL" Or Trim$(UCase(MiTag)) = "MATRIZ" _
        Or Trim$(UCase(MiTag)) = "MDCL_U" Or Trim$(UCase(MiTag)) = "MDCL_FFMM" Then
       
              If Not BAC_SQL_EXECUTE(NomProc, Envia) Then
                 MousePointer = 0
                 Exit Sub
              
              End If
              
              Dim SW As Boolean
              SW = False
   
              Do While BAC_SQL_FETCH(Datos())
                 
                 If Datos(1) <> "ERROR" Then
                     
                   If Trim$(UCase(MiTag)) = "MDCL" Or Trim$(UCase(MiTag)) = "MDCL_U" _
                        Or Trim$(UCase(MiTag)) = "MDCL_FFMM" Then
                     
                        If Titulo Then
                     
                           Arreglo = Array()
                           PROC_ELEMENTO_LIST Arreglo, "Cliente"
                           PROC_ELEMENTO_LIST Arreglo, "Rut"
                           PROC_ELEMENTO_LIST Arreglo, "Codigo"
                           Call PROC_LLENADO_LIST(Arreglo, True)
                           Titulo = False
                        
                        End If
                        
                        LstAyuda.Sorted = False
                        LstAyuda.AllowColumnReorder = False
                        
                        
                        LstAyuda.ListItems.Add , , Datos(4)
                        LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(1)
                        LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(3)
                        
                        'Debug.Print Datos(4), Datos(1), Datos(3)
                     
                        SW = True
                  Else
                                    
                     Espacio0 = 50 - Len(Mid(Datos(3), 1, 48))
                     Espacio1 = 15 - Len(Mid(Datos(1), 1, 14))
                    
                     SW = True
                     If UCase(MiTag) = "MATRIZ" Then

                           If Titulo Then
                        
                              Arreglo = Array()
                              PROC_ELEMENTO_LIST Arreglo, "Cliente"
                              PROC_ELEMENTO_LIST Arreglo, "Rut"
                              PROC_ELEMENTO_LIST Arreglo, "Codigo"
                              Call PROC_LLENADO_LIST(Arreglo, True)
                              Titulo = False
                           
                           End If
                          
                           LstAyuda.ListItems.Add , , Datos(3)
                           LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(4)
                           LstAyuda.ListItems.Item(.ListItems.Count).ListSubItems.Add , , Datos(2)
                          
                          'lstNombre.AddItem Mid(Datos(3), 1, 48) + Space(Espacio0) + Datos(1) + Space(Espacio1) + Datos(2) + Space(100) + Datos(2) + Space(100) + Datos(4)

                     End If

                  End If
                 
                 End If
              
              Loop
              
   End If
   If Trim$(UCase(MiTag)) = "TBCODIGOSCOMERCIO" Then
   
              If Not BAC_SQL_EXECUTE(NomProc, Envia) Then
                 MousePointer = 0
                 Exit Sub
              
              End If
              
               Arreglo = Array()
               PROC_ELEMENTO_LIST Arreglo, "Código"
               PROC_ELEMENTO_LIST Arreglo, "Descripción"
               
               Call PROC_LLENADO_LIST(Arreglo, True)
              
              
             Do While BAC_SQL_FETCH(Datos())
                 
                 If Datos(1) <> "ERROR" Then
                     
                   If Trim$(UCase(MiTag)) = "TBCODIGOSCOMERCIO" Then
                     
                     Espacio0 = 8 - Len(Datos(1))
                           
                     If UCase(MiTag) = "TBCODIGOSCOMERCIO" Then
                    
                           Arreglo = Array()
                           PROC_ELEMENTO_LIST Arreglo, Datos(1)
                           PROC_ELEMENTO_LIST Arreglo, Datos(2)
                           
                           Call PROC_LLENADO_LIST(Arreglo, False)
                           
                          'lstNombre.AddItem Datos(1) + Space(Espacio0) + UCase(Datos(2))
                    
                     End If
                  End If
                End If
              Loop
   End If
   If MiTag = "CAMPO_CONTABILIDAD" Then
            Arreglo = Array()
            PROC_ELEMENTO_LIST Arreglo, "Descripcion"
            PROC_ELEMENTO_LIST Arreglo, "Concepto Programa"
            
            Call PROC_LLENADO_LIST(Arreglo, True)
         
            If Not BAC_SQL_EXECUTE(NomProc) Then
               MousePointer = 0
               Exit Sub
            End If
              
            Do While BAC_SQL_FETCH(Datos())
                
               Arreglo = Array()
               PROC_ELEMENTO_LIST Arreglo, Datos(4)
               PROC_ELEMENTO_LIST Arreglo, Datos(1)
               PROC_ELEMENTO_LIST Arreglo, Datos(2)
               PROC_ELEMENTO_LIST Arreglo, Datos(3)
               
               Call PROC_LLENADO_LIST(Arreglo, False)
                
            Loop
              
    End If
   If MiTag = "NOMBRE_CAMPO_CONTABILIDAD" Then
            Arreglo = Array()
            PROC_ELEMENTO_LIST Arreglo, "Descripcion"
            
            Call PROC_LLENADO_LIST(Arreglo, True)
         
            If Not BAC_SQL_EXECUTE(NomProc, Envia) Then
               MousePointer = 0
               Exit Sub
            End If
              
            Do While BAC_SQL_FETCH(Datos())
                
               Arreglo = Array()
               PROC_ELEMENTO_LIST Arreglo, Datos(1)
               PROC_ELEMENTO_LIST Arreglo, Datos(2)
               
               Call PROC_LLENADO_LIST(Arreglo, False)
                
            Loop
              
    End If
    
   If MiTag = "CODIGO_OPERACION_CONTABILIDAD" Then
   
            Arreglo = Array()
            
            PROC_ELEMENTO_LIST Arreglo, "Descripcion"
            PROC_ELEMENTO_LIST Arreglo, "Código"
            
            Call PROC_LLENADO_LIST(Arreglo, True)
         
            If Not BAC_SQL_EXECUTE(NomProc) Then
               MousePointer = 0
               Exit Sub
            End If
              
            Do While BAC_SQL_FETCH(Datos())
                
               Arreglo = Array()
               PROC_ELEMENTO_LIST Arreglo, Datos(8)
               PROC_ELEMENTO_LIST Arreglo, Datos(1)
               
               Call PROC_LLENADO_LIST(Arreglo, False)
                
            Loop
              
    End If
      
      
      .Sorted = True
      .AllowColumnReorder = True
      .ColumnHeaderIcons = ImageList2
   
   End With

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


Private Sub PROC_ORDEN_LIST(Indice As Integer)
Dim nColumna    As Integer
Dim Arreglo()
   
   For nColumna = 1 To LstAyuda.ColumnHeaders.Count
      
      LstAyuda.ColumnHeaders.Item(nColumna).Icon = 0
   
   Next nColumna
   
   LstAyuda.SortKey = Indice - 1
   
   If LstAyuda.SortOrder = 0 Then

      LstAyuda.SortOrder = lvwDescending
      LstAyuda.ColumnHeaders.Item(Indice).Icon = 1
         
   Else
      LstAyuda.SortOrder = lvwAscending
      LstAyuda.ColumnHeaders.Item(Indice).Icon = 2
 
   End If

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
               Bac_SendKey vbKeyLeft
               .SetFocus
               Exit For
            
            End If
   
         Else
   
            If UCase(Mid(.ListItems(nFila).ListSubItems.Item(Val(LblBuscarPor.Tag)).Text, 1, Len(Elemento))) = Elemento Then
               .ListItems.Item(nFila).Selected = True
               .SetFocus
               Bac_SendKey vbKeyLeft
               Exit For
            
            End If
   
         End If
   
      Next nFila
   
   End With

End Sub



Private Sub PROC_ELEMENTO_LIST(ByRef Arreglo As Variant, Parametro As Variant)
Dim nCuenta As Integer
   
   On Error GoTo errorcuenta:
   
   nCuenta = UBound(Arreglo) + 1
   ReDim Preserve Arreglo(nCuenta)
   Arreglo(nCuenta) = Parametro
   
   Exit Sub

errorcuenta:
   
   nCuenta = 1
   Resume Next

End Sub

Private Sub TxtBuscar_KeyPress(KeyAscii As Integer)
   
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

   If KeyAscii = vbKeyReturn Then
      PROC_BUSCA_ELEMENTO TxtBuscar.Text
   End If

End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)

  Select Case UCase(Button.Description)
    Case "ACEPTAR"
         
      Dim Rut
      Dim NomProc As String
      Dim Datos()
      
      Rut = LstAyudaCliente.ListItems.Item(LstAyudaCliente.SelectedItem.Index).ListSubItems(1).Text
      codigo = LstAyudaCliente.ListItems.Item(LstAyudaCliente.SelectedItem.Index).ListSubItems(2).Text
      
      Envia = Array()
      NomProc = "sp_Busca_Cliente_Rut"
      AddParam Envia, Rut
      AddParam Envia, codigo

                
      If Not BAC_SQL_EXECUTE(NomProc, Envia) Then
            MsgBox "Error al buscar Cliente", vbInformation
            Exit Sub
      End If

      If BAC_SQL_FETCH(Datos()) Then
         gsCodigo$ = Datos(1)       'clrut
         gsrut$ = Datos(1)          'clrut
         gsDigito$ = Datos(2)       'cldv
         gsDescripcion$ = Datos(4)  'clnombre
         gsFax$ = Datos(5)          'clfax
         gsCodCli = Datos(3)        'clcodigo
         gsValor$ = Datos(3)        'clcodigo
      Else
         MsgBox "Cliente no encontrado", vbInformation
      End If
          
      giAceptar% = True
      Unload Me

    Case "SALIR"
        Botones.Buttons(1).Enabled = True
        Botones.Buttons(2).Enabled = True
        Botones.Buttons(3).Enabled = True
        TxtBuscar.Text = ""
        FraBuscaCliente.Visible = False
  End Select
  
End Sub

Private Sub LstAyudaCliente_DblClick()
   Call Toolbar2_ButtonClick(Botones.Buttons(1))
End Sub

Private Sub PROC_DETALLE()
   Dim cEspacio
   Dim cRut       As String

   If Trim$(MiTag) = "MDCL" Or Trim$(MiTag) = "MATRIZ" Or Trim$(MiTag) = "MDCL_FFMM" Then
      LstAyudaCliente.Sorted = False
      LstAyudaCliente.AllowColumnReorder = False
      
      LstAyudaCliente.ListItems.Clear
   
      Envia = Array()
      AddParam Envia, "CBUS"
      AddParam Envia, LstAyuda.ListItems.Item(LstAyuda.SelectedItem.Index).ListSubItems(1).Text
   
      If Not BAC_SQL_EXECUTE("SP_CON_AYUDA_DEPENDENCIA", Envia) Then
          Exit Sub
      End If
   
      Do While BAC_SQL_FETCH(Datos())
           codigo = Datos(1)
      Loop
   
      If codigo = 0 Then
         Exit Sub
      Else
         Botones.Buttons(1).Enabled = False
         Botones.Buttons(2).Enabled = False
         Botones.Buttons(3).Enabled = False
         FraBuscaCliente.Visible = True
   
         Envia = Array()
         AddParam Envia, "BDEPE"
         AddParam Envia, CDbl(LstAyuda.ListItems.Item(LstAyuda.SelectedItem.Index).ListSubItems(1).Text)
   
         If Not BAC_SQL_EXECUTE("SP_CON_AYUDA_DEPENDENCIA", Envia) Then
             Exit Sub
         End If
   
         Do While BAC_SQL_FETCH(Datos())
   
            cRut = Trim(Datos(1)) + "-" + Trim(Datos(2))
            cEspacio = 42 - Len(Mid(Datos(4), 1, 38))
            
            LstAyudaCliente.Sorted = False
            LstAyudaCliente.AllowColumnReorder = False
   
            LstAyudaCliente.ListItems.Add , , Datos(4)
            LstAyudaCliente.ListItems.Item(LstAyudaCliente.ListItems.Count).ListSubItems.Add , , Datos(1)
            LstAyudaCliente.ListItems.Item(LstAyudaCliente.ListItems.Count).ListSubItems.Add , , Datos(3)
   
         Loop
   
      End If
   End If
End Sub

Private Sub PROC_LLENADO_LIST_CLIENTE(Arreglo As Variant, Titulos As Boolean)

Dim nRegistro As Integer

   With LstAyudaCliente
      
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

Private Sub TxtBuscarCliente_GotFocus()
   TxtBuscarCliente.SelStart = Len(TxtBuscarCliente.Text)
End Sub

Private Sub TxtBuscarCliente_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyUp Or KeyCode = vbKeyDown Then
      TxtBuscarCliente_KeyPress vbKeyReturn
      LstAyudaCliente_KeyDown KeyCode, Shift
   End If
End Sub

Private Sub TxtBuscarCliente_KeyPress(KeyAscii As Integer)
   
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

   If KeyAscii = vbKeyReturn Then
      PROC_BUSCA_ELEMENTO_CLIENTE TxtBuscarCliente.Text
   End If

End Sub

Private Sub LstAyudaCliente_KeyDown(KeyAscii As Integer, Shift As Integer)

   If KeyAscii = vbKeyUp Or KeyAscii = vbKeyDown Or KeyAscii = vbKeyLeft Or KeyAscii = vbKeyRight Or KeyAscii = vbKeyPageUp Or KeyAscii = vbKeyPageDown Then
      Call LstAyudaCliente_Click
      LstAyudaCliente.SetFocus
      Exit Sub
   End If

End Sub

Private Sub LstAyudaCliente_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyUp Or KeyAscii = vbKeyDown Or KeyAscii = vbKeyLeft Or KeyAscii = vbKeyRight Or KeyAscii = vbKeyPageUp Or KeyAscii = vbKeyPageDown Then
      Call LstAyudaCliente_Click
      Exit Sub
   End If

   If KeyAscii = vbKeyReturn Then
      Call LstAyudaCliente_DblClick
      Exit Sub
   End If

   TxtBuscarCliente.Text = UCase(Chr(KeyAscii))
   'TxtBuscarCliente.SetFocus
   
End Sub

Private Sub LstAyudaCliente_Click()
   TxtBuscarCliente.Text = LstAyudaCliente.SelectedItem.Text
End Sub

Private Sub PROC_BUSCA_ELEMENTO_CLIENTE(Elemento As String)

Dim nFila As Integer

On Error Resume Next

   Elemento = UCase(Elemento)

   With LstAyudaCliente
   
      For nFila = 1 To .ListItems.Count
   
            If UCase(Mid(.ListItems.Item(nFila).Text, 1, Len(Elemento))) = Elemento Then
               .ListItems.Item(nFila).Selected = True
               Bac_SendKey vbKeyLeft
               .SetFocus
               Exit For
            
            End If
   
      Next nFila
   
   End With

End Sub
Private Sub PROC_BUSCA_ELEMENTO_PARCIAL(Elemento As String)
Dim nFila As Integer
Dim nIndex As Integer

On Error Resume Next

   Elemento = UCase(Elemento)

   With LstAyuda
   
      For nFila = 1 To .ListItems.Count
            If InStr(1, .ListItems.Item(nFila).Text, Elemento, vbTextCompare) = 1 Then
            
                '.ListItems.Item(nFila).Selected = True
                
                
'         If Val(LblBuscarPor.Tag) = 0 Then
'
'            If UCase(Mid(.ListItems.Item(nFila).Text, 1, Len(Elemento))) = Elemento Then
'               .ListItems.Item(nFila).Selected = True
'               .SetFocus
'               Exit For
'            End If
'
'         Else
'
'            If UCase(Mid(.ListItems(nFila).ListSubItems.Item(Val(LblBuscarPor.Tag)).Text, 1, Len(Elemento))) = Elemento Then
'               .ListItems.Item(nFila).Selected = True
'               .SetFocus
'               Exit For
'            End If
'
'         End If
        End If
      Next nFila
   
   End With

End Sub

