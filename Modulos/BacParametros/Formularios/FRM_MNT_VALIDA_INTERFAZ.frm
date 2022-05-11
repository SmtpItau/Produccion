VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form FRM_MNT_VALIDA_INTERFAZ 
   Caption         =   "Validacion Interfaz"
   ClientHeight    =   7980
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12690
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   7980
   ScaleWidth      =   12690
   WindowState     =   2  'Maximized
   Begin VB.Frame Frame1 
      Height          =   1095
      Left            =   120
      TabIndex        =   28
      Top             =   465
      Width           =   12495
      Begin VB.ComboBox cmbInterfaz 
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   30
         Top             =   600
         Width           =   6255
      End
      Begin VB.ComboBox cmbSistema 
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   29
         Top             =   240
         Width           =   2415
      End
      Begin VB.Label Label1 
         Caption         =   "Interfaz"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   375
         Left            =   240
         TabIndex        =   32
         Top             =   600
         Width           =   975
      End
      Begin VB.Label Label7 
         Caption         =   "Sistema"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   240
         TabIndex        =   31
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.Frame Frame2 
      Height          =   4215
      Left            =   120
      TabIndex        =   24
      Top             =   1560
      Width           =   12495
      Begin VB.TextBox txtDescripcion 
         BackColor       =   &H80000002&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   315
         Left            =   4320
         TabIndex        =   25
         Text            =   "Descripcion"
         Top             =   600
         Visible         =   0   'False
         Width           =   1530
      End
      Begin BACControles.TXTNumero txtIngresoNum 
         Height          =   270
         Left            =   3360
         TabIndex        =   26
         Top             =   600
         Visible         =   0   'False
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   476
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "1"
         Text            =   "1"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid grdValidacion 
         Height          =   3840
         Left            =   120
         TabIndex        =   27
         Top             =   240
         Width           =   12255
         _ExtentX        =   21616
         _ExtentY        =   6773
         _Version        =   393216
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483645
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame Frame3 
      Height          =   2175
      Left            =   120
      TabIndex        =   2
      Top             =   5745
      Width           =   12495
      Begin VB.OptionButton optValidacion 
         Caption         =   "Validacion"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   120
         TabIndex        =   34
         Top             =   240
         Width           =   1215
      End
      Begin VB.Frame Frame4 
         Height          =   855
         Left            =   600
         TabIndex        =   13
         Top             =   1200
         Width           =   7575
         Begin VB.OptionButton optComparacion 
            Caption         =   "Campo de Comparacion"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   120
            TabIndex        =   17
            Top             =   120
            Width           =   2535
         End
         Begin VB.OptionButton optValEsperado 
            Caption         =   "Valor Esperado"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   120
            TabIndex        =   16
            Top             =   480
            Width           =   2415
         End
         Begin VB.ComboBox cmbComparacion 
            Enabled         =   0   'False
            Height          =   315
            Left            =   2880
            Style           =   2  'Dropdown List
            TabIndex        =   15
            Top             =   120
            Width           =   4000
         End
         Begin VB.TextBox txtValEsperado 
            Enabled         =   0   'False
            Height          =   315
            Left            =   2880
            TabIndex        =   14
            Top             =   480
            Width           =   4000
         End
      End
      Begin VB.TextBox txtSeleccionado2 
         Height          =   315
         Left            =   1200
         TabIndex        =   12
         Top             =   840
         Width           =   4000
      End
      Begin VB.TextBox txtUbicacion 
         Height          =   315
         Left            =   11250
         TabIndex        =   11
         Top             =   810
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.ComboBox cmbOperador 
         Height          =   315
         Left            =   8235
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   840
         Width           =   1455
      End
      Begin VB.TextBox txtInicio1 
         Height          =   315
         Left            =   9360
         TabIndex        =   9
         Top             =   1320
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.TextBox txtLargo1 
         Enabled         =   0   'False
         Height          =   315
         Left            =   5520
         TabIndex        =   8
         Top             =   840
         Width           =   615
      End
      Begin VB.TextBox txtInicio2 
         Height          =   315
         Left            =   9360
         TabIndex        =   7
         Top             =   1800
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.TextBox txtLargo2 
         Height          =   315
         Left            =   8760
         TabIndex        =   6
         Top             =   1800
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.TextBox txtIdc 
         Enabled         =   0   'False
         Height          =   315
         Left            =   720
         TabIndex        =   5
         Top             =   840
         Width           =   375
      End
      Begin VB.TextBox txtHasta 
         Enabled         =   0   'False
         Height          =   315
         Left            =   7365
         TabIndex        =   4
         Top             =   840
         Width           =   615
      End
      Begin VB.TextBox txtDesde 
         Enabled         =   0   'False
         Height          =   315
         Left            =   6480
         TabIndex        =   3
         Top             =   840
         Width           =   615
      End
      Begin VB.Label lblSeleccionado2 
         Caption         =   "Campo Seleccionado"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   720
         TabIndex        =   23
         Top             =   600
         Width           =   1935
      End
      Begin VB.Label lblUbicacion 
         Caption         =   "Ubicación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   11190
         TabIndex        =   22
         Top             =   465
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label lblOperador 
         Caption         =   "Operador Lógico"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   8220
         TabIndex        =   21
         Top             =   570
         Width           =   1575
      End
      Begin VB.Label lblLargo 
         Caption         =   "Largo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   5520
         TabIndex        =   20
         Top             =   600
         Width           =   495
      End
      Begin VB.Label lblDesde 
         Caption         =   "Desde"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   6480
         TabIndex        =   19
         Top             =   600
         Width           =   615
      End
      Begin VB.Label lblHasta 
         Caption         =   "Hasta"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   7365
         TabIndex        =   18
         Top             =   585
         Width           =   615
      End
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   120
      Picture         =   "FRM_MNT_VALIDA_INTERFAZ.frx":0000
      ScaleHeight     =   345
      ScaleWidth      =   375
      TabIndex        =   1
      Top             =   8040
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   360
      Index           =   0
      Left            =   480
      Picture         =   "FRM_MNT_VALIDA_INTERFAZ.frx":015A
      ScaleHeight     =   360
      ScaleWidth      =   405
      TabIndex        =   0
      Top             =   8040
      Visible         =   0   'False
      Width           =   405
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7200
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_VALIDA_INTERFAZ.frx":02B4
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_VALIDA_INTERFAZ.frx":118E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_VALIDA_INTERFAZ.frx":2068
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_VALIDA_INTERFAZ.frx":2F42
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_VALIDA_INTERFAZ.frx":3E1C
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_VALIDA_INTERFAZ.frx":4CF6
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   33
      Top             =   0
      Width           =   12690
      _ExtentX        =   22384
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Nuevo"
            Description     =   "Nuevo"
            Object.ToolTipText     =   "Nuevo"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar/Actualizar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Description     =   "Excel"
            Object.ToolTipText     =   "Excel"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Command 
         Left            =   5880
         Top             =   0
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
End
Attribute VB_Name = "FRM_MNT_VALIDA_INTERFAZ"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const ncol_Descripcion = 1
Const nCol_Codigo = 0
Const nFila_Cabecera = 0
Const Cons_Prioridad = 2

Const nColNro = 0
Const nColDesc = 1
Const nColTipo = 2
Const nColLargo = 3
Const nColDesde = 4
Const nColHasta = 5
Const nColValFijo = 6
Const nColValida = 7
Const nColOperador = 8
Const nColInicio2 = 9
Const nColLargo2 = 10
Const nColId2 = 11
Const nColInicio1 = 12
Const nColLargo1 = 13
Const nColDef = 14
Const nColCampo = 15

Private tipo_grabacion
Private tipo_select

Public IdInterfaz As Integer
Public ExisteInterfaz As Integer
Public total_filas As Integer
Public indice As Integer
Dim id_campo()


