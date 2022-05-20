VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form Switch_Operativo 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Switch Operativos"
   ClientHeight    =   6555
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11535
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6555
   ScaleWidth      =   11535
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.ListBox Sistema_Orden_Especial 
      Height          =   255
      Left            =   6720
      TabIndex        =   21
      Top             =   7800
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.ListBox Sistema_Orden_Normal 
      Height          =   255
      Left            =   4920
      TabIndex        =   20
      Top             =   7800
      Visible         =   0   'False
      Width           =   1335
   End
   Begin BACControles.TXTNumero Posicion 
      Height          =   255
      Left            =   3360
      TabIndex        =   17
      Top             =   7440
      Width           =   615
      _ExtentX        =   1085
      _ExtentY        =   450
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
   Begin Threed.SSPanel SSPanel1 
      Height          =   5925
      Left            =   30
      TabIndex        =   8
      Top             =   585
      Width           =   5655
      _Version        =   65536
      _ExtentX        =   9975
      _ExtentY        =   10451
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
      BorderWidth     =   1
      BevelOuter      =   1
      BevelInner      =   2
      Begin Threed.SSFrame FRM_SWITCH 
         Height          =   1080
         Left            =   90
         TabIndex        =   9
         Top             =   4740
         Width           =   5430
         _Version        =   65536
         _ExtentX        =   9578
         _ExtentY        =   1905
         _StockProps     =   14
         Caption         =   "Definición de Switch Operativos"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Begin VB.TextBox Caja_De_Texto_Opcion 
            Height          =   315
            Left            =   1260
            TabIndex        =   2
            Top             =   280
            Width           =   4050
         End
         Begin VB.TextBox Caja_De_Texto_Descripcion 
            Height          =   315
            Left            =   1260
            TabIndex        =   3
            Top             =   615
            Width           =   4050
         End
         Begin VB.Label Label1 
            Caption         =   "Opción"
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
            Left            =   120
            TabIndex        =   11
            Top             =   285
            Width           =   1305
         End
         Begin VB.Label Label3 
            Caption         =   "Descripción"
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
            Left            =   105
            TabIndex        =   10
            Top             =   615
            Width           =   1305
         End
      End
      Begin Threed.SSFrame Frm_Filtro 
         Height          =   615
         Left            =   90
         TabIndex        =   12
         Top             =   45
         Width           =   5430
         _Version        =   65536
         _ExtentX        =   9578
         _ExtentY        =   1085
         _StockProps     =   14
         Caption         =   "Sistema"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Begin VB.ComboBox Caja_Combinada_Sistema 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   870
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   185
            Width           =   4515
         End
      End
      Begin Threed.SSFrame Frm_Menu 
         Height          =   4140
         Left            =   90
         TabIndex        =   13
         Top             =   600
         Width           =   5430
         _Version        =   65536
         _ExtentX        =   9578
         _ExtentY        =   7302
         _StockProps     =   14
         Caption         =   "Selección de Menu"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Begin VB.ListBox Caja_De_Lista_Principal 
            Height          =   2400
            ItemData        =   "Switch_Operativo.frx":0000
            Left            =   2730
            List            =   "Switch_Operativo.frx":0002
            TabIndex        =   14
            Top             =   450
            Visible         =   0   'False
            Width           =   2490
         End
         Begin MSComctlLib.ImageList ImageList1 
            Left            =   1320
            Top             =   2280
            _ExtentX        =   1005
            _ExtentY        =   1005
            BackColor       =   -2147483643
            ImageWidth      =   24
            ImageHeight     =   24
            MaskColor       =   12632256
            _Version        =   393216
            BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
               NumListImages   =   2
               BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Switch_Operativo.frx":0004
                  Key             =   ""
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Switch_Operativo.frx":0EDE
                  Key             =   ""
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.TreeView Arbol_Principal 
            Height          =   3840
            Left            =   75
            TabIndex        =   1
            Top             =   240
            Width           =   5280
            _ExtentX        =   9313
            _ExtentY        =   6773
            _Version        =   393217
            HideSelection   =   0   'False
            Indentation     =   529
            LabelEdit       =   1
            LineStyle       =   1
            Style           =   7
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
            OLEDragMode     =   1
            OLEDropMode     =   1
         End
      End
   End
   Begin TabDlg.SSTab Panel_Orden 
      Height          =   5955
      Left            =   6660
      TabIndex        =   6
      Top             =   555
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   10504
      _Version        =   393216
      Style           =   1
      Tabs            =   2
      TabHeight       =   520
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Orden Normal"
      TabPicture(0)   =   "Switch_Operativo.frx":1DB8
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Lista_Orden_Normal"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Caja_De_Lista_Orden_Normal"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).ControlCount=   2
      TabCaption(1)   =   "Orden Especial"
      TabPicture(1)   =   "Switch_Operativo.frx":1DD4
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Lista_Orden_Especial"
      Tab(1).Control(1)=   "Caja_De_Lista_Orden_Especial"
      Tab(1).ControlCount=   2
      Begin VB.ListBox Caja_De_Lista_Orden_Normal 
         Height          =   2400
         Left            =   1380
         TabIndex        =   24
         Top             =   1920
         Visible         =   0   'False
         Width           =   2490
      End
      Begin VB.ListBox Lista_Orden_Normal 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   5580
         Left            =   45
         OLEDragMode     =   1  'Automatic
         OLEDropMode     =   1  'Manual
         Style           =   1  'Checkbox
         TabIndex        =   5
         Top             =   330
         Width           =   4725
      End
      Begin VB.ListBox Caja_De_Lista_Orden_Especial 
         Height          =   2400
         Left            =   -73965
         TabIndex        =   22
         Top             =   1590
         Visible         =   0   'False
         Width           =   2490
      End
      Begin VB.ListBox Lista_Orden_Especial 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   5580
         Left            =   -74955
         OLEDragMode     =   1  'Automatic
         OLEDropMode     =   1  'Manual
         Style           =   1  'Checkbox
         TabIndex        =   23
         Top             =   330
         Width           =   4725
      End
   End
   Begin VB.ListBox Caja_De_Lista_Secundaria 
      Height          =   255
      Left            =   0
      TabIndex        =   7
      Top             =   7560
      Visible         =   0   'False
      Width           =   2490
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   4500
      Top             =   30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   10
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":1DF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":210A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":2FE4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":3EBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":4D98
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":5C72
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":60C4
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":6516
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":6968
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Switch_Operativo.frx":6DBA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Barra_De_Herramientas 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpia"
            Description     =   "Limpia"
            Object.ToolTipText     =   "Limpia"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Graba"
            Description     =   "Graba"
            Object.ToolTipText     =   "Graba"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Eliminar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Busca"
            Description     =   "Busca"
            Object.ToolTipText     =   "Busca"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "APROBAR"
            Object.ToolTipText     =   "Cambiar Nombre"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel2 
      Height          =   2070
      Left            =   5580
      TabIndex        =   15
      Top             =   2535
      Width           =   1380
      _Version        =   65536
      _ExtentX        =   2434
      _ExtentY        =   3651
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
      BevelOuter      =   0
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   450
         Left            =   120
         TabIndex        =   18
         Top             =   630
         Width           =   930
         _ExtentX        =   1640
         _ExtentY        =   794
         ButtonWidth     =   820
         ButtonHeight    =   794
         Style           =   1
         ImageList       =   "Img_opciones"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "IZQUIERDA"
               ImageIndex      =   8
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "DERECHA"
               ImageIndex      =   9
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.Toolbar Toolbar1 
         Height          =   450
         Left            =   345
         TabIndex        =   16
         Top             =   180
         Width           =   825
         _ExtentX        =   1455
         _ExtentY        =   794
         ButtonWidth     =   820
         ButtonHeight    =   794
         Style           =   1
         ImageList       =   "Img_opciones"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   3
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "ARRIBA"
               ImageIndex      =   7
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "ABAJO"
               ImageIndex      =   6
            EndProperty
         EndProperty
      End
   End
   Begin VB.Label Label6 
      Caption         =   "Label6"
      Height          =   255
      Left            =   2280
      TabIndex        =   19
      Top             =   7920
      Visible         =   0   'False
      Width           =   1095
   End
