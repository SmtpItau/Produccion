VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_FILTRO_VCPACTO 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Filtro Ventas Con Pacto"
   ClientHeight    =   6255
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8490
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6255
   ScaleWidth      =   8490
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame SSFrame4 
      Height          =   1620
      Left            =   5745
      TabIndex        =   4
      Top             =   1305
      Width           =   2700
      _Version        =   65536
      _ExtentX        =   4762
      _ExtentY        =   2857
      _StockProps     =   14
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
      Begin MSComctlLib.ListView LstCategoria 
         Height          =   1470
         Left            =   60
         TabIndex        =   22
         Top             =   105
         Width           =   2580
         _ExtentX        =   4551
         _ExtentY        =   2593
         View            =   3
         MultiSelect     =   -1  'True
         LabelWrap       =   0   'False
         HideSelection   =   -1  'True
         Checkboxes      =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         NumItems        =   0
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   1620
      Left            =   2880
      TabIndex        =   3
      Top             =   1305
      Width           =   2820
      _Version        =   65536
      _ExtentX        =   4974
      _ExtentY        =   2857
      _StockProps     =   14
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
      Begin MSComctlLib.ListView LstCartera 
         Height          =   1470
         Left            =   30
         TabIndex        =   24
         Top             =   105
         Width           =   2760
         _ExtentX        =   4868
         _ExtentY        =   2593
         View            =   3
         MultiSelect     =   -1  'True
         LabelWrap       =   0   'False
         HideSelection   =   -1  'True
         Checkboxes      =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         NumItems        =   0
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   1605
      Left            =   15
      TabIndex        =   2
      Top             =   1305
      Width           =   2850
      _Version        =   65536
      _ExtentX        =   5027
      _ExtentY        =   2831
      _StockProps     =   14
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
      Begin MSComctlLib.ListView LstLibro 
         Height          =   1470
         Left            =   0
         TabIndex        =   23
         Top             =   105
         Width           =   2790
         _ExtentX        =   4921
         _ExtentY        =   2593
         View            =   3
         MultiSelect     =   -1  'True
         LabelWrap       =   0   'False
         HideSelection   =   -1  'True
         Checkboxes      =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         NumItems        =   0
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   630
      Left            =   15
      TabIndex        =   1
      Top             =   540
      Width           =   8445
      _Version        =   65536
      _ExtentX        =   14896
      _ExtentY        =   1111
      _StockProps     =   14
      Caption         =   "Entidad"
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
      Begin VB.ComboBox CMBEntidad 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   210
         Width           =   7665
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8490
      _ExtentX        =   14975
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ACEPTAR"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SALIR"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5355
         Top             =   30
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
               Picture         =   "FRM_FILTRO_VCPACTO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_VCPACTO.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   3
      Left            =   60
      TabIndex        =   5
      Top             =   3015
      Width           =   1950
      _Version        =   65536
      _ExtentX        =   3440
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Familias"
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
      Begin VB.OptionButton Opt_sel_fam 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   8
         Top             =   630
         Width           =   1320
      End
      Begin VB.OptionButton Opt_tod_fam 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   7
         Top             =   360
         Width           =   1290
      End
      Begin VB.ListBox lstFamilias 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   1815
         Left            =   120
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   885
         Width           =   1668
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   4
      Left            =   2145
      TabIndex        =   9
      Top             =   3015
      Width           =   1950
      _Version        =   65536
      _ExtentX        =   3440
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Emisores"
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
      Begin VB.ListBox lstEmisores 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1815
         Left            =   90
         MultiSelect     =   1  'Simple
         TabIndex        =   15
         Top             =   855
         Width           =   1650
      End
      Begin VB.OptionButton Opt_sel_emi 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   165
         TabIndex        =   11
         Top             =   630
         Width           =   1245
      End
      Begin VB.OptionButton Opt_tod_emi 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   165
         TabIndex        =   10
         Top             =   360
         Width           =   1065
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   0
      Left            =   4230
      TabIndex        =   12
      Top             =   3015
      Width           =   1950
      _Version        =   65536
      _ExtentX        =   3440
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Monedas"
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
      Begin VB.ListBox lstMonedas 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1815
         Left            =   75
         MultiSelect     =   1  'Simple
         TabIndex        =   21
         Top             =   855
         Width           =   1740
      End
      Begin VB.OptionButton Opt_tod_mon 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   14
         Top             =   360
         Width           =   1290
      End
      Begin VB.OptionButton Opt_sel_mon 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   13
         Top             =   630
         Width           =   1320
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   2895
      Index           =   1
      Left            =   6285
      TabIndex        =   16
      Top             =   3015
      Width           =   2145
      _Version        =   65536
      _ExtentX        =   3784
      _ExtentY        =   5106
      _StockProps     =   14
      Caption         =   "Series del Instrumento"
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
      Begin VB.OptionButton opt_sel_ser 
         Caption         =   "Selección"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   19
         Top             =   630
         Width           =   1320
      End
      Begin VB.OptionButton opt_tod_ser 
         Caption         =   "Todas"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   135
         TabIndex        =   18
         Top             =   360
         Width           =   1290
      End
      Begin VB.ListBox lstSeries 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   1815
         Left            =   90
         MultiSelect     =   1  'Simple
         Sorted          =   -1  'True
         TabIndex        =   17
         TabStop         =   0   'False
         Top             =   870
         Width           =   1668
      End
   End