Private Sub cmbInterfaz_Click()
    Dim Datos()
   
    total_filas = 0
    
    Call HabilitaControls(True)
    Let Tbl_Opciones.Buttons.Item(2).Enabled = False
    Let Tbl_Opciones.Buttons.Item(3).Enabled = True
    Let Tbl_Opciones.Buttons.Item(4).Enabled = True
    
    Envia = Array(Trim(Right(cmbSistema.Text, 3)), 0, 3, Trim(Left(cmbInterfaz.Text, 20)))
       
    If Not Bac_Sql_Execute("BACPARAMSUDA..SP_TRAE_DATOS_INTERFACE", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intenter consultar las interfaces", vbOKOnly + vbCritical
        Exit Sub
    Else
        Do While Bac_SQL_Fetch(Datos())
            IdInterfaz = Datos(1)
        Loop
    End If
    
    
    Envia = Array(Trim(Right(cmbSistema.Text, 3)), IdInterfaz, 1, "")
       
    If Not Bac_Sql_Execute("BACPARAMSUDA..SP_TRAE_DATOS_INTERFACE", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intenter consultar las interfaces", vbOKOnly + vbCritical
        Exit Sub
    Else
        With grdValidacion
            .Rows = 1
            
            Do While Bac_SQL_Fetch(Datos())
                .AddItem ""
                .TextMatrix(.Rows - 1, 0) = Trim(Datos(1))      ' i
                .TextMatrix(.Rows - 1, 1) = Trim(Datos(2))      ' descripcion
                .TextMatrix(.Rows - 1, 2) = Trim(Datos(3))      ' tipo dato
                .TextMatrix(.Rows - 1, 3) = Trim(Datos(4))      ' largo
                .TextMatrix(.Rows - 1, 4) = Trim(Datos(5))      ' desde
                .TextMatrix(.Rows - 1, 5) = Trim(Datos(6))      ' hasta
                .TextMatrix(.Rows - 1, 6) = Trim(Datos(7))      ' resultado esperado
                .TextMatrix(.Rows - 1, 7) = Trim(Datos(8))      ' validacion
                .TextMatrix(.Rows - 1, 8) = Trim(Datos(9))      ' operador
                .TextMatrix(.Rows - 1, 9) = Trim(Datos(10))     ' inicio 2
                .TextMatrix(.Rows - 1, 10) = Trim(Datos(11))    ' largo2
                .TextMatrix(.Rows - 1, 11) = Trim(Datos(12))    ' id2
                .TextMatrix(.Rows - 1, 12) = Trim(Datos(13))    ' inicio1
                .TextMatrix(.Rows - 1, 13) = Trim(Datos(14))    ' largo1
                .TextMatrix(.Rows - 1, 14) = Trim(Datos(15))    ' Definicion campo
                .TextMatrix(.Rows - 1, 15) = Datos(16)

                Let grdValidacion.Col = 15:   Let grdValidacion.Row = grdValidacion.Rows - 1
                grdValidacion.CellPictureAlignment = flexAlignCenterCenter
                        
                If Datos(16) = 1 Then
                    Set grdValidacion.CellPicture = ConCheck.Item(0).Picture
                    .TextMatrix(.RowSel, 15) = "."
                Else
                    Set grdValidacion.CellPicture = SinCheck.Item(0).Picture
                    .TextMatrix(.RowSel, 15) = ""
                End If

                largo = Trim(Datos(6))
            Loop
           
        End With
        total_filas = grdValidacion.Rows
    End If
    
    ReDim id_campo(largo) 'se redimensiona el arreglo para que tenga la misma cantidad de registros de la grilla
    
    'habilita
    If grdValidacion.Rows > 1 Then
        Call AnchoColumnasGrilla
        ExisteInterfaz = 1
    End If
    
    ' llena campo comparacion
    tipo_select = 1
    Envia2 = Array(IdInterfaz, Trim(Right(cmbSistema.Text, 3)), 0, tipo_select)

    If Not Bac_Sql_Execute("SP_TRAE_CAMPO_COMPARACION", Envia2) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar obtener los datos de los sistemas", vbOKOnly + vbCritical
        Exit Sub
    Else
        cmbComparacion.Clear
        Do While Bac_SQL_Fetch(Datos())
            'cmbComparacion.AddItem (Datos(2) & Space(50) & Datos(1))
            cmbComparacion.AddItem (Datos(1) & Space(2) & Datos(2))
        Loop
    End If
        
    tipo_select = 0
End Sub

Private Sub cmbComparacion_Click()
'    Dim indice As Integer
    
    If cmbComparacion.Text <> "" Then
        ' llena campos asociados al campo comparacion
        tipo_select = 2
        Envia = Array(IdInterfaz, Trim(Right(cmbSistema.Text, 3)), CInt(Trim(Left(cmbComparacion.Text, 3))), tipo_select)
         
        If Not Bac_Sql_Execute("SP_TRAE_CAMPO_COMPARACION", Envia) Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar obtener los datos de los sistemas", vbOKOnly + vbCritical
            Exit Sub
        Else
            With grdValidacion
                Do While Bac_SQL_Fetch(Datos())
                    txtInicio2.Text = Datos(3)
                    txtLargo2.Text = Datos(4)
                Loop
            End With
               
        End If
        tipo_select = 0
    End If
    
'    indice = cmbComparacion.ListIndex
    If txtIdc.Text = Trim(Left(cmbComparacion.Text, 3)) Then
        MsgBox "Seleccione un campo distinto al seleccionado", vbOKOnly + vbExclamation
        If indice = 0 Then
            cmbComparacion.ListIndex = -1
        Else
            cmbComparacion.ListIndex = indice
        End If
    End If
    
End Sub

Private Sub Form_Load()
    IdInterfaz = 0
    
    If Not Bac_Sql_Execute("SP_BACMNTMP_SISTEMA") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar obtener los datos de los sistemas", vbOKOnly + vbCritical
        Exit Sub
    Else
        cmbSistema.Clear
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "DRV" And Datos(1) <> "BCC" Then
                cmbSistema.AddItem (Datos(2) & Space(50) & Datos(1))
            End If
        Loop
        cmbSistema.AddItem ("PASIVOS" & Space(50) & "PAS")
    End If
    
    cmbOperador.Clear
    cmbOperador.AddItem ("=" & Space(50) & 0)
    cmbOperador.AddItem (">" & Space(50) & 1)
    cmbOperador.AddItem ("<" & Space(50) & 2)
    
    Frame4.BorderStyle = 0
        
    Call Limpiar
    Call DeshabilitaValidaciones
    
End Sub

Private Sub cmbSistema_Click()
    PROC_CARGA_INTERFACES cmbInterfaz
End Sub

Sub PROC_CARGA_INTERFACES(Combo As Object)
    Dim Datos()
    
    Envia = Array(Right(cmbSistema.Text, 3), 0)
    
    If Not Bac_Sql_Execute("SP_TRAE_ENCABEZADO_INTERFACES", Envia) Then Exit Sub
    
    Combo.Clear
    
    Do While Bac_SQL_Fetch(Datos)
        IdInterfaz = Datos(1)
        Combo.AddItem Datos(2)
    Loop
     
End Sub

Private Sub Limpiar()
    ExisteInterfaz = 0
   Screen.MousePointer = vbDefault
   
   grdValidacion.Clear

   With grdValidacion

        .Cols = 16

        .TextMatrix(0, nColNro) = "Nro"
        .TextMatrix(0, nColDesc) = "Descripcion"
        .TextMatrix(0, nColTipo) = "Tipo"
        .TextMatrix(0, nColLargo) = "Largo"
        .TextMatrix(0, nColDesde) = "Desde"
        .TextMatrix(0, nColHasta) = "Hasta"
        .TextMatrix(0, nColValFijo) = "Valor Fijo"
        .TextMatrix(0, nColValida) = "Valida S/N"
        .TextMatrix(0, nColOperador) = "Operador"
        .TextMatrix(0, nColInicio2) = "Inicio2"
        .TextMatrix(0, nColLargo2) = "Largo2"
        .TextMatrix(0, nColId2) = "Id2"
        .TextMatrix(0, nColInicio1) = "Inicio1"
        .TextMatrix(0, nColLargo1) = "Largo1"
        .TextMatrix(0, nColDef) = "Definicion"
        .TextMatrix(0, nColCampo) = "Valida Campo a Campo"
        
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        .ColWidth(13) = 0
        '.ColWidth(14) = 0
        .ColAlignment(nColCampo) = flexAlignCenterCenter
        

    End With

    cmbSistema.ListIndex = -1
    cmbInterfaz.ListIndex = -1
    grdValidacion.Rows = 2
    
    txtSeleccionado2.Text = ""
    txtUbicacion.Text = ""
    txtValEsperado.Text = ""
    cmbOperador.ListIndex = -1
    cmbComparacion.ListIndex = -1
    optComparacion.Value = False
    optValEsperado.Value = False
    tipo_grabacion = 0
    optValidacion.Value = False
    
    txtIdc.Text = ""
    txtLargo1.Text = ""
    txtDesde.Text = ""
    txtHasta.Text = ""
    indice = 0
    
    Let Tbl_Opciones.Buttons.Item(2).Enabled = False
    Let Tbl_Opciones.Buttons.Item(3).Enabled = False
    Let Tbl_Opciones.Buttons.Item(4).Enabled = False
    
End Sub

Private Sub LimpiarGrilla()
    ExisteInterfaz = 0
   Screen.MousePointer = vbDefault
   
   grdValidacion.Clear

   With grdValidacion

        .Cols = 16

        .TextMatrix(0, nColNro) = "Nro"
        .TextMatrix(0, nColDesc) = "Descripcion"
        .TextMatrix(0, nColTipo) = "Tipo"
        .TextMatrix(0, nColLargo) = "Largo"
        .TextMatrix(0, nColDesde) = "Desde"
        .TextMatrix(0, nColHasta) = "Hasta"
        .TextMatrix(0, nColValFijo) = "Valor Fijo"
        .TextMatrix(0, nColValida) = "Valida S/N"
        .TextMatrix(0, nColOperador) = "Operador"
        .TextMatrix(0, nColInicio2) = "Inicio2"
        .TextMatrix(0, nColLargo2) = "Largo2"
        .TextMatrix(0, nColId2) = "Id2"
        .TextMatrix(0, nColInicio1) = "Inicio1"
        .TextMatrix(0, nColLargo1) = "Largo1"
        .TextMatrix(0, nColDef) = "Definicion"
        .TextMatrix(0, nColCampo) = "Valida Campo a Campo"
        
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        .ColWidth(13) = 0
        .ColAlignment(nColCampo) = flexAlignCenterCenter

    End With
    
End Sub


Private Sub LimpiaCampos1()
    tipo_grabacion = 0
    
End Sub

Private Sub LimpiaCampos2()
    
    txtSeleccionado2.Text = ""
    txtUbicacion.Text = ""
    txtValEsperado.Text = ""
    cmbOperador.ListIndex = -1
    cmbComparacion.ListIndex = -1
    optComparacion.Value = False
    optValEsperado.Value = False
    tipo_grabacion = 0
    
    txtIdc.Text = ""
    txtLargo1.Text = ""
    txtDesde.Text = ""
    txtHasta.Text = ""
    
End Sub

Private Sub grdValidacion_DblClick()

If ExisteInterfaz = 1 Then
    LimpiaCampos1
    LimpiaCampos2
    Call DeshabilitaValidaciones
    Dim DelCod  As Integer
    Dim DelSer  As String
    Dim I As Integer
    
    DelCod = Val(grdValidacion.TextMatrix(grdValidacion.RowSel, 0))
    DelSer = grdValidacion.TextMatrix(grdValidacion.RowSel, 1)
    
    cmbOperador.ListIndex = -1
    cmbComparacion.ListIndex = -1
    optComparacion.Value = False
    optValEsperado.Value = False
    txtValEsperado.Text = ""
    optValidacion.Value = False
        
    With grdValidacion
        If .Col = .Cols - 1 Then
            Let grdValidacion.Col = 15:   'Let grdValidacion.Row = grdValidacion.Rows - 1
            grdValidacion.CellPictureAlignment = flexAlignCenterCenter
            
            If grdValidacion.CellPicture = ConCheck.Item(0).Picture Then
                Set grdValidacion.CellPicture = SinCheck.Item(0).Picture
                .TextMatrix(.RowSel, 15) = ""
            Else
                Set grdValidacion.CellPicture = ConCheck.Item(0).Picture
                .TextMatrix(.RowSel, 15) = "."
            End If
       
            optValidacion.Value = False
            
            Let Tbl_Opciones.Buttons.Item(2).Enabled = True
                tipo_grabacion = 5
        Else
        
        txtSeleccionado2.Text = .TextMatrix(grdValidacion.RowSel, 1)    ' Descripcion campo - validacion
        txtIdc.Text = .TextMatrix(grdValidacion.RowSel, 0)              ' ID
        txtUbicacion.Text = .TextMatrix(grdValidacion.RowSel, 12)       ' inicio1
        txtDesde.Text = .TextMatrix(.RowSel, 4)                         ' Desde
        txtHasta.Text = .TextMatrix(.RowSel, 5)                         ' Hasta
        txtInicio1.Text = .TextMatrix(grdValidacion.RowSel, 12)         ' Inicio1
        txtLargo1.Text = .TextMatrix(grdValidacion.RowSel, 3)          ' Largo1
        If .TextMatrix(.RowSel, 8) <> "" Then                           ' Operador
            cmbOperador.ListIndex = .TextMatrix(.RowSel, 8)
        End If
        If .TextMatrix(.RowSel, 9) <> "" Then                           ' inicio2
            txtInicio2.Text = .TextMatrix(.RowSel, 9)
        End If
        If .TextMatrix(.RowSel, 10) <> "" Then                          ' largo2
            txtLargo2.Text = .TextMatrix(.RowSel, 10)
        End If
        If .TextMatrix(.RowSel, 6) <> "" Then                           ' resultado esperado
            txtValEsperado.Text = .TextMatrix(.RowSel, 6)
        End If
        If .TextMatrix(.RowSel, 11) <> "" Then                          ' id2
            If CInt(.TextMatrix(.RowSel, 11)) > 0 Then
                cmbComparacion.ListIndex = .TextMatrix(.RowSel, 11) - 1
                indice = cmbComparacion.ListIndex
            End If
        End If
        optValidacion.Enabled = True
        
        tipo_grabacion = 5
        End If
    End With
    
End If
    
End Sub
Public Sub CtrlObj_Alinear(nGrid As MSFlexGrid, nText As Object)
    On Error Resume Next
    nText.Top = nGrid.Top + nGrid.CellTop + 10
    nText.Left = nGrid.Left + nGrid.CellLeft + 50
    nText.Width = nGrid.CellWidth - 10
    nText.Height = nGrid.CellHeight - 10
    
    nText.Text = nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel)
    nText.SelStart = Len(nText.Text)
    nText.Visible = True
    nText.SetFocus
End Sub

Private Sub HabilitaControls(ByVal xValor As Boolean)
   Dim iContador As Integer

   For iContador = 1 To Tbl_Opciones.Buttons.Count
      Let Tbl_Opciones.Buttons.Item(iContador).Enabled = xValor
   Next iContador

End Sub

Private Sub grdValidacion_KeyDown(KeyCode As Integer, Shift As Integer)
     Dim I As Integer
    If KeyCode = vbKeyReturn Then
        If grdValidacion.ColSel = 1 Or grdValidacion.ColSel = 2 Or grdValidacion.ColSel = 14 Then
            Call DeshabilitaValidaciones
            Let Tbl_Opciones.Buttons.Item(2).Enabled = True
            tipo_grabacion = 5
            
            grdValidacion.Col = grdValidacion.ColSel
            grdValidacion.Row = grdValidacion.RowSel
            
            txtDescripcion.Text = grdValidacion.TextMatrix(grdValidacion.RowSel, grdValidacion.ColSel)
            txtDescripcion.Left = (grdValidacion.CellLeft + 100) '-10
            txtDescripcion.Top = (grdValidacion.CellTop + 246)
            txtDescripcion.Height = (grdValidacion.CellHeight - 10)
            txtDescripcion.Width = (grdValidacion.CellWidth - 10)
            txtDescripcion.Visible = True
            txtDescripcion.SetFocus
            grdValidacion.Enabled = False
           
        End If
      
        If grdValidacion.ColSel = 3 Or grdValidacion.ColSel = 4 Or grdValidacion.ColSel = 5 Then
            Call DeshabilitaValidaciones
            Let Tbl_Opciones.Buttons.Item(2).Enabled = False
            tipo_grabacion = 5
            
            grdValidacion.Col = grdValidacion.ColSel
            grdValidacion.Row = grdValidacion.RowSel
            
            txtIngresoNum.Text = grdValidacion.TextMatrix(grdValidacion.RowSel, grdValidacion.ColSel)
            txtIngresoNum.Left = (grdValidacion.CellLeft + 100) '-10
            txtIngresoNum.Top = (grdValidacion.CellTop + 246)
            txtIngresoNum.Height = (grdValidacion.CellHeight - 10)
            txtIngresoNum.Width = (grdValidacion.CellWidth - 10)
            txtIngresoNum.Visible = True
            txtIngresoNum.SetFocus
            grdValidacion.Enabled = False
            
        End If
      
    End If
   
    If KeyCode = vbKeyInsert Then
        Call DeshabilitaValidaciones
        Let Tbl_Opciones.Buttons.Item(2).Enabled = True
        tipo_grabacion = 5
        
        grdValidacion.Tag = "SI"
        If Val(grdValidacion.TextMatrix(grdValidacion.Rows - 1, 0)) = 0 Then
            MsgBox "¡ Debe primero completar la información antes de insertar un nuevo registro !", vbExclamation, TITSISTEMA
            If grdValidacion.Enabled = True Then grdValidacion.SetFocus
            Exit Sub
        End If
        grdValidacion.Rows = grdValidacion.Rows + 1
        grdValidacion.Col = 0
        grdValidacion.Row = grdValidacion.Rows - 1
        
        If grdValidacion.Rows = grdValidacion.FixedRows + 1 Then
            grdValidacion.TextMatrix(grdValidacion.RowSel, 0) = 1
        Else
            If Val(grdValidacion.TextMatrix(grdValidacion.RowSel, 0)) = 0 Then
                grdValidacion.TextMatrix(grdValidacion.RowSel, 0) = CDbl(grdValidacion.TextMatrix(grdValidacion.RowSel - 1, 0)) + 1
            End If
        End If
        
        Let grdValidacion.Col = 15:   'Let grdValidacion.Row = grdValidacion.Rows - 1
        grdValidacion.CellPictureAlignment = flexAlignCenterCenter
        
        Set grdValidacion.CellPicture = SinCheck.Item(0).Picture
        grdValidacion.TextMatrix(grdValidacion.RowSel, 15) = ""
        
        If grdValidacion.Enabled = True Then
            grdValidacion.SetFocus
        End If
        
    End If
    
    If KeyCode = vbKeyDelete Then
        Call DeshabilitaValidaciones
        Let Tbl_Opciones.Buttons.Item(2).Enabled = True
        tipo_grabacion = 5
        
        '--> Elimina solo la ultima fila de la grilla
        If Val(grdValidacion.TextMatrix(grdValidacion.RowSel, 0)) = (grdValidacion.Rows - 1) Then
            grdValidacion.Tag = "SI"
            If MsgBox("¿ Se encuentra segúro de eliminar el registro seleccionado ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
               
                If grdValidacion.Enabled = True Then grdValidacion.SetFocus
                Exit Sub
            End If
            With grdValidacion
                For I = 0 To 19
                    If id_campo(I) = "" Then
                        id_campo(I) = .TextMatrix(.RowSel, 0)
                        Exit For
                    End If
                Next I
            End With
            grdValidacion.RemoveItem grdValidacion.RowSel
            If grdValidacion.Enabled = True Then grdValidacion.SetFocus
        End If
        '--> Elimina solo la ultima fila de la grilla
    End If
    
End Sub


Private Sub optValidacion_Click()
    Call HabilitaValidaciones
        
    lblSeleccionado2.Enabled = True
    txtSeleccionado2.Enabled = True
    lblUbicacion.Enabled = True
    txtUbicacion.Enabled = True
    lblOperador.Enabled = True
    cmbOperador.Enabled = True
    optValEsperado.Enabled = True
    optComparacion.Enabled = True
    
    ' --> llena campo comparacion
'    tipo_select = 1
'    Envia2 = Array(IdInterfaz, Trim(Right(cmbSistema.Text, 3)), 0, tipo_select)
'
'    If Not Bac_Sql_Execute("SP_TRAE_CAMPO_COMPARACION", Envia2) Then
'        Screen.MousePointer = vbDefault
'        MsgBox "Ha ocurrido un error al intentar obtener los datos de los sistemas", vbOKOnly + vbCritical
'        Exit Sub
'    Else
'        cmbComparacion.Clear
'        Do While Bac_SQL_Fetch(Datos())
'            'cmbComparacion.AddItem (Datos(2) & Space(50) & Datos(1))
'            cmbComparacion.AddItem (Datos(1) & Space(2) & Datos(2))
'        Loop
'    End If
    ' --> llena campo comparacion
    
    With grdValidacion
        optValEsperado.Enabled = True
        optComparacion.Enabled = True
        If .TextMatrix(.RowSel, 6) <> "" Then                           ' resultado esperado
            optValEsperado.Value = True
            txtValEsperado.Text = .TextMatrix(.RowSel, 6)
        End If
        If .TextMatrix(.RowSel, 11) <> "" Then                          ' id2
            If CInt(.TextMatrix(.RowSel, 11)) > 0 Then
                optComparacion.Value = True
                cmbComparacion.ListIndex = .TextMatrix(.RowSel, 11) - 1
            End If
        End If
    
    End With
'    cmbComparacion.RemoveItem (txtIdc.Text - 1)
    Let Tbl_Opciones.Buttons.Item(2).Enabled = True
    
    tipo_grabacion = 2
End Sub

Private Sub optCampos_Click(Index As Integer)

End Sub

Private Sub optComparacion_Click()
    cmbComparacion.Enabled = True
    txtValEsperado.Enabled = False
    txtValEsperado.Text = ""
    With grdValidacion
        If .TextMatrix(.RowSel, 11) <> "" Then
            cmbComparacion.ListIndex = .TextMatrix(.RowSel, 11) - 1
        End If
    End With
End Sub

Private Sub optValEsperado_Click()
    txtValEsperado.Enabled = True
    cmbComparacion.Enabled = False
    cmbComparacion.ListIndex = -1
    With grdValidacion
        txtValEsperado.Text = .TextMatrix(.RowSel, 6)
    End With
End Sub


Private Sub SinCheck_DblClick(Index As Integer)
    With grdValidacion
        Let grdValidacion.Col = 15:   Let grdValidacion.Row = grdValidacion.Rows - 1
        grdValidacion.CellPictureAlignment = flexAlignCenterCenter
                
        Set grdValidacion.CellPicture = ConCheck.Item(0).Picture
    End With
End Sub

Private Sub Tbl_Opciones_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1      '"Nuevo"
            Call Limpiar
            Call DeshabilitaValidaciones

        Case 2      '"Grabar"
        
            If tipo_grabacion = 1 Then
                If cmdGrabarGrilla() Then
                    MsgBox "Se grabraron los datos OK.", vbInformation, TITSISTEMA
                    tipo_grabacion = 0
                    Call Limpiar
                End If
                
            ElseIf tipo_grabacion = 2 Then
                If cmdActualizar() Then
                    MsgBox "Se grabraron los datos OK.", vbInformation, TITSISTEMA
                    tipo_grabacion = 0
                    Call Limpiar
                    Call DeshabilitaValidaciones
                End If
                
            ElseIf tipo_grabacion = 3 Then
                If cmdActualizarGrilla() Then
                    MsgBox "Se grabraron los datos OK.", vbInformation, TITSISTEMA
                    tipo_grabacion = 0
                    Call Limpiar
                    Call DeshabilitaValidaciones
                End If
                
            ElseIf tipo_grabacion = 5 Then
               If cmdGrabarGrilla() Then
                    MsgBox "Se grabraron los datos OK.", vbInformation, TITSISTEMA
                    tipo_grabacion = 0
                    Call Limpiar
                End If
                
            End If
            
        Case 3      '"Eliminar"
            If cmdEliminar() Then
                MsgBox "Se eliminaron los datos OK.", vbInformation, TITSISTEMA
                Call Limpiar
            End If

        Case 4      '"Cargar"
            Call Proc_Carga_Excel
            
        Case 5      '"Salir"
             Unload Me
         
    End Select
End Sub

Function cmdEliminar() As Boolean

    Let cmdEliminar = False
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Exit Function
    End If
    
    Envia = Array()
    AddParam Envia, IdInterfaz                           ' id_interfaz
    AddParam Envia, Trim(Right(cmbInterfaz.Text, 20))    ' interfaz
    AddParam Envia, Trim(Right(cmbSistema.Text, 3))      ' sistema
    AddParam Envia, Trim("B")                            ' Tipo B -> Body
        
    If Not Bac_Sql_Execute("SP_ELIMINA_VALIDACION_INTERFACES ", Envia) Then
        bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
        Exit Function
    End If
     
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo ErrorGrabar
    End If
    
    Let cmdEliminar = True
    
    Exit Function
    
ErrorGrabar:
   
    MsgBox "Problemas al grabar datos interface", vbCritical, TITSISTEMA

    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
    End If
    
End Function


Function cmdGrabar() As Boolean
    Dim nLin       As Integer
    Dim Marca      As Integer
    Dim largo_body As Integer

    cmdGrabar = False
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Exit Function
    End If
    
    ' Si existe interfaz la borra
    tipo_grabacion = 5
        
    Envia = Array()
    AddParam Envia, IdInterfaz                           ' id_interfaz
    AddParam Envia, Trim(Right(cmbInterfaz.Text, 20))    ' interfaz
    AddParam Envia, Trim(Right(cmbSistema.Text, 3))      ' sistema
    AddParam Envia, tipo_grabacion                       ' indica Insert
    AddParam Envia, Trim("B")                            ' Tipo B -> Body
    AddParam Envia, 0                                    ' ID
    AddParam Envia, ""                                   ' Descripcion campo
    AddParam Envia, ""                                   ' tipo dato campo
    AddParam Envia, 0                                    ' largo
    AddParam Envia, 0                                    ' desde
    AddParam Envia, 0                                    ' hasta
    AddParam Envia, ""                                   ' Definicion campo
    AddParam Envia, ""                                   ' validacion vacia
    AddParam Envia, 0                                    ' inicio1 vacia
    AddParam Envia, 0                                    ' largo1 vacia
    AddParam Envia, ""                                   ' operador vacia
    AddParam Envia, 0                                    ' id2 vacia
    AddParam Envia, 0                                    ' inicio2 vacia
    AddParam Envia, 0                                    ' largo2 vacia
    AddParam Envia, ""                                   ' resultado vacia
    AddParam Envia, 0                                    ' habilita campo a campo
        
    If Not Bac_Sql_Execute("SP_GRABA_VALIDACION_INTERFAZ ", Envia) Then
       GoTo ErrorGrabar:
    End If
   
    ' Graba interfaz
    tipo_grabacion = 1
    
    With grdValidacion
       
        For nLin = 1 To .Rows - 1
            Envia = Array()
            If Trim(.TextMatrix(nLin, 0)) <> "" Then
            
            If .TextMatrix(nLin, 15) = "" Then
                Marca = 0
            Else
                Marca = 1
            End If
            
            AddParam Envia, IdInterfaz                           ' id_interfaz
            AddParam Envia, Trim(Right(cmbInterfaz.Text, 20))    ' interfaz
            AddParam Envia, Trim(Right(cmbSistema.Text, 3))      ' sistema
            AddParam Envia, tipo_grabacion                       ' indica Insert
            AddParam Envia, Trim("B")                            ' Tipo B -> Body
            AddParam Envia, Trim(.TextMatrix(nLin, 0))           ' ID
            AddParam Envia, Trim(.TextMatrix(nLin, 1))           ' Descripcion campo
            AddParam Envia, Trim(.TextMatrix(nLin, 2))           ' tipo dato campo
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 3)))     ' largo
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 4)))     ' desde
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 5)))     ' hasta
            AddParam Envia, Trim(.TextMatrix(nLin, 14))          ' Definicion campo
            AddParam Envia, ""                                   ' validacion vacia
            AddParam Envia, 0                                    ' inicio1 vacia
            AddParam Envia, 0                                    ' largo1 vacia
            AddParam Envia, ""                                   ' operador vacia
            AddParam Envia, 0                                    ' id2 vacia
            AddParam Envia, 0                                    ' inicio2 vacia
            AddParam Envia, 0                                    ' largo2 vacia
            AddParam Envia, ""                                   ' resultado vacia
            AddParam Envia, Marca                                ' habilita campo a campo
            
            If nLin = .Rows - 1 Then
                largo_body = CInt(Trim(.TextMatrix(nLin, 5)))
            End If
            
            If Not Bac_Sql_Execute("SP_GRABA_VALIDACION_INTERFAZ ", Envia) Then
               GoTo ErrorGrabar:
            End If
                  
            End If
        Next nLin

    End With
    
    Envia = Array()
    AddParam Envia, IdInterfaz
    AddParam Envia, Trim(Left(cmbInterfaz.Text, 20))        ' nombre corto interfaz
    AddParam Envia, ""                                      ' nombre largo interfaz
    AddParam Envia, 0                                       ' largo encabezado
    AddParam Envia, largo_body                              ' largo cuerpo
    AddParam Envia, 0                                       ' largo ultimo campo
    AddParam Envia, Trim(Right(cmbSistema, 3))              ' sistema
    AddParam Envia, 0                                       ' periodicidad
    AddParam Envia, 1                                       ' Tipo update
    AddParam Envia, 0                                       ' valida largo
    AddParam Envia, 0                                       ' valida consistencia
    AddParam Envia, 0                                       ' valida campo a campo
    
    If Not Bac_Sql_Execute("SP_GRABA_FORMATO_INTERFACES ", Envia) Then
        bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
        Exit Function
    End If
    
    tipo_grabacion = 0
     
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo ErrorGrabar
    End If

    cmdGrabar = True

    Exit Function