End
Attribute VB_Name = "Switch_Operativo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'---------------------------------------------------------------------------------------------------------
'--  Autor               :   Enrique Medina                                                             --
'--  Descripcion         :   Mantenedor de Switch Operativos                                            --
'--  Fecha Creacion      :   21/10/2002                                                                 --
'--  Fecha Modificacion  :   27/02/2002                                                                 --
'--  Modificado por      :   Cristián Labarca                                                           --
'--  Cambios Realizados  :   Insertar en ambas listas si se agrega elemento                             --
'--                          Eliminar en ambas listas si se quita elemento                              --
'---------------------------------------------------------------------------------------------------------

Option Explicit

Dim cOpcion_Local       As String
Dim nIndice             As Integer
Dim nIndice_Nodo        As Integer
Dim nHijo               As Integer
Dim nUbicacion_Global   As Integer
Dim nTermino_Orden      As Integer
Dim inicio              As Boolean
Dim SwInicio            As Boolean
Private Sub Arbol_Principal_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyLeft Then
      Call Toolbar2_ButtonClick(Toolbar2.Buttons(1))
      KeyCode = 0
   ElseIf KeyCode = vbKeyRight Then
      Call Toolbar2_ButtonClick(Toolbar2.Buttons(2))
      KeyCode = 0
   End If


End Sub

Private Sub Caja_Combinada_Sistema_Click()

   If inicio Then
      Barra_De_Herramientas_ButtonClick Barra_De_Herramientas.Buttons(4)
   End If

End Sub

Private Sub Lista_Orden_Especial_Click()