End
Attribute VB_Name = "FRM_FILTRO_VCPACTO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const Descripcion = 1
Const Codigo = 2
Dim bRefrescar             As Boolean
   
Dim I%
Dim cCadena_Libros      As String
Dim cCadena_Cartera     As String
Dim cCadena_CatSuper    As String
Dim cCadena_Familia     As String
Dim cCadena_Emisor      As String
Dim cCadena_Moneda      As String
   
Sub Proc_Llena_Cadena()

   cCadena_Familia = ""
   cCadena_Emisor = ""
   cCadena_Moneda = ""
   cCadena_Libros = ""
   cCadena_Cartera = ""
   cCadena_CatSuper = ""
    
   Screen.MousePointer = vbHourglass
       
   'Libros
   If LstLibro.ListItems.Count > 0 Then
   For I% = 1 To LstLibro.ListItems.Count
      If LstLibro.ListItems.Item(I%).Checked = True Then
         Let cCadena_Libros = cCadena_Libros & "-" & CStr(LstLibro.ListItems.Item(I%).ListSubItems(1).Text)
      End If
   Next I%
   End If
   
   'Cartera
   If LstCartera.ListItems.Count > 0 Then
   For I% = 1 To LstCartera.ListItems.Count
      If LstCartera.ListItems.Item(I%).Checked = True Then
         Let cCadena_Cartera = cCadena_Cartera & "-" & CStr(LstCartera.ListItems.Item(I%).ListSubItems(1).Text)
      End If
   Next I%
   End If
   
   'Categoria Super
   If LstCategoria.ListItems.Count > 0 Then
   For I% = 1 To LstCategoria.ListItems.Count
      If LstCategoria.ListItems.Item(I%).Checked = True Then
         Let cCadena_CatSuper = cCadena_CatSuper & "-" & CStr(LstCategoria.ListItems.Item(I%).ListSubItems(1).Text)
      End If
   Next I%
   End If
       
   If lstFamilias.SelCount > 0 Then
        For I% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(I%) = True Then
                cCadena_Familia = cCadena_Familia & "-" & lstFamilias.List(I%)
            End If
        Next I%
   End If
    
   If lstEmisores.SelCount > 0 Then
        For I% = 0 To lstEmisores.ListCount - 1
            If lstEmisores.Selected(I%) = True Then
                cCadena_Emisor = cCadena_Emisor & "-" & lstEmisores.List(I%)
            End If
        Next I%
   End If
    
    If lstMonedas.SelCount > 0 Then
        For I% = 0 To lstMonedas.ListCount - 1
            If lstMonedas.Selected(I%) = True Then
                cCadena_Moneda = cCadena_Moneda & "-" & lstMonedas.List(I%)
            End If
        Next I%
    End If
                
    '''ProTipOper
    
    Proc_Busca_Papeles_Disponibles "VI", _
                                    cCadena_Familia, _
                                    cCadena_Emisor, _
                                    cCadena_Moneda, _
                                    cCadena_Libros, _
                                    cCadena_CatSuper, _
                                    cCadena_Cartera

                                    
                          
    Screen.MousePointer = vbDefault
    
End Sub


Private Function FuncLoadLibro()
   Dim Datos()

   LstLibro.ColumnHeaders.Clear
   LstLibro.ColumnHeaders.Add Descripcion, "A", "Libro", 2700
   LstLibro.ColumnHeaders.Add Codigo, "B", "Código", 1

   Envia = Array()
   AddParam Envia, CDbl(1)
   
   If Not Bac_Sql_Execute("DBO.SP_CARGA_FILTRO", Envia) Then
      Call MsgBox("Se ha originado un error en la consulta SQL.", vbExclamation, App.Title)
      Exit Function
   End If
   
   LstLibro.ListItems.Clear
   Do While Bac_SQL_Fetch(Datos())
      LstLibro.ListItems.Add , , Datos(2)
      LstLibro.ListItems.Item(LstLibro.ListItems.Count).ListSubItems.Add , , Datos(1)
   Loop
End Function

Private Function FuncLoadTipoCartera()
   Dim Datos()
   
   LstCartera.ColumnHeaders.Clear
   LstCartera.ColumnHeaders.Add Descripcion, "A", "Tipo Cartera", 2700
   LstCartera.ColumnHeaders.Add Codigo, "B", "Código", 1

   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, 0
   AddParam Envia, ""
   
   If Not Bac_Sql_Execute("DBO.SP_CARGA_FILTRO", Envia) Then
      Call MsgBox("Se ha originado un error en la consulta SQL.", vbExclamation, App.Title)
      Exit Function
   End If
   
   LstCartera.ListItems.Clear
   
   Do While Bac_SQL_Fetch(Datos())
      LstCartera.ListItems.Add , , Datos(2)
      LstCartera.ListItems.Item(LstCartera.ListItems.Count).ListSubItems.Add , , Datos(1)
   Loop
   
End Function

Private Function FuncLoadCategoriaSuper()
   
   Dim Datos()
    
   LstCategoria.ColumnHeaders.Clear
   LstCategoria.ColumnHeaders.Add Descripcion, "A", "Categoría Cartera Super", 2500
   LstCategoria.ColumnHeaders.Add Codigo, "B", "Código", 1
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, 0
   AddParam Envia, cCadena_Libros
   
   If Not Bac_Sql_Execute("DBO.SP_CARGA_FILTRO", Envia) Then
      Call MsgBox("Se ha originado un error en la consulta SQL.", vbExclamation, App.Title)
      Exit Function
   End If
   
   LstCategoria.ListItems.Clear
   
   Do While Bac_SQL_Fetch(Datos())
      LstCategoria.ListItems.Add , , Datos(2)
      LstCategoria.ListItems.Item(LstCategoria.ListItems.Count).ListSubItems.Add , , Datos(1)
   Loop
   
End Function

Private Sub Form_Load()
    
    BacCentrarPantalla Me
    Set objDCartera = New clsDCarteras
    bRefrescar = True
    
    Call objDCartera.LeerDCarteras("")
    Call objDCartera.Coleccion2Control(Me.CMBEntidad)
   
    CMBEntidad.Enabled = True
    CMBEntidad.ListIndex = IIf(CMBEntidad.ListCount > 0, 0, -1)
    
    lstFamilias.Clear
    lstEmisores.Clear
    lstMonedas.Clear
    
    Opt_sel_fam.Value = True
    Opt_sel_emi.Value = True
    Opt_sel_mon.Value = True
    opt_sel_ser.Value = True
    
   ' Call FuncLoadEntidad
    Call FuncLoadLibro
    
    If LstLibro.ListItems.Count > 0 Then
        LstLibro.ListItems.Item(1).Checked = True
        Let cCadena_Libros = CStr(LstLibro.ListItems.Item(1).ListSubItems(1).Text)
    End If
        
    Call FuncLoadTipoCartera
    
    If LstCartera.ListItems.Count > 0 Then
        LstCartera.ListItems.Item(1).Checked = True
        Let cCadena_Cartera = CStr(LstCartera.ListItems.Item(1).ListSubItems(1).Text)
    End If
    
    Call FuncLoadCategoriaSuper
    
    If LstCategoria.ListItems.Count > 0 Then
        LstCategoria.ListItems.Item(1).Checked = True
        Let cCadena_CatSuper = CStr(LstCategoria.ListItems.Item(1).ListSubItems(1).Text)
    End If
    
    Call FuncLoadFamilia
    Call FuncLoadEmisores
    Call FuncLoadMonedas
    Call FuncLoadSeries

    
    
    BacControlWindows 12
    SendKeys "{TAB}"
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set objDCartera = Nothing
End Sub


Private Sub LstCartera_Click()
    
    For nContador = 0 To lstEmisores.ListCount - 1
        lstEmisores.Selected(nContador) = False
    Next nContador
    
    For nContador = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(nContador) = False
    Next nContador

    For nContador = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(nContador) = False
    Next nContador
    
    Call Proc_Llena_Cadena
   
    Call FuncLoadFamilia
    Call FuncLoadEmisores
    Call FuncLoadMonedas
    Call FuncLoadSeries
    
End Sub

Private Sub LstCategoria_Click()
    
    For nContador = 0 To lstEmisores.ListCount - 1
        lstEmisores.Selected(nContador) = False
    Next nContador
    
    For nContador = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(nContador) = False
    Next nContador

    For nContador = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(nContador) = False
    Next nContador
   
   Call Proc_Llena_Cadena

   Call FuncLoadFamilia
   Call FuncLoadEmisores
   Call FuncLoadMonedas
   Call FuncLoadSeries
    
End Sub

Private Sub lstEmisores_Click()

    If lstFamilias.SelCount > 0 And bRefrescar = True Then
                
        lstSeries.Clear
        
        Call Proc_Llena_Cadena
    
    End If
End Sub

Private Sub lstFamilias_Click()
    
    lstSeries.Clear
    
    If lstFamilias.SelCount > 0 And bRefrescar = True Then
    
       Call Proc_Llena_Cadena
           
    End If

End Sub

Private Sub LstLibro_Click()
    Dim sw As Integer
    
    sw = 0
    
    For nContador = 0 To lstEmisores.ListCount - 1
        lstEmisores.Selected(nContador) = False
    Next nContador
    
    For nContador = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(nContador) = False
    Next nContador

    For nContador = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(nContador) = False
    Next nContador
    
    For I% = 1 To LstLibro.ListItems.Count
        If LstLibro.ListItems.Item(I%).Checked = True Then
            sw = 1
        End If
    Next I%
    
    If sw = 1 Then
        Call Proc_Llena_Cadena
        Call FuncLoadTipoCartera
        Call FuncLoadCategoriaSuper
        Call FuncLoadFamilia
        Call FuncLoadEmisores
        Call FuncLoadMonedas
        Call FuncLoadSeries
        
    Else
        LstCartera.ListItems.Clear
        LstCategoria.ListItems.Clear
        lstFamilias.Clear
        lstEmisores.Clear
        lstSeries.Clear
    End If
End Sub


Private Sub LstLibro_ItemCheck(ByVal Item As MSComctlLib.ListItem)

         Dim I%
         
         For I% = 1 To LstLibro.ListItems.Count
            If LstLibro.ListItems.Item(I%).Checked = True Then
                If I% <> Item.Index Then
                        LstLibro.ListItems.Item(I%).Checked = False
                End If
            End If
         Next I%

End Sub

Private Sub lstMonedas_Click()
    If lstFamilias.SelCount > 0 And bRefrescar = True Then
    
        lstSeries.Clear
                
        Call Proc_Llena_Cadena
    
    End If
End Sub

Private Sub Opt_sel_emi_Click()
   Dim I As Integer
   
   bRefrescar = False
   
   For I% = 0 To lstEmisores.ListCount - 1
       lstEmisores.Selected(I%) = False
   Next I%
   
   DoEvents
   
   bRefrescar = True
   
   lstSeries.Clear
   Call Proc_Llena_Cadena
End Sub

Private Sub Opt_sel_fam_Click()
   Dim I As Integer
   
    lstSeries.Clear
    bRefrescar = False
   
    For I% = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(I%) = False
    Next I%
    
    bRefrescar = True

End Sub

Private Sub Opt_sel_mon_Click()
   Dim I As Integer
   
    bRefrescar = False
   
   For I% = 0 To lstMonedas.ListCount - 1
       lstMonedas.Selected(I%) = False
   Next I%
   
   DoEvents
   
   bRefrescar = True
   
   lstSeries.Clear
   Call Proc_Llena_Cadena
End Sub

Private Sub opt_sel_ser_Click()
   Dim I As Integer
   For I% = 0 To lstSeries.ListCount - 1
       lstSeries.Selected(I%) = False
   Next I%

End Sub

Private Sub Opt_tod_emi_Click()
    Dim I As Integer

    bRefrescar = False

    For I% = 0 To lstEmisores.ListCount - 1
        lstEmisores.Selected(I%) = True
    Next I%
    
    DoEvents

    bRefrescar = True
    
    Call lstEmisores_Click

End Sub

Private Sub Opt_tod_fam_Click()
     Dim I As Integer
    
    bRefrescar = False

    For I% = 0 To lstFamilias.ListCount - 1
        lstFamilias.Selected(I%) = True
    Next I%
    
    DoEvents
        
    bRefrescar = True
    
    Call lstFamilias_Click
    
   ' Marco(6).Enabled = False

End Sub

Private Sub Opt_tod_mon_Click()
    Dim I As Integer

    bRefrescar = False

    For I% = 0 To lstMonedas.ListCount - 1
        lstMonedas.Selected(I%) = True
    Next I%
    
    DoEvents
    
    bRefrescar = True
    
    Call lstMonedas_Click

End Sub

Private Sub opt_tod_ser_Click()
   Dim I As Integer
   
   If lstSeries.ListCount < 9 Then
      For I% = lstSeries.TopIndex To lstSeries.ListCount - 1
          lstSeries.Selected(I%) = True
      Next I%
   Else
      For I% = lstSeries.TopIndex To lstSeries.TopIndex + 8
          lstSeries.Selected(I%) = True
      Next I%
   End If
End Sub







Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 Select Case Button.Index
    Case 1
        Call Aceptar
    Case 2
        Call Cancelar
 End Select
End Sub

Private Sub Cancelar()
 On Error GoTo BacErrHnd

    giAceptar% = False
    Unload FRM_FILTRO_VCPACTO

    Exit Sub

BacErrHnd:
    MsgBox "ERROR", vbExclamation, "MENSAJE"
    On Error GoTo 0
    Resume
End Sub

Function Validar_Seleccion_FM() As Boolean
Dim irow As Integer
Dim noOk As Boolean
Dim SiFMUT As Boolean
Dim I%

noOk = False
SiFMUT = False

    'Familias
    If lstFamilias.SelCount > 0 Then
        For I% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(I%) = True And lstFamilias.List(I%) = "FMUTUO" Then
                SiFMUT = True
            End If
        Next I%
    End If

    If SiFMUT Then
        For I% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(I%) = True And lstFamilias.List(I%) <> "FMUTUO" Then
                MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar otra familia..."
                Validar_Seleccion_FM = True
                Exit Function
            End If
        Next I%
        If SiFMUT And lstEmisores.SelCount > 0 Then
           MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar EMISORES..."
           Validar_Seleccion_FM = True
           Exit Function
        End If
        If lstMonedas.SelCount > 1 Then
           MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar mas de una MONEDA..."
           Validar_Seleccion_FM = True
           Exit Function
        End If
        If lstSeries.SelCount > 1 Then
           MsgBox "Si seleciono FONDOS MUTUOS, no deberia selecionar mas de una SERIE..."
           Validar_Seleccion_FM = True
           Exit Function
        End If
        If lstMonedas.SelCount = 0 And lstSeries.SelCount = 0 Then
           MsgBox "Si seleciono FONDOS MUTUOS, deberia selecionar MONEDA o SERIE..."
           Validar_Seleccion_FM = True
           Exit Function
        End If
        
    End If

Validar_Seleccion_FM = False

End Function

Private Function FuncLoadFamilia()
   Dim Datos()
   
   lstFamilias.Clear

   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, CMBEntidad.ItemData(CMBEntidad.ListIndex) 'Rut
   AddParam Envia, ""                                        'Libro
   AddParam Envia, cCadena_Cartera                              'Tipo Cartera
   If Not Bac_Sql_Execute("DBO.SP_CARGA_FILTRO", Envia) Then
      Call MsgBox("NO  SE PUDO CONSULTAR FAMILIAS EN TABLA DE DISPONIBILIDAD", vbExclamation, App.Title)
      Exit Function
   End If
   
   Do While Bac_SQL_Fetch(Datos())
        lstFamilias.AddItem Datos(1)
   Loop
    
End Function

Private Function FuncLoadEmisores()
   Dim Datos()

   lstEmisores.Clear

   Envia = Array()
   AddParam Envia, CDbl(5)
   AddParam Envia, CMBEntidad.ItemData(CMBEntidad.ListIndex) 'Rut
   AddParam Envia, ""                                        'Libro
   AddParam Envia, cCadena_Cartera                                 'Tipo Cartera

   If Not Bac_Sql_Execute("DBO.SP_CARGA_FILTRO", Envia) Then
      Call MsgBox("NO  SE PUDO CONSULTAR EMISORES EN TABLA DE DISPONIBILIDAD", vbExclamation, App.Title)
      Exit Function
   End If
   
   Do While Bac_SQL_Fetch(Datos())
        lstEmisores.AddItem Datos(1)
   Loop
    
End Function

Private Function FuncLoadMonedas()
   Dim Datos()

   lstMonedas.Clear

   Envia = Array()
   AddParam Envia, CDbl(6)
   AddParam Envia, CMBEntidad.ItemData(CMBEntidad.ListIndex) 'Rut
   AddParam Envia, ""                                        'Libro
   AddParam Envia, cCadena_Cartera                                 'Tipo Cartera

   If Not Bac_Sql_Execute("DBO.SP_CARGA_FILTRO", Envia) Then
      Call MsgBox("NO  SE PUDO CONSULTAR MONEDAS EN TABLA DE DISPONIBILIDAD", vbExclamation, App.Title)
      Exit Function
   End If
   
   Do While Bac_SQL_Fetch(Datos())
        lstMonedas.AddItem Datos(1)
   Loop
    
End Function

Private Function FuncLoadSeries()
   Dim Datos()

   lstSeries.Clear

   Envia = Array()
   AddParam Envia, CDbl(7)
   AddParam Envia, CMBEntidad.ItemData(CMBEntidad.ListIndex) 'Rut
   AddParam Envia, cCadena_Libros                            'Libro
   AddParam Envia, cCadena_Cartera                           'Tipo Cartera
   AddParam Envia, cCadena_CatSuper                          'Cartera Super
  
  If Not Bac_Sql_Execute("DBO.SP_CARGA_FILTRO", Envia) Then
      Call MsgBox("NO  SE PUDO CONSULTAR SERIES EN TABLA DE DISPONIBILIDAD", vbExclamation, App.Title)
      Exit Function
   End If
   
   Do While Bac_SQL_Fetch(Datos())
        lstSeries.AddItem Datos(1)
   Loop
    
End Function

Private Sub Aceptar()
    Dim I%, Rutcart&

    If Not ChkDatos() Then
        Exit Sub
    End If

    Rutcart& = CMBEntidad.ItemData(CMBEntidad.ListIndex)

    'Libros
    gSQLLibro$ = ""
    
    For I% = 1 To LstLibro.ListItems.Count
      If LstLibro.ListItems.Item(I%).Checked = True Then
         Let gSQLLibro$ = gSQLLibro$ & "-" & CStr(LstLibro.ListItems.Item(I%).ListSubItems(1).Text)
      End If
    Next I%
   
    If Trim(gSQLLibro$) = "" Then
        MsgBox "DEBE SELECCIONAR UN LIBRO", vbExclamation, "Mensaje"
        Exit Sub
    End If
    
   'Cartera
   gSQLCartera$ = ""
   For I% = 1 To LstCartera.ListItems.Count
      If LstCartera.ListItems.Item(I%).Checked = True Then
         Let gSQLCartera$ = gSQLCartera$ & "-" & CStr(LstCartera.ListItems.Item(I%).ListSubItems(1).Text)
      End If
   Next I%
   
   
   'Categoria Super
   gSQLCatSuper$ = ""
   For I% = 1 To LstCategoria.ListItems.Count
      If LstCategoria.ListItems.Item(I%).Checked = True Then
         Let gSQLCatSuper$ = gSQLCatSuper$ & "-" & CStr(LstCategoria.ListItems.Item(I%).ListSubItems(1).Text)
      End If
   Next I%
   
    'Familias
   gSQLFam = ""
   If lstFamilias.SelCount > 0 Then
      For I% = 0 To lstFamilias.ListCount - 1
            If lstFamilias.Selected(I%) = True Then
                gSQLFam = gSQLFam & "-" & lstFamilias.List(I%)
            End If
      Next I%
   Else
      For I% = 0 To lstFamilias.ListCount - 1
                gSQLFam = gSQLFam & "-" & lstFamilias.List(I%)
      Next I%
   End If
    
   'Emisores
   gSQLEmi = ""
   If lstEmisores.SelCount > 0 Then
        For I% = 0 To lstEmisores.ListCount - 1
            If lstEmisores.Selected(I%) = True Then
                gSQLEmi = gSQLEmi & "-" & lstEmisores.List(I%)
            End If
        Next I%
   Else
        For I% = 0 To lstEmisores.ListCount - 1
            gSQLEmi = gSQLEmi & "-" & lstEmisores.List(I%)
        Next I%
   End If
    
   'Monedas
   gSQLMon = ""
   If lstMonedas.SelCount > 0 Then
        For I% = 0 To lstMonedas.ListCount - 1
            If lstMonedas.Selected(I%) = True Then
                gSQLMon = gSQLMon & "-" & lstMonedas.List(I%)
            End If
        Next I%
   Else
        For I% = 0 To lstMonedas.ListCount - 1
            gSQLMon = gSQLMon & "-" & lstMonedas.List(I%)
        Next I%
   End If
    
    'Series
   gSQLSer = ""
   If lstSeries.SelCount > 0 Then
     For I% = 0 To lstSeries.ListCount - 1
          If lstSeries.Selected(I%) = True Then
              gSQLSer = gSQLSer & Mid(lstSeries.List(I%), 1, 20) & ";"
          End If
     Next I%
   End If
   
   If gSQLSer = "" Then
     gSQLSer = "VACIO"
   Else

   End If
   
   giAceptar% = True
   
   Let gSQLLibro$ = CStr(Abs(gSQLLibro$)) 'siempre va ser 1 solo libro
   
   
   
   Envia = Array( _
            Rutcart&, _
            gSQLCartera$, _
            gSQLFam, _
            gSQLEmi, _
            gSQLMon, _
            gSQLSer, _
            gSQLCatSuper$, _
            gsBac_User, _
            gSQLLibro$)

'    If BacIrfSl.ProTipOper = "VP" Then
'        AddParam Envia, Mid(CmbModalidad.Text, 1, 1)
'    End If
    RutCartV = CMBEntidad.ItemData(CMBEntidad.ListIndex)

   Unload Me
   Exit Sub

End Sub

Private Function ChkDatos() As Boolean
   'Se validará que no se ingresen demasiadas familias,emisores o monedas
   'para que no sobrepase la longitud del string y no haga la consulta muy compleja

    ChkDatos = False
    
    If lstFamilias.SelCount = 0 And lstEmisores.SelCount = 0 And lstMonedas.SelCount = 0 And lstSeries.SelCount Then
        MsgBox "DEBE SELECCIONAR UN ITEM DE LAS LISTAS", vbExclamation, "Mensaje"
        lstFamilias.SetFocus
        Exit Function
    End If
    
    
    If lstFamilias.SelCount > 10 Then
        MsgBox "SE PERMITE UNA SELECCION MAXIMA DE 15 FAMILIAS", vbExclamation, "Mensaje"
        lstFamilias.SetFocus
        Exit Function
    End If
    
    If lstEmisores.SelCount > 10 Then
        MsgBox "SE PERMITE UNA SELECCION MAXIMA DE 15 EMISORES", vbExclamation, "Mensaje"
        lstEmisores.SetFocus
        Exit Function
    End If
    
    If lstMonedas.SelCount > 10 Then
        MsgBox "SE PERMITE UNA SELECCION MAXIMA DE 15 MONEDAS", vbExclamation, "Mensaje"
        lstMonedas.SetFocus
        Exit Function
    End If
    
    If lstSeries.SelCount > 10 Then
        MsgBox "SE PERMITE UNA SELECCION MAXIMA DE 15 SERIES", vbExclamation, "Mensaje"
        lstSeries.SetFocus
        Exit Function
    End If
    
    If Validar_Seleccion_FM() Then
        ChkDatos = False
        Exit Function
    End If
    
    ChkDatos = True

End Function


Private Sub Proc_Busca_Papeles_Disponibles(cTipOper As String, cCadena_Familia As String, cCadena_Emisor As String, cCadena_Moneda As String, cLibro As String, cCartera As String, cCategoriaSuper As String)

    Dim Datos()

    Envia = Array()
    AddParam Envia, cTipOper
    AddParam Envia, cCadena_Familia
    AddParam Envia, cCadena_Emisor
    AddParam Envia, cCadena_Moneda
    AddParam Envia, Trim(cLibro)
    AddParam Envia, Trim(cCategoriaSuper)
    AddParam Envia, Trim(cCartera)
    
    'If Bac_Sql_Execute("SP_CON_PAPELES_DISPONIBLES", Envia) Then
    If Bac_Sql_Execute("SP_VI_PAPELES_DISPONIBLES", Envia) Then
        
        Do While Bac_SQL_Fetch(Datos())
            lstSeries.AddItem Trim(Datos(1)) & Space(20) & Trim(Datos(2))
        Loop
        
       ' Marco(6).Enabled = True
        opt_sel_ser.Value = True
        
    Else
        MsgBox "Ha ocurrido un error al intentar filtrar los papeles disponibles", vbCritical, "Error en Bac-Trader"
        Screen.MousePointer = vbDefault
    End If

End Sub