ErrorGrabar:
   
    MsgBox "Problemas al grabar datos interface", vbCritical, TITSISTEMA

    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
    End If

End Function

Function cmdGrabarGrilla() As Boolean
    Dim nLin       As Integer
    Dim Marca      As Integer
    Dim largo_body As Integer

    cmdGrabarGrilla = False
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Exit Function
    End If
    
    ' Si existe interfaz la borra
    tipo_grabacion = 5
        
    Envia = Array()
    AddParam Envia, IdInterfaz                           ' id_interfaz
    AddParam Envia, Trim(Right(cmbInterfaz.Text, 20))    ' interfaz
    AddParam Envia, Trim(Right(cmbSistema.Text, 3))      ' sistema
    AddParam Envia, tipo_grabacion                       ' indica Insert
    AddParam Envia, Trim("B")                            ' Tipo B -> Body
    AddParam Envia, 0                                    ' ID
    AddParam Envia, ""                                   ' Descripcion campo
    AddParam Envia, ""                                   ' tipo dato campo
    AddParam Envia, 0                                    ' largo
    AddParam Envia, 0                                    ' desde
    AddParam Envia, 0                                    ' hasta
    AddParam Envia, ""                                   ' Definicion campo
    AddParam Envia, ""                                   ' validacion vacia
    AddParam Envia, 0                                    ' inicio1 vacia
    AddParam Envia, 0                                    ' largo1 vacia
    AddParam Envia, ""                                   ' operador vacia
    AddParam Envia, 0                                    ' id2 vacia
    AddParam Envia, 0                                    ' inicio2 vacia
    AddParam Envia, 0                                    ' largo2 vacia
    AddParam Envia, ""                                   ' resultado vacia
    AddParam Envia, 0                                    ' habilita campo a campo
        
    If Not Bac_Sql_Execute("SP_GRABA_VALIDACION_INTERFAZ ", Envia) Then
       GoTo ErrorGrabar:
    End If
   
    ' Graba interfaz
    tipo_grabacion = 1
    
    With grdValidacion
       
        For nLin = 1 To .Rows - 1
            Envia = Array()
            If Trim(.TextMatrix(nLin, 0)) <> "" Then
            
            If .TextMatrix(nLin, 15) = "" Then
                Marca = 0
            Else
                Marca = 1
            End If
            
            AddParam Envia, IdInterfaz                           ' id_interfaz
            AddParam Envia, Trim(Right(cmbInterfaz.Text, 20))    ' interfaz
            AddParam Envia, Trim(Right(cmbSistema.Text, 3))      ' sistema
            AddParam Envia, tipo_grabacion                       ' indica Insert
            AddParam Envia, Trim("B")                            ' Tipo B -> Body
            AddParam Envia, Trim(.TextMatrix(nLin, 0))           ' ID
            AddParam Envia, Trim(.TextMatrix(nLin, 1))           ' Descripcion campo
            AddParam Envia, Trim(.TextMatrix(nLin, 2))           ' tipo dato campo
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 3)))     ' largo
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 4)))     ' desde
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 5)))     ' hasta
            AddParam Envia, Trim(.TextMatrix(nLin, 14))          ' Definicion campo
            AddParam Envia, Trim(.TextMatrix(nLin, 7))           ' validacion vacia
            AddParam Envia, IIf(Len(.TextMatrix(nLin, 12)) = 0, 0, .TextMatrix(nLin, 12)) ' inicio1 vacia
            AddParam Envia, IIf(Len(.TextMatrix(nLin, 13)) = 0, 0, .TextMatrix(nLin, 13))    ' largo1 vacia
            AddParam Envia, Trim(.TextMatrix(nLin, 8))           ' operador vacia
            AddParam Envia, IIf(Len(.TextMatrix(nLin, 11)) = 0, 0, .TextMatrix(nLin, 11))    ' id2 vacia
            AddParam Envia, IIf(Len(.TextMatrix(nLin, 9)) = 0, 0, .TextMatrix(nLin, 9))      ' inicio2 vacia
            AddParam Envia, IIf(Len(.TextMatrix(nLin, 10)) = 0, 0, .TextMatrix(nLin, 10))    ' largo2 vacia
            AddParam Envia, Trim(.TextMatrix(nLin, 6))                                   ' resultado vacia
            AddParam Envia, Marca                                ' habilita campo a campo
            
            If nLin = .Rows - 1 Then
                largo_body = CInt(Trim(.TextMatrix(nLin, 5)))
            End If
            
            If Not Bac_Sql_Execute("SP_GRABA_VALIDACION_INTERFAZ ", Envia) Then
               GoTo ErrorGrabar:
            End If
                  
            End If
        Next nLin

    End With
    
    Envia = Array()
    AddParam Envia, IdInterfaz
    AddParam Envia, Trim(Left(cmbInterfaz.Text, 20))        ' nombre corto interfaz
    AddParam Envia, ""                                      ' nombre largo interfaz
    AddParam Envia, 0                                       ' largo encabezado
    AddParam Envia, largo_body                              ' largo cuerpo
    AddParam Envia, 0                                       ' largo ultimo campo
    AddParam Envia, Trim(Right(cmbSistema, 3))              ' sistema
    AddParam Envia, 0                                       ' periodicidad
    AddParam Envia, 1                                       ' Tipo update
    AddParam Envia, 0                                       ' valida largo
    AddParam Envia, 0                                       ' valida consistencia
    AddParam Envia, 0                                       ' valida campo a campo
    
    If Not Bac_Sql_Execute("SP_GRABA_FORMATO_INTERFACES ", Envia) Then
        bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
        Exit Function
    End If
    
    tipo_grabacion = 0
     
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo ErrorGrabar
    End If

    cmdGrabarGrilla = True

    Exit Function