Dim nContador            As Integer
Dim Datos_Recibidos_1()

    If nTermino_Orden = 1 Then
        Caja_De_Texto_Opcion.Text = ""
        Caja_De_Texto_Opcion.Text = Lista_Orden_Especial.List(Lista_Orden_Especial.ListIndex)
        Label6.Caption = Caja_De_Lista_Orden_Normal.List(Lista_Orden_Especial.ListIndex)
        Envia_Parametros = Array(Trim(Label6.Caption))
        
        If Not BAC_SQL_EXECUTE("Sp_CON_Busca_Switch_Operativo ", Envia_Parametros) Then Exit Sub
    
            Do While BAC_SQL_FETCH(Datos_Recibidos_1)
                If Trim(Datos_Recibidos_1(3)) = "" Or Trim(Datos_Recibidos_1(3)) <> Lista_Orden_Especial.List(Lista_Orden_Especial.ListIndex) Then
                    Caja_De_Texto_Descripcion.Text = Lista_Orden_Especial.List(Lista_Orden_Especial.ListIndex)
                Else
                    Caja_De_Texto_Descripcion.Text = Datos_Recibidos_1(3)
                End If
                Caja_De_Texto_Descripcion.Enabled = True
            Loop
            
        Barra_De_Herramientas.Buttons(5).Enabled = True
        
    End If

End Sub

Private Sub Lista_Orden_Especial_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, Y As Single, State As Integer)

   If State = vbEnter Then
      
      Call Insertar_Elem_Lista(Lista_Orden_Normal, Data.GetData(1), Caja_De_Lista_Orden_Normal, Sistema_Orden_Normal)
      Call Insertar_Elem_Lista(Lista_Orden_Especial, Data.GetData(1), Caja_De_Lista_Orden_Especial, Sistema_Orden_Especial)

   End If

   If State = vbLeave Then
      
      Call Eliminar_Elem_Lista(Lista_Orden_Normal, Caja_De_Lista_Orden_Normal, Sistema_Orden_Normal)
      Call Eliminar_Elem_Lista(Lista_Orden_Especial, Caja_De_Lista_Orden_Especial, Sistema_Orden_Especial)
      
   End If
   
End Sub

Private Sub Lista_Orden_Normal_Click()

Dim nContador            As Integer
Dim Datos_Recibidos_1()

    If nTermino_Orden = 1 Then
        Caja_De_Texto_Opcion.Text = ""
        Caja_De_Texto_Opcion.Text = Lista_Orden_Normal.List(Lista_Orden_Normal.ListIndex)
        Label6.Caption = Caja_De_Lista_Orden_Normal.List(Lista_Orden_Normal.ListIndex)
        Envia_Parametros = Array(Trim(Label6.Caption))
    
        If Not BAC_SQL_EXECUTE("Sp_CON_Busca_Switch_Operativo ", Envia_Parametros) Then Exit Sub
    
            Do While BAC_SQL_FETCH(Datos_Recibidos_1)
                If Trim(Datos_Recibidos_1(3)) = "" Or Trim(Datos_Recibidos_1(3)) <> Lista_Orden_Normal.List(Lista_Orden_Normal.ListIndex) Then
                    Caja_De_Texto_Descripcion.Text = Lista_Orden_Normal.List(Lista_Orden_Normal.ListIndex)
                Else
                    Caja_De_Texto_Descripcion.Text = Datos_Recibidos_1(3)
                End If
                Caja_De_Texto_Descripcion.Enabled = True
            Loop
            
        Barra_De_Herramientas.Buttons(5).Enabled = True
        
    End If
    
End Sub

Private Sub Lista_Orden_Normal_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, Y As Single, State As Integer)

   If State = vbEnter Then
       
      Call Insertar_Elem_Lista(Lista_Orden_Normal, Data.GetData(1), Caja_De_Lista_Orden_Normal, Sistema_Orden_Normal)
      Call Insertar_Elem_Lista(Lista_Orden_Especial, Data.GetData(1), Caja_De_Lista_Orden_Especial, Sistema_Orden_Especial)

   End If

   If State = vbLeave Then
      
      Call Eliminar_Elem_Lista(Lista_Orden_Normal, Caja_De_Lista_Orden_Normal, Sistema_Orden_Normal)
      Call Eliminar_Elem_Lista(Lista_Orden_Especial, Caja_De_Lista_Orden_Especial, Sistema_Orden_Especial)
      
   End If
    
End Sub

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me, ""
   
    If Caja_Combinada_Sistema.ListCount = 0 Then
       MsgBox "NO Existen Sistemas Cargados.", vbExclamation, Me.Caption
       Unload Me
       Exit Sub
    End If
    
    PROC_CARGA_ORDEN
    inicio = True
    
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
   Case vbKeyLimpiar
      If Barra_De_Herramientas.Buttons(1).Enabled Then
         Call Barra_De_Herramientas_ButtonClick(Barra_De_Herramientas.Buttons(1))

      End If

   Case vbKeyGrabar
      If Barra_De_Herramientas.Buttons(2).Enabled Then
         Call Barra_De_Herramientas_ButtonClick(Barra_De_Herramientas.Buttons(2))

      End If

   Case vbKeyEliminar
      If Barra_De_Herramientas.Buttons(3).Enabled Then
         Call Barra_De_Herramientas_ButtonClick(Barra_De_Herramientas.Buttons(3))

      End If

   Case vbKeyBuscar
      If Barra_De_Herramientas.Buttons(4).Enabled Then
         Call Barra_De_Herramientas_ButtonClick(Barra_De_Herramientas.Buttons(4))

      End If
   Case vbKeyArriba
        Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))
        
   Case vbKeyAbajo
        Call Toolbar1_ButtonClick(Toolbar1.Buttons(2))
        
   Case vbKeyIzquierda
        Call Toolbar2_ButtonClick(Toolbar2.Buttons(1))
        
   Case vbKeyDerecha
        Call Toolbar2_ButtonClick(Toolbar2.Buttons(2))
        
   Case vbKeySalir
      Unload Me

   End Select

End Sub

Private Sub Form_Load()


    inicio = False
    cOpcion_Local = Opt
    Me.top = 0
    Me.left = 0
    Me.Icon = Menu_Principal.Icon
    PROC_CARGA_SISTEMAS Caja_Combinada_Sistema
    PROC_LIMPIA
    Me.Caption = Switch_Operativo.Caption
    
    Call LogAuditoria("07", cOpcion_Local, Me.Caption, "", "")
'***********************JUANLIZAMA**********************************
'    Call objCentralizacion.Chequeo_Estado("SCE", "INICIO", False)
     Call Chequeo_Estado("PSV", "INICIO", False)

'*******************************************************************
'   If objCentralizacion.Estado And objCentralizacion.Error = 0 Then
'      SwInicio = False
'   Else
'      SwInicio = True
'
'   End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    
    Call LogAuditoria("08", cOpcion_Local, Me.Caption, "", "")

End Sub

Private Sub Barra_De_Herramientas_ButtonClick(ByVal Button As MSComctlLib.Button)

Dim nContador       As Integer
Dim cDescripcion    As String
Dim cDescripciones  As String
Dim nEstado         As Integer

    Select Case UCase(Button.Description)
    
    Case "LIMPIA"
        inicio = False
        PROC_LIMPIA
        PROC_CARGA_ORDEN
        inicio = True
        Caja_Combinada_Sistema.SetFocus
    Case "BUSCA"
        PROC_CARGA_BACMENU
        PROC_CARGA_SWITCH
        Barra_De_Herramientas.Buttons(4).Enabled = False
        Exit Sub
    Case "GRABA"
        PROC_GRABA_SWITCH
        PROC_CARGA_SWITCH
        PROC_CARGA_ORDEN
'    Case "ELIMINAR"
'        PROC_BORRA_SWITCH
'        PROC_CARGA_SWITCH
'        PROC_CARGA_ORDEN
    Case "APROBAR"
        If Panel_Orden.Tab = 0 Then
            nContador = Lista_Orden_Normal.ListIndex
            
            If nContador = -1 Then
                Exit Sub
            End If
            
            nEstado = Lista_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Caja_De_Texto_Descripcion.Text
            cDescripciones = Lista_Orden_Normal.List(Lista_Orden_Normal.ListIndex)
            Lista_Orden_Normal.RemoveItem nContador
            Lista_Orden_Normal.AddItem cDescripcion, nContador
            Lista_Orden_Normal.SetFocus
            Lista_Orden_Normal.ListIndex = nContador
            Lista_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex) = nEstado
            
            For nContador = 0 To Lista_Orden_Especial.ListCount - 1
                If Lista_Orden_Especial.List(nContador) = cDescripciones Then
                    nEstado = Lista_Orden_Especial.Selected(nContador)
                    cDescripcion = Caja_De_Texto_Descripcion.Text
                    Lista_Orden_Especial.RemoveItem nContador
                    Lista_Orden_Especial.AddItem cDescripcion, nContador
                End If
            Next
        Else
            nContador = Lista_Orden_Especial.ListIndex
            
            If nContador = -1 Then
                Exit Sub
            End If
            
            nEstado = Lista_Orden_Especial.Selected(Lista_Orden_Especial.ListIndex)
            cDescripcion = Caja_De_Texto_Descripcion.Text
            cDescripciones = Lista_Orden_Especial.List(Lista_Orden_Especial.ListIndex)
            Lista_Orden_Especial.RemoveItem nContador
            Lista_Orden_Especial.AddItem cDescripcion, nContador
            Lista_Orden_Especial.SetFocus
            Lista_Orden_Especial.ListIndex = nContador
            Lista_Orden_Especial.Selected(Lista_Orden_Especial.ListIndex) = nEstado
            
            For nContador = 0 To Lista_Orden_Normal.ListCount - 1
                If Lista_Orden_Normal.List(nContador) = cDescripciones Then
                    nEstado = Lista_Orden_Normal.Selected(nContador)
                    cDescripcion = Caja_De_Texto_Descripcion.Text
                    Lista_Orden_Normal.RemoveItem nContador
                    Lista_Orden_Normal.AddItem cDescripcion, nContador
                End If
            Next
            
        End If
        Barra_De_Herramientas.Buttons(5).Enabled = False
    Case "SALIR"
        Unload Me
        Exit Sub
    End Select

End Sub

Sub PROC_CARGA_SISTEMAS(Caja_Combinada As Object)

Dim Datos_Recibidos()


    Envia_Parametros = Array("S", "")
    
    If Not BAC_SQL_EXECUTE("SP_BUSCA_ACCESO_USUARIO", Envia_Parametros) Then Exit Sub
    
    Caja_Combinada.Clear
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)
       Caja_Combinada.AddItem Datos_Recibidos(1) + Space(150) + Datos_Recibidos(2)
    Loop