ErrorGrabar:
   
    MsgBox "Problemas al grabar datos interface", vbCritical, TITSISTEMA

    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
    End If

End Function

Function cmdInsertaFila() As Boolean
    Dim nLin       As Integer
    Dim largo_body As Integer
    largo_body = 0

    tipo_grabacion = 1
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Exit Function
    End If
    
    'Call cmdGrabar
   
    cmdInsertaFila = False

    Envia = Array()
    With grdValidacion

        For nLin = total_filas To .Rows - 1
            Envia = Array()
            If Trim(.TextMatrix(nLin, 0)) <> "" Then

            AddParam Envia, IdInterfaz                           ' id_interfaz
            AddParam Envia, Trim(Right(cmbInterfaz.Text, 20))    ' interfaz
            AddParam Envia, Trim(Right(cmbSistema.Text, 3))      ' sistema
            AddParam Envia, 1                                    ' indica Insert
            AddParam Envia, Trim("B")                            ' Tipo B -> Body
            AddParam Envia, Trim(.TextMatrix(nLin, 0))           ' ID
            AddParam Envia, Trim(.TextMatrix(nLin, 1))           ' Descripcion campo
            AddParam Envia, Trim(.TextMatrix(nLin, 2))           ' tipo dato campo
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 3)))     ' largo
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 4)))     ' desde
            AddParam Envia, CInt(Trim(.TextMatrix(nLin, 5)))     ' hasta
            AddParam Envia, Trim(.TextMatrix(nLin, 14))          ' Definicion campo
            AddParam Envia, ""                                   ' validacion vacia
            AddParam Envia, 0                                    ' inicio1 vacia
            AddParam Envia, 0                                    ' largo1 vacia
            AddParam Envia, ""                                   ' operador vacia
            AddParam Envia, 0                                    ' id2 vacia
            AddParam Envia, 0                                    ' inicio2 vacia
            AddParam Envia, 0                                    ' largo2 vacia
            AddParam Envia, ""                                   ' resultado vacia
            AddParam Envia, 0                                    ' habilita campo a campo

            If nLin = .Rows - 1 Then
                largo_body = CInt(Trim(.TextMatrix(nLin, 5)))
            End If
            If Not Bac_Sql_Execute("SP_GRABA_VALIDACION_INTERFAZ ", Envia) Then
               GoTo ErrorGrabar:
            End If

        End If
        Next nLin

    End With
    
    Envia = Array()
    AddParam Envia, IdInterfaz
    AddParam Envia, Trim(Left(cmbInterfaz.Text, 20))        ' nombre corto interfaz
    AddParam Envia, ""                                      ' nombre largo interfaz
    AddParam Envia, 0                                       ' largo encabezado
    AddParam Envia, largo_body                              ' largo cuerpo
    AddParam Envia, 0                                       ' largo ultimo campo
    AddParam Envia, Trim(Right(cmbSistema, 3))              ' sistema
    AddParam Envia, 0                                       ' periodicidad
    AddParam Envia, 1                                       ' Tipo update
    AddParam Envia, 0                                       ' valida largo
    AddParam Envia, 0                                       ' valida consistencia
    AddParam Envia, 0                                       ' valida campo a campo
    
    If Not Bac_Sql_Execute("SP_GRABA_FORMATO_INTERFACES ", Envia) Then
        bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
        Exit Function
    End If
    
    tipo_grabacion = 0

    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo ErrorGrabar
    End If

    cmdInsertaFila = True