End Sub

Sub PROC_LIMPIA()

    Frm_Filtro.Enabled = True
    Frm_Menu.Enabled = False
    
    Barra_De_Herramientas.Buttons(2).Enabled = False
    Barra_De_Herramientas.Buttons(3).Enabled = False
    Barra_De_Herramientas.Buttons(4).Enabled = True
    Barra_De_Herramientas.Buttons(5).Enabled = False
    Caja_De_Texto_Opcion.Text = ""
    Caja_De_Texto_Descripcion.Text = ""
    Caja_De_Texto_Opcion.Enabled = False
    Caja_De_Texto_Descripcion.Enabled = False
    If Caja_Combinada_Sistema.ListCount > 0 Then Caja_Combinada_Sistema.ListIndex = 0
    Caja_De_Lista_Principal.Clear
    Arbol_Principal.Visible = False
    Arbol_Principal.Nodes.Clear
    Arbol_Principal.Visible = True
    
    
    
End Sub

Sub PROC_CARGA_BACMENU()

Dim Datos_Recibidos()
Dim cItem_Menu          As String
Dim cDescripcion_Menu   As String
Dim cPosicion_Menu(100)  As String
Dim nContador_Menu(100)  As Integer
Dim cIndice_Menu        As String
Dim nCodigo_Ascii       As Integer: nCodigo_Ascii = 64
Dim nContador_Orden     As Integer
Dim nAceptar            As Integer

    nCodigo_Ascii = 64
    
    cItem_Menu = ""
    cDescripcion_Menu = "s"
    
    If Arbol_Principal.Nodes.Count > 0 Then
        nUbicacion_Global = Arbol_Principal.SelectedItem.Index
    Else
        nUbicacion_Global = 0
    End If
    
    Envia_Parametros = Array("M", Trim(right(Caja_Combinada_Sistema.Text, 3)))
    
    If Not BAC_SQL_EXECUTE("SP_BUSCA_ACCESO_USUARIO ", Envia_Parametros) Then Exit Sub
    
    Caja_De_Lista_Principal.Clear
    Caja_De_Lista_Secundaria.Clear
    
    Arbol_Principal.Nodes.Clear
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)
          
       
        If Val(Datos_Recibidos(3)) = 0 Then
       
          nCodigo_Ascii = nCodigo_Ascii + 1
          cItem_Menu = Chr(nCodigo_Ascii)
          nContador_Menu(1) = 0
          cIndice_Menu = "0"
          cDescripcion_Menu = ""
          Arbol_Principal.Nodes.Add , , cItem_Menu, Datos_Recibidos(1)
          
          Caja_De_Lista_Principal.AddItem Datos_Recibidos(2)
          Caja_De_Lista_Secundaria.AddItem Datos_Recibidos(1)
        
          
        Else
          
        nAceptar = 0
        
'        On Error Resume Next
        
        
'        For nContador_Orden = 0 To (Caja_De_Lista_Orden_Normal.ListCount - 1)
'            Caja_De_Lista_Orden_Normal.ListIndex = nContador_Orden
'            If Datos_Recibidos(2) = Caja_De_Lista_Orden_Normal.Text Then
'                nAceptar = 1
'                Exit For
'            End If
'        Next
'
'        For nContador_Orden = 0 To (Caja_De_Lista_Orden_Especial.ListCount - 1)
'            Caja_De_Lista_Orden_Especial.ListIndex = nContador_Orden
'            If Datos_Recibidos(2) = Caja_De_Lista_Orden_Especial.Text Then
'                nAceptar = nAceptar + 1
'                Exit For
'            End If
'        Next
          
         If nAceptar = 0 Then
         
            nContador_Menu(Val(Datos_Recibidos(3))) = nContador_Menu(Val(Datos_Recibidos(3))) + 1
         
            If cIndice_Menu <> Val(Datos_Recibidos(3)) Then
             
               If Datos_Recibidos(3) > Val(cIndice_Menu) Then
                  nContador_Menu(Val(Datos_Recibidos(3))) = 1
                  cPosicion_Menu(Val(Datos_Recibidos(3))) = cItem_Menu
                  cItem_Menu = IIf(cDescripcion_Menu = "", cItem_Menu, cDescripcion_Menu)
               Else
                  cItem_Menu = cPosicion_Menu(Val(Datos_Recibidos(3)))
               End If
             
               cDescripcion_Menu = cItem_Menu + Chr(64 + nContador_Menu(Val(Datos_Recibidos(3))))
            Else
               cDescripcion_Menu = cItem_Menu + Chr(64 + nContador_Menu(Val(Datos_Recibidos(3))))              'Trim(Str(nContador_menu))
            End If
          


            Arbol_Principal.Nodes.Add cItem_Menu, tvwChild, cDescripcion_Menu, Datos_Recibidos(1)
            Caja_De_Lista_Principal.AddItem Datos_Recibidos(2)
            Caja_De_Lista_Secundaria.AddItem Datos_Recibidos(1)
            