'
    Exit Function

ErrorGrabar:

    MsgBox "Problemas al grabar datos interface", vbCritical, TITSISTEMA

    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
    End If

End Function

Function cmdEliminaFila() As Boolean
    Dim nLin       As Integer
    Dim largo_body As Integer
    Dim Graba As Integer
    Dim I As Integer
    Graba = 0
    largo_body = 0

    tipo_grabacion = 1
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Exit Function
    End If
   
    cmdEliminaFila = False

    Envia = Array()
    With grdValidacion
        largo_body = .TextMatrix(.Rows - 1, 5)
        I = 0
        For nLin = .Rows - 1 To total_filas 'To .Rows - 1
            Envia = Array()
            AddParam Envia, IdInterfaz                              ' id
            AddParam Envia, Trim(Right(cmbSistema, 3))              ' sistema
            AddParam Envia, CInt(id_campo(I))                             ' campo
            AddParam Envia, 1                                       ' tipo
            AddParam Envia, largo_body                              ' largo

            If Not Bac_Sql_Execute("SP_ELIMINA_VALIDACION_INTERFAZ ", Envia) Then
               GoTo ErrorGrabar:
            End If
            I = I + 1
        Next nLin

    End With
        
    tipo_grabacion = 0
    

    'Erase id_campo   'limpiar arreglo
    
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo ErrorGrabar
    End If

    cmdEliminaFila = True
    Exit Function