'        On Error GoTo 0
            cIndice_Menu = Val(Datos_Recibidos(3))
         End If
        End If
       
    Loop
    
    
    'Frm_Filtro.Enabled = False
    Frm_Menu.Enabled = True
    If SwInicio = False Then
        Barra_De_Herramientas.Buttons(2).Enabled = True
    End If
    Barra_De_Herramientas.Buttons(3).Enabled = True
    Barra_De_Herramientas.Buttons(4).Enabled = False

End Sub
Sub PROC_CARGA_SWITCH()

Dim Datos_Recibidos()
Dim nContador           As Integer

    Envia_Parametros = Array(right(Caja_Combinada_Sistema.Text, 3))
    
    
    If Not BAC_SQL_EXECUTE("Sp_CON_Busca_Switch_Operativo_2 ", Envia_Parametros) Then Exit Sub
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)
       For nContador = 0 To Caja_De_Lista_Principal.ListCount - 1
           If Trim(Datos_Recibidos(1)) = Caja_De_Lista_Principal.List(nContador) Then
              'Arbol_Principal.Nodes.item(nContador + 1).Image = 2
           End If
       Next nContador
    Loop
    
    Arbol_Principal.Nodes(1).Expanded = True
    
    
    If nUbicacion_Global > 0 Then
         If Arbol_Principal.Nodes.Count < nUbicacion_Global Then
         
           Exit Sub
         
         End If
        
        Arbol_Principal.Nodes(nUbicacion_Global).Selected = True
    Else
        Arbol_Principal.Nodes(1).Selected = True
    End If

End Sub

Sub PROC_GRABA_SWITCH()

Dim Datos_Recibidos()
Dim nContador                As Integer
    
    If Not BAC_SQL_EXECUTE("Sp_DEL_Borra_Switch_Operativo ") Then
         MsgBox "Problemas al Grabar Switch Operatico", vbCritical
         Exit Sub
    End If
    
    For nContador = 0 To Lista_Orden_Normal.ListCount - 1
    
        Envia_Parametros = Array(Caja_De_Lista_Orden_Normal.List(nContador), Sistema_Orden_Normal.List(nContador), nContador + 1, 1, Trim(Lista_Orden_Normal.List(nContador)), IIf(Lista_Orden_Normal.Selected(nContador) = True, 2, 4))
        
        If Not BAC_SQL_EXECUTE("Sp_ACT_Graba_Switch_Operativo ", Envia_Parametros) Then
            MsgBox "Problemas al Grabar Switch Operatico", vbCritical
            Exit Sub
        End If
        
    Next
    
    
    For nContador = 0 To Lista_Orden_Especial.ListCount - 1
    
        Envia_Parametros = Array(Caja_De_Lista_Orden_Especial.List(nContador), Sistema_Orden_Especial.List(nContador), nContador + 1, 2, Trim(Lista_Orden_Especial.List(nContador)), IIf(Lista_Orden_Especial.Selected(nContador) = True, 2, 4))
        
        If Not BAC_SQL_EXECUTE("Sp_ACT_Graba_Switch_Operativo ", Envia_Parametros) Then
            MsgBox "Problemas al Grabar Switch Operatico", vbCritical
            Exit Sub
        End If
        
    Next
    
    MsgBox "Switch Operativo Grabado en Forma Correcta", vbInformation
    
End Sub
Sub PROC_CARGA_SWITCH_B()

Dim Datos_Recibidos()
Dim nContador            As Integer

   For nContador = 0 To Caja_De_Lista_Principal.ListCount - 1
       If Trim(Caja_De_Texto_Opcion.Text) = Caja_De_Lista_Principal.List(nContador) Then
          Arbol_Principal.Nodes.item(nContador + 1).Checked = False
       End If
   Next nContador

End Sub

Private Sub Arbol_Principal_Validate(Cancel As Boolean)

    Cancel = False

End Sub

Sub PROC_CARGA_ORDEN()