ErrorGrabar:

    MsgBox "Problemas al grabar datos interface", vbCritical, TITSISTEMA

    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
    End If
End Function

Function cmdActualizar() As Boolean
    Dim nLin       As Integer
    Dim largo1     As Integer
    Dim Errores    As Integer
    Errores = 0

    tipo_grabacion = 2

    If optValidacion.Value = True Then
    
        If txtSeleccionado2.Text = "" Or Trim(Right(cmbOperador.Text, 3)) = "" And (optComparacion.Value = False Or optValEsperado.Value = False) And Errores = 0 Then
            MsgBox "Hay campos que no ha sido seleccionados o su valor es vacío"
            With grdValidacion
                cmbOperador.ListIndex = IIf(Len(.TextMatrix(grdValidacion.RowSel, 8)) = 0, -1, .TextMatrix(grdValidacion.RowSel, 8)) '.TextMatrix(grdValidacion.RowSel, 8)
                cmbOperador.SetFocus
            End With
            Errores = 1
            Exit Function
        End If
    End If

    If Errores = 0 Then
        
        cmdActualizar = False
        If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
            Exit Function
        End If
               
        With grdValidacion
            nLin = 1
            Envia = Array()
            If Trim(.TextMatrix(.RowSel, 0)) <> "" Then
                           
                largo1 = CInt(txtLargo1.Text) 'CInt(.TextMatrix(.RowSel, 5)) - CInt(txtUbicacion.Text)
                
                AddParam Envia, IdInterfaz                          ' id_interfaz
                AddParam Envia, Trim(Right(cmbInterfaz.Text, 20))   ' interfaz
                AddParam Envia, Trim(Right(cmbSistema.Text, 3))     ' sistema
                AddParam Envia, 3                                   ' indica Update
                AddParam Envia, Trim("B")                           ' Tipo B -> Body
                AddParam Envia, CInt(txtIdc.Text)                   ' ID 'CInt(txtUbicacion.Text)
                AddParam Envia, Trim(txtSeleccionado2.Text)         ' Descripcion
                AddParam Envia, ""                                  ' tipo dato campo vacia
                AddParam Envia, 0                                   ' largo no se graba
                AddParam Envia, 0                                   ' desde no se graba
                AddParam Envia, 0                                   ' hasta no se graba
                AddParam Envia, ""                                  ' Definicion campo vacia
                AddParam Envia, "S"                                 ' validacion
                AddParam Envia, CInt(txtDesde.Text)                 ' inicio1
                AddParam Envia, largo1                              ' largo1
                AddParam Envia, Trim(Right(cmbOperador.Text, 3))    ' operador
                
                'comparacion con otro campo
                If optComparacion.Value = True Then
                    AddParam Envia, CInt(Trim(Left(cmbComparacion.Text, 3)))    ' Id2
                    AddParam Envia, CInt(Trim(txtInicio2.Text))                 ' inicio2
                    AddParam Envia, CInt(Trim(txtLargo2.Text))                  ' largo2
                    AddParam Envia, ""                                          ' resultado vacia
                    AddParam Envia, 0                                           ' habilita campo a campo
                ElseIf optValEsperado.Value = True Then
                    If txtValEsperado.Text <> "" Then
                        AddParam Envia, 0                                       ' Id2 vacia
                        AddParam Envia, 0                                       ' inicio2 vacia
                        AddParam Envia, 0                                       ' largo2 vacia
                        AddParam Envia, txtValEsperado.Text                     ' resultado
                        AddParam Envia, 0                                       ' habilita campo a campo
                    Else
                        MsgBox "Debe ingresar valor a validadr", vbCritical, TITSISTEMA
                        txtValEsperado.SetFocus
                    End If
                Else 'validacion
                    AddParam Envia, 0                                           ' Id2
                    AddParam Envia, 0                                           ' inicio2
                    AddParam Envia, 0                                           ' largo2
                    AddParam Envia, ""                                          ' resultado vacia
                    AddParam Envia, 0                                           ' habilita campo a campo
                End If
                           
                If Not Bac_Sql_Execute("SP_GRABA_VALIDACION_INTERFAZ", Envia) Then
                   GoTo ErrorGrabar:
                End If
    
             End If
    
        End With
        tipo_grabacion = 0
    
        If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
            GoTo ErrorGrabar
        End If
       
        cmdActualizar = True
    
        Exit Function
    
ErrorGrabar:
       
        MsgBox "Problemas al grabar datos interface", vbCritical, TITSISTEMA
    
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
        End If
       
    Else
        MsgBox "Falta ingresar un campo de la validacion", vbCritical, TITSISTEMA
    
    End If

End Function

Function cmdActualizarGrilla() As Boolean
Dim largo1     As Integer
Dim Errores  As Integer
Errores = 0
Dim I As Integer
Dim Marca As Integer
tipo_grabacion = 3

    cmdActualizarGrilla = False
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Exit Function
    End If
    
    With grdValidacion
        For I = 1 To .Rows - 1
            If .TextMatrix(I, 15) = "" Then
                Marca = 0
            Else
                Marca = 1
            End If
            
            Envia = Array()
            AddParam Envia, IdInterfaz                                  ' id_interfaz
            AddParam Envia, Trim(Right(cmbInterfaz.Text, 20))           ' interfaz
            AddParam Envia, Trim(Right(cmbSistema.Text, 3))             ' sistema
            AddParam Envia, 4                                           ' indica Insert
            AddParam Envia, Trim("B")                                   ' Tipo B -> Body
            AddParam Envia, I                                           ' ID campo
            AddParam Envia, ""                                          ' Descripcion
            AddParam Envia, ""                                          ' tipo dato
            AddParam Envia, 0                                           ' largo no se graba
            AddParam Envia, 0                                           ' desde no se graba
            AddParam Envia, 0                                           ' hasta no se graba
            AddParam Envia, ""                                          ' Definicion campo vacia
            AddParam Envia, ""                                          ' validacion
            AddParam Envia, 0                                           ' inicio1
            AddParam Envia, 0                                           ' largo1
            AddParam Envia, ""                                          ' operador
            AddParam Envia, 0                                           ' Id2
            AddParam Envia, 0                                           ' inicio2
            AddParam Envia, 0                                           ' largo2
            AddParam Envia, ""                                          ' resultado vacia
            AddParam Envia, Marca                                       ' habilita campo a campo
           
            If Not Bac_Sql_Execute("SP_GRABA_VALIDACION_INTERFAZ", Envia) Then
               GoTo ErrorGrabar:
            End If
            
        Next I
    End With
    
    tipo_grabacion = 0
    
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo ErrorGrabar
    End If
   
    cmdActualizarGrilla = True
    
    Exit Function
    
ErrorGrabar:
        MsgBox "Problemas al grabar datos interface", vbCritical, TITSISTEMA
    
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
        End If

End Function

Private Sub Proc_Carga_Excel()
Call LimpiarGrilla
Call LimpiaCampos1
Call LimpiaCampos2
On Error GoTo ErrorAction
        Dim nArchivo   As String
        Dim nContador  As Long
        Dim Contador As Integer
        Dim nFilas     As Long
        Dim xRiesgo    As String
        Dim xItem      As String
        Dim oValor     As Double
        Dim MiFila     As Integer
        Dim Datos()
        iCadena = ""
       '--> Variables de Barra de Progreso y Cursor
       Screen.MousePointer = vbHourglass

        '--> Inicializa la Pantalla Open File de Windows
       Command.CancelError = True
       Command.Filter = ".xlsx"
       Command.FileName = ""
       Call Command.ShowOpen
ShowOpenAgain:
        If Command.FileName = "" Then
           If MsgBox("Advertencia." & vbCrLf & vbCrLf & "No se ha seleccionado ninguna planilla. " _
           & vbCrLf & vbCrLf & ".... Reintentar ?", vbExclamation + vbRetryCancel, TITSISTEMA) = vbRetry Then

              GoTo ShowOpenAgain
           Else

              GoTo ErrorAction
           End If
        End If
        Screen.MousePointer = vbHourglass
       '--> Levanta las Variables de entorno de Excel
       Set MiExcell = CreateObject("Excel.Application")
       Set MiLibro = MiExcell.Workbooks.Open(Command.FileName)
       Set MiHoja = Nothing
       Set MiHoja = MiExcell.ActiveSheet
       '--> Levanta las Variables de entorno de Excel

       '--> Determina el Largo Aprox de la Hoja Seleccionada