Dim Datos_Recibidos()
Dim cDescripcion_Menu    As String

    nTermino_Orden = 0
    
    cDescripcion_Menu = ""
    
    Envia_Parametros = Array("1")
    
    If Not BAC_SQL_EXECUTE("Sp_CON_Busca_Orden ", Envia_Parametros) Then Exit Sub
    
    Caja_De_Lista_Orden_Normal.Clear
    Lista_Orden_Normal.Clear
    Sistema_Orden_Normal.Clear
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)
        Caja_De_Lista_Orden_Normal.AddItem Datos_Recibidos(1)
        Sistema_Orden_Normal.AddItem Datos_Recibidos(5)
        cDescripcion_Menu = ""
        Lista_Orden_Normal.AddItem Datos_Recibidos(3)   ' IIf(Val(Datos_Recibidos(4)) <> 4 And Val(Datos_Recibidos(4)) <> 0, 2, 1)
        If Val(Datos_Recibidos(4)) <> 4 And Val(Datos_Recibidos(4)) <> 0 Then
           Lista_Orden_Normal.Selected(Lista_Orden_Normal.NewIndex) = True
        End If
    Loop
    
    Envia_Parametros = Array("2")
    
    If Not BAC_SQL_EXECUTE("Sp_CON_Busca_Orden ", Envia_Parametros) Then Exit Sub
    
    Caja_De_Lista_Orden_Especial.Clear
    Lista_Orden_Especial.Clear
    Sistema_Orden_Especial.Clear
    
    Do While BAC_SQL_FETCH(Datos_Recibidos)
        Caja_De_Lista_Orden_Especial.AddItem Datos_Recibidos(1)
        Sistema_Orden_Especial.AddItem Datos_Recibidos(5)
        cDescripcion_Menu = ""
        Lista_Orden_Especial.AddItem Datos_Recibidos(3)
        If Val(Datos_Recibidos(4)) <> 4 And Val(Datos_Recibidos(4)) <> 0 Then
              Lista_Orden_Especial.Selected(Lista_Orden_Especial.NewIndex) = True ' IIf(Val(Datos_Recibidos(4)) <> 4 And Val(Datos_Recibidos(4)) <> 0, 2, 1)
        End If
    Loop
    
    nTermino_Orden = 1
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Dim nContador       As Integer
Dim cDescripcion    As String
Dim nEstado         As Integer

    Select Case UCase(Button.Key)
    
    Case "ARRIBA"
        If Panel_Orden.Tab = 0 Then
            nContador = Lista_Orden_Normal.ListIndex
            
            If nContador = 0 Or nContador = -1 Then
                Exit Sub
            End If
            
            nEstado = Lista_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Lista_Orden_Normal.List(nContador)
            Lista_Orden_Normal.RemoveItem nContador
            Lista_Orden_Normal.AddItem cDescripcion, nContador - 1
            Lista_Orden_Normal.SetFocus
            Lista_Orden_Normal.ListIndex = nContador - 1
            Lista_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex) = nEstado
            
            nEstado = Caja_De_Lista_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Caja_De_Lista_Orden_Normal.List(nContador)
            Caja_De_Lista_Orden_Normal.RemoveItem nContador
            Caja_De_Lista_Orden_Normal.AddItem cDescripcion, nContador - 1
            
            nEstado = Sistema_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Sistema_Orden_Normal.List(nContador)
            Sistema_Orden_Normal.RemoveItem nContador
            Sistema_Orden_Normal.AddItem cDescripcion, nContador - 1
            
            
        Else
            nContador = Lista_Orden_Especial.ListIndex
            
            If nContador = 0 Or nContador = -1 Then
                Exit Sub
            End If
            
            If Caja_De_Lista_Orden_Especial.ListCount <= Lista_Orden_Normal.ListIndex Then
               Exit Sub
            
            End If
            
            nEstado = Lista_Orden_Especial.Selected(Lista_Orden_Especial.ListIndex)
            cDescripcion = Lista_Orden_Especial.List(nContador)
            Lista_Orden_Especial.RemoveItem nContador
            Lista_Orden_Especial.AddItem cDescripcion, nContador - 1
            Lista_Orden_Especial.SetFocus
            Lista_Orden_Especial.ListIndex = nContador - 1
            Lista_Orden_Especial.Selected(Lista_Orden_Especial.ListIndex) = nEstado


            nEstado = Caja_De_Lista_Orden_Especial.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Caja_De_Lista_Orden_Especial.List(nContador)
            Caja_De_Lista_Orden_Especial.RemoveItem nContador
            Caja_De_Lista_Orden_Especial.AddItem cDescripcion, nContador - 1
            
            nEstado = Sistema_Orden_Especial.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Sistema_Orden_Especial.List(nContador)
            Sistema_Orden_Especial.RemoveItem nContador
            Sistema_Orden_Especial.AddItem cDescripcion, nContador - 1

        End If
    Case "ABAJO"
        If Panel_Orden.Tab = 0 Then
            nContador = Lista_Orden_Normal.ListIndex
            If nContador = Lista_Orden_Normal.ListCount - 1 Then
                Exit Sub
            End If
            nEstado = Lista_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Lista_Orden_Normal.List(nContador)
            Lista_Orden_Normal.RemoveItem nContador
            Lista_Orden_Normal.AddItem cDescripcion, nContador + 1
            Lista_Orden_Normal.SetFocus
            Lista_Orden_Normal.ListIndex = nContador + 1
            Lista_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex) = nEstado
            
            nEstado = Caja_De_Lista_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Caja_De_Lista_Orden_Normal.List(nContador)
            Caja_De_Lista_Orden_Normal.RemoveItem nContador
            Caja_De_Lista_Orden_Normal.AddItem cDescripcion, nContador + 1
            
            nEstado = Sistema_Orden_Normal.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Sistema_Orden_Normal.List(nContador)
            Sistema_Orden_Normal.RemoveItem nContador
            Sistema_Orden_Normal.AddItem cDescripcion, nContador + 1
            
        Else
            nContador = Lista_Orden_Especial.ListIndex
            If nContador = Lista_Orden_Especial.ListCount - 1 Then
                Exit Sub
            End If
            
            If Caja_De_Lista_Orden_Especial.ListCount <= Lista_Orden_Normal.ListIndex Then
               Exit Sub
            
            End If
            
            nEstado = Lista_Orden_Especial.Selected(Lista_Orden_Especial.ListIndex)
            cDescripcion = Lista_Orden_Especial.List(nContador)
            Lista_Orden_Especial.RemoveItem nContador
            Lista_Orden_Especial.AddItem cDescripcion, nContador + 1
            Lista_Orden_Especial.SetFocus
            Lista_Orden_Especial.ListIndex = nContador + 1
            Lista_Orden_Especial.Selected(Lista_Orden_Especial.ListIndex) = nEstado

            nEstado = Caja_De_Lista_Orden_Especial.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Caja_De_Lista_Orden_Especial.List(nContador)
            Caja_De_Lista_Orden_Especial.RemoveItem nContador
            Caja_De_Lista_Orden_Especial.AddItem cDescripcion, nContador + 1
            
            nEstado = Sistema_Orden_Especial.Selected(Lista_Orden_Normal.ListIndex)
            cDescripcion = Sistema_Orden_Especial.List(nContador)
            Sistema_Orden_Especial.RemoveItem nContador
            Sistema_Orden_Especial.AddItem cDescripcion, nContador + 1

        End If
    End Select

End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)
      Case "IZQUIERDA"
      
         Call Eliminar_Elem_Lista(Lista_Orden_Normal, Caja_De_Lista_Orden_Normal, Sistema_Orden_Normal)
         Call Eliminar_Elem_Lista(Lista_Orden_Especial, Caja_De_Lista_Orden_Especial, Sistema_Orden_Especial)
   
      Case "DERECHA"
       If Me.Caja_De_Lista_Principal.ListCount > 0 Then
         Call Insertar_Elem_Lista(Lista_Orden_Normal, Arbol_Principal.SelectedItem, Caja_De_Lista_Orden_Normal, Sistema_Orden_Normal)
         Call Insertar_Elem_Lista(Lista_Orden_Especial, Arbol_Principal.SelectedItem, Caja_De_Lista_Orden_Especial, Sistema_Orden_Especial)
       End If
   End Select

End Sub

Private Sub Insertar_Elem_Lista(Lista_Orden As Object, Valor_Item As String, Caja_Lst_Orden As Object, Sistema_Orden As Object)
   
   Dim nContador       As Integer
   Dim nContador_Arbol As Integer
   Dim nContador_nodo  As Integer
   Dim cDescripcion    As String
   Dim nUbicacion      As Integer
   
   If Arbol_Principal.Nodes.Count > 0 Then
      If Arbol_Principal.SelectedItem.Children = 0 Then
         If Arbol_Principal.SelectedItem.Selected Then
            
            nUbicacion = Lista_Orden.ListIndex
            
            For nContador = 0 To Lista_Orden.ListCount - 1
               Caja_Lst_Orden.ListIndex = nContador
               If Caja_De_Lista_Principal.List(Arbol_Principal.SelectedItem.Index - 1) = Caja_Lst_Orden.Text Then
               'If Lista_Orden.Text = Valor_Item Then
                  Exit Sub
               End If
            Next
            
            If nUbicacion = -1 Then
               nUbicacion = 0
            End If
            
            Caja_Lst_Orden.AddItem Caja_De_Lista_Principal.List(Arbol_Principal.SelectedItem.Index - 1), nUbicacion
            Sistema_Orden.AddItem right(Caja_Combinada_Sistema.Text, 3), nUbicacion
            Lista_Orden.AddItem Arbol_Principal.SelectedItem, nUbicacion
            Lista_Orden.Selected(nUbicacion) = True
            Lista_Orden.ListIndex = nUbicacion
         
         End If
      End If
   End If

End Sub

Private Sub Eliminar_Elem_Lista(Lista_Orden As Object, Caja_Lst_Orden As Object, Sistema_Orden As Object)
   
   Dim nContador       As Integer
   Dim nContador_Arbol As Integer
   Dim nContador_nodo  As Integer
   Dim cDescripcion    As String
   Dim nUbicacion      As Integer

   If Lista_Orden.ListIndex = -1 Then
      Exit Sub
   End If

   Envia_Parametros = Array(Trim(Caja_Lst_Orden.List(Lista_Orden.ListIndex)))
   
   If BAC_SQL_EXECUTE("SP_CON_SWITCH_MENSAJE ", Envia_Parametros) Then
      Do While BAC_SQL_FETCH(Datos_Recibidos)
         
         If Trim(Datos_Recibidos(1)) = "S" Then
            MsgBox "No Puede Sacar Opcion de Menu Por Estar Asignada a Una Regla", vbExclamation
            Exit Sub
         End If
      
      Loop
   End If

   If Arbol_Principal.Nodes.Count > 0 Then
     ' If Arbol_Principal.SelectedItem.Children = 0 Then
         If Caja_Lst_Orden.List(Lista_Orden.ListIndex) = "INICIO" Or _
            Caja_Lst_Orden.List(Lista_Orden.ListIndex) = "FIN" Or _
            Caja_Lst_Orden.List(Lista_Orden.ListIndex) = "BLOQUEO" Or _
            Caja_Lst_Orden.List(Lista_Orden.ListIndex) = "CONTABILIDAD" Then
            
            Exit Sub
         
         End If
         
         nUbicacion = Lista_Orden.ListIndex
         Lista_Orden.RemoveItem nUbicacion
         Caja_Lst_Orden.RemoveItem nUbicacion
         Sistema_Orden.RemoveItem nUbicacion
      
     ' End If
    
      
   End If

End Sub