'        nFilas = MiHoja.Columns.End(xlDown).Row
        
        With MiHoja
            nFilas = .UsedRange.Rows.Count
        End With
        

         '--> Comienza a Recorrer cada una de las filas del Excel y grabla bloqueados
        Dim Filax As Integer
        Filax = 2
        
        With grdValidacion
            .Rows = 1 '--> nFilas
            
            For Contador = 1 To nFilas - 1
                .Rows = .Rows + 1
                .TextMatrix(Contador, 0) = MiHoja.Cells(Filax, "A")                '--> Se Ingresa el parametro N° campo
                .TextMatrix(Contador, 1) = CStr(MiHoja.Cells(Filax, "B"))          '--> Se Ingresa Descripcion
                .TextMatrix(Contador, 2) = CStr(MiHoja.Cells(Filax, "C"))          '--> Se Ingresa Tipo de Campo
                .TextMatrix(Contador, 3) = CInt(MiHoja.Cells(Filax, "D"))          '--> Se Ingresa Largo Campo
                .TextMatrix(Contador, 4) = CInt(MiHoja.Cells(Filax, "E"))          '--> Se Ingresa rango inicio del campo
                .TextMatrix(Contador, 5) = CInt(MiHoja.Cells(Filax, "F"))          '--> Se Ingresa rango termino del campo
                .TextMatrix(Contador, 14) = CStr(MiHoja.Cells(Filax, "G"))
                
                .Col = 15:   .Row = .Rows - 1
                grdValidacion.CellPictureAlignment = flexAlignCenterCenter
    
                Set grdValidacion.CellPicture = SinCheck.Item(0).Picture
                
                Filax = Filax + 1
            Next Contador

        End With
        
        If grdValidacion.Rows > 1 Then
            Call AnchoColumnasGrilla
            Let Tbl_Opciones.Buttons.Item(2).Enabled = True
        End If
        
        'MSHFlexGrid1.ColWidth(4) = n * 150
         Screen.MousePointer = vbDefault
         Call MsgBox("Planilla ha sido cargada en forma exitosa", vbInformation, App.Title)   '--> Mensaje

        Set MiSheet = Nothing
        Set MiHoja = Nothing
        MiLibro.Application.Workbooks.Close
        MiExcell.Application.Quit
        Set MiLibro = Nothing
        Set MiExcell = Nothing
        
        tipo_grabacion = 1
        '--> Cierra las variables de entorno de Windows para Excel
'On Error GoTo 0
      'Exit sub
ErrorAction:
    Screen.MousePointer = vbDefault
    If Err.Number = 32755 Then
    Else
       If Err.Number <> 0 Then
          Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
          Exit Sub
          MiLibro.Application.Workbooks.Close
          MiExcell.Application.Quit
       End If
    End If
    tipo_grabacion = 1
End Sub

Private Sub AnchoColumnasGrilla()
    Dim a, n0, n1, n2, n3, n4, n5, n6, n7, n8, n9 As Integer
    
    n0 = n1 = n2 = n3 = n4 = n5 = n6 = n7 = n8 = 0
        
    With grdValidacion
        For a = 0 To .Rows - 1
            If Len(RTrim(grdValidacion.TextMatrix(a, 0))) > n0 Then
                n0 = Len(RTrim(grdValidacion.TextMatrix(a, 0)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 1))) > n1 Then
                n1 = Len(RTrim(grdValidacion.TextMatrix(a, 1)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 2))) > n2 Then
                n2 = Len(RTrim(grdValidacion.TextMatrix(a, 2)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 3))) > n3 Then
                n3 = Len(RTrim(grdValidacion.TextMatrix(a, 3)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 4))) > n4 Then
                n4 = Len(RTrim(grdValidacion.TextMatrix(a, 4)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 5))) > n5 Then
                n5 = Len(RTrim(grdValidacion.TextMatrix(a, 5)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 6))) > n6 Then
                n6 = Len(RTrim(grdValidacion.TextMatrix(a, 6)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 7))) > n7 Then
                n7 = Len(RTrim(grdValidacion.TextMatrix(a, 7)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 14))) > n8 Then
                n8 = Len(RTrim(grdValidacion.TextMatrix(a, 14)))
            End If
            If Len(RTrim(grdValidacion.TextMatrix(a, 15))) > n9 Then
                n9 = Len(RTrim(grdValidacion.TextMatrix(a, 15)))
            End If
        Next
       
        .ColWidth(nColNro) = n0 * 150
        .ColWidth(nColDesc) = n1 * 100
        .ColWidth(nColTipo) = n2 * 120
        .ColWidth(nColLargo) = n3 * 120
        .ColWidth(nColDesde) = n4 * 120
        .ColWidth(nColHasta) = n5 * 120
        .ColWidth(nColValFijo) = n6 * 100
        .ColWidth(nColValida) = n7 * 100
        .ColWidth(nColDef) = 0              'n8 * 100
        .ColWidth(nColCampo) = n9 * 100        'col = 15
    End With
End Sub

Private Sub DeshabilitaValidaciones()
        lblSeleccionado2.Enabled = False
        txtSeleccionado2.Enabled = False
        lblUbicacion.Enabled = False
        txtUbicacion.Enabled = False
        lblOperador.Enabled = False
        cmbOperador.Enabled = False
        cmbComparacion.Enabled = False
        txtValEsperado.Enabled = False
        optComparacion.Enabled = False
        optValEsperado.Enabled = False
        lblLargo.Enabled = False
        lblDesde.Enabled = False
        lblHasta.Enabled = False
    optValidacion.Enabled = False
End Sub

Private Sub HabilitaValidaciones()
    lblSeleccionado2.Enabled = True
    txtSeleccionado2.Enabled = True
    lblUbicacion.Enabled = True
    txtUbicacion.Enabled = True
    lblOperador.Enabled = True
    cmbOperador.Enabled = True
    optComparacion.Enabled = True
    optValEsperado.Enabled = True
    lblLargo.Enabled = True
    lblDesde.Enabled = True
    lblHasta.Enabled = True
    
    optValidacion.Enabled = True
    
End Sub

Private Sub TxtDescripcion_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        grdValidacion.Tag = "SI"
        If grdValidacion.Rows = grdValidacion.FixedRows + 1 Then
           grdValidacion.TextMatrix(grdValidacion.RowSel, 0) = 1
        Else
           If Val(grdValidacion.TextMatrix(grdValidacion.RowSel, 0)) = 0 Then
              grdValidacion.TextMatrix(grdValidacion.RowSel, 0) = CDbl(grdValidacion.TextMatrix(grdValidacion.RowSel - 1, 0)) + 1
           End If
        End If
        grdValidacion.TextMatrix(grdValidacion.RowSel, grdValidacion.ColSel) = txtDescripcion.Text
        txtDescripcion.Text = ""
        grdValidacion.Enabled = True
        txtDescripcion.Visible = False
        If grdValidacion.Enabled = True Then: grdValidacion.SetFocus
    End If
   
    If KeyCode = vbKeyEscape Then
        txtDescripcion.Text = ""
        grdValidacion.Enabled = True
        txtDescripcion.Visible = False
        If grdValidacion.Enabled = True Then: grdValidacion.SetFocus
    End If
    
    tipo_grabacion = 5
End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)
    'KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtIngresoNum_KeyDown(KeyCode As Integer, Shift As Integer)
    
    Dim iColumna   As Integer
    iColumna = grdValidacion.ColSel

    If KeyCode = vbKeyReturn Then
       If iColumna = 3 Or iColumna = 4 Or iColumna = 5 Then
          grdValidacion.TextMatrix(grdValidacion.RowSel, grdValidacion.ColSel) = txtIngresoNum.Text
          grdValidacion.Enabled = True
          Tbl_Opciones.Enabled = True
          txtIngresoNum.Visible = False
          grdValidacion.SetFocus
          Call HabilitaControls(True)
       End If
    End If
    If KeyCode = vbKeyEscape Then
       If iColumna = 3 Or iColumna = 4 Or iColumna = 5 Then
          grdValidacion.Enabled = True
          Tbl_Opciones.Enabled = True
          txtIngresoNum.Visible = False
          grdValidacion.SetFocus
          Call HabilitaControls(True)
       End If
    End If
End Sub

Private Sub txtIngresoTex_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim iColumna   As Integer
    iColumna = grdValidacion.ColSel
    
    If KeyCode = vbKeyReturn Then
        grdValidacion.TextMatrix(grdValidacion.RowSel, grdValidacion.ColSel) = UCase(Trim(txtIngresoTex.Text))
        grdValidacion.Enabled = True
        Tbl_Opciones.Enabled = True
        txtIngresoTex.Visible = False
        grdValidacion.SetFocus
        Call HabilitaControls(True)
        
    End If
    
    If KeyCode = vbKeyEscape Then
          grdValidacion.Enabled = True
          Tbl_Opciones.Enabled = True
          txtIngresoTex.Visible = False
          grdValidacion.SetFocus
          Call HabilitaControls(True)
          
    End If
End Sub



